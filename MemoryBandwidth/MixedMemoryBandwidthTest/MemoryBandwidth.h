#pragma once

#include <stdint.h>
extern "C" float sse_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx512_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);

float __fastcall instr_read(void* arr, uint64_t arr_length, uint64_t iterations)
{
    void (*nopfunc)(uint64_t);
    nopfunc = (void(*)(uint64_t))arr;
    int iterIdx;
    for (iterIdx = 0; iterIdx < iterations; iterIdx++) nopfunc(iterations);
    return iterIdx;
}

float (*bw_func)(void*, uint64_t, uint64_t) = sse_asm_read;

enum InstructionTestType { None, FourByte, EightByte, K8_FourByte, Branch16 };
struct BandwidthTestThreadData {
    uint32_t iterations;
    uint32_t arr_length;
    uint64_t tsc_duration;
    float* arr;
    float (*bw_func)(void*, uint64_t, uint64_t);
};


/// <summary>
/// Automatically picks the best assembly read function supported by the current CPU
/// </summary>
void auto_set_bw_func()
{
    int cpuid_data[4];
    __cpuidex(cpuid_data, 1, 0);
    if (cpuid_data[3] & (1UL << 25)) {
        fprintf(stderr, "SSE supported\n");
        bw_func = sse_asm_read;
    }

    if (cpuid_data[2] & (1UL << 28)) {
        fprintf(stderr, "AVX supported\n");
        bw_func = avx_asm_read;
    }

    __cpuidex(cpuid_data, 7, 0);
    if (cpuid_data[1] & (1UL << 16)) {
        fprintf(stderr, "AVX512 supported\n");
        bw_func = avx512_asm_read;
    }
}

void FillInstructionArray(uint64_t* arr, uint64_t sizeKb, enum InstructionTestType nopSize)
{
    char nop8b[8] = { 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };

    // zen/piledriver optimization manual uses this pattern
    char nop4b[8] = { 0x0F, 0x1F, 0x40, 0x00, 0x0F, 0x1F, 0x40, 0x00 };

    // athlon64 (K8) optimization manual pattern
    char k8_nop4b[8] = { 0x66, 0x66, 0x66, 0x90, 0x66, 0x66, 0x66, 0x90 };

    uint64_t elements = (sizeKb * 1024 / 8) - 1; // leave room for ret
    unsigned char* functionEnd = (unsigned char*)(arr + elements);

    if (nopSize != Branch16) {
        uint64_t* nopPtr;
        if (nopSize == EightByte) nopPtr = (uint64_t*)(nop8b);
        else if (nopSize == FourByte) nopPtr = (uint64_t*)(nop4b);
        else if (nopSize == K8_FourByte) nopPtr = (uint64_t*)(k8_nop4b);
        else {
            fprintf(stderr, "%d (enum value) NOP size isn't supported :(\n", nopSize);
            return;
        }

        for (uint64_t nopIdx = 0; nopIdx < elements; nopIdx++) {
            arr[nopIdx] = *nopPtr;
        }

        functionEnd[0] = 0xC3;
    }
    else {
        // jump forward 14 bytes
        char branch16b[8] = { 0xEB, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
        char ret8b[8] = { 0xC3, 0, 0, 0, 0, 0, 0, 0 };
        uint64_t* branchPtr = (uint64_t*)(branch16b);
        uint64_t* nopPtr = (uint64_t*)(nop8b); // doesn't really matter, we should never hit this

        // last iteration must have nopIdx % 2 == 1, so the jump will go to the return statement
        // i.e. branchElements for loop must be even, so the last iteration is odd
        uint64_t branchElements = elements % 2 == 0 ? elements : elements - 1;
        uint64_t nopIdx;
        for (nopIdx = 0; nopIdx < branchElements; nopIdx++) {
            arr[nopIdx] = nopIdx % 2 == 0 ? *branchPtr : *nopPtr;
        }

        arr[nopIdx] = *(uint64_t*)ret8b;
    }
}

/// <summary>
/// Given test size in KB, return a good iteration count
/// </summary>
/// <param name="testSize">test size in KB</param>
/// <returns>Iterations per thread</returns>
uint32_t GetIterationCount(uint32_t testSize, uint32_t threads)
{
    uint32_t gbToTransfer = 512;
    if (testSize > 64) gbToTransfer = 512 / 2;
    if (testSize > 512) gbToTransfer = 512 / 4;
    if (testSize > 8192) gbToTransfer = 512 / 8;
    uint32_t iterations = gbToTransfer * 1024 * 1024 / testSize;
    if (iterations % 2 != 0) iterations += 1;

    if (iterations < 8) return 8; // set a minimum to reduce noise
    else return iterations;
}