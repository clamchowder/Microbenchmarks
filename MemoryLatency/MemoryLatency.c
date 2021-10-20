#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <sys/time.h>
#include <unistd.h>

#define ITERATIONS 100000000

// TODO: possibly get this programatically
#define PAGE_SIZE 4096
#define CACHELINE_SIZE 64

int default_test_sizes[36] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576 };

extern void preplatencyarr(uint64_t *arr, uint32_t len) __attribute__((ms_abi));
extern uint32_t latencytest(uint64_t iterations, uint64_t *arr) __attribute((ms_abi));                      

float RunTest(uint32_t size_kb, uint64_t iterations);
float RunAsmTest(uint32_t size_kb, uint64_t iterations);
float RunTlbTest(uint32_t size_kb, uint64_t iterations);

float (*testFunc)(uint32_t, uint64_t) = RunTest;

int main(int argc, char* argv[]) {
    if (argc > 1)
    {
        if (strncmp(argv[1], "tlb", 3) == 0) {
            testFunc = RunTlbTest;
            fprintf(stderr, "Running TLB test\n");
        } 
        
        if (strncmp(argv[1], "asm", 3) == 0) {
            testFunc = RunAsmTest;
            fprintf(stderr, "Running ASM (simple address) test\n");
        }
    }

    printf("Region,Latency (ns)\n");
    for (int i = 0; i < sizeof(default_test_sizes) / sizeof(int); i++)
    {
        printf("%d,%f\n", default_test_sizes[i], testFunc(default_test_sizes[i], ITERATIONS));
    }

    return 0;
}

/// <summary>
/// Heuristic to make sure test runs for enough time but not too long
/// </summary>
/// <param name="size_kb">Region size</param>
/// <param name="iterations">base iterations</param>
/// <returns>scaled iterations</returns>
uint64_t scale_iterations(uint32_t size_kb, uint64_t iterations) {
    uint64_t retval = iterations;
    if (size_kb <= 512) retval *= 10;
    if (size_kb > 4096) retval /= 10;
    if (size_kb > 131072) retval /= 30;
    return retval;
}

float RunTest(uint32_t size_kb, uint64_t iterations) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t list_size = size_kb * 1024 / 4;
    uint32_t sum = 0, current;

    // Fill list to create random access pattern
    int* A = (int*)malloc(sizeof(int) * list_size);
    for (int i = 0; i < list_size; i++) {
        A[i] = i;
    }

    int iter = list_size;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint32_t tmp = A[iter];
        A[iter] = A[j];
        A[j] = tmp;
    }

    uint64_t scaled_iterations = scale_iterations(size_kb, iterations);

    // Run test
    gettimeofday(&startTv, &startTz);
    current = A[0];
    for (int i = 0; i < scaled_iterations; i++) {
        current = A[current];
        sum += current;
    }
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float latency = 1e6 * (float)time_diff_ms / (float)scaled_iterations;
    free(A);

    if (sum == 0) printf("sum == 0 (?)\n");
    return latency;
}

float RunAsmTest(uint32_t size_kb, uint64_t iterations) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t list_size = size_kb * 1024 / sizeof(uint64_t); // using 64-bit pointers
    uint32_t sum = 0, current;

    // Fill list to create random access pattern
    uint64_t *A = (uint64_t*)malloc(sizeof(uint64_t) * list_size);
    for (int i = 0; i < list_size; i++) {
        A[i] = i;
    }

    int iter = list_size;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint64_t tmp = A[iter];
        A[iter] = A[j];
        A[j] = tmp;
    }

    preplatencyarr(A, list_size);

    uint64_t scaled_iterations = scale_iterations(size_kb, iterations);

    // Run test
    gettimeofday(&startTv, &startTz);
    sum = latencytest(scaled_iterations, A);
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float latency = 1e6 * (float)time_diff_ms / (float)scaled_iterations;
    free(A);

    if (sum == 0) printf("sum == 0 (?)\n");
    return latency;
}

float RunTlbTest(uint32_t size_kb, uint64_t iterations) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t element_count = size_kb / 4;
    uint32_t list_size = size_kb * 1024 / 4;
    uint32_t sum = 0, current;

    if (element_count == 0) element_count = 1;

    //fprintf(stderr, "Element count for size %u: %u\n", size_kb, element_count);

    // create access pattern first, then fill it into the test array spaced by page size
    uint32_t* pattern_arr = (uint32_t*)malloc(sizeof(uint32_t) * element_count);
    for (int i = 0; i < element_count; i++) {
        pattern_arr[i] = i;
    }

    int iter = element_count;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint32_t tmp = pattern_arr[iter];
        pattern_arr[iter] = pattern_arr[j];
        pattern_arr[j] = tmp;
    }

    // translate offsets and fill the test array
    // [offset-------page-------][offset-----page------....etc
    uint32_t *A = (uint32_t *)malloc(sizeof(uint32_t) * list_size);
    memset(A, INT_MAX, list_size); // catch any bad accesses immediately
    int pageIncrement = PAGE_SIZE / sizeof(uint32_t);
    for (int i = 0;i < element_count; i++) {
        // offset each by i cachelines to avoid conflict misses. If we just use the first cacheline
        // in each page, the index bits for every VIPT access will be the same and we'll run into L1D misses
        // faster than we would like
        int idx = i * pageIncrement + ((i * 16) & (pageIncrement - 1));
        int target_idx = pattern_arr[i] * pageIncrement + ((pattern_arr[i] * 16) & (pageIncrement - 1));
        A[idx] = target_idx;
    }

    free(pattern_arr);  // don't need this anymore

    uint64_t scaled_iterations = scale_iterations(size_kb, iterations);

    // Run test
    gettimeofday(&startTv, &startTz);
    current = A[0];
    for (int i = 0; i < scaled_iterations; i++) {
        current = A[current];
        sum += current;
        //if (size_kb == 48) fprintf(stderr, "idx: %u\n", current);
    }
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float latency = 1e6 * (float)time_diff_ms / (float)scaled_iterations;
    free(A);

    if (element_count > 1 && sum == 0) printf("sum == 0 (?)\n");

    // Get a reference timing for the size, to isolate TLB latency from cache latency
    uint32_t memoryUsedKb = (element_count * CACHELINE_SIZE) / 1024;
    if (memoryUsedKb == 0) memoryUsedKb = 1;
    float cacheLatency = RunTest(memoryUsedKb, iterations);

    //fprintf(stderr, "Memory used - %u KB, ref latency: %f\n", memoryUsedKb, cacheLatency);
    return latency - cacheLatency;
}
 
