#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <string.h>

#ifndef _MSC_VER
#include <pthread.h>
#include <unistd.h>
#include <sys/syscall.h>
#ifdef __x86_64
#define SMALLKITTEN __attribute__((ms_abi))
#else
#define SMALLKITTEN
#endif
#define gettid() ((pid_t)syscall(SYS_gettid))
#else 
#include <Windows.h>
#define SMALLKITTEN
#define _CRT_SECURE_NO_WARNINGS
#endif
#include "../Common/timing.h"


struct TestThreadData {
    float timeMs;  // written by thread to indicate elapsed runtime for that thread
    uint64_t iterations;
    void *testData;
    int core;     // -1 = don't set affinity. otherwise set affinity to specified core
    uint64_t (*testfunc)(uint64_t, void *) SMALLKITTEN;
};

float measureFunction(uint64_t baseIterations, uint64_t (*testFunc)(uint64_t, void *) SMALLKITTEN, void *data);
void *TestThread(void *param);

int threadCount = 1;
int *coreList = NULL;

#ifdef __aarch64__
#include "arm_mt_instructionrate.c"
#endif 

#ifdef __x86_64
#include "x86_mt_instructionrate.c"
#endif

#ifdef _MSC_VER
#include "x86_mt_instructionrate.c"
#endif


#ifdef __PPC64__
#include "ppc64_mt_instructionrate.c"
#endif

int main(int argc, char *argv[]) {
   char parseBuffer[512];
   int parseIndices[64];

   for (int argIdx = 1; argIdx < argc; argIdx++) {
      if (*(argv[argIdx]) == '-') {
        char *arg = argv[argIdx] + 1;
	if (strncmp(arg, "threads", 7) == 0) {
	  argIdx++;
	  threadCount = atoi(argv[argIdx]);
	  fprintf(stderr, "Using first %d cores\n", threadCount);
	} else if (strncmp(arg, "cores", 5) == 0) {
	  argIdx++;
	  
	  // whatever just parse it here
	  strncpy(parseBuffer, argv[argIdx], 511);
          parseIndices[0] = 0;
          int indexIdx = 1;
          threadCount = 1;
          for (int i = 0; i < 512 && indexIdx < 64; i++) {
            if (parseBuffer[i] == ',') {
              parseBuffer[i] = '\0';
              parseIndices[indexIdx] = i + 1;
              indexIdx++;
              threadCount++;
            }
          }

          coreList = malloc(sizeof(int) * threadCount);

          fprintf(stderr, "Using %d cores:", threadCount);
          for (int i = 0;i < threadCount; i++) {
            coreList[i] = atoi(parseBuffer + parseIndices[i]);
            fprintf(stderr, " %d", coreList[i]); 
          }

          fprintf(stderr, "\n");
	}
      }
   }

   RunTests();

   free(coreList);
   return 0;
}

// return billion operations per second
// test function must perform iterations ops
float measureFunction(uint64_t baseIterations, uint64_t (*testFunc)(uint64_t, void *) SMALLKITTEN, void *data){
  int toleranceMet = 0, minTimeMet = 0;
  unsigned int timeMs;
  
  struct TestThreadData *testData = (struct TestThreadData *)malloc(threadCount * sizeof(struct TestThreadData));
  for (int threadIdx = 0; threadIdx < threadCount; threadIdx++) {
    testData[threadIdx].iterations = baseIterations;
    testData[threadIdx].testData = data;
    testData[threadIdx].testfunc = testFunc;
    if (coreList == NULL) testData[threadIdx].core = threadIdx;
    else testData[threadIdx].core = coreList[threadIdx];
  }

#ifndef _MSC_VER
  pthread_t* testThreads = (pthread_t*)malloc(threadCount * sizeof(pthread_t));
#else
  HANDLE* testThreads = (HANDLE*)malloc(threadCount * sizeof(HANDLE));
#endif

  do {
    start_timing();
    for (int threadIdx = 0; threadIdx < threadCount; threadIdx++) {
#ifndef _MSC_VER
      pthread_create(testThreads + threadIdx, NULL, TestThread, testData + threadIdx);
#else
      testThreads[threadIdx] = CreateThread(NULL, 0, TestThread, testData + threadIdx, CREATE_SUSPENDED, NULL, NULL);
      SetThreadAffinityMask(testThreads[threadIdx], 1UL << testData[threadIdx].core);
      ResumeThread(testThreads[threadIdx]);
#endif
    }

    float maxThreadTime = -1, minThreadTime = -1;
    for (int threadIdx = 0; threadIdx < threadCount; threadIdx++) {
#ifndef _MSC_VER
      pthread_join(testThreads[threadIdx], NULL);
#else
      WaitForMultipleObjects((DWORD)threadCount, testThreads, TRUE, INFINITE);
#endif
      fprintf(stderr, "Thread %d took %f ms\n", threadIdx, testData[threadIdx].timeMs);
      if (maxThreadTime < 0 || testData[threadIdx].timeMs > maxThreadTime) maxThreadTime = testData[threadIdx].timeMs;
      if (minThreadTime < 0 || testData[threadIdx].timeMs < minThreadTime) minThreadTime = testData[threadIdx].timeMs;
    }

    timeMs = end_timing();
    minTimeMet = timeMs > 2000; // see if 2 seconds will work
    toleranceMet = ((maxThreadTime - minThreadTime) / minThreadTime) < 0.1f; // allow 10% variation?

    if (!minTimeMet) {
      // Increase iteration count with 3s target
      baseIterations = scale_iterations_to_target(baseIterations, (float)timeMs, 3000.0f); 
      for (int threadIdx = 0; threadIdx < threadCount; threadIdx++) {
        testData[threadIdx].iterations = baseIterations;
      }

      fprintf(stderr, "Setting %lu iterations\n", baseIterations);
    } else if (!toleranceMet) {
      for (int threadIdx = 0; threadIdx < threadCount; threadIdx++) {
        testData[threadIdx].iterations = scale_iterations_to_target(
          testData[threadIdx].iterations,
          testData[threadIdx].timeMs,
          maxThreadTime);
        fprintf(stderr, "Thread %d -> %lu iterations\n", threadIdx, testData[threadIdx].iterations); 
      }
    }
  } while ((!toleranceMet) || (!minTimeMet));

  fprintf(stderr, "time elapsed: %d ms\n", timeMs);

  uint64_t totalIterations = 0;
  for (int threadIdx = 0; threadIdx < threadCount; threadIdx++) {
    totalIterations += testData[threadIdx].iterations;
  }

  free(testData);
  free(testThreads);

  return (1000 * totalIterations / timeMs) / 1e9;
}

void *TestThread(void *param) {
  struct TestThreadData *testData = (struct TestThreadData *)param;

#ifndef _MSC_VER
  if (testData->core >= 0) {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(testData->core, &cpuset);
    sched_setaffinity(gettid(), sizeof(cpu_set_t), &cpuset);
  }
  
  struct timeval start1;
#else
  struct timeb start1;
#endif
  start_timing_ts(&start1);
  testData->testfunc(testData->iterations, testData->testData);
  testData->timeMs = end_timing_ts(&start1);

  return NULL;
}
