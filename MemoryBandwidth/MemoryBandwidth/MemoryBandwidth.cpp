// MemoryBandwidth.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys\timeb.h>
#include <intrin.h>
#include <immintrin.h>
#include <windows.h>

int default_test_sizes[39] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576, 1572864, 2097152, 3145728 };

struct BandwidthTestThreadData {
    uint64_t iterations;
    uint64_t arr_length;
    float* arr;
    float bw; // written to by the thread
};

float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations);
float sse_read(float* arr, uint64_t arr_length, uint64_t iterations);
float avx_read(float* arr, uint64_t arr_length, uint64_t iterations);
float MeasureBw(uint64_t sizeKb, uint64_t iterations, uint64_t threads);
extern "C" float avx_asm_read(float* arr, uint64_t arr_length, uint64_t iterations);
uint64_t GetIterationCount(uint64_t testSize, uint64_t threads);
DWORD WINAPI ReadBandwidthTestThread(LPVOID param);

float (*bw_func)(float*, uint64_t, uint64_t) = avx_asm_read;

int main(int argc, char *argv[]) {
    float bw = MeasureBw(262144, 10, 8);
    int threads = 1;
    if (argc > 1) {
        threads = atoi(argv[1]);
    }

    printf("Using %d threads\n", threads);
    for (int i = 0; i < sizeof(default_test_sizes) / sizeof(int); i++)
    {
        printf("%d,%f\n", default_test_sizes[i], MeasureBw(default_test_sizes[i], GetIterationCount(default_test_sizes[i], threads), threads));
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
    uint64_t gbToTransfer = 256;
    if (testSize > 64) gbToTransfer = 64;
    if (testSize > 512) gbToTransfer = 32;
    if (testSize > 8192) gbToTransfer = 16;
    uint64_t iterations = gbToTransfer * 1024 * 1024 / testSize;

    if (iterations == 0) return 1;
    else return iterations;
}

float MeasureBw(uint64_t sizeKb, uint64_t iterations, uint64_t threads) {
    struct timeb start, end;
    float bw = 0;
    uint64_t elements = sizeKb * 1024 / sizeof(float);

    // make array and fill it with something
    float* testArr = (float*)malloc(elements * sizeof(float));
    for (uint64_t i = 0; i < elements; i++) {
        testArr[i] = i + 0.5f;
    }

    HANDLE* testThreads = (HANDLE*)malloc(threads * sizeof(HANDLE));
    DWORD* tids = (DWORD*)malloc(threads * sizeof(DWORD));
    bw_func(testArr, 128, iterations);
    struct BandwidthTestThreadData* threadData = (struct BandwidthTestThreadData*)malloc(threads * sizeof(struct BandwidthTestThreadData));

    ftime(&start);
    for (uint64_t i = 0; i < threads; i++) {
        threadData[i].arr = testArr;
        threadData[i].arr_length = elements;
        threadData[i].iterations = iterations;
        threadData[i].bw = 0;
        testThreads[i] = CreateThread(NULL, 0, ReadBandwidthTestThread, threadData + i, 0, tids + i);
    }

    WaitForMultipleObjects(threads, testThreads, TRUE, INFINITE);
    ftime(&end);

    int64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
    double gbTransferred = iterations * sizeof(float) * elements * threads / (double)1e9;
    bw = 1000 * gbTransferred / (double)time_diff_ms;
    //printf("%f GB, %lu ms\n", gbTransferred, time_diff_ms);

    free(testThreads);
    free(testArr);
    free(tids);
    return bw;
}

float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations) {
    float sum = 0;
    for (uint64_t iter_idx = 0; iter_idx < iterations; iter_idx++) {
        for (uint64_t i = 0; (i + 15) < arr_length; i += 16) {
            // sum elements 0-15 for consistency
            float partialSum1 = arr[i] + arr[i + 1];
            float partialSum2 = arr[i + 2] + arr[i + 3];
            float partialSum3 = arr[i + 4] + arr[i + 5];
            float partialSum4 = arr[i + 6] + arr[i + 7];
            float partialSum5 = arr[i + 8] + arr[i + 9];
            float partialSum6 = arr[i + 10] + arr[i + 11];
            float partialSum7 = arr[i + 12] + arr[i + 13];
            float partialSum8 = arr[i + 14] + arr[i + 15];
            sum += partialSum1 + partialSum2 + partialSum3 + partialSum4 + partialSum5 + partialSum6 + partialSum7 + partialSum8;
        }
    }

    return sum;
}

// return sum of array
float sse_read(float* arr, uint64_t arr_length, uint64_t iterations) {
    float sum = 0;
    for (uint64_t iter_idx = 0; iter_idx < iterations; iter_idx++) {
        float iterSum = 0;
        // zero two sums
        __m128 vecSum = _mm_setzero_ps();
        __m128 zero = _mm_setzero_ps();
        for (uint64_t i = 0; (i + 15) < arr_length; i += 16)
        {
            // each 128-bit vector has 4x32-bit elements
            // unrolled loop loads elements 0-15
            __m128 e1 = _mm_loadu_ps(arr + i);
            __m128 e2 = _mm_loadu_ps(arr + i + 4);
            __m128 e3 = _mm_loadu_ps(arr + i + 8);
            __m128 e4 = _mm_loadu_ps(arr + i + 12);
            __m128 partialSum1 = _mm_add_ps(e1, e2);
            __m128 partialSum2 = _mm_add_ps(e3, e4);
            vecSum = _mm_add_ps(vecSum, partialSum1);
            vecSum = _mm_add_ps(vecSum, partialSum2);
        }

        // who cares just extract the first one, sink the result somehow
        //vecSum = _mm_hadd_ps(vecSum, zero);
        //vecSum = _mm_hadd_ps(vecSum, zero);
        iterSum = _mm_cvtss_f32(vecSum);
        sum = iterSum;
    }

    return sum;
}

float avx_read(float* arr, uint64_t arr_length, uint64_t iterations) {
    float sum = 0;
    for (uint64_t iter_idx = 0; iter_idx < iterations; iter_idx++) {
        float iterSum = 0;
        __m256 s1 = _mm256_setzero_ps();
        __m256 s2 = _mm256_loadu_ps(arr);
        __m256 s3 = _mm256_setzero_ps();
        __m256 s4 = _mm256_loadu_ps(arr);
        __m256 s5 = _mm256_loadu_ps(arr);
        __m256 s6 = _mm256_loadu_ps(arr);
        __m256 s7 = _mm256_loadu_ps(arr);
        __m256 s8 = _mm256_loadu_ps(arr);
        for (uint64_t i = 0; (i + 63) < arr_length; i += 64)
        {
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
        }

        // sink the result somehow
        iterSum = _mm256_cvtss_f32(s1) + _mm256_cvtss_f32(s2) + _mm256_cvtss_f32(s3) + _mm256_cvtss_f32(s4) +
            _mm256_cvtss_f32(s5) + _mm256_cvtss_f32(s6) + _mm256_cvtss_f32(s7) + _mm256_cvtss_f32(s8);
        sum = iterSum;
    }

    return sum;
}

DWORD WINAPI ReadBandwidthTestThread(LPVOID param) {
    BandwidthTestThreadData* bwTestData = (BandwidthTestThreadData*)param;
    float sum = bw_func(bwTestData->arr, bwTestData->arr_length, bwTestData->iterations);
    if (sum == 0) printf("woohoo\n");
    return 0;
}