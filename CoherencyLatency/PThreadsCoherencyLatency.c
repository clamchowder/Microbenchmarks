#define _GNU_SOURCE

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/sysinfo.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <sched.h>
#include <pthread.h>

#define ITERATIONS 10000000;

// kidding right?
#define gettid() syscall(SYS_gettid)

typedef struct LatencyThreadData {
    uint64_t start;
    uint64_t iterations;
    uint64_t *target;
    unsigned int processorIndex;
} LatencyData;

typedef struct LatencyPairRunData {
    uint32_t processor1;
    uint32_t processor2;
    uint64_t iter;
    float result;
    uint64_t *target;
} LatencyPairRunData;

void *LatencyTestThread(void *param);
void *RunTest(void *param);

int main(int argc, char *argv[]) {
    float **latencies;
    int *parallelTestState;
    int numProcs, offsets = 1, parallelismFactor = 1;
    uint64_t iter = ITERATIONS;
    uint64_t *bouncyArr;

    numProcs = get_nprocs();
    fprintf(stderr, "Number of CPUs: %u\n", numProcs);



    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char* arg = argv[argIdx] + 1;
            if (strncmp(arg, "iterations", 10) == 0) {
                argIdx++;
                iter = atoi(argv[argIdx]);
                fprintf(stderr, "%lu iterations requested\n", iter);
            }
            else if (strncmp(arg, "bounce", 6) == 0) {
                fprintf(stderr, "Bouncy\n");
            }
            else if (strncmp(arg, "offset", 6) == 0) {
                argIdx++;
                offsets = atoi(argv[argIdx]);
                fprintf(stderr, "Offsets: %d\n", offsets);
            }
            else if (strncmp(arg, "parallel", 8) == 0) {
                argIdx++;
                parallelismFactor = atoi(argv[argIdx]);
                fprintf(stderr, "Will go for %d runs in parallel\n", parallelismFactor);
            }
        }
    }

    latencies = (float **)malloc(sizeof(float *) * offsets);
    parallelTestState = (int *)malloc(sizeof(int) * numProcs * numProcs);
    memset(latencies, 0, sizeof(float) * offsets);
    if (0 != posix_memalign((void **)(&bouncyArr), 4096, 4096 * parallelismFactor)) {
        fprintf(stderr, "Could not allocate aligned mem\n");
        return 0;
    } 

    LatencyPairRunData *pairRunData = (LatencyPairRunData *)malloc(sizeof(LatencyPairRunData) * parallelismFactor);

    for (int offsetIdx = 0; offsetIdx < offsets; offsetIdx++) {
        latencies[offsetIdx] = (float *)malloc(sizeof(float) * numProcs * numProcs);
        memset(parallelTestState, 0, sizeof(int) * numProcs * numProcs);
        float *latenciesPtr = latencies[offsetIdx];

        while (1) {
            // select parallelismFactor threads
            int selectedParallelTestCount = 0;
            memset(pairRunData, 0, sizeof(LatencyPairRunData) * parallelismFactor);
            for (int i = 0;i < numProcs && selectedParallelTestCount < parallelismFactor; i++) {
                for (int j = 0;j < numProcs && selectedParallelTestCount < parallelismFactor; j++) {
                    if (j == i) { latenciesPtr[j + i * numProcs] = 0; continue; }
                    if (parallelTestState[j + i * numProcs] == 1) {
                        fprintf(stderr, "Thread unexpectedly did not complete\n");
                        exit(0);
                    }
                    if (parallelTestState[j + i * numProcs] == 0) {
                        // neither thread can already have a pending run
                        int validPair = 1;
                        for (int c = 0; c < numProcs; c++) {
                            if (parallelTestState[j + c * numProcs] == 1 || 
                                parallelTestState[c + i * numProcs] == 1 ||
                                parallelTestState[i + c * numProcs] == 1 ||
                                parallelTestState[c + j * numProcs] == 1) {
                                validPair = 0;
                                break;
                            }
                        }

                        if (!validPair) continue;

                        // for SMT enabled CPUs, check sibling threads. will do later
                        parallelTestState[j + i * numProcs] = 1;
                        pairRunData[selectedParallelTestCount].processor1 = i;
                        pairRunData[selectedParallelTestCount].processor2 = j;
                        pairRunData[selectedParallelTestCount].iter = iter;
                        pairRunData[selectedParallelTestCount].result = 0.0f;
                        pairRunData[selectedParallelTestCount].target = bouncyArr + (512 * selectedParallelTestCount + 8 * offsetIdx);
                        fprintf(stderr, "Selected %d -> %d\n", i, j);
                        selectedParallelTestCount++;
                    }
                }
            }
            
            if (selectedParallelTestCount == 0) break;

            // launch threads
            fprintf(stderr, "Selected %d pairs for parallel testing\n", selectedParallelTestCount);
            pthread_t *testThreads = (pthread_t *)malloc(selectedParallelTestCount * sizeof(pthread_t));
            memset(testThreads, 0, selectedParallelTestCount * sizeof(pthread_t));
            for (int parallelIdx = 0; parallelIdx < selectedParallelTestCount; parallelIdx++) {
                if (pairRunData[parallelIdx].processor1 == 0 && pairRunData[parallelIdx].processor2 == 0) break;
                pthread_create(testThreads + parallelIdx, NULL, RunTest, (void *)(pairRunData + parallelIdx));
            }

            // join threads
            for (int parallelIdx = 0; parallelIdx < selectedParallelTestCount; parallelIdx++) {
                pthread_join(testThreads[parallelIdx], NULL);
                int i = pairRunData[parallelIdx].processor1;
                int j = pairRunData[parallelIdx].processor2;
                latenciesPtr[j + i * numProcs] = pairRunData[parallelIdx].result;
                parallelTestState[j + i * numProcs] = 2;
            }

            free(testThreads);
        }
    }

      for (int offsetIdx = 0; offsetIdx < offsets; offsetIdx++) {
        float *latenciesPtr = latencies[offsetIdx];
        printf("Cache line offset: %d\n", offsetIdx);
        for (int i = 0;i < numProcs; i++) {
            for (int j = 0;j < numProcs; j++) {
                if (j != 0) printf(",");
                if (j == i) printf("x");
                // to maintain consistency, divide by 2 (see justification in windows version)
                else printf("%f", latenciesPtr[j + i * numProcs] / 2);
            }
            printf("\n");
        }

        free(latenciesPtr);
    }

    free(parallelTestState);
    free(pairRunData);
    free(latencies);
    free(bouncyArr);
    return 0;
}

// run test and gather timing data using the specified thread function
float TimeThreads(unsigned int proc1,
                  unsigned int proc2,
                  uint64_t iter,
                  LatencyData *lat1,
                  LatencyData *lat2,
                  void *(*threadFunc)(void *)) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    pthread_t testThreads[2];
    int t1rc, t2rc;
    void *res1, *res2;

    gettimeofday(&startTv, &startTz);
    t1rc = pthread_create(&testThreads[0], NULL, threadFunc, (void *)lat1);
    t2rc = pthread_create(&testThreads[1], NULL, threadFunc, (void *)lat2);
    if (t1rc != 0 || t2rc != 0) {
      fprintf(stderr, "Could not create threads\n");
      return 0;
    }

    pthread_join(testThreads[0], &res1);
    pthread_join(testThreads[1], &res2);
    gettimeofday(&endTv, &endTz);

    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float latency = 1e6 * (float)time_diff_ms / (float)iter;
    return latency;
}

// test latency between two logical CPUs
// float RunTest(unsigned int processor1, unsigned int processor2, uint64_t iter) {
void *RunTest(void *param) {
  LatencyPairRunData *pairRunData = (LatencyPairRunData *)param;
  uint32_t processor1 = pairRunData->processor1;
  uint32_t processor2 = pairRunData->processor2;
  uint64_t iter = pairRunData->iter;
  LatencyData lat1, lat2;
  float latency;

  *(pairRunData->target) = 0;
  lat1.iterations = iter;
  lat1.start = 1;
  lat1.target = pairRunData->target;
  lat1.processorIndex = processor1;
  lat2.iterations = iter;
  lat2.start = 2;
  lat2.target = pairRunData->target;
  lat2.processorIndex = processor2;
  latency = TimeThreads(processor1, processor2, iter, &lat1, &lat2, LatencyTestThread);
  fprintf(stderr, "%d to %d: %f ns\n", processor1, processor2, latency);
  pairRunData->result = latency;
  return NULL;
}

void *LatencyTestThread(void *param) {
    LatencyData *latencyData = (LatencyData *)param;
    cpu_set_t cpuset;
    uint64_t current = latencyData->start;

    CPU_ZERO(&cpuset);
    CPU_SET(latencyData->processorIndex, &cpuset);
    sched_setaffinity(gettid(), sizeof(cpu_set_t), &cpuset);
    //fprintf(stderr, "thread %ld set affinity %d\n", gettid(), latencyData->processorIndex);

    while (current <= 2 * latencyData->iterations) {
        if (__sync_bool_compare_and_swap(latencyData->target, current - 1, current)) current += 2;
    }

    pthread_exit(NULL);
}
