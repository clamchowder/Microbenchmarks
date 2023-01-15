/* This is a one-off microbenchmark for attempts to dissect
 * Zhaoxin's KX-6640MA (LuJiaZui) architecture
 */
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// make mingw happy for cross compiling
#ifdef __MINGW32__
#define aligned_alloc(align, size) _aligned_malloc(size, align)
#endif

extern uint64_t clktest(uint64_t iterations, void *data);

extern uint64_t noptest(uint64_t iterations, void *data);
extern uint64_t addtest(uint64_t iterations, void *data);
extern uint64_t loadtest(uint64_t iterations, void *data);

float fpTestArr[8] __attribute__ ((aligned (64))) = { 0.2, 1.5, 2.7, 3.14, 5.16, 6.3, 7.7, 9.45 };
float fpSinkArr[8] __attribute__ ((aligned (64))) = { 2.1, 3.2, 4.3, 5.4, 6.2, 7.8, 8.3, 9.4 };
int *intTestArr;
int intSinkArr[8] __attribute__ ((aligned (64))) = { 2, 3, 4, 5, 6, 7, 8, 9 };

float measureFunction(uint64_t iterations, float clockSpeedGhz, void *arr, uint64_t (*testfunc)(uint64_t, void *));

int main(int argc, char *argv[]) {
  struct timeval startTv, endTv;
  struct timezone startTz, endTz;
  uint64_t iterations = 1500000000;
  uint64_t iterationsHigh = iterations * 5;
  uint64_t time_diff_ms;
  float latency, opsPerNs, clockSpeedGhz;
  uint64_t intTestArrLength = 1024;

  intTestArr = aligned_alloc(64, sizeof(int) * intTestArrLength);
  for (uint64_t i = 0; i < intTestArrLength; i++) {
    intTestArr[i] = i;
  }

  if (argc > 2) {
    uint64_t scaleFactor = (uint64_t)atol(argv[2]);
    iterationsHigh =  iterationsHigh * scaleFactor;
    iterations *= scaleFactor;
    printf("setting %lu iterations\n", iterationsHigh);
  }

  if (argc == 1) {
    // figure out clock speed
    gettimeofday(&startTv, &startTz);
    clktest(iterationsHigh, NULL);
    gettimeofday(&endTv, &endTz);
    time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    latency = 1e6 * (float)time_diff_ms / (float)iterationsHigh;
    // clk speed should be 1/latency, assuming we got one add per clk, roughly
    clockSpeedGhz = 1/latency;
  } else clockSpeedGhz = 1.0f;

  printf("Estimated clock speed: %.2f GHz\n", clockSpeedGhz);

  // throughput
  if (argc == 1 || argc > 1 && strncmp(argv[1], "nop", 3) == 0)
    printf("nops per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, NULL, noptest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "add", 3) == 0)
    printf("adds per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, NULL, addtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "load", 4) == 0)
    printf("load per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, intSinkArr, loadtest));
  
  return 0;
}

float measureFunction(uint64_t iterations, float clockSpeedGhz, void *arr, uint64_t (*testfunc)(uint64_t, void *)) {
  struct timeval startTv, endTv;
  struct timezone startTz, endTz;
  uint64_t time_diff_ms, retval;
  float latency, opsPerNs;

  gettimeofday(&startTv, &startTz);
  retval = testfunc(iterations, arr);
  gettimeofday(&endTv, &endTz);
  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
  latency = 1e6 * (float)time_diff_ms / (float)iterations;
  opsPerNs = 1/latency;
  //printf("%f adds/ns, %f adds/clk?\n", opsPerNs, opsPerNs / clockSpeedGhz);
  //printf("return value: %lu\n", retval);
  return opsPerNs / clockSpeedGhz;
}