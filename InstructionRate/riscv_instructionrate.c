#define  _GNU_SOURCE
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>

float measureFunction(uint64_t iterations, float clockSpeedGhz, void *arr, uint64_t (*testfunc)(uint64_t, void *));

extern uint64_t clktest(uint64_t iterations, void *data);
extern uint64_t addtest(uint64_t iterations, void *data);
extern uint64_t faddtest(uint64_t iterations, void *data);
extern uint64_t fmultest(uint64_t iterations, void *data);
extern uint64_t mixfaddfmultest(uint64_t iterations, void *data);
extern uint64_t fmatest(uint64_t iterations, void *data);
extern uint64_t faddlattest(uint64_t iterations, void *data);
extern uint64_t fmullattest(uint64_t iterations, void *data);
extern uint64_t fmalattest(uint64_t iterations, void *data);

float fpTestArr[4] __attribute__ ((aligned (64))) = { 0.2, 1.5, 2.7, 3.14 };
int intTestArr[4] __attribute__ ((aligned (64))) = { 1, 2, 3, 4 };
int sinkArr[4] __attribute__ ((aligned (64))) = { 2, 3, 4, 5 };

int main(int argc, char *argv[]) {
  struct timeval startTv, endTv;
  struct timezone startTz, endTz;
  uint64_t iterations = 1500000000;
  uint64_t iterationsHigh = iterations * 5;
  uint64_t time_diff_ms;
  float latency, opsPerNs, clockSpeedGhz;
  if (argc > 1) {
    for (int argIdx = 1; argIdx < argc; argIdx++) {
      if (*(argv[argIdx]) == '-') {
        char *arg = argv[argIdx] + 1;
        if (strncmp(arg, "iter", 4) == 0) {
	  argIdx++;
	  int iterMul = atoi(argv[argIdx]);
	  iterations *= iterMul;
	  iterationsHigh *= iterMul;
	  fprintf(stderr, "Scaled iterations by %d\n", iterMul);
	}
      }
    }
  }

  gettimeofday(&startTv, &startTz);
  clktest(iterations, NULL);
  gettimeofday(&endTv, &endTz);
  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
  latency = 1e6 * (float)time_diff_ms / (float)iterations;
  // clk speed should be 1/latency, assuming we got one add per clk, roughly
  clockSpeedGhz = 1/latency;
  printf("Estimated clock speed> %.2f GHz\n", clockSpeedGhz);

  // integer side
  printf("Adds per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, NULL, addtest));

  // FP
  printf("FP32 Adds per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, fpTestArr, faddtest));
  printf("FP32 Add latency> %.2f cycles\n", 1 / measureFunction(iterations, clockSpeedGhz, fpTestArr, faddlattest));
  printf("FP32 Multiplies per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, fpTestArr, fmultest));
  printf("FP32 Multiply latency> %.2f cycles\n", 1 / measureFunction(iterations, clockSpeedGhz, fpTestArr, fmullattest));
  printf("1:1 FP32 Add:Mul per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, fpTestArr, mixfaddfmultest));
  printf("FP32 FMA per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, fpTestArr, fmatest));
  printf("FP32 FMA latency> %.2f cycles\n", 1 / measureFunction(iterations, clockSpeedGhz, fpTestArr, fmalattest));

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
  //printf("return value: %lu\n", retval);
  return opsPerNs / clockSpeedGhz;
}
