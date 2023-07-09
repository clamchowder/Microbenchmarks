// MixedMemoryBandwidthTest.cpp : One-off microbenchmark for hitting L2 with both instruction and data accesses
//

#include <stdio.h>
#include <intrin.h>
#include <immintrin.h>
#include <sys\timeb.h>
#include <math.h>
#include <windows.h>
#include "MemoryBandwidth.h"

int default_test_sizes[39] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576, 1572864, 2097152, 3145728 };

double Measure2TBw(uint32_t sizeKb, uint32_t iterations, int shared, enum InstructionTestType instr, double* final_instr_bw, double* final_data_bw);

int main(int argc, char *argv[])
{
    int shared = 0;

    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char* arg = argv[argIdx] + 1;
            if (_strnicmp(arg, "shared", 6) == 0) {
                shared = 1;
                fprintf(stderr, "Using one array shared across all threads\n");
            }
        }
    }
    auto_set_bw_func();
    double* test_results = (double *)malloc(2 * sizeof(double) * (sizeof(default_test_sizes) / sizeof(int)));
    memset(test_results, 0, 2 * sizeof(double) * (sizeof(default_test_sizes) / sizeof(int)));
    for (int test_size_idx = 0; test_size_idx < sizeof(default_test_sizes) / sizeof(int); test_size_idx++)
    {
        fprintf(stderr, "Testing %d KB\n", default_test_sizes[test_size_idx]);
        Measure2TBw(default_test_sizes[test_size_idx], GetIterationCount(default_test_sizes[test_size_idx], 2), shared, EightByte, &test_results[test_size_idx * 2], &test_results[test_size_idx * 2 + 1]);
    }

    printf("Test Size (KB), Instruction Bandwidth (GB/s), Data Bandwidth (GB/s)\n");
    for (int test_size_idx = 0; test_size_idx < sizeof(default_test_sizes) / sizeof(int); test_size_idx++)
    {
        printf("%d,%f,%f\n", default_test_sizes[test_size_idx], test_results[test_size_idx * 2], test_results[test_size_idx * 2 + 1]);
    }

    free(test_results);
    return 0;
}

DWORD WINAPI ReadBandwidthTestThread(LPVOID param) {
    BandwidthTestThreadData* bwTestData = (BandwidthTestThreadData*)param;
    uint64_t start_tsc = __rdtsc();
    bwTestData->bw_func(bwTestData->arr, bwTestData->arr_length, bwTestData->iterations);
    bwTestData->tsc_duration = __rdtsc() - start_tsc;
    return 0;
}

// Use two threads to measure bandwidth and pin them to sibling SMT cores
// One thread measures instruction bandwidth, the other measures data bw
// Auto-adjusts iteration counts to prevent long-tailed behavior where one thread finishes first
double Measure2TBw(uint32_t sizeKb, uint32_t iterations, int shared, enum InstructionTestType instr, double *final_instr_bw, double *final_data_bw) {
    struct timeb start, end;
    float bw = 0;
    uint32_t elements = sizeKb * 1024 / sizeof(float);
    uint32_t private_elements = ceil((double)sizeKb / 2) * 256;
    DWORD protection_flags = PAGE_EXECUTE_READWRITE;
    DWORD tids[2];
    struct BandwidthTestThreadData instrThreadData, dataThreadData;

    if (!shared) elements = private_elements;
    if (!shared && sizeKb < 2) {
        return 0;
    }

    // make array and fill it
    float* sharedTestArr = NULL;
    if (shared) {
        // shared case: both threads read from the same array. it has to contain valid instructions
        sharedTestArr = (float*)VirtualAlloc(NULL, elements * sizeof(float), MEM_COMMIT | MEM_RESERVE, protection_flags);
        if (sharedTestArr == NULL) {
            fprintf(stderr, "Could not allocate memory\n");
            return 0;
        }

        FillInstructionArray((uint64_t*)sharedTestArr, sizeKb, instr);
        instrThreadData.arr = sharedTestArr;
        dataThreadData.arr = sharedTestArr;
    }
    else {
        // Give threads different arrays
        instrThreadData.arr = (float*)VirtualAlloc(NULL, elements * sizeof(float), MEM_COMMIT | MEM_RESERVE, protection_flags);
        dataThreadData.arr = (float*)VirtualAlloc(NULL, elements * sizeof(float), MEM_COMMIT | MEM_RESERVE, protection_flags);
        FillInstructionArray((uint64_t*)instrThreadData.arr, (elements * 4) / 1024, instr);
        for (uint64_t arr_idx = 0; arr_idx < elements; arr_idx++) {
            dataThreadData.arr[arr_idx] = arr_idx + 0.5f;
        }
    }

    instrThreadData.arr_length = elements;
    instrThreadData.bw_func = instr_read;
    instrThreadData.iterations = iterations;
    dataThreadData.arr_length = elements;
    dataThreadData.bw_func = bw_func;
    dataThreadData.iterations = iterations;

    while (true) {
        HANDLE instrThread = CreateThread(NULL, 0, ReadBandwidthTestThread, &instrThreadData, CREATE_SUSPENDED, &tids[0]);
        HANDLE dataThread = CreateThread(NULL, 0, ReadBandwidthTestThread, &dataThreadData, CREATE_SUSPENDED, &tids[1]);
    
        // set thread affinity to sibling SMT threads
        ULONGLONG instrMask = 0, dataMask = 0;
        instrMask = (1UL << 2);
        dataMask = (1UL << 3);
        SetThreadAffinityMask(instrThread, instrMask);
        SetThreadAffinityMask(dataThread, dataMask);

        ftime(&start);
        ResumeThread(instrThread);
        ResumeThread(dataThread);
        WaitForSingleObject(dataThread, INFINITE);
        WaitForSingleObject(instrThread, INFINITE);
        ftime(&end);

        int64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
        double instrGbTransferred = (uint64_t)instrThreadData.iterations * sizeof(float) * elements / (double)1e9;
        double dataGbTransferred = (uint64_t)dataThreadData.iterations * sizeof(float) * elements / (double)1e9;
        double dataBw = 1000 * instrGbTransferred / (double)time_diff_ms;
        double instrBw = 1000 * dataGbTransferred / (double)time_diff_ms;
        bw = dataBw + instrBw;

        double instr_over_data_ratio = (double)instrThreadData.tsc_duration / (double)dataThreadData.tsc_duration;
        fprintf(stderr, "Instr %f GB/s in %f G ticks, data %f GB/s in %f G ticks, time ratio %f\n", 
            instrBw, instrThreadData.tsc_duration / 1e9, dataBw, dataThreadData.tsc_duration / 1e9, instr_over_data_ratio);
        if (fabs(instr_over_data_ratio - 1.0f) < .1f)
        {
            *final_instr_bw = instrBw;
            *final_data_bw = dataBw;
            break;
        }
        else
        {
            // adjust iteration count on data thread until they finish close enough
            dataThreadData.iterations *= instr_over_data_ratio;
        }
    }

    if (shared) VirtualFree(sharedTestArr, 0, MEM_RELEASE);
    else {
        VirtualFree(instrThreadData.arr, 0, MEM_RELEASE);
        VirtualFree(dataThreadData.arr, 0, MEM_RELEASE);
    }

    return bw;
}