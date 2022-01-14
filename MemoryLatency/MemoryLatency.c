#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include <sys/time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>

// TODO: possibly get this programatically
#define PAGE_SIZE 4096
#define CACHELINE_SIZE 64

int default_test_sizes[37] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576 };

#ifdef __x86_64
extern void preplatencyarr(uint64_t *arr, uint32_t len) __attribute__((ms_abi));
extern uint32_t latencytest(uint64_t iterations, uint64_t *arr) __attribute((ms_abi));
extern void stlftest(uint64_t iterations, uint32_t *arr) __attribute((ms_abi));
extern void matchedstlftest(uint64_t iterations, uint32_t *arr) __attribute((ms_abi));
extern void stlftest32(uint64_t iterations, uint32_t *arr) __attribute((ms_abi));
void (*stlfFunc)(uint64_t, uint32_t *) __attribute__((ms_abi)) = stlftest;
#elif __i686
extern void preplatencyarr(uint32_t *arr, uint32_t len) __attribute__((fastcall));
extern uint32_t latencytest(uint32_t iterations, uint32_t *arr) __attribute((fastcall));
extern void stlftest(uint32_t iterations, uint32_t *arr) __attribute((fastcall));
extern void matchedstlftest(uint32_t iterations, uint32_t *arr) __attribute((fastcall));
void (*stlfFunc)(uint32_t, uint32_t *) __attribute__((fastcall)) = stlftest;
#define BITS_32
#elif __aarch64__
extern void preplatencyarr(uint64_t *arr, uint32_t len);
extern uint32_t latencytest(uint64_t iterations, uint64_t *arr);
extern void matchedstlftest(uint64_t iterations, uint32_t *arr);
extern void stlftest(uint64_t iterations, uint32_t *arr);
extern void stlftest32(uint64_t iterations, uint32_t *arr);
void (*stlfFunc)(uint64_t, uint32_t *) = stlftest;
#else 
#define UNKNOWN_ARCH 1
extern uint32_t latencytest(uint64_t iterations, uint64_t *arr);
void (*stlfFunc)(uint64_t, uint32_t *) = NULL;
#endif

float RunTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr);
float RunAsmTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr);
float RunTlbTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr);
float RunMlpTest(uint32_t size_kb, uint32_t iterations, uint32_t parallelism);
void RunStlfTest(uint32_t iterations, int mode);

float (*testFunc)(uint32_t, uint32_t, uint32_t *) = RunTest;

uint32_t ITERATIONS = 100000000;

int main(int argc, char* argv[]) {
    uint32_t maxTestSizeMb = 0;
    uint32_t testSizeCount = sizeof(default_test_sizes) / sizeof(int);
    int mlpTest = 0;  // if > 0, run MLP test with (value) levels of parallelism max
    int stlf = 0, hugePages = 0;
    uint32_t *hugePagesArr = NULL;
    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char *arg = argv[argIdx] + 1; 
            if (strncmp(arg, "test", 4) == 0) {
                argIdx++;
                char *testType = argv[argIdx];
                
		if (strncmp(testType, "c", 1) == 0) {
                    testFunc = RunTest;
                    fprintf(stderr, "Using simple C test\n");
                } else if (strncmp(testType, "tlb", 3) == 0) {
                    testFunc = RunTlbTest;
                    fprintf(stderr, "Testing TLB with one element accessed per 4K page\n");
                } else if (strncmp(testType, "mlp", 3) == 0) {
                    mlpTest = 32;
                    fprintf(stderr, "Running memory parallelism test\n");
                } 
                #ifndef UNKNOWN_ARCH
                else if (strncmp(testType, "asm", 3) == 0) {
                    testFunc = RunAsmTest;
                    fprintf(stderr, "Using ASM (simple address) test\n");
                } else if (strncmp(testType, "stlf", 4) == 0) {
                    stlf = 1;
                    fprintf(stderr, "Running store to load forwarding test\n");
                } else if (strncmp(testType, "matched_stlf", 4) == 0) {
                    stlf = 1;
                    stlfFunc = matchedstlftest;
                    fprintf(stderr, "Running store to load forwarding test, with matched load/store sizes\n");
                }
		#ifndef BITS_32
                else if (strncmp(testType, "dword_stlf", 9) == 0) {
                    stlf = 2;
                    stlfFunc = stlftest32;
                    fprintf(stderr, "Running store to load forwarding test, with 32-bit stores\n");
                }
		#endif
		#endif
                else {
                    fprintf(stderr, "Unrecognized test type: %s\n", testType);
                    fprintf(stderr, "Valid test types: c, tlb, mlp");
		    #ifndef UNKNOWN_ARCH
		    fprintf(stderr, ", asm, stlf, matched_stlf, dword_stlf");
		    #endif
		    fprintf(stderr, "\n");
                }
            } else if (strncmp(arg, "maxsizemb", 9) == 0) {
                argIdx++;
                maxTestSizeMb = atoi(argv[argIdx]);
                fprintf(stderr, "Will not exceed %u MB\n", maxTestSizeMb);
            } else if (strncmp(arg, "iter", 4) == 0) {
                argIdx++;
                ITERATIONS = atoi(argv[argIdx]);
                fprintf(stderr, "Base iterations: %u\n", ITERATIONS);
            } else if (strncmp(arg, "hugepages", 9) == 0) {
	              hugePages = 1;
	              fprintf(stderr, "If applicable, will use huge pages. Will allocate max memory at start, make sure system has enough memory.\n");
	          } else {
                fprintf(stderr, "Unrecognized option: %s\n", arg);
            }
        }
    }

    if (argc == 1) {
        fprintf(stderr, "Usage: [-test <c/asm/tlb/mlp>] [-maxsizemb <max test size in MB>] [-iter <base iterations, default 100000000]\n");
    }

    if (hugePages) {
       size_t hugePageSize = 1 << 21;
       size_t maxMemRequired = default_test_sizes[testSizeCount - 1] * 1024;
       if (maxTestSizeMb > 0 && maxMemRequired > maxTestSizeMb * 1024 * 1024) maxMemRequired = maxTestSizeMb * 1024 * 1024;
       maxMemRequired = (((maxMemRequired - 1) / hugePageSize) + 1) * hugePageSize;
       fprintf(stderr, "mmap-ing %lu bytes\n", maxMemRequired);
       hugePagesArr = mmap(NULL, maxMemRequired, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
       if (hugePagesArr == (void *)-1) { // on failure, mmap will return MAP_FAILED, or (void *)-1
           fprintf(stderr, "Failed to mmap huge pages, errno %d = %s\nWill not use huge pages\n", errno, strerror(errno));
	   hugePagesArr = NULL;
       }
    }

    if (mlpTest) {
        // allocate arr to hold results
        float *results = (float *)malloc(testSizeCount * mlpTest * sizeof(float));
        for (int size_idx = 0; size_idx < testSizeCount; size_idx++) {
            for (int parallelism = 0; parallelism < mlpTest; parallelism++) {
                results[size_idx * mlpTest + parallelism] = RunMlpTest(default_test_sizes[size_idx], ITERATIONS, parallelism + 1);
                printf("%d KB, %dx parallelism, %f MB/s\n", default_test_sizes[size_idx], parallelism + 1, results[size_idx * mlpTest + parallelism]);
            }
        }

        for (int size_idx = 0; size_idx < testSizeCount; size_idx++) {
            printf(",%d", default_test_sizes[size_idx]);
        }

        printf("\n");

        for (int parallelism = 0; parallelism < mlpTest; parallelism++) {
            printf("%d", parallelism + 1);
            for (int size_idx = 0; size_idx < default_test_sizes[size_idx]; size_idx++) {
                printf(",%f", results[size_idx * mlpTest + parallelism]);
            }
            printf("\n");
        }

        free(results);
    } else if (stlf) {
        RunStlfTest(ITERATIONS, stlf); 
    } else {
        printf("Region,Latency (ns)\n");
        for (int i = 0; i < testSizeCount; i++) {
            if ((maxTestSizeMb == 0) || (default_test_sizes[i] <= maxTestSizeMb * 1024))
                printf("%d,%f\n", default_test_sizes[i], testFunc(default_test_sizes[i], ITERATIONS, hugePagesArr));
            else {
                fprintf(stderr, "Test size %u KB exceeds max test size of %u KB\n", default_test_sizes[i], maxTestSizeMb * 1024);
                break;
            }
        }
    } 

    return 0;
}

/// <summary>
/// Heuristic to make sure test runs for enough time but not too long
/// </summary>
/// <param name="size_kb">Region size</param>
/// <param name="iterations">base iterations</param>
/// <returns>scaled iterations</returns>
uint64_t scale_iterations(uint32_t size_kb, uint32_t iterations) {
    return 10 * iterations / pow(size_kb, 1.0 / 4.0);
}

// Fills an array using Sattolo's algo
void FillPatternArr(uint32_t *pattern_arr, uint32_t list_size, uint32_t byte_increment) {
    uint32_t increment = byte_increment / sizeof(uint32_t);
    uint32_t element_count = list_size / increment;
    for (int i = 0; i < element_count; i++) {
        pattern_arr[i * increment] = i * increment;
    }

    int iter = element_count;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint32_t tmp = pattern_arr[iter * increment];
        pattern_arr[iter * increment] = pattern_arr[j * increment];
        pattern_arr[j * increment] = tmp;
    } 
}

void FillPatternArr64(uint64_t *pattern_arr, uint64_t list_size, uint64_t byte_increment) {
    uint32_t increment = byte_increment / sizeof(uint64_t);
    uint32_t element_count = list_size / increment;
    for (int i = 0; i < element_count; i++) {
        pattern_arr[i * increment] = i * increment;
    }

    int iter = element_count;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint64_t tmp = pattern_arr[iter * increment];
        pattern_arr[iter * increment] = pattern_arr[j * increment];
        pattern_arr[j * increment] = tmp;
    } 
}

float RunTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t list_size = size_kb * 1024 / 4;
    uint32_t sum = 0, current;

    // Fill list to create random access pattern
    int *A;
    if (preallocatedArr == NULL) {
        A = (int*)malloc(sizeof(int) * list_size);
        if (!A) {
            fprintf(stderr, "Failed to allocate memory for %u KB test\n", size_kb);
            return 0;
        }
    } else {
        A = preallocatedArr;
    }
    
    FillPatternArr(A, list_size, CACHELINE_SIZE);

    uint32_t scaled_iterations = scale_iterations(size_kb, iterations);

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
    if (preallocatedArr == NULL) free(A);

    if (sum == 0) printf("sum == 0 (?)\n");
    return latency;
}

// Tests memory level parallelism. Returns achieved BW in MB/s using specified number of 
// independent pointer chasing chains
float RunMlpTest(uint32_t size_kb, uint32_t iterations, uint32_t parallelism) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t list_size = size_kb * 1024 / 4;
    uint32_t sum = 0, current;

    if (parallelism < 1) return 0;

    // Fill list to create random access pattern, and hold temporary data
    int* A = (int*)malloc(sizeof(int) * list_size);
    int *offsets = (int*)malloc(sizeof(int) * parallelism);
    if (!A || !offsets) {
        fprintf(stderr, "Failed to allocate memory for %u KB test\n", size_kb);
        return 0;
    }
    
    FillPatternArr(A, list_size, CACHELINE_SIZE);
    for (int i = 0; i < parallelism; i++) offsets[i] = i * (CACHELINE_SIZE / sizeof(int));
    uint32_t scaled_iterations = scale_iterations(size_kb, iterations) / parallelism;

    // Run test
    gettimeofday(&startTv, &startTz);
    for (int i = 0; i < scaled_iterations; i++) {
        for (int j = 0; j < parallelism; j++)
        {
            offsets[j] = A[offsets[j]];
        }
    }
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    double mbTransferred = (scaled_iterations * parallelism * sizeof(int))  / (double)1e6;
    float bw = 1000 * mbTransferred / (double)time_diff_ms; 

    sum = 0;
    for (int i = 0; i < parallelism; i++) sum += offsets[i];
    if (sum == 0) printf("sum == 0 (?)\n");

    free(A);
    free (offsets);
    return bw;
}

#ifdef __i686
#define POINTER_SIZE 4
#define POINTER_INT uint32_t
#else
#define POINTER_SIZE 8
#define POINTER_INT uint64_t
#endif

float RunAsmTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t list_size = size_kb * 1024 / POINTER_SIZE; // using 32-bit pointers
    uint32_t sum = 0, current;

    // Fill list to create random access pattern
    POINTER_INT *A;
    if (preallocatedArr == NULL) {
        A = (POINTER_INT *)malloc(POINTER_SIZE * list_size);
        if (!A) {
            fprintf(stderr, "Failed to allocate memory for %u KB test\n", size_kb);
            return 0;
	      }
    } else {
        A = (POINTER_INT *)preallocatedArr;
    }

    memset(A, 0, POINTER_SIZE * list_size);

#ifdef __i686
    FillPatternArr(A, list_size, CACHELINE_SIZE);
#else
    FillPatternArr64(A, list_size, CACHELINE_SIZE);
#endif

    preplatencyarr(A, list_size);

    uint32_t scaled_iterations = scale_iterations(size_kb, iterations);

    // Run test
    gettimeofday(&startTv, &startTz);
    sum = latencytest(scaled_iterations, A);
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float latency = 1e6 * (float)time_diff_ms / (float)scaled_iterations;
    if (preallocatedArr == NULL) free(A);

    if (sum == 0) printf("sum == 0 (?)\n");
    return latency;
}

// Tries to isolate virtual to physical address translation latency by accessing
// one element per page, and checking latency difference between that and hitting the same amount of "hot"
// cachelines using a normal latency test.. 4 KB pages are assumed. 
float RunTlbTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t element_count = size_kb / 4;
    uint32_t list_size = size_kb * 1024 / 4;
    uint32_t sum = 0, current;

    if (element_count == 0) element_count = 1;

    //fprintf(stderr, "Element count for size %u: %u\n", size_kb, element_count);

    // create access pattern first, then fill it into the test array spaced by page size
    uint32_t *pattern_arr = (uint32_t*)malloc(sizeof(uint32_t) * element_count);
    if (!pattern_arr) {
        fprintf(stderr, "Failed to allocate memory for %u KB test (offset array)\n", size_kb);
        return 0;
    }
    
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
    uint32_t *A; 
    if (preallocatedArr == NULL) {
        uint32_t *A = (uint32_t *)malloc(sizeof(uint32_t) * list_size);
        if (!A) {
            fprintf(stderr, "Failed to allocate memory for %u KB test (pointer array)\n", size_kb);
        }
    } else {
        A = preallocatedArr;
    }
    
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

    uint32_t scaled_iterations = scale_iterations(size_kb, iterations);

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
    if (preallocatedArr == NULL) free(A);

    if (element_count > 1 && sum == 0) printf("sum == 0 (?)\n");

    // Get a reference timing for the size, to isolate TLB latency from cache latency
    uint32_t memoryUsedKb = (element_count * CACHELINE_SIZE) / 1024;
    if (memoryUsedKb == 0) memoryUsedKb = 1;
    float cacheLatency = RunTest(memoryUsedKb, iterations, preallocatedArr);

    //fprintf(stderr, "Memory used - %u KB, latency: %f, ref latency: %f\n", memoryUsedKb, latency, cacheLatency);
    return latency - cacheLatency;
}

// Run store to load forwarding test, as described in https://blog.stuffedcow.net/2014/01/x86-memory-disambiguation/
// uses 4B loads and 8B stores to see when/if store forwarding can succeed when sizes are not matched
void RunStlfTest(uint32_t iterations, int mode) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz; 
    uint64_t time_diff_ms;
    float latency;
    float stlfResults[64][64];
    int *arr;
  
    // obtain a couple of cachelines, assuming 64B cacheline size
#ifdef _WIN32
    arr = (int *)_aligned_malloc(128, 64);
    if (arr == NULL) {
        fprintf(stderr, "Could not obtain aligned memory\n");
        return;
    }
#else 
    if (0 != posix_memalign((void **)(&arr), 64, 128)) {
        fprintf(stderr, "Could not obtain aligned memory\n");
        return;
    }
#endif

    for (int storeOffset = 0; storeOffset < 64; storeOffset++)
        for (int loadOffset = 0; loadOffset < 64; loadOffset++) {
            arr[0] = storeOffset;
            arr[1] = loadOffset;
            gettimeofday(&startTv, &startTz);
            stlfFunc(iterations, arr);
            gettimeofday(&endTv, &endTz);
            time_diff_ms = 1e6 * (endTv.tv_sec - startTv.tv_sec) + (endTv.tv_usec - startTv.tv_usec);
            latency = 1e3 * (float) time_diff_ms / (float) iterations;
            stlfResults[storeOffset][loadOffset] = latency;
            fprintf(stderr, "Store offset %d, load offset %d: %f ns\n", storeOffset, loadOffset, latency);
        }

    // output as CSV
    for (int loadOffset = 0; loadOffset < 64; loadOffset++) printf(",%d", loadOffset);
    printf("\n");
    for (int storeOffset = 0; storeOffset < 64; storeOffset++) {
        printf("%d", storeOffset);
        for (int loadOffset = 0; loadOffset < 64; loadOffset++) {
            printf(",%f", stlfResults[storeOffset][loadOffset]);
        }
        printf("\n");
    }
#ifdef _WIN32
    _aligned_free(arr);
#else
    free(arr);
#endif
    return;
}
