#define _GNU_SOURCE

#include <stdio.h>
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

void *LatencyTestThread(void *param);
float RunTest(unsigned int processor1, unsigned int processor2, uint64_t iter); 

int main(int argc, char *argv[]) {
    float *latencies;
    int numProcs;
    uint64_t iter = ITERATIONS;

    numProcs = get_nprocs();
    fprintf(stderr, "Number of CPUs: %u\n", numProcs);
    latencies = (float *)malloc(sizeof(float) * numProcs * numProcs);
    
    if (argc > 1) {
        iter = atol(argv[1]);
        fprintf(stderr, "%lu iterations requested\n", iter);
    }

    for (int i = 0;i < numProcs; i++) {
        for (int j = 0;j < numProcs; j++) {
            latencies[j + i * numProcs] = i == j ? 0 : RunTest(i, j, iter);
        }
    }

    for (int i = 0;i < numProcs; i++) {
        for (int j = 0;j < numProcs; j++) { 
            if (j != 0) printf(",");
            if (j == i) printf("x");
            // to maintain consistency, divide by 2 (see justification in windows version)
            else printf("%f", latencies[j + i * numProcs] / 2);
        }
        printf("\n");
    }

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
float RunTest(unsigned int processor1, unsigned int processor2, uint64_t iter) {
  LatencyData lat1, lat2;
  uint64_t bouncy;
  float latency;

  bouncy = 0;
  lat1.iterations = iter;
  lat1.start = 1;
  lat1.target = &bouncy;
  lat1.processorIndex = processor1;
  lat2.iterations = iter;
  lat2.start = 2;
  lat2.target = &bouncy;
  lat2.processorIndex = processor2;
  latency = TimeThreads(processor1, processor2, iter, &lat1, &lat2, LatencyTestThread);
  fprintf(stderr, "%d to %d: %f ns\n", processor1, processor2, latency);
  return latency;
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
