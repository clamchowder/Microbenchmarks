// MemoryBandwidth.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys\timeb.h>
#include <math.h>
#include <intrin.h>
#include <immintrin.h>
#include <windows.h>

#define NUMA_STRIPE 1
#define NUMA_SEQ 2
#define NUMA_CROSSNODE 3
#define NUMA_AUTO 4

#ifdef _WIN64
int default_test_sizes[39] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576, 1572864, 2097152, 3145728 };
#else
int default_test_sizes[35] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288 };
#endif

enum NopType { None, FourByte, EightByte, K8_FourByte, Branch16 };

struct BandwidthTestThreadData {
    uint32_t iterations;
    uint32_t arr_length;
    float* arr;
    float bw; // written to by the thread
};

#ifdef _WIN64
uint32_t dataGb = 512;
#else
uint32_t dataGb = 96;
#endif
//__int32 dataGb = 32;

// array length = number of 4 byte elements
float _fastcall scalar_read(void* arr, uint32_t arr_length, uint32_t iterations);

#ifdef _WIN64
extern "C" float sse_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float sse_asm_write(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float sse_asm_ntwrite(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float sse_asm_copy(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float sse_asm_add(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_write(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_copy(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_cflip(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_add(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx512_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float repmovsb_copy(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float repstosb_write(void* arr, uint64_t arr_length, uint64_t iterations);
float (*bw_func)(void*, uint64_t, uint64_t) = sse_asm_read;

#else
extern "C" float __fastcall scalar_asm_read32(void* arr, uint32_t arr_length, uint32_t iterations);
extern "C" float __fastcall mmx_asm_read32(void* arr, uint32_t arr_length, uint32_t iterations);
extern "C" float __fastcall sse_asm_read32(void* arr, uint32_t arr_length, uint32_t iterations);
extern "C" float __fastcall dummy(void* arr, uint32_t arr_length, uint32_t iterations);
float(_fastcall *bw_func)(void*, uint32_t, uint32_t) = dummy;
#endif

float MeasureBw(uint32_t sizeKb, uint32_t iterations, uint32_t threads, int shared, enum NopType instr);
float MeasureInstructionBw(uint64_t sizeKb, uint64_t iterations, enum NopType nopSize, uint32_t threads, int shared);
void FillInstructionArray(uint64_t* arr, uint64_t sizeKb, enum NopType nopSize);
#ifdef _WIN64
float __fastcall instr_read(void* arr, uint64_t arr_length, uint64_t iterations);
#else
float __fastcall instr_read(void* arr, uint32_t arr_length, uint32_t iterations);
#endif

void PrintNumaInfo();
uint32_t GetIterationCount(uint32_t testSize, uint32_t threads);
DWORD WINAPI ReadBandwidthTestThread(LPVOID param);

int numa = 0;
char coreNode, memNode;
char GetSeqNode(uint64_t);
char GetStripeNode(uint64_t);

int main(int argc, char *argv[]) {
    int threads = 1, shared = 0, methodSet = 0;
    enum NopType instr = None;
    int cpuid_data[4];
    int singleSize = 0;

    if (argc == 1) {
        printf("Usage: [-threads <thread count>] [-method <scalar/sse/avx/asm_avx/asm_avx512>] [-shared] [-private] [-data <base GB to transfer, default = %d>]\n", dataGb);
    }

    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char* arg = argv[argIdx] + 1;
            if (_strnicmp(arg, "threads", 7) == 0) {
                argIdx++;
                threads = atoi(argv[argIdx]);
                fprintf(stderr, "Using %d threads\n", threads);
            }
            else if (_strnicmp(arg, "shared", 6) == 0) {
                shared = 1;
                fprintf(stderr, "Using one array shared across all threads\n");
            }
            else if (_strnicmp(arg, "private", 7) == 0) {
                shared = 0;
                fprintf(stderr, "Using private array for each thread\n");
            }
            else if (_strnicmp(arg, "method", 6) == 0) {
                methodSet = 1;
                argIdx++;
#ifdef _WIN64
                if (_strnicmp(argv[argIdx], "read_asm_sse", 7) == 0) {
                    bw_func = sse_asm_read;
                    fprintf(stderr, "Using SSE assembly\n");
                }
                else if (_strnicmp(argv[argIdx], "read_asm_avx512", 10) == 0) {
                    bw_func = avx512_asm_read;
                    fprintf(stderr, "Using AVX512 assembly\n");
                }
                else if (_strnicmp(argv[argIdx], "write_asm_avx", 14) == 0) {
                    bw_func = avx_asm_write;
                    fprintf(stderr, "Using AVX assembly, writing instead of reading\n");
                }
                else if (_strnicmp(argv[argIdx], "read_asm_avx", 12) == 0) {
                    bw_func = avx_asm_read;
                    fprintf(stderr, "Using AVX assembly\n");
                }
                else if (_strnicmp(argv[argIdx], "copy_asm_avx", 12) == 0) {
                    bw_func = avx_asm_copy;
                    fprintf(stderr, "Using AVX assembly, copying one half of array to the other\n");
                }
                else if (_strnicmp(argv[argIdx], "cflip_asm_avx", 13) == 0) {
                    bw_func = avx_asm_cflip;
                    fprintf(stderr, "Using AVX assembly, flipping order of vec sized elements within a cacheline\n");
                }
                else if (_strnicmp(argv[argIdx], "add_asm_avx", 11) == 0) {
                    bw_func = avx_asm_add;
                    fprintf(stderr, "Using AVX assembly, adding constant to array\n");
                }
                else if (_strnicmp(argv[argIdx], "copy_asm_sse", 12) == 0) {
                    bw_func = sse_asm_copy;
                    fprintf(stderr, "Using SSE assembly, copying one half of array to the other\n");
                }
                else if (_strnicmp(argv[argIdx], "write_asm_sse", 13) == 0) {
                    bw_func = sse_asm_write;
                    fprintf(stderr, "Using SSE assembly, writing\n");
                }
                else if (_strnicmp(argv[argIdx], "ntwrite_asm_sse", 13) == 0) {
                    bw_func = sse_asm_ntwrite;
                    fprintf(stderr, "Using SSE assembly, non-temporal writes\n");
                }
                else if (_strnicmp(argv[argIdx], "add_asm_sse", 11) == 0) {
                    bw_func = sse_asm_add;
                    fprintf(stderr, "Using SSE assembly, adding constant to array\n");
                }
                else if (_strnicmp(argv[argIdx], "copy_repmovsb", 11) == 0) {
                    bw_func = repmovsb_copy;
                    fprintf(stderr, "Using assembly, rep movsb to copy one half of the array to the other\n");
                }
                else if (_strnicmp(argv[argIdx], "write_repstosb", 11) == 0) {
                    bw_func = repstosb_write;
                    fprintf(stderr, "Using assembly, rep stosb to set array contents to 1\n");
                }
#else
                if (_strnicmp(argv[argIdx], "scalar", 6) == 0) {
                    bw_func = scalar_asm_read32;
                    fprintf(stderr, "Using scalar MOV r <- mem32\n");
                }
                else if (_strnicmp(argv[argIdx], "sse", 3) == 0) {
                    bw_func = sse_asm_read32;
                    fprintf(stderr, "Using SSE MOVAPS xmm <- mem128\n");
                }
                else if (_strnicmp(argv[argIdx], "mmx", 3) == 0) {
                    bw_func = mmx_asm_read32;
                    fprintf(stderr, "Using MMX MOVQ mm <- mem64\n");
                }
#endif
                else if (_strnicmp(argv[argIdx], "instr8", 6) == 0) {
                    instr = EightByte;
                    fprintf(stderr, "Using 8B NOPs\n");
                }
                else if (_strnicmp(argv[argIdx], "instr4", 6) == 0) {
                    instr = FourByte;
                    fprintf(stderr, "Using 4B NOPs\n");
                }
                else if (_strnicmp(argv[argIdx], "instrk8_4", 6) == 0) {
                    instr = K8_FourByte;
                    fprintf(stderr, "Using 4B NOPs, with encoding recommended in the Athlon optimization manual\n");
                }
                else if (_strnicmp(argv[argIdx], "branch16", 6) == 0) {
                    instr = Branch16;
                    fprintf(stderr, "Using branch per 16B\n");
                }
                else {
                    methodSet = 0;
                    fprintf(stderr, "I'm so confused. Gonna use whatever the CPU supports I guess\n");
                }
            }
            else if (_strnicmp(arg, "data", 4) == 0) {
                argIdx++;
                dataGb = atoi(argv[argIdx]);
                fprintf(stderr, "Base data to transfer: %u\n", dataGb);
            }
            else if (_strnicmp(arg, "printnumainfo", 8) == 0) {
                fprintf(stderr, "Printing NUMA info and exiting\n");
                PrintNumaInfo();
                return 0;
            }
            else if (_strnicmp(arg, "numa", 4) == 0) {
                argIdx++;
                fprintf(stderr, "Attempting to be NUMA aware\n");
                numa = NUMA_SEQ;
                if (_strnicmp(argv[argIdx], "stripe", 6) == 0) {
                    numa = NUMA_STRIPE;
                }
                else if (_strnicmp(argv[argIdx], "seq", 3) == 0) {
                    numa = NUMA_SEQ;
                }

                if (numa == NUMA_SEQ) fprintf(stderr, "Filling NUMA nodes one by one\n");
                else if (numa == NUMA_STRIPE) fprintf(stderr, "Striping threads across NUMA nodes\n");
            }
            else if (_strnicmp(arg, "autonuma", 8) == 0) {
                numa = NUMA_AUTO;
            }
            else if (_strnicmp(arg, "crossnode", 9) == 0) {
                numa = NUMA_CROSSNODE;
                argIdx++;
                coreNode = atoi(argv[argIdx]);
                argIdx++;
                memNode = atoi(argv[argIdx]);
                fprintf(stderr, "Testing %d -> %d\n", coreNode, memNode);
            }
            else if (_strnicmp(arg, "singlesize", 10) == 0) {
                argIdx++;
                singleSize = atoi(argv[argIdx]);
                fprintf(stderr, "Testing %d KB\n", singleSize);
            }
        }
    }

    if (!methodSet) {
        // cpuid_data[0] = eax, [1] = ebx, [2] = ecx, [3] = edx
        __cpuidex(cpuid_data, 1, 0);
#ifdef _WIN64
        // EDX bit 25 = SSE
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
#else
        int choice = 0;
        printf("Pick a method. Choose wisely:\n");
        printf("1. SSE movaps xmm <- mem128");
        if (cpuid_data[3] & (1UL << 25)) printf(" (looks supported)\n");
        else printf(" (looks unsupported)\n");

        printf("2. MMX movq mm <- mem64");
        if (cpuid_data[3] & (1UL << 23)) printf("  (looks supported)\n");
        else printf("  (looks unsupported\n");

        printf("3. mov gpr <- mem32 (better work)\n");
        printf("4. instruction side, 8B NOPs (0F 1F 84 00 00 00 00 00)\n");
        printf("5. instruction side, 4B NOPs (0F 1F 40 00)\n");
        printf("6. instruction side, 4B NOPs (66 66 66 90)\n");
        printf("Your choice: ");
        scanf_s("%d", &choice);
        if (choice == 1) bw_func = sse_asm_read32;
        else if (choice == 2) bw_func = mmx_asm_read32;
        else if (choice == 3) bw_func = scalar_asm_read32;
        else if (choice == 4) instr = EightByte;
        else if (choice == 5) instr = FourByte;
        else if (choice == 6) instr = K8_FourByte;
        else { printf("Bye\n"); return 0; }
#endif
    }

    if (instr) {
        bw_func = instr_read;
    }

    if (singleSize) {
        float bw = MeasureBw(singleSize, GetIterationCount(singleSize, threads), threads, shared, instr);
        printf("%d,%f\n", singleSize, bw);
    }
    else if (numa == NUMA_AUTO) {
        ULONG highestNumaNode;
        if (!GetNumaHighestNodeNumber(&highestNumaNode)) {
            fprintf(stderr, "Could not get highest NUMA node number: %d\n", GetLastError());
            return 0;
        }

        for (int coreNode = 0; coreNode <= highestNumaNode; coreNode++) printf(",%d", coreNode);
        printf("\n");

        for (int coreNodeIdx = 0; coreNodeIdx <= highestNumaNode; coreNodeIdx++) {
            printf("%d", coreNodeIdx);
            for (int memNodeIdx = 0; memNodeIdx <= highestNumaNode; memNodeIdx++) {
                ULONGLONG mask;
                DWORD index;
                coreNode = coreNodeIdx;
                memNode = memNodeIdx;
                numa = NUMA_CROSSNODE; // hacky, oh well
                float bw = MeasureBw(
                    default_test_sizes[(sizeof(default_test_sizes) / sizeof(int)) - 1],
                    GetIterationCount(default_test_sizes[(sizeof(default_test_sizes) / sizeof(int)) - 1], threads),
                    threads,
                    shared,
                    instr);
                printf(",%f", bw);
            }

            printf("\n");
        }
    }
    else {
        printf("Using %d threads\n", threads);
        for (int i = 0; i < sizeof(default_test_sizes) / sizeof(int); i++) {
            float bw = MeasureBw(default_test_sizes[i], GetIterationCount(default_test_sizes[i], threads), threads, shared, instr);
            if (bw > 0) printf("%d,%f\n", default_test_sizes[i], bw);
        }
    }

    return 0;
}

/// <summary>
/// Given test size in KB, return a good iteration count
/// </summary>
/// <param name="testSize">test size in KB</param>
/// <returns>Iterations per thread</returns>
uint32_t GetIterationCount(uint32_t testSize, uint32_t threads)
{
    uint32_t gbToTransfer = dataGb;
    if (testSize > 64) gbToTransfer = dataGb / 2;
    if (testSize > 512) gbToTransfer = dataGb / 4;
    if (testSize > 8192) gbToTransfer = dataGb / 8;
    uint32_t iterations = gbToTransfer * 1024 * 1024 / testSize;
    if (iterations % 2 != 0) iterations += 1;

    if (iterations < 8) return 8; // set a minimum to reduce noise
    else return iterations;
}

float MeasureBw(uint32_t sizeKb, uint32_t iterations, uint32_t threads, int shared, enum NopType instr) {
    struct timeb start, end;
    float bw = 0;
    uint32_t elements = sizeKb * 1024 / sizeof(float);
    uint32_t private_elements = ceil((double)sizeKb / (double)threads) * 256;
    DWORD protection_flags = PAGE_EXECUTE_READWRITE;

    //if (instr != None) protection_flags = PAGE_EXECUTE_READWRITE;
    if (!shared) elements = private_elements;

    //fprintf(stderr, "%llu elements per thread\n", elements);

    if (!shared && sizeKb < threads) {
        //fprintf(stderr, "Too many threads for this size, continuing\n");
        return 0;
    }

    // make array and fill it with something
    float* testArr = NULL;
    if (shared) {
        testArr = (float*)VirtualAlloc(NULL, elements * sizeof(float), MEM_COMMIT | MEM_RESERVE, protection_flags);
        if (testArr == NULL) {
            fprintf(stderr, "Could not allocate memory\n");
            return 0;
        }

        if (instr != None)
        {
            FillInstructionArray((uint64_t*)testArr, sizeKb, instr);
        }
        else {
            for (uint32_t i = 0; i < elements; i++) {
                testArr[i] = i + 0.5f;
            }
        }
    }

    HANDLE* testThreads = (HANDLE*)malloc(threads * sizeof(HANDLE));
    DWORD* tids = (DWORD*)malloc(threads * sizeof(DWORD));
    struct BandwidthTestThreadData* threadData = (struct BandwidthTestThreadData*)malloc(threads * sizeof(struct BandwidthTestThreadData));

    for (uint64_t i = 0; i < threads; i++) {
        char node;
        if (shared) {
            threadData[i].arr = testArr;
            threadData[i].iterations = iterations;
        }
        else {
            if (!numa) threadData[i].arr = (float*)VirtualAlloc(NULL, elements * sizeof(float), MEM_COMMIT | MEM_RESERVE, protection_flags);
            else if (numa == NUMA_STRIPE) {
                node = GetStripeNode(i);
                threadData[i].arr = (float *)VirtualAllocExNuma(
                    GetCurrentProcess(),
                    NULL,
                    elements * sizeof(float),
                    MEM_RESERVE | MEM_COMMIT,
                    protection_flags,
                    node
                );
            }
            else if (numa == NUMA_SEQ) {
                node = GetSeqNode(i);
                threadData[i].arr = (float*)VirtualAllocExNuma(
                    GetCurrentProcess(),
                    NULL,
                    elements * sizeof(float),
                    MEM_RESERVE | MEM_COMMIT,
                    protection_flags,
                    node
                );
            }
            else if (numa == NUMA_CROSSNODE) {
                threadData[i].arr = (float*)VirtualAllocExNuma(
                    GetCurrentProcess(),
                    NULL,
                    elements * sizeof(float),
                    MEM_RESERVE | MEM_COMMIT,
                    protection_flags,
                    memNode
                );

                node = memNode;
            }

            if (threadData[i].arr == NULL) {
                fprintf(stderr, "Could not allocate memory for thread %llu\n", i);
                return 0;
            }

            if (instr != None)
            {
                FillInstructionArray((uint64_t*)threadData[i].arr, (elements * 4) / 1024, instr);
            }
            else
            {
                for (uint64_t arr_idx = 0; arr_idx < elements; arr_idx++) {
                    threadData[i].arr[arr_idx] = arr_idx + i + 0.5f;
                }
            }

            threadData[i].iterations = iterations * threads;
        }

        threadData[i].arr_length = elements;
        threadData[i].bw = 0;
        testThreads[i] = CreateThread(NULL, 0, ReadBandwidthTestThread, threadData + i, CREATE_SUSPENDED, tids + i);

        // turns out setting affinity makes no difference, and it's easier to set affinity via start /affinity <mask> anyway
        //SetThreadAffinityMask(testThreads[i], 1UL << i);
        if (numa == NUMA_STRIPE || numa == NUMA_SEQ) {
            ULONGLONG mask;
            //fprintf(stderr, "Thread %d pinned to node %d\n", i, node);
            GetNumaNodeProcessorMask(node, &mask);
            SetThreadAffinityMask(testThreads[i], mask);
        }
        else if (numa == NUMA_CROSSNODE) {
            ULONGLONG mask;
            GetNumaNodeProcessorMask(coreNode, &mask);
            SetThreadAffinityMask(testThreads[i], mask);
        }
    }

    ftime(&start);
    for (uint32_t i = 0; i < threads; i++) ResumeThread(testThreads[i]);
    WaitForMultipleObjects((DWORD)threads, testThreads, TRUE, INFINITE);
    ftime(&end);

    int64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
    double gbTransferred = (uint64_t)iterations * sizeof(float) * elements * threads / (double)1e9;
    bw = 1000 * gbTransferred / (double)time_diff_ms;
    if (!shared) bw = bw * threads;
    //printf("%u iterations\n", iterations);
    //printf("%f GB, %lu ms\n", gbTransferred, time_diff_ms);

    free(testThreads);
    if (shared) VirtualFree(testArr, elements * sizeof(float), MEM_RELEASE);
    free(tids);

    if (!shared) {
        for (int i = 0; i < threads; i++) {
            VirtualFreeEx(GetCurrentProcess(), threadData[i].arr, 0, MEM_RELEASE);
        }
    }

    free(threadData);
    return bw;
}

void FillInstructionArray(uint64_t* arr, uint64_t sizeKb, enum NopType nopSize)
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
        uint64_t *branchPtr = (uint64_t*)(branch16b);
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

#ifdef _WIN64
float __fastcall instr_read(void* arr, uint64_t arr_length, uint64_t iterations)
#else
float __fastcall instr_read(void* arr, uint32_t arr_length, uint32_t iterations)
#endif
{
    void (*nopfunc)(uint64_t);
    nopfunc = (void(*)(uint64_t))arr;
    int iterIdx;
    for (iterIdx = 0; iterIdx < iterations; iterIdx++) nopfunc(iterations);
    return iterIdx;
}

float __fastcall scalar_read(void* a, uint32_t arr_length, uint32_t iterations)  {
    float sum = 0;
    if (16 >= arr_length) return 0;

    uint32_t iter_idx = 0, i = 0;
    float s1 = 0, s2 = 1, s3 = 0, s4 = 1, s5 = 0, s6 = 1, s7 = 0, s8 = 1;
    float* arr = (float*)a;
    while (iter_idx < iterations) {
        s1 += arr[i];
        s2 *= arr[i + 1];
        s3 += arr[i + 2];
        s4 *= arr[i + 3];
        s5 += arr[i + 4];
        s6 *= arr[i + 5];
        s7 += arr[i + 6];
        s8 *= arr[i + 7];
        i += 8;
        if (i + 7 >= arr_length) i = 0;
        if (i == 0) iter_idx++;
    }

    sum += s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8;

    return sum;
}

// return sum of array
float sse_read(float* arr, uint64_t arr_length, uint64_t iterations) {
    float sum = 0;
    float iterSum = 0;
    // zero two sums
    __m128 s1 = _mm_setzero_ps();
    __m128 s2 = _mm_setzero_ps();
    __m128 s3 = _mm_loadu_ps(arr);
    __m128 s4 = _mm_loadu_ps(arr);
    __m128 s5 = _mm_setzero_ps();
    __m128 s6 = _mm_setzero_ps();
    __m128 s7 = _mm_loadu_ps(arr);
    __m128 s8 = _mm_loadu_ps(arr);
    __m128 zero = _mm_setzero_ps();

    uint64_t iter_idx = 0, i = 0;
    while (iter_idx < iterations) {
        __m128 e1 = _mm_loadu_ps(arr + i);
        __m128 e2 = _mm_loadu_ps(arr + i + 4);
        __m128 e3 = _mm_loadu_ps(arr + i + 8);
        __m128 e4 = _mm_loadu_ps(arr + i + 12);
        __m128 e5 = _mm_loadu_ps(arr + i + 16);
        __m128 e6 = _mm_loadu_ps(arr + i + 20);
        __m128 e7 = _mm_loadu_ps(arr + i + 24);
        __m128 e8 = _mm_loadu_ps(arr + i + 28);
        s1 = _mm_add_ps(s1, e1);
        s2 = _mm_add_ps(s2, e2);
        s3 = _mm_mul_ps(s3, e3);
        s4 = _mm_mul_ps(s4, e4);
        s5 = _mm_add_ps(s5, e5);
        s6 = _mm_add_ps(s6, e6);
        s7 = _mm_mul_ps(s7, e7);
        s8 = _mm_mul_ps(s8, e8);
        i += 32;
        if (i + 31 >= arr_length) i = 0;
        if (i == 0) iter_idx++;
    }

    iterSum = _mm_cvtss_f32(s1) + _mm_cvtss_f32(s2) + _mm_cvtss_f32(s3) + _mm_cvtss_f32(s4) +
        _mm_cvtss_f32(s5) + _mm_cvtss_f32(s6) + _mm_cvtss_f32(s7) + _mm_cvtss_f32(s8);
    sum = iterSum;
    return sum;
}

#ifdef _WIN64
float avx_read(float* arr, uint64_t arr_length, uint64_t iterations) {
    float sum = 0;
    float iterSum = 0;
    __m256 s1 = _mm256_setzero_ps();
    __m256 s2 = _mm256_loadu_ps(arr);
    __m256 s3 = _mm256_setzero_ps();
    __m256 s4 = _mm256_loadu_ps(arr);
    __m256 s5 = _mm256_loadu_ps(arr);
    __m256 s6 = _mm256_loadu_ps(arr);
    __m256 s7 = _mm256_loadu_ps(arr);
    __m256 s8 = _mm256_loadu_ps(arr);
    uint64_t iter_idx = 0, i = 0;

    while (iter_idx < iterations) {
        __m256 e1 = _mm256_loadu_ps(arr + i);
        __m256 e2 = _mm256_loadu_ps(arr + i + 8);
        __m256 e3 = _mm256_loadu_ps(arr + i + 16);
        __m256 e4 = _mm256_loadu_ps(arr + i + 24);
        __m256 e5 = _mm256_loadu_ps(arr + i + 32);
        __m256 e6 = _mm256_loadu_ps(arr + i + 40);
        __m256 e7 = _mm256_loadu_ps(arr + i + 48);
        __m256 e8 = _mm256_loadu_ps(arr + i + 56);
        s1 = _mm256_add_ps(s1, e1);
        s2 = _mm256_mul_ps(s2, e2);
        s3 = _mm256_add_ps(s3, e3);
        s4 = _mm256_mul_ps(s4, e4);
        s5 = _mm256_mul_ps(s5, e5);
        s6 = _mm256_mul_ps(s6, e6);
        s7 = _mm256_mul_ps(s7, e7);
        s8 = _mm256_mul_ps(s8, e8);
        i += 64;
        if (i + 63 >= arr_length) i = 0;
        if (i == 0) iter_idx++;
    }

    // sink the result somehow
    iterSum = _mm256_cvtss_f32(s1) + _mm256_cvtss_f32(s2) + _mm256_cvtss_f32(s3) + _mm256_cvtss_f32(s4) +
        _mm256_cvtss_f32(s5) + _mm256_cvtss_f32(s6) + _mm256_cvtss_f32(s7) + _mm256_cvtss_f32(s8);
    sum = iterSum;

    return sum;
}
#endif

DWORD WINAPI ReadBandwidthTestThread(LPVOID param) {
    BandwidthTestThreadData* bwTestData = (BandwidthTestThreadData*)param;
    float sum = bw_func(bwTestData->arr, bwTestData->arr_length, bwTestData->iterations);
    if (sum == 0) printf("woohoo\n");
    return 0;
}

void PrintNumaInfo() {
    ULONG highestNumaNode;
    DWORD nProcs;
    SYSTEM_INFO SystemInfo;
    GetSystemInfo(&SystemInfo);
    nProcs = SystemInfo.dwNumberOfProcessors;
    if (!GetNumaHighestNodeNumber(&highestNumaNode)) {
        fprintf(stderr, "Could not get highest NUMA node number: %d\n", GetLastError());
        return;
    }

    printf("%d processors, highest NUMA node is %lu\n", nProcs, highestNumaNode);

    if (highestNumaNode == 0)
    {
        return;
    }

    for (int procIdx = 0; procIdx < nProcs; procIdx++)
    {
        unsigned char node;
        GetNumaProcessorNode(procIdx, &node);
        printf("Processor %d is on node %d\n", procIdx, node);
    }

    for (char nodeIdx = 0; nodeIdx <= highestNumaNode; nodeIdx++) {
        ULONGLONG mask;
        GetNumaNodeProcessorMask(nodeIdx, &mask);
        printf("Node %d: %llx\n", nodeIdx, mask);
    }
}

char GetStripeNode(uint64_t threadIdx) {
    ULONG highestNumaNode;
    if (!GetNumaHighestNodeNumber(&highestNumaNode)) {
        fprintf(stderr, "Could not get highest NUMA node number: %d\n", GetLastError());
        return 0;
    }

    return threadIdx % highestNumaNode;
}

char GetSeqNode(uint64_t threadIdx) {
    SYSTEM_INFO SystemInfo;
    GetSystemInfo(&SystemInfo);
    unsigned int clippedThreadIdx = threadIdx % SystemInfo.dwNumberOfProcessors;
    unsigned char node;
    GetNumaProcessorNode(clippedThreadIdx, &node);
    return node;
}
