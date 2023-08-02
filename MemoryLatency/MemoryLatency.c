#define _GNU_SOURCE
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include <sys/time.h>
#include <unistd.h>

#ifndef __MINGW32__
#include <sys/mman.h>
#endif

#ifdef NUMA
#include <numa.h>
#include <numaif.h>
#include <sys/sysinfo.h>
#endif
#include <errno.h>
#include <sched.h>

// TODO: possibly get this programatically
#define PAGE_SIZE 4096
#define CACHELINE_SIZE 64

int default_test_sizes[] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576 }; //2097152 };

#ifdef __x86_64
extern void preplatencyarr(uint64_t *arr, uint64_t len) __attribute__((ms_abi));
extern uint32_t latencytest(uint64_t iterations, uint64_t *arr) __attribute((ms_abi));

#define LONGPATTERN 1
extern uint32_t longpatternlatencytest(uint64_t iterations, uint64_t *arr) __attribute((ms_abi));

extern void stlftest(uint64_t iterations, char *arr) __attribute((ms_abi));
extern void matchedstlftest(uint64_t iterations, char *arr) __attribute((ms_abi));
extern void stlftest32(uint64_t iterations, char *arr) __attribute((ms_abi));
extern void stlftest128(uint64_t iterations, char *arr) __attribute((ms_abi));
void (*stlfFunc)(uint64_t, char *) __attribute__((ms_abi)) = stlftest;
#elif __i686
extern void preplatencyarr(uint32_t *arr, uint32_t len) __attribute__((fastcall));
extern uint32_t latencytest(uint32_t iterations, uint32_t *arr) __attribute((fastcall));
extern void stlftest(uint32_t iterations, char *arr) __attribute((fastcall));
extern void matchedstlftest(uint32_t iterations, char *arr) __attribute((fastcall));
void (*stlfFunc)(uint32_t, char *) __attribute__((fastcall)) = stlftest;
#define BITS_32
#elif __aarch64__
extern void preplatencyarr(uint64_t *arr, uint64_t len);
extern uint32_t latencytest(uint64_t iterations, uint64_t *arr);

#define LONGPATTERN 1
extern uint32_t longpatternlatencytest(uint64_t iterations, uint64_t *arr);

extern void matchedstlftest(uint64_t iterations, char *arr);
extern void stlftest(uint64_t iterations, char *arr);
extern void stlftest32(uint64_t iterations, char *arr);
extern void stlftest128(uint64_t iterations, char *arr);
void (*stlfFunc)(uint64_t, char *) = stlftest;
#elif __riscv
extern void preplatencyarr(uint64_t *arr, uint64_t len);
extern uint32_t latencytest(uint64_t iterations, uint64_t *arr);
extern void matchedstlftest(uint64_t iterations, char *arr);
extern void stlftest(uint64_t iterations, char *arr);
extern void stlftest32(uint64_t iterations, char *arr);
extern void stlftest128(uint64_t iterations, char *arr);
void (*stlfFunc)(uint64_t, char *) = stlftest; 
#else
#define UNKNOWN_ARCH 1
extern uint32_t latencytest(uint64_t iterations, uint64_t *arr);
void (*stlfFunc)(uint64_t, char *) = NULL;
#endif

float RunTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr);
float RunAsmTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr);
float RunTlbTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr);
float RunMlpTest(uint32_t size_kb, uint32_t iterations, uint32_t parallelism);
void RunStlfTest(uint32_t iterations, int mode, int pageEnd, int loadDistance);
void FillPatternArr64(uint64_t *pattern_arr, uint64_t list_size, uint64_t byte_increment);
void FillPatternArr(uint32_t *pattern_arr, uint32_t list_size, uint32_t byte_increment);

float (*testFunc)(uint32_t, uint32_t, uint32_t *) = RunTest;

uint32_t ITERATIONS = 100000000;
uint32_t pageByPage = 0;
uint32_t longpattern = 0;

int main(int argc, char* argv[]) {
    uint32_t maxTestSizeMb = 0;
    uint32_t singleSize = 0;
    uint32_t testSizeCount = sizeof(default_test_sizes) / sizeof(int);
    int mlpTest = 0;  // if > 0, run MLP test with (value) levels of parallelism max
    int stlf = 0, hugePages = 0;
    int stlfPageEnd = 0, numa = 0, stlfLoadDistance = 0;
    uint32_t *hugePagesArr = NULL;
    size_t hugePagesAllocatedBytes = 0;
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
                } else if (strncmp(testType, "128_stlf", 4) == 0) {
                    stlf = 1;
                    stlfFunc = stlftest128;
                    fprintf(stderr, "Running store to load forwarding test, with 128-bit store, 64-bit load\n");
                } 
                #ifdef LONGPATTERN
                else if (strncmp(testType, "longpattern", 11) == 0) {
                    testFunc = RunAsmTest;
                    longpattern = 1;
                    fprintf(stderr, "Using ASM (simple address) test with longer pattern\n");
                }
                #endif
                #ifndef BITS_32
                else if (strncmp(testType, "dword_stlf", 9) == 0) {
                    stlf = 2;
                    stlfFunc = stlftest32;
                    fprintf(stderr, "Running store to load forwarding test, with 32-bit stores\n");
                }
                #endif
                #endif  // end UNKNOWN_ARCH
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
            } 
            else if (strncmp(arg, "stlf_page_end", 13) == 0) {
                    argIdx++;
                    stlfPageEnd = atoi(argv[argIdx]);
                    fprintf(stderr, "Store to load forwarding test will be pushed to end of %d byte page\n", stlfPageEnd);
            }
            else if (strncmp(arg, "stlf_load_offset", 16) == 0) {
                    argIdx++;
                    stlfLoadDistance = atoi(argv[argIdx]);
                    fprintf(stderr, "Loads will be offset by %d bytes\n", stlfLoadDistance);
            }
            #ifndef __MINGW32__
            else if (strncmp(arg, "hugepages", 9) == 0) {
                  hugePages = 1;
                  fprintf(stderr, "If applicable, will use huge pages. Will allocate max memory at start, make sure system has enough memory.\n");
            } 
            #endif
            else if (strncmp(arg, "pagebypage", 10) == 0) {
                pageByPage = 1;
                fprintf(stderr, "If applicable, will hit all elements in a page before moving to another page to reduce TLB penalties\n");
            }
            else if (strncmp(arg, "sizekb", 6) == 0) {
                argIdx++;
                singleSize = atoi(argv[argIdx]);
                fprintf(stderr, "Testing %u KB only\n", singleSize);
            }

#ifdef NUMA
            else if (strncmp(arg, "numa", 4) == 0) {
                numa = 1;
                singleSize = 1048576;
                fprintf(stderr, "Testing node to node latency. If test size is not set, it will be 1 GB\n");
            }
#endif
        else {
                fprintf(stderr, "Unrecognized option: %s\n", arg);
            }
        }
    }

    if (argc == 1) {
        fprintf(stderr, "Usage: [-test <c/asm/tlb/mlp>] [-maxsizemb <max test size in MB>] [-iter <base iterations, default 100000000]\n");
    }

#ifndef __MINGW32__
    if (hugePages) {
       size_t hugePageSize = 1 << 21;
       size_t testSizeKb = singleSize ? singleSize : default_test_sizes[testSizeCount - 1];
       size_t maxMemRequired = testSizeKb * (size_t)1024;
       hugePagesAllocatedBytes = maxMemRequired;
       if (maxTestSizeMb > 0 && maxMemRequired > maxTestSizeMb * 1024 * 1024) maxMemRequired = maxTestSizeMb * 1024 * 1024;
       maxMemRequired = (((maxMemRequired - 1) / hugePageSize) + 1) * hugePageSize;
       fprintf(stderr, "mmap-ing %lu bytes\n", maxMemRequired);
       hugePagesArr = mmap(NULL, maxMemRequired, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
       if (hugePagesArr == (void *)-1) { // on failure, mmap will return MAP_FAILED, or (void *)-1
           fprintf(stderr, "Failed to mmap huge pages, errno %d = %s\nWill try to use madvise\n", errno, strerror(errno));
           if (0 != posix_memalign((void **)(&hugePagesArr), 2 * 1024 * 1024, maxMemRequired)) {
               fprintf(stderr, "Failed to allocate 2 MB aligned memory, will not use hugepages\n");
           hugePagesArr = NULL;
               return 0;
           }

           madvise(hugePagesArr, maxMemRequired, MADV_HUGEPAGE);
       }
    }
#endif

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
        RunStlfTest(ITERATIONS, stlf, stlfPageEnd, stlfLoadDistance);
    } 
#ifdef NUMA
    else if (numa) {
        if (numa_available() == -1) {
        fprintf(stderr, "NUMA is not available\n");
        return 0;
    }

    int numaNodeCount = numa_max_node() + 1;
    if (numaNodeCount > 64) {
        fprintf(stderr, "Too many NUMA nodes. Go home.\n");
        return 0;
    }

    struct bitmask *nodeBitmask = numa_allocate_cpumask();
    float *crossnodeLatencies = (float *)malloc(sizeof(float) * numaNodeCount * numaNodeCount);
    memset(crossnodeLatencies, 0, sizeof(float) * numaNodeCount * numaNodeCount);
        for (int cpuNode = 0; cpuNode < numaNodeCount; cpuNode++) {
        numa_node_to_cpus(cpuNode, nodeBitmask);
        int nodeCpuCount = numa_bitmask_weight(nodeBitmask);
        if (nodeCpuCount == 0) {
            fprintf(stderr, "Node %d has no cores\n", cpuNode);
        continue;
        }

            fprintf(stderr, "Node %d has %d cores\n", cpuNode, nodeCpuCount);
        cpu_set_t cpuset;
        memcpy(cpuset.__bits, nodeBitmask->maskp, nodeBitmask->size / 8);
            // for (int i = 0; i < get_nprocs(); i++) 
            //  if (numa_bitmask_isbitset(nodeBitmask, i)) CPU_SET(i, &cpuset); 

        sched_setaffinity(gettid(), sizeof(cpu_set_t), &cpuset);

        for (int memNode = 0; memNode < numaNodeCount; memNode++) {
            uint64_t nodeMask = 1UL << memNode;
        uint32_t *arr;
            if (hugePagesArr) {
            fprintf(stderr, "mbind-ing pre-allocated arr, size %lu bytes\n", hugePagesAllocatedBytes);
            long mbind_rc = mbind(hugePagesArr, hugePagesAllocatedBytes, MPOL_BIND, &nodeMask, 64, MPOL_MF_STRICT | MPOL_MF_MOVE);
            fprintf(stderr, "mbind returned %ld\n", mbind_rc);
            if (mbind_rc != 0) {
                fprintf(stderr, "errno: %d\n", errno);
            }
            arr = hugePagesArr;
        } else {
                    arr = numa_alloc_onnode(singleSize * 1024, memNode);
                    madvise(arr, singleSize * 1024, MADV_HUGEPAGE);
        }
            
        float latency = testFunc(singleSize, ITERATIONS, arr);
        crossnodeLatencies[cpuNode * numaNodeCount + memNode] = latency;
        fprintf(stderr, "CPU node %d -> mem node %d: %f ns\n", cpuNode, memNode, latency);
        if (!hugePages) numa_free(arr, singleSize * 1024);
        }
    }

    for (int memNode = 0; memNode < numaNodeCount; memNode++) {
        printf(",%d", memNode);
    }

    printf("\n");
    for (int cpuNode = 0; cpuNode < numaNodeCount; cpuNode++) {
        printf("%d", cpuNode);
        for (int memNode = 0; memNode < numaNodeCount; memNode++) {
            printf(",%f", crossnodeLatencies[cpuNode * numaNodeCount + memNode]);
        }

        printf("\n");
    }

    free(crossnodeLatencies);
    }
#endif
    else {
        if (singleSize == 0) {
        printf("Region,Latency (ns)\n");
            for (int i = 0; i < testSizeCount; i++) {
                if ((maxTestSizeMb == 0) || (default_test_sizes[i] <= maxTestSizeMb * 1024))
                    printf("%d,%f\n", default_test_sizes[i], testFunc(default_test_sizes[i], ITERATIONS, hugePagesArr));
                else {
                    fprintf(stderr, "Test size %u KB exceeds max test size of %u KB\n", default_test_sizes[i], maxTestSizeMb * 1024);
                    break;
                }
            }
        } else {
            printf("%d,%f\n", singleSize, testFunc(singleSize, ITERATIONS, hugePagesArr));
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

// Fills an array so that traversal completes within one page before going to another
// random page. Tries to avoid TLB penalties at the cost of not being completely random
// list_size = size of pattern arr in 32-bit elements
void FillPageByPage(uint32_t *pattern_arr, uint32_t list_size, uint32_t byte_increment) {
    uint32_t pageCount = list_size * sizeof(uint32_t) / PAGE_SIZE;
    uint32_t page_element_count = PAGE_SIZE / sizeof(uint32_t);
    if (pageCount <= 2) {
        FillPatternArr(pattern_arr, list_size, byte_increment);
        return;
    }

    // If test size is not divisible by page size, handle the extra page separately
    short extraPage = 0;
    if (pageCount * PAGE_SIZE / sizeof(uint32_t) < list_size) extraPage = 1;

    uint32_t *pagePatternArr = malloc(sizeof(uint32_t) * (pageCount + extraPage));
    FillPatternArr(pagePatternArr, pageCount + extraPage, 4);
    for (uint32_t page_idx = 0; page_idx < pageCount; page_idx++)
    {
        uint32_t *page_base = pattern_arr + (page_element_count * page_idx);
        FillPatternArr(page_base, page_element_count, byte_increment);

        uint32_t page_last_element_index;
        for (uint32_t page_element_idx = 0; page_element_idx < (PAGE_SIZE / sizeof(uint32_t)); page_element_idx += (byte_increment / sizeof(uint32_t))) {
            // element that points to 0 should be directed to the next page
            if (page_base[page_element_idx] == 0) page_base[page_element_idx] = pagePatternArr[page_idx] * (PAGE_SIZE / sizeof(uint32_t));

            // otherwise make sure the offset is set relative to the start of the uber-array
            else page_base[page_element_idx] += page_element_count * page_idx;
        }
    }

    free(pagePatternArr);
    return;
}

// Fills an array so that traversal completes within one page before going to another
// random page. Tries to avoid TLB penalties at the cost of not being completely random
// list_size = size of pattern arr in 32-bit elements
void FillPageByPage64(uint64_t *pattern_arr, uint32_t list_size, uint32_t byte_increment) {
    uint32_t pageCount = list_size * sizeof(uint64_t) / PAGE_SIZE;
    uint32_t page_element_count = PAGE_SIZE / sizeof(uint64_t);
    if (pageCount <= 2) {
        FillPatternArr64(pattern_arr, list_size, byte_increment);
        return;
    }

    // If test size is not divisible by page size, handle the extra page separately
    short extraPage = 0;
    if (pageCount * PAGE_SIZE / sizeof(uint64_t) < list_size) extraPage = 1;

    uint32_t *pagePatternArr = malloc(sizeof(uint32_t) * (pageCount + extraPage));
    FillPatternArr(pagePatternArr, pageCount + extraPage, 4);
    for (uint32_t page_idx = 0; page_idx < pageCount; page_idx++)
    {
        uint64_t *page_base = pattern_arr + (page_element_count * page_idx);
        FillPatternArr((uint32_t *)page_base, page_element_count, byte_increment);

        uint32_t page_last_element_index;
        for (uint32_t page_element_idx = 0; page_element_idx < (PAGE_SIZE / sizeof(uint64_t)); page_element_idx += (byte_increment / sizeof(uint64_t))) {
            // element that points to 0 should be directed to the next page
            if (page_base[page_element_idx] == 0) page_base[page_element_idx] = pagePatternArr[page_idx] * (PAGE_SIZE / sizeof(uint64_t));

            // otherwise make sure the offset is set relative to the start of the uber-array
            else page_base[page_element_idx] += page_element_count * page_idx;
        }
    }

    free(pagePatternArr);
    return;
}

// Fills an array using Sattolo's algo
// pattern_arr = array to fill
// list_size = size of pattern arr in 32-bit elements
// byte_increment = one element per this many bytes
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

// Same thing but with 64-bit elements
// pattern_arr = array to fill
// list_size = number of 64-bit elements in array
// byte_increment = cacheline size, in bytes
void FillPatternArr64(uint64_t *pattern_arr, uint64_t list_size, uint64_t byte_increment) {
    uint32_t increment = byte_increment / sizeof(uint64_t); // number of 64-bit integers in a cacheline
    uint32_t element_count = list_size / increment;
    for (int increment_offset = 0; increment_offset < increment; increment_offset++) {
        for (int i = 0; i < element_count; i++) {
            pattern_arr[i * increment + increment_offset] = i * increment + increment_offset;
        }

        int iter = element_count;
        while (iter > 1) {
            iter -= 1;
            int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
            uint64_t tmp = pattern_arr[iter * increment + increment_offset];
            pattern_arr[iter * increment + increment_offset] = pattern_arr[j * increment + increment_offset];
            pattern_arr[j * increment + increment_offset] = tmp;
        }
    }
}

float RunTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t list_size = size_kb * 1024 / 4;
    uint32_t sum = 0, current;

    // Fill list to create random access pattern
    uint32_t *A;
    if (preallocatedArr == NULL) {
        if (0 != posix_memalign((void **)(&A), 64, sizeof(uint32_t) * list_size)) {
            fprintf(stderr, "Failed to allocate memory for %u KB test\n", size_kb);
        }
    } else {
        A = (uint32_t *)preallocatedArr;
    }

    if (!pageByPage) FillPatternArr(A, list_size, CACHELINE_SIZE);
    else FillPageByPage(A, list_size, CACHELINE_SIZE);

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
    uint32_t *A = (uint32_t *)malloc(sizeof(uint32_t) * list_size);
    uint32_t *offsets = (uint32_t *)malloc(sizeof(uint32_t) * parallelism);
    if (!A || !offsets) {
        fprintf(stderr, "Failed to allocate memory for %u KB test\n", size_kb);
        return 0;
    }

    FillPatternArr(A, list_size, CACHELINE_SIZE);
    for (int i = 0; i < parallelism; i++) offsets[i] = i * (CACHELINE_SIZE / sizeof(uint32_t));
    uint32_t scaled_iterations = scale_iterations(size_kb, iterations) / parallelism;

    // Run test
    gettimeofday(&startTv, &startTz);
    for (uint32_t i = 0; i < scaled_iterations; i++) {
        for (uint32_t j = 0; j < parallelism; j++)
        {
            offsets[j] = A[offsets[j]];
        }
    }
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    double mbTransferred = (scaled_iterations * parallelism * sizeof(uint32_t))  / (double)1e6;
    float bw = 1000 * mbTransferred / (double)time_diff_ms;

    sum = 0;
    for (uint32_t i = 0; i < parallelism; i++) sum += offsets[i];
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

#ifndef UNKNOWN_ARCH
float RunAsmTest(uint32_t size_kb, uint32_t iterations, uint32_t *preallocatedArr) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint64_t list_size = size_kb * 1024 / POINTER_SIZE; // using 32-bit pointers
    uint32_t sum = 0, current;

    // Fill list to create random access pattern
    POINTER_INT *A;
    if (preallocatedArr == NULL) {
        if (0 != posix_memalign((void **)(&A), 64, POINTER_SIZE * list_size)) {
            fprintf(stderr, "Failed to allocate memory for %u KB test\n", size_kb);
        }
    } else {
        A = (POINTER_INT *)preallocatedArr;
    }

    memset(A, 0, POINTER_SIZE * list_size);

#ifdef __i686
    if (!pageByPage) FillPatternArr(A, list_size, CACHELINE_SIZE);
    else FillPageByPage(A, list_size, CACHELINE_SIZE);
#else
    if (!pageByPage) FillPatternArr64(A, list_size, CACHELINE_SIZE);
    else FillPageByPage64(A, list_size, CACHELINE_SIZE);
#endif

    preplatencyarr(A, list_size);

    uint32_t scaled_iterations = scale_iterations(size_kb, iterations);

    // Run test
    gettimeofday(&startTv, &startTz);
    #ifdef LONGPATTERN
    if (longpattern) sum = longpatternlatencytest(scaled_iterations, A);
    else 
    #endif
        sum = latencytest(scaled_iterations, A);
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float latency = 1e6 * (float)time_diff_ms / (float)scaled_iterations;
    if (preallocatedArr == NULL) free(A);

    // if (sum == 0) printf("sum == 0 (?)\n");
    return latency;
}
#endif

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
        A = (uint32_t *)malloc(sizeof(uint32_t) * list_size);
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
// pageEnd = push test to the end of (pageEnd) sized page. 0 = just test cacheline
// loadDistance = how far ahead to push the load (for testing aliasing)
// cannot set both pageEnd and loadDistance
void RunStlfTest(uint32_t iterations, int mode, int pageEnd, int loadDistance) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint64_t time_diff_ms;
    float latency;
    float stlfResults[64][64];
    char *arr; 
    char *allocArr;

    // defaults: grab a couple of cachelines
    int testAlignment = 64, testAllocSize = 128, testOffset = 0;

    if (pageEnd != 0) {
        testAlignment = pageEnd;
        testAllocSize = pageEnd * 2;
        testOffset = pageEnd - 64;
    } else if (loadDistance != 0) {
        testAlignment = 4096;
        testAllocSize = loadDistance + 128; // enough if I ever go to avx-512 loads
    }

    // obtain a couple of cachelines, assuming 64B cacheline size
#ifdef _WIN32
    allocArr = (char *)_aligned_malloc(testAllocSize, testAlignment);
    if (allocArr == NULL) {
        fprintf(stderr, "Could not obtain aligned memory\n");
        return;
    }
#else
    if (0 != posix_memalign((void **)(&allocArr), testAlignment, testAllocSize)) {
        fprintf(stderr, "Could not obtain aligned memory\n");
        return;
    }
#endif

    arr = allocArr + testOffset;

    for (int storeOffset = 0; storeOffset < 64; storeOffset++)
        for (int loadOffset = 0; loadOffset < 64; loadOffset++) {
            ((uint32_t *)(arr))[0] = storeOffset;
            ((uint32_t *)(arr))[1] = loadOffset + loadDistance;
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
    _aligned_free(allocArr);
#else
    free(allocArr);
#endif
    return;
}
