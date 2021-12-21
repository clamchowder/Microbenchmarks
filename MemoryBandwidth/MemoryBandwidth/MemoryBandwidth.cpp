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

int default_test_sizes[39] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576, 1572864, 2097152, 3145728 };

struct BandwidthTestThreadData {
    uint32_t iterations;
    uint32_t arr_length;
    float* arr;
    float bw; // written to by the thread
};

uint32_t dataGb = 512;
//__int32 dataGb = 32;

// array length = number of 4 byte elements
float _fastcall scalar_read(void* arr, uint32_t arr_length, uint32_t iterations);

#ifdef _WIN64
extern "C" float sse_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx_asm_write(void* arr, uint64_t arr_length, uint64_t iterations);
extern "C" float avx512_asm_read(void* arr, uint64_t arr_length, uint64_t iterations);
float (*bw_func)(void*, uint64_t, uint64_t) = sse_asm_read;

#else
extern "C" float __fastcall mmx_asm_read32(void* arr, uint32_t arr_length, uint32_t iterations);
extern "C" float __fastcall sse_asm_read32(void* arr, uint32_t arr_length, uint32_t iterations);
extern "C" float __fastcall dummy(void* arr, uint32_t arr_length, uint32_t iterations);
float(_fastcall *bw_func)(void*, uint32_t, uint32_t) = dummy;
#endif

float MeasureBw(uint32_t sizeKb, uint32_t iterations, uint32_t threads, int shared);
uint32_t GetIterationCount(uint32_t testSize, uint32_t threads);
DWORD WINAPI ReadBandwidthTestThread(LPVOID param);

int main(int argc, char *argv[]) {
    int threads = 1, shared = 1, methodSet = 0;
    int cpuid_data[4];

    if (argc == 1) {
        printf("Usage: [-threads <thread count>] [-method <scalar/sse/avx/asm_avx/asm_avx512>] [-shared] [-private] [-data <base GB to transfer, default = 512>]\n");
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
                if (_strnicmp(argv[argIdx], "asm_sse", 7) == 0) {
                    bw_func = sse_asm_read;
                    fprintf(stderr, "Using SSE assembly\n");
                }
                else if (_strnicmp(argv[argIdx], "asm_avx512", 10) == 0) {
                    bw_func = avx512_asm_read;
                    fprintf(stderr, "Using AVX512 assembly\n");
                }
                else if (_strnicmp(argv[argIdx], "write_asm_avx", 14) == 0) {
                    bw_func = avx_asm_write;
                    fprintf(stderr, "Using AVX assembly, writing instead of reading\n");
                }
                else if (_strnicmp(argv[argIdx], "asm_avx", 7) == 0) {
                    bw_func = avx_asm_read;
                    fprintf(stderr, "Using AVX assembly\n");
                }
#else
                if (_strnicmp(argv[argIdx], "scalar", 6) == 0) {
                    bw_func = scalar_read;
                    fprintf(stderr, "Using scalar C code\n");
                }
                else if (_strnicmp(argv[argIdx], "sse", 3) == 0) {
                    bw_func = sse_asm_read32;
                    fprintf(stderr, "Using SSE assembly\n");
                }
                else if (_strnicmp(argv[argIdx], "mmx", 3) == 0) {
                    bw_func = mmx_asm_read32;
                    fprintf(stderr, "Using MMX assembly\n");
                }
#endif
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
        }
    }

    if (!methodSet) {
        // check for sse/avx
        __cpuidex(cpuid_data, 1, 0);
        // EDX bit 25 = SSE
        if (cpuid_data[3] & (1UL << 25)) {
            fprintf(stderr, "SSE supported\n");
#ifdef _WIN64
            bw_func = sse_asm_read;
#else
            bw_func = sse_asm_read32;
            //bw_func = scalar_read;
#endif
        }

#ifdef _WIN64
        if (cpuid_data[2] & (1UL << 28)) {
            fprintf(stderr, "AVX supported\n");
            bw_func = avx_asm_read;
        }

        __cpuidex(cpuid_data, 7, 0);
        if (cpuid_data[1] & (1UL << 16)) {
            fprintf(stderr, "AVX512 supported\n");
            bw_func = avx512_asm_read;
        }
#endif
    }

    printf("Using %d threads\n", threads);
    for (int i = 0; i < sizeof(default_test_sizes) / sizeof(int); i++) {
        printf("%d,%f\n", default_test_sizes[i], MeasureBw(default_test_sizes[i], GetIterationCount(default_test_sizes[i], threads), threads, shared));
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

    if (iterations < 8) return 8; // set a minimum to reduce noise
    else return iterations;
}

float MeasureBw(uint32_t sizeKb, uint32_t iterations, uint32_t threads, int shared) {
    struct timeb start, end;
    float bw = 0;
    uint32_t elements = sizeKb * 1024 / sizeof(float);
    //uint64_t private_elements = (uint64_t)ceil(((double)sizeKb * 1024 / sizeof(float)) / (double)threads);
    uint32_t private_elements = ceil((double)sizeKb / (double)threads) * 256;

    if (!shared) elements = private_elements;

    //fprintf(stderr, "%llu elements per thread\n", elements);

    if (!shared && sizeKb < threads) {
        //fprintf(stderr, "Too many threads for this size, continuing\n");
        return 0;
    }

    // make array and fill it with something
    float* testArr = NULL;
    if (shared) {
        testArr = (float*)_aligned_malloc(elements * sizeof(float), 64);
        if (testArr == NULL) {
            fprintf(stderr, "Could not allocate memory\n");
            return 0;
        }

        for (uint32_t i = 0; i < elements; i++) {
            testArr[i] = i + 0.5f;
        }
    }

    HANDLE* testThreads = (HANDLE*)malloc(threads * sizeof(HANDLE));
    DWORD* tids = (DWORD*)malloc(threads * sizeof(DWORD));
    //bw_func(testArr, 128, iterations);
    struct BandwidthTestThreadData* threadData = (struct BandwidthTestThreadData*)malloc(threads * sizeof(struct BandwidthTestThreadData));

    for (uint64_t i = 0; i < threads; i++) {
        if (shared) {
            threadData[i].arr = testArr;
            threadData[i].iterations = iterations;
        }
        else {
            threadData[i].arr = (float*)_aligned_malloc(elements * sizeof(float), 64);
            if (threadData[i].arr == NULL) {
                fprintf(stderr, "Could not allocate memory for thread %llu\n", i);
                return 0;
            }

            for (uint64_t arr_idx = 0; arr_idx < elements; arr_idx++) {
                threadData[i].arr[arr_idx] = arr_idx + i + 0.5f;
            }

            threadData[i].iterations = iterations * threads;
        }

        threadData[i].arr_length = elements;
        threadData[i].bw = 0;
        testThreads[i] = CreateThread(NULL, 0, ReadBandwidthTestThread, threadData + i, CREATE_SUSPENDED, tids + i);

        // turns out setting affinity makes no difference, and it's easier to set affinity via start /affinity <mask> anyway
        //SetThreadAffinityMask(testThreads[i], 1UL << i);
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
    if (shared) _aligned_free(testArr);
    free(tids);

    if (!shared) {
        for (int i = 0; i < threads; i++) {
            _aligned_free(threadData[i].arr);
        }
    }

    free(threadData);
    return bw;
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

DWORD WINAPI ReadBandwidthTestThread(LPVOID param) {
    BandwidthTestThreadData* bwTestData = (BandwidthTestThreadData*)param;
    float sum = bw_func(bwTestData->arr, bwTestData->arr_length, bwTestData->iterations);
    if (sum == 0) printf("woohoo\n");
    return 0;
}
