/* This is a one-off microbenchmark for attempts to figure out what
 * instructions are fused on Centaur's CNS
 */
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <cpuid.h>

// make mingw happy for cross compiling
#ifdef __MINGW32__
#define aligned_alloc(align, size) _aligned_malloc(size, align)
#endif

extern uint64_t noptest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t clktest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t addtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t testfusion(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t cmpfusion(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t subfusion(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t nopfusion(uint64_t iterations) __attribute((sysv_abi));

float fpTestArr[8] __attribute__ ((aligned (64))) = { 0.2, 1.5, 2.7, 3.14, 5.16, 6.3, 7.7, 9.45 };
float fpSinkArr[8] __attribute__ ((aligned (64))) = { 2.1, 3.2, 4.3, 5.4, 6.2, 7.8, 8.3, 9.4 };
int *intTestArr;
int intSinkArr[8] __attribute__ ((aligned (64))) = { 2, 3, 4, 5, 6, 7, 8, 9 };

float measureFunction(uint64_t iterations, float clockSpeedGhz, __attribute((sysv_abi)) uint64_t (*testfunc)(uint64_t));

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
    iterationsHigh =  1500000000 * (uint64_t)atol(argv[2]);
    printf("setting %lu iterations\n", iterationsHigh);
  }

  // figure out clock speed
  gettimeofday(&startTv, &startTz);
  clktest(iterationsHigh);
  gettimeofday(&endTv, &endTz);
  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
  latency = 1e6 * (float)time_diff_ms / (float)iterationsHigh;
  // clk speed should be 1/latency, assuming we got one add per clk, roughly
  clockSpeedGhz = 1/latency;

  printf("Estimated clock speed: %.2f GHz\n", clockSpeedGhz);

  // throughput
  printf("2-byte nops per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, noptest));
  printf("Adds per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addtest));
  printf("test+jnz: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, testfusion));
  printf("cmp+jnz: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, cmpfusion));
  printf("sub+jnz: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, subfusion));
  printf("nop+jnz: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, nopfusion));

  return 0;
}

float measureFunction(uint64_t iterations, float clockSpeedGhz,  __attribute((sysv_abi)) uint64_t (*testfunc)(uint64_t)) {
  struct timeval startTv, endTv;
  struct timezone startTz, endTz;
  uint64_t time_diff_ms, retval;
  float latency, opsPerNs;

  gettimeofday(&startTv, &startTz);
  retval = testfunc(iterations);
  gettimeofday(&endTv, &endTz);
  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
  latency = 1e6 * (float)time_diff_ms / (float)iterations;
  opsPerNs = 1/latency;
  //printf("%f adds/ns, %f adds/clk?\n", opsPerNs, opsPerNs / clockSpeedGhz);
  //printf("return value: %lu\n", retval);
  return opsPerNs / clockSpeedGhz;
}
