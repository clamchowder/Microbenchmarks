#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/sysinfo.h>
#include <sys/time.h>
#include <sched.h>
#include <pthread.h>
#include <math.h>
#include <errno.h>

#define CACHELINE_SIZE 64

struct BandwidthTestThreadData {
    uint64_t read_bytes;
    uint64_t arr_length_bytes;
    char *arr;
    volatile int *flag;
    cpu_set_t cpuset;
    pthread_t handle;
};

struct LatencyTestData {
    uint32_t iterations;
    uint32_t *arr;
    float latency;
    cpu_set_t cpuset;
    pthread_t handle;
};

int default_test_sizes[] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 600, 768, 1024, 1536, 2048, 2304, 2560,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 13312, 14336, 15360, 16384, 18432, 20480, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576 };

extern uint64_t asm_read(char *arr, uint64_t arr_length, volatile int *flag, int waitfactor) __attribute__((ms_abi)); 
void *ReadBandwidthTestThread(void *param);
void *FillBandwidthTestArr(void *param);
void FillPatternArr(uint32_t *pattern_arr, uint32_t list_size, uint32_t byte_increment);
void *RunLatencyTest(void *param);
float RunTest(cpu_set_t latencyAffinity, cpu_set_t bwAffinity, int bwThreadCount, int hugepages, int sharedLatency, float *measuredBw); 

uint64_t BandwidthTestMemoryKB = 16384;
uint64_t LatencyTestMemoryKB = 2048;
uint64_t LatencyTestIterations = 1e5;
uint64_t throttle = 0;

int main(int argc, char *argv[]) {
    int bwThreadCap = get_nprocs() - 1;
    int coreCount = get_nprocs();
    int latencyCore = 0;
    int *customCores = NULL;
    int sharedLatency = 0;
    if (argc == 1) {
        fprintf(stderr, "Options:\n");
        fprintf(stderr, "-bwthreads [int]: Number of bandwidth test threads\n");
        fprintf(stderr, "-latencyaffinity [int]: Core to run latency test thread on\n");
        fprintf(stderr, "-bwcores [comma separated list]: Cores to run bandwidth load on\n");
        fprintf(stderr, "-scaleiterations [int]: Iterations scaling factor\n");
        fprintf(stderr, "-throttle [int]: Reduce bandwidth load per bandwidth test thread\n");
    }
    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char *arg = argv[argIdx] + 1;
            if (strncmp(arg, "bwthreads", 9) == 0) {
                argIdx++;
                bwThreadCap = atoi(argv[argIdx]);
                fprintf(stderr, "Using up to %d bw threads\n", bwThreadCap);
            } else if (strncmp(arg, "latencyaffinity", 15) == 0) {
                argIdx++;
                latencyCore = atoi(argv[argIdx]);
                fprintf(stderr, "Latency test thread will run in core %d\n", latencyCore);
            } else if (strncmp(arg, "scaleiterations", 15) == 0) {
                argIdx++;
                int scaleFactor = atoi(argv[argIdx]);
                LatencyTestIterations *= scaleFactor;
                fprintf(stderr, "Scaling iterations up by a factor of %d\n", scaleFactor);
            } else if (strncmp(arg, "throttle", 8) == 0) {
                argIdx++;
                throttle = atoi(argv[argIdx]);
                fprintf(stderr, "Pulling memory bandwidth test threads back, factor of %d\n", throttle);
            } else if (strncmp(arg, "bwcores", 7) == 0) {
                argIdx++;
                char *customCoreListStr = argv[argIdx];
                bwThreadCap = 1;
                for (int i = 0; customCoreListStr[i] != 0; i++) {   // shell should null terminate this
                    if (customCoreListStr[i] == ',') {
                        bwThreadCap++;
                    }
                }

                customCores = (int *)malloc(sizeof(int) * bwThreadCap);
                memset(customCores, 0, sizeof(int) * bwThreadCap);
                int commaIdx = 1;
                for (int i = 0; customCoreListStr[i] != 0; i++) {
                    if (customCoreListStr[i] == ',') {
                        customCores[commaIdx] = i + 1;
                        commaIdx++;
                        customCoreListStr[i] = '\0';
                    }
                }

                fprintf(stderr, "Cores used for bandwidth load:");
                for (int i = 0; i < bwThreadCap; i++) {
                    customCores[i] = atoi(customCoreListStr + customCores[i]);
                    fprintf(stderr, " %d", customCores[i]);
                }

                fprintf(stderr, "\n");
            } else if (strncmp(arg, "sharedlatency", 13) == 0) {
                fprintf(stderr, "Shared arr bw+latency\n");
                sharedLatency = 1;
            }
        }
    }
        
    cpu_set_t latency_cpuset;
    CPU_ZERO(&latency_cpuset);
    CPU_SET(latencyCore, &latency_cpuset);
    
    cpu_set_t bw_cpuset;
    CPU_ZERO(&bw_cpuset);

    if (!sharedLatency) {
        fprintf(stderr, "%d cores, will use up to %d for BW threads\n", coreCount, bwThreadCap);
        float *latencies = (float *)malloc(sizeof(float) * bwThreadCap + 1);
        float *bandwidths = (float *)malloc(sizeof(float) * bwThreadCap + 1);
        for (int bwThreadCount = 0; bwThreadCount <= bwThreadCap; bwThreadCount++) {
            float bw;
            int nextCore;
            if (bwThreadCount > 0) {
                if (customCores == NULL) nextCore = coreCount - bwThreadCount - 1;
                else nextCore = customCores[bwThreadCount - 1] ;
                fprintf(stderr, "next core is %d\n", nextCore);
                CPU_SET(nextCore, &bw_cpuset);
            }

            if (nextCore < 0) break;

            // sharedlatency will always be false in this run mode
            float latencyNs = RunTest(latency_cpuset, bw_cpuset, bwThreadCount, 1, sharedLatency, &bw);
            fprintf(stderr, "%d bw threads %f GB/s %f ns\n", bwThreadCount, bw, latencyNs);
            latencies[bwThreadCount] = latencyNs;
            bandwidths[bwThreadCount] = bw;
        }

        printf("BW Threads, Bandwidth (GB/s), Latency (ns)\n");
        for (int bwThreadCount = 0; bwThreadCount <= bwThreadCap; bwThreadCount++) {
            printf("%d, %f, %f\n", bwThreadCount, bandwidths[bwThreadCount], latencies[bwThreadCount]);
        }
        free(latencies);
        free(bandwidths);
    } else {
        int testSizeCount = sizeof(default_test_sizes) / sizeof(int);
        float *latencies = (float*)malloc(sizeof(float) * testSizeCount);
        float *bandwidths = (float*)malloc(sizeof(float) * testSizeCount);
        // set mask to all selected cores
        for (int bwThreadCount = 0; bwThreadCount < bwThreadCap; bwThreadCount++) {
            int nextCore;
            if (customCores == NULL) nextCore = coreCount - bwThreadCount - 1;
            else nextCore = customCores[bwThreadCount];
            CPU_SET(nextCore, &bw_cpuset);
            fprintf(stderr, "Set core %d\n", nextCore);
        }

        for (int i = 0; i < testSizeCount; i++) {
            LatencyTestMemoryKB = default_test_sizes[i];
            latencies[i] = RunTest(latency_cpuset, bw_cpuset, bwThreadCap, 1, sharedLatency, bandwidths + i);
            fprintf(stderr, "%d KB: %f ns %f GB/s\n", LatencyTestMemoryKB, latencies[i], bandwidths[i]);
        }

        printf("Test Size (KB), Latency (ns), Bandwidth (GB/s)\n");
        for (int i = 0; i < testSizeCount; i++) {
            printf("%d,%f,%f\n", default_test_sizes[i], latencies[i], bandwidths[i]);
        }

        free(latencies);
        free(bandwidths);
    }

    if (customCores != NULL) free(customCores);
    return 0;
}

// returns latency in ns
// sets measuredBw = measured bandwidth
float RunTest(cpu_set_t latencyAffinity, cpu_set_t bwAffinity, int bwThreadCount, int hugepages, int sharedLatency, float *measuredBw) {
    uint64_t perThreadArrSizeBytes = ceil((double)BandwidthTestMemoryKB / (double)bwThreadCount) * 1024;
    volatile int flag = 0;  // set 1 to stop
    struct timeval startTv, endTv;
    struct timezone startTz, endTz; 
    int map_failed = 0;

    // MT bw test array fill
    struct BandwidthTestThreadData *bandwidthTestData = (struct BandwidthTestThreadData *)malloc(sizeof(struct BandwidthTestThreadData) * bwThreadCount);
    for (int threadIdx = 0; threadIdx < bwThreadCount; threadIdx++) {
        bandwidthTestData[threadIdx].read_bytes = 0;
        bandwidthTestData[threadIdx].flag = &flag;
        bandwidthTestData[threadIdx].cpuset = bwAffinity;

        if (!sharedLatency) {
            bandwidthTestData[threadIdx].arr = (char *)malloc(perThreadArrSizeBytes);
            bandwidthTestData[threadIdx].arr_length_bytes = perThreadArrSizeBytes;
            pthread_create(&(bandwidthTestData[threadIdx].handle), NULL, FillBandwidthTestArr, (void *)(bandwidthTestData + threadIdx));
        }
    }

    // set up latency test
    uint32_t *latencyArr;
    latencyArr = mmap(NULL, LatencyTestMemoryKB * 1024, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
    if (latencyArr == (void *)-1) {  // MAP_FAILED
        fprintf(stderr, "Failed to map hugepages arr, will use madvise\n");
        if (0 != posix_memalign((void **)(&latencyArr), 64, LatencyTestMemoryKB * 1024)) {
            fprintf(stderr, "Failed to allocate %u KB of memory for latency test\n", LatencyTestMemoryKB);
            return 0.0f;
        }

        madvise(latencyArr, LatencyTestMemoryKB * 1024, MADV_HUGEPAGE);
        map_failed = 1;
    }

    struct LatencyTestData latencyTestData;
    latencyTestData.iterations = LatencyTestIterations;
    latencyTestData.latency = 0.0f;
    latencyTestData.cpuset = latencyAffinity;
    latencyTestData.arr = latencyArr;
    FillPatternArr(latencyArr, (LatencyTestMemoryKB * 256), CACHELINE_SIZE);

    // let bw array fills finish
    for (int threadIdx = 0; threadIdx < bwThreadCount && !sharedLatency; threadIdx++) {
        pthread_join(bandwidthTestData[threadIdx].handle, NULL);
    }

    // use one array for all bw test threads. latency test size applies across bw threads
    if (sharedLatency) {
        for (int threadIdx = 0; threadIdx < bwThreadCount; threadIdx++) {
            bandwidthTestData[threadIdx].arr = (char *)latencyArr;
            bandwidthTestData[threadIdx].arr_length_bytes = LatencyTestMemoryKB * 1024;
        }
    }

    gettimeofday(&startTv, &startTz);
    // start bw test threads
    for (int threadIdx = 0; threadIdx < bwThreadCount; threadIdx++) {
        pthread_create(&(bandwidthTestData[threadIdx].handle), NULL, ReadBandwidthTestThread, (void *)(bandwidthTestData + threadIdx));
    }

    pthread_create(&(latencyTestData.handle), NULL, RunLatencyTest, (void *)&latencyTestData); 
    pthread_join(latencyTestData.handle, NULL);
    flag = 1;

    for (int threadIdx = 0; threadIdx < bwThreadCount; threadIdx++) {
        pthread_join(bandwidthTestData[threadIdx].handle, NULL);
    }
    
    gettimeofday(&endTv, &endTz);

    // count on a cacheline basis even though the test only loads 4B at a time
    uint64_t latencyReadBytes = 64 * LatencyTestIterations;

    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float totalReadData = (float)latencyReadBytes;
    for (int threadIdx = 0; threadIdx < bwThreadCount; threadIdx++) {
        if (!sharedLatency) free(bandwidthTestData[threadIdx].arr);
        totalReadData += (float)bandwidthTestData[threadIdx].read_bytes;
    }

    *measuredBw = 1000 * (totalReadData / (float)1e9) / (float)time_diff_ms; 

    free(bandwidthTestData);
    if (map_failed) free(latencyArr);
    else munmap(latencyArr, LatencyTestMemoryKB * 1024); 
    return latencyTestData.latency;
}

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

// No need for simple addressing because this test should be operating well in DRAM
// where an extra cycle for indexed addressing should not make a big difference
// returns load to use latency in nanoseconds
// size_kb should be divisible by 2M, or whatever the hugepage size is
void *RunLatencyTest(void *param) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    struct LatencyTestData *testData = (struct LatencyTestData *)param;
    uint32_t *A = testData->arr;
    uint32_t iterations = testData->iterations;
    uint32_t sum = 0, current;

    // fucking affinity setting does not work
    int rc = sched_setaffinity(0, sizeof(cpu_set_t), &(testData->cpuset));
    if (rc != 0) fprintf(stderr, "Latency thread failed to set affinity\n");

    // Run test
    gettimeofday(&startTv, &startTz);
    current = A[0];
    for (int i = 0; i < iterations; i++) {
        current = A[current];
        sum += current;
    }
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    testData->latency = 1e6 * (float)time_diff_ms / (float)iterations;

    if (sum == 0) printf("sum == 0 (?)\n");
}

void *FillBandwidthTestArr(void *param) {
    struct BandwidthTestThreadData *bwTestData = (struct BandwidthTestThreadData *)param;
    float *arr = (float *)bwTestData->arr;
    uint64_t float_elements = bwTestData->arr_length_bytes / 4;
    for (int i = 0; i < float_elements;i++) {
        arr[i] = (i + ((uint64_t)arr & 0x3)) + 0.2f;
    }
}

void *ReadBandwidthTestThread(void *param) {
    struct BandwidthTestThreadData *bwTestData = (struct BandwidthTestThreadData *)param;
    int rc = sched_setaffinity(0, sizeof(cpu_set_t), &(bwTestData->cpuset));
    if (rc != 0) {
        fprintf(stderr, "BW test thread failed to set affinity: %s\n", strerror(errno));
        for (int i = 0; i < 8; i++) {
            if (CPU_ISSET(i, &(bwTestData->cpuset))) fprintf(stderr, "\tCPU %d is set\n", i);
            else fprintf(stderr, "\tCPU %d is NOT set\n", i);
        }
    }
    uint64_t totalDataBytes = asm_read(bwTestData->arr, bwTestData->arr_length_bytes, bwTestData->flag, throttle);
    bwTestData->read_bytes = totalDataBytes;
}
