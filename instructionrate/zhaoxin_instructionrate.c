/* This is a one-off microbenchmark for attempts to dissect
 * Zhaoxin's KX-6640MA (LuJiaZui) architecture 
 */
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

extern uint64_t noptest(uint64_t iterations);
extern uint64_t noptest1b(uint64_t iterations);
extern uint64_t clktest(uint64_t iterations); 
extern uint64_t addtest(uint64_t iterations);
extern uint64_t addmultest(uint64_t iterations); 
extern uint64_t add256int(uint64_t iterations); 
extern uint64_t mixadd256int(uint64_t iterations); 
extern uint64_t mixadd256int11(uint64_t iterations); 
extern uint64_t mixadd256fpint(uint64_t iterations); 
extern uint64_t mix256fp(uint64_t iterations); 
extern uint64_t mix256fp11(uint64_t iterations); 
extern uint64_t latadd256int(uint64_t iterations); 
extern uint64_t latadd128int(uint64_t iterations); 
extern uint64_t latadd256fp(uint64_t iterations); 
extern uint64_t latmul128int(uint64_t iterations); 
extern uint64_t latmul256int(uint64_t iterations); 
extern uint64_t latmul256fp(uint64_t iterations); 
extern uint64_t latadd128fp(uint64_t iterations); 
extern uint64_t latmul128fp(uint64_t iterations); 
extern uint64_t fma256(uint64_t iterations);
extern uint64_t mul256fp(uint64_t iterations);
extern uint64_t add256fp(uint64_t iterations);
extern uint64_t latmul64(uint64_t iterations);
extern uint64_t latmul16(uint64_t iterations);
extern uint64_t mul16(uint64_t iterations);
extern uint64_t mul64(uint64_t iterations);
extern uint64_t load128(uint64_t iterations, int *arr);
extern uint64_t spacedload128(uint64_t iterations, int *arr);
extern uint64_t load256(uint64_t iterations, float *arr);
extern uint64_t store128(uint64_t iterations, int *arr, int *sink);
extern uint64_t store256(uint64_t iterations, float *arr, float *sink);
extern uint64_t mixaddmul128int(uint64_t iterations);
extern uint64_t mixmul16mul64(uint64_t iterations); 
extern uint64_t mixmul16mul64_21(uint64_t iterations); 

float fpTestArr[8] __attribute__ ((aligned (64))) = { 0.2, 1.5, 2.7, 3.14, 5.16, 6.3, 7.7, 9.45 };
float fpSinkArr[8] __attribute__ ((aligned (64))) = { 2.1, 3.2, 4.3, 5.4, 6.2, 7.8, 8.3, 9.4 };
int *intTestArr;
int intSinkArr[8] __attribute__ ((aligned (64))) = { 2, 3, 4, 5, 6, 7, 8, 9 };

uint64_t load128wrapper(uint64_t iterations);
uint64_t load256wrapper(uint64_t iterations);
uint64_t store128wrapper(uint64_t iterations);
uint64_t store256wrapper(uint64_t iterations);

float measureFunction(uint64_t iterations, float clockSpeedGhz, uint64_t (*testfunc)(uint64_t));

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
  
  if (argc == 1) {
    // figure out clock speed
    gettimeofday(&startTv, &startTz);
    clktest(iterationsHigh);
    gettimeofday(&endTv, &endTz);  
    time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    latency = 1e6 * (float)time_diff_ms / (float)iterationsHigh; 
    // clk speed should be 1/latency, assuming we got one add per clk, roughly
    clockSpeedGhz = 1/latency;
  } else clockSpeedGhz = 1.0f;
  
  printf("Estimated clock speed: %.2f GHz\n", clockSpeedGhz);

  // throughput
  if (argc == 1 || argc > 1 && strncmp(argv[1], "1bnop", 5) == 0) 
    printf("1-byte nops per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, noptest1b));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "2bnop", 5) == 0) 
    printf("2-byte nops per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, noptest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "add", 3) == 0) 
    printf("Adds per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "miximuladd", 10) == 0) 
    printf("4:1 adds/imul per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "avx256int", 9) == 0) 

  // vector and FP
    printf("256-bit avx integer add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, add256int));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixavx256int", 12) == 0) 
    printf("2:1 scalar add/256-bit avx integer add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixadd256int));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mix11avx256int", 14) == 0) 
    printf("1:1 scalar add/256-bit avx integer add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixadd256int11));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixavx256fpint", 14) == 0) 
    printf("1:1 256-bit avx int add/avx fadd per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixadd256fpint));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mix256fp", 8) == 0) 
    printf("1:1 256-bit avx fp mul/add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mix256fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latadd256int", 12) == 0) 
    printf("256-bit avx2 integer add latency: %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latadd256int));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul256int", 12) == 0) 
    printf("256-bit avx2 integer multiply latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul256int));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latadd128int", 12) == 0) 
    printf("128-bit sse integer add latency: %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latadd128int));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul128int", 12) == 0) 
    printf("128-bit sse integer multiply latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul128int)); 
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latadd256fp", 11) == 0) 
    printf("256-bit avx fadd latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latadd256fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul256fp", 11) == 0) 
    printf("256-bit avx fmul latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul256fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latadd128fp", 11) == 0) 
    printf("128-bit sse fadd latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latadd128fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul128fp", 11) == 0) 
    printf("128-bit sse fmul latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul128fp));
  // zhaoxin does not support FMA
  /*if (argc == 1 || argc > 1 && strncmp(argv[1], "fma256", 6) == 0) 
    printf("256-bit FMA per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, fma256));*/
  if (argc == 1 || argc > 1 && strncmp(argv[1], "fadd256", 6) == 0) 
    printf("256-bit FADD per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, add256fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "fmul256", 6) == 0) 
    printf("256-bit FMUL per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mul256fp));

  // integer multiply. zhaoxin appears to handle 16-bit and 64-bit multiplies differntly
  // unlike Intel/AMD CPUs that behave similarly regardless of register width
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul16", 8) == 0) 
    printf("16-bit imul latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul16)); 
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul64", 8) == 0) 
    printf("64-bit imul latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul64));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mul16", 5) == 0) 
    printf("16-bit imul per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mul16));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mul64", 5) == 0) 
    printf("64-bit imul per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mul64));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixmul16mul64", 5) == 0) 
    printf("1:1 mixed 16-bit/64-bit imul per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mixmul16mul64));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mix21mul16mul64", 5) == 0) 
    printf("2:1 mixed 16-bit/64-bit imul per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mixmul16mul64_21));

  // load/store
  if (argc == 1 || argc > 1 && strncmp(argv[1], "load128", 7) == 0) 
    printf("128-bit loads per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, load128wrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "spacedload128", 13) == 0) 
    printf("128-bit loads (spaced) per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, load128wrapper)); 
  if (argc == 1 || argc > 1 && strncmp(argv[1], "load256", 7) == 0) 
    printf("256-bit loads per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, load256wrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "store128", 7) == 0) 
    printf("128-bit stores per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, store128wrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "store256", 7) == 0) 
    printf("256-bit stores per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, store256wrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixaddmul128int", 15) == 0) 
    printf("1:1 mixed 128-bit vec add/mul per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mixaddmul128int));

  return 0;
}

float measureFunction(uint64_t iterations, float clockSpeedGhz, uint64_t (*testfunc)(uint64_t)) {
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

uint64_t load128wrapper(uint64_t iterations) {
  return load128(iterations, intTestArr);
}

uint64_t spacedload128wrapper(uint64_t iterations) {
  return spacedload128(iterations, intTestArr);
} 

uint64_t load256wrapper(uint64_t iterations) {
  return load256(iterations, fpTestArr);
}

uint64_t store128wrapper(uint64_t iterations) {
  return store128(iterations, intTestArr, intSinkArr);
}

uint64_t store256wrapper(uint64_t iterations) {
  return store256(iterations, fpTestArr, fpSinkArr);
}
