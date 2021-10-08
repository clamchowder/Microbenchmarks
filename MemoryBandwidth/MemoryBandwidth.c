// MemoryBandwidth.c : Version for linux (x86 and ARM)
// Mostly the same as the x86-only VS version, but a bit more manual

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <unistd.h>
#include <sched.h>
#include <pthread.h>
#include <math.h>

int default_test_sizes[39] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576, 1572864, 2097152, 3145728 };

typedef struct BandwidthTestThreadData {
    uint64_t iterations;
    uint64_t arr_length;
    uint64_t start;
    float* arr;
    float bw; // written to by the thread
} BandwidthTestThreadData;

float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
float MeasureBw(uint64_t sizeKb, uint64_t iterations, uint64_t threads, int shared);


extern float asm_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);

extern float avx512_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
uint64_t GetIterationCount(uint64_t testSize, uint64_t threads);
void *ReadBandwidthTestThread(void *param);

float (*bw_func)(float*, uint64_t, uint64_t, uint64_t start) = scalar_read;

int main(int argc, char *argv[]) {
    int threads = 1;
    int cpuid_data[4];
    int shared = 1;

    if (argc > 1) {
        threads = atoi(argv[1]);
    }
    if (argc > 2)
    {
        if (strncmp(argv[2], "private", 7) == 0)
        {
            shared = 0;
            printf("Using private data per-thread\n");
        }
    }
    
    if (argc == 1)
    {
        printf("Usage: [threads] [shared/private] [scalar/asm/avx512]\n");
    }

    //bw_func = scalar_read;
    printf("Using asm\n");
    bw_func = asm_read;

    if (argc > 3) 
    {
        if (strncmp(argv[3], "scalar", 6) == 0) {
            bw_func = scalar_read;
            printf("Using scalar C code\n");
        } else if (strncmp(argv[3], "asm", 3) == 0) {
            bw_func = asm_read;
            printf("Using asm (neon or avx)\n");
        } else if (strncmp(argv[3], "avx512", 6) == 0) {
            bw_func = avx512_read;
            printf("Using avx512\n");
        }
    }


    printf("Using %d threads\n", threads);
    for (int i = 0; i < sizeof(default_test_sizes) / sizeof(int); i++)
    {
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
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    float bw = 0;
    uint64_t elements = sizeKb * 1024 / sizeof(float);

    // make sure this is divisble by 512 bytes, since the unrolled asm loop depends on that
    // it's hard enough to get close to theoretical L1D BW as is, so we don't want additional cmovs or branches
    // in the hot loop
    uint64_t private_elements = (uint64_t)ceil(((double)sizeKb * 1024 / sizeof(float)) / (double)threads);
    //fprintf(stderr, "Actual data: %lu KB\n", private_elements * 4 * threads / 1024);

    // make array and fill it with something, if shared
    float* testArr = NULL;
    if (shared){ 
        testArr = (float*)aligned_alloc(64, elements * sizeof(float));
        if (testArr == NULL) {
            fprintf(stderr, "Could not allocate memory\n");
            return 0;
        }

        for (uint64_t i = 0; i < elements; i++) {
            testArr[i] = i + 0.5f;
        }
    }
    else 
    {
        elements = private_elements; // will fill arrays below, per-thread
    }

    pthread_t* testThreads = (pthread_t*)malloc(threads * sizeof(pthread_t));
    struct BandwidthTestThreadData* threadData = (struct BandwidthTestThreadData*)malloc(threads * sizeof(struct BandwidthTestThreadData));

    gettimeofday(&startTv, &startTz);
    for (uint64_t i = 0; i < threads; i++) {
        if (shared) 
        {
            threadData[i].arr = testArr;
            threadData[i].iterations = iterations;
        }
        else
        {
            threadData[i].arr = (float*)aligned_alloc(64, elements * sizeof(float));
            if (threadData[i].arr == NULL)
            {
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
        int pthreadRc = pthread_create(testThreads + i, NULL, ReadBandwidthTestThread, (void *)(threadData + i));
    }

    for (uint64_t i = 0; i < threads; i++) pthread_join(testThreads[i], NULL);
    gettimeofday(&endTv, &endTz);

    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    double gbTransferred = iterations * sizeof(float) * elements * threads / (double)1e9;
    bw = 1000 * gbTransferred / (double)time_diff_ms;
    if (!shared) bw = bw * threads; // iteration count is divided by thread count if in thread private mode
    //printf("%f GB, %lu ms\n", gbTransferred, time_diff_ms);

    free(testThreads);
    free(testArr); // should be null in not-shared (private) mode

    if (!shared) {
        for (uint64_t i = 0; i < threads; i++) {
            free(threadData[i].arr);
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

void *ReadBandwidthTestThread(void *param) {
    BandwidthTestThreadData* bwTestData = (BandwidthTestThreadData*)param;
    float sum = bw_func(bwTestData->arr, bwTestData->arr_length, bwTestData->iterations, bwTestData->start);
    if (sum == 0) printf("woohoo\n");
    pthread_exit(NULL);
}
