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
    uint64_t iterations;
    uint64_t arr_length;
    uint64_t start;
    float* arr;
    float bw; // written to by the thread
};

float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
float sse_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
float avx_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
float MeasureBw(uint64_t sizeKb, uint64_t iterations, uint64_t threads, int shared);
extern "C" float avx_asm_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
uint64_t GetIterationCount(uint64_t testSize, uint64_t threads);
DWORD WINAPI ReadBandwidthTestThread(LPVOID param);

float (*bw_func)(float*, uint64_t, uint64_t, uint64_t start) = scalar_read;

int main(int argc, char *argv[]) {
    int threads = 1, shared = 1;
    int cpuid_data[4];

    if (argc == 1) {
        printf("Usage: [threads] [sse/avx/asm_avx/scalar] [shared/private]\n");
    }

    if (argc > 1) {
        threads = atoi(argv[1]);
        if (threads > 64) {
            threads = 64;
            fprintf(stderr, "Too many threads pls stop. Setting thread count to 64\n");
        }
    }

    if (argc > 2) {
        if (_strnicmp(argv[2], "sse", 3) == 0) {
            fprintf(stderr, "Using SSE\n");
            bw_func = sse_read;
        }
        else if (_strnicmp(argv[2], "avx", 3) == 0) {
            fprintf(stderr, "Using AVX\n");
            bw_func = avx_read;
        }
        else if (_strnicmp(argv[2], "asm_avx", 7) == 0) {
            fprintf(stderr, "Using AVX (asm)\n");
            bw_func = avx_asm_read;
        }
        else {
            fprintf(stderr, "Using scalar C code\n");
            bw_func = scalar_read;
        }
    }
    else {
        // check for sse/avx
        __cpuidex(cpuid_data, 1, 0);
        // EDX bit 25 = SSE
        if (cpuid_data[3] & (1UL << 25)) {
            fprintf(stderr, "SSE supported\n");
            bw_func = sse_read;
        }

        if (cpuid_data[2] & (1UL << 28)) {
            fprintf(stderr, "AVX supported\n");
            bw_func = avx_asm_read;
        }
    }

    if (argc > 3)
    {
        if (_strnicmp(argv[3], "private", 7) == 0) {
            shared = 0;
            fprintf(stderr, "Using private data per-thread\n");
        }
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
uint64_t GetIterationCount(uint64_t testSize, uint64_t threads)
{
    uint64_t gbToTransfer = 512;
    if (testSize > 64) gbToTransfer = 64;
    if (testSize > 512) gbToTransfer = 32;
    if (testSize > 8192) gbToTransfer = 16;
    uint64_t iterations = gbToTransfer * 1024 * 1024 / testSize;

    if (iterations < 8) return 8; // set a minimum to reduce noise
    else return iterations;
}

float MeasureBw(uint64_t sizeKb, uint64_t iterations, uint64_t threads, int shared) {
    struct timeb start, end;
    float bw = 0;
    uint64_t elements = sizeKb * 1024 / sizeof(float);
    uint64_t private_elements = (uint64_t)ceil(((double)sizeKb * 1024 / sizeof(float)) / (double)threads);

    if (!shared) elements = private_elements;

    if (sizeKb < threads) {
        fprintf(stderr, "Too many threads for this size, continuing\n");
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

        for (uint64_t i = 0; i < elements; i++) {
            testArr[i] = i + 0.5f;
        }
    }

    HANDLE* testThreads = (HANDLE*)malloc(threads * sizeof(HANDLE));
    DWORD* tids = (DWORD*)malloc(threads * sizeof(DWORD));
    //bw_func(testArr, 128, iterations);
    struct BandwidthTestThreadData* threadData = (struct BandwidthTestThreadData*)malloc(threads * sizeof(struct BandwidthTestThreadData));

    ftime(&start);
    for (uint64_t i = 0; i < threads; i++) {
        if (shared) {
            threadData[i].arr = testArr;
            threadData[i].iterations = iterations;
        }
        else {
            threadData[i].arr = (float*)_aligned_malloc(elements * sizeof(float), 64);
            if (threadData[i].arr == NULL) {
                fprintf(stderr, "Could not allocate memory for thread %ld\n", i);
                return 0;
            }

            for (uint64_t arr_idx = 0; arr_idx < elements; arr_idx++) {
                threadData[i].arr[arr_idx] = arr_idx + i + 0.5f;
            }

            threadData[i].iterations = iterations * threads;
        }

        threadData[i].arr_length = elements;
        threadData[i].bw = 0;
        threadData[i].start = 0;
        if (elements > 8192 * 1024) threadData[i].start = 4096 * i; // must be multiple of 128 because of unrolling
        testThreads[i] = CreateThread(NULL, 0, ReadBandwidthTestThread, threadData + i, 0, tids + i);
        SetThreadAffinityMask(testThreads[i], 1UL << i);
    }

    WaitForMultipleObjects(threads, testThreads, TRUE, INFINITE);
    ftime(&end);

    int64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
    double gbTransferred = iterations * sizeof(float) * elements * threads / (double)1e9;
    bw = 1000 * gbTransferred / (double)time_diff_ms;
    if (!shared) bw = bw * threads;
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

float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) {
    float sum = 0;
    if (start + 16 >= arr_length) return 0;

    uint64_t iter_idx = 0, i = start;
    float s1 = 0, s2 = 1, s3 = 0, s4 = 1, s5 = 0, s6 = 1, s7 = 0, s8 = 1;
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
        if (i == start) iter_idx++;
    }
        
    sum += s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8;

    return sum;
}

// return sum of array
float sse_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) {
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

    uint64_t iter_idx = 0, i = start;
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
        if (i == start) iter_idx++;
    }

    iterSum = _mm_cvtss_f32(s1) + _mm_cvtss_f32(s2) + _mm_cvtss_f32(s3) + _mm_cvtss_f32(s4) + 
        _mm_cvtss_f32(s5) + _mm_cvtss_f32(s6) + _mm_cvtss_f32(s7) + _mm_cvtss_f32(s8);
    sum = iterSum;
    return sum;
}

float avx_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) {
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
    uint64_t iter_idx = 0, i = start;

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
        if (i == start) iter_idx++;
    }

    // sink the result somehow
    iterSum = _mm256_cvtss_f32(s1) + _mm256_cvtss_f32(s2) + _mm256_cvtss_f32(s3) + _mm256_cvtss_f32(s4) +
        _mm256_cvtss_f32(s5) + _mm256_cvtss_f32(s6) + _mm256_cvtss_f32(s7) + _mm256_cvtss_f32(s8);
    sum = iterSum;

    return sum;
}

DWORD WINAPI ReadBandwidthTestThread(LPVOID param) {
    BandwidthTestThreadData* bwTestData = (BandwidthTestThreadData*)param;
    float sum = bw_func(bwTestData->arr, bwTestData->arr_length, bwTestData->iterations, bwTestData->start);
    if (sum == 0) printf("woohoo\n");
    return 0;
}