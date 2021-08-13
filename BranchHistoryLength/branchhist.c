#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/time.h>
#include <time.h>

#include "branchhist.h"

int default_test_sizes[30] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536 };

float runtest(uint32_t historyLen, uint32_t branchCount, int random);
void printCsvHeader();
void printResultFloatArr(float *arr);

int main(int argc, char *argv[]) {
  uint32_t testSizeCount = sizeof(default_test_sizes) / sizeof(int);
  initializeFuncArr();
  srand(time(NULL));

  size_t resultSize = sizeof(float) * maxBranchCount * testSizeCount;
  float *randomResults = (float *)malloc(resultSize);
  float *predictableResults = (float *)malloc(resultSize);
  for (uint32_t branchCountIdx = 0; branchCountIdx < maxBranchCount; branchCountIdx++) {
    for (uint32_t testSizeIdx = 0; testSizeIdx < testSizeCount; testSizeIdx++) {
      uint32_t testSize = default_test_sizes[testSizeIdx];
      uint32_t branchCount = branchCounts[branchCountIdx];
      printf("Testing branch count %d history length %d\n", branchCount, testSize);
      randomResults[branchCountIdx * testSizeCount + testSizeIdx] = runtest(testSize, branchCountIdx, 1);
      predictableResults[branchCountIdx * testSizeCount + testSizeIdx] = runtest(testSize, branchCountIdx, 0);
      printf("%d, %f, %f\n", testSize, 
        randomResults[branchCountIdx * testSizeCount + testSizeIdx], 
        predictableResults[branchCountIdx * testSizeCount + testSizeIdx]);
    }
  }

  printf("Random:\n");
  printResultFloatArr(randomResults);
  printf("\nPredictable:\n");
  printResultFloatArr(predictableResults);
  
  free(randomResults);
  free(predictableResults);

  return 0;
}

void printResultFloatArr(float *arr) {
  uint32_t testSizeCount = sizeof(default_test_sizes) / sizeof(int);
  printCsvHeader();
  for (uint32_t branchCountIdx = 0; branchCountIdx < maxBranchCount; branchCountIdx++) {
    // row header
    printf("%d", branchCounts[branchCountIdx]);
    for (uint32_t testSizeIdx = 0; testSizeIdx < testSizeCount; testSizeIdx++) {
      printf(",%f", arr[branchCountIdx * testSizeCount + testSizeIdx]);
    }

    printf("\n");
  }
}

void printCsvHeader() {
  printf("x");
  for (uint32_t testSizeIdx = 0; testSizeIdx < sizeof(default_test_sizes) / sizeof(int); testSizeIdx++) {
    printf(", %d", default_test_sizes[testSizeIdx]);
  }

  printf("\n");
}

// Run a test, return the result in time (ns) per branch
// historyLen: length of random array that the test loops through
// branchCountIdx: index into array of branch counts, max determined by generated header/asm
// random: if 1, randomize test array contents. If 0, fill with zeroes
float runtest(uint32_t historyLen, uint32_t branchCountIdx, int random) {
  struct timeval startTv, endTv; 
  struct timezone startTz, endTz;
  uint32_t branchCount = branchCounts[branchCountIdx];
  uint64_t iterations = 80000000 / branchCount;
  uint64_t (*branchtestFunc)(uint64_t, uint32_t **, uint32_t) = branchtestFuncArr[branchCountIdx];

  uint32_t **testArrToArr = (uint32_t **)malloc(sizeof(uint32_t *) * branchCount);
  for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) {
    uint32_t *testArr = (uint32_t *)malloc(sizeof(uint32_t) * historyLen);
    for (uint32_t i = 0;i < historyLen; i++) testArr[i] = random ? rand() % 2 : 0;
    testArrToArr[testArrIdx] = testArr;
  }

  gettimeofday(&startTv, &startTz);
  branchtestFunc(iterations, testArrToArr, historyLen);
  gettimeofday(&endTv, &endTz);
  uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
  float latency = 1e6 * (float)time_diff_ms / (float)iterations;

  // give result in latency per branch
  latency = latency / branchCount;

  for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) free(testArrToArr[testArrIdx]);
  free(testArrToArr); 
  return latency;
}

