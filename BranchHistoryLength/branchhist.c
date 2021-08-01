#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/time.h>
#include <time.h>

int default_test_sizes[30] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536 };

extern uint64_t branchtest(uint64_t iterations, uint32_t *arr, uint32_t arrLen);
float runtest(uint32_t historyLen, int random);

int main(int argc, char *argv[]) {
  printf("History Length, Latency\n");
  for (uint32_t i = 0;i < sizeof(default_test_sizes) / sizeof(int); i++) {
    uint32_t testSize = default_test_sizes[i];
    printf("%d, %f, %f\n", testSize, runtest(testSize, 1), runtest(testSize, 0));
  }

  return 0;
}

float runtest(uint32_t historyLen, int random) {
  struct timeval startTv, endTv; 
  struct timezone startTz, endTz;
  uint64_t iterations = 150000000;
  uint32_t *testArr = (uint32_t *)malloc(sizeof(uint32_t) * historyLen);
  srand(time(NULL));
  for (uint32_t i = 0;i < historyLen; i++) testArr[i] = random ? rand() % 2 : 0;

  gettimeofday(&startTv, &startTz);
  branchtest(iterations, testArr, historyLen);
  gettimeofday(&endTv, &endTz);
  uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
  float latency = 1e6 * (float)time_diff_ms / (float)iterations;
  free(testArr);
  return latency;
}

