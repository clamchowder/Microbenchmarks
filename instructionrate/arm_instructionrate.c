#define  _GNU_SOURCE
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <stdint.h>
#include <sys/types.h>
#include <unistd.h>
#include <sched.h>

extern uint64_t noptest(uint64_t iterations);
extern uint64_t clktest(uint64_t iterations);

extern uint64_t addtest(uint64_t iterations);
extern uint64_t eortest(uint64_t iterations);
extern uint64_t maddaddtest(uint64_t iterations);
extern uint64_t cmptest(uint64_t iterations);
extern uint64_t addmultest(uint64_t iterations);
extern uint64_t addmul21test(uint64_t iterations);
extern uint64_t mul32test(uint64_t iterations);
extern uint64_t mul64test(uint64_t iterations);
extern uint64_t latmul64test(uint64_t iterations);
extern uint64_t jmptest(uint64_t iterations);
extern uint64_t fusejmptest(uint64_t iterations);
extern uint64_t mixmuljmptest(uint64_t iterations);
extern uint64_t mixmuljmptest21(uint64_t iterations);
extern uint64_t mixaddjmptest(uint64_t iterations);
extern uint64_t mixaddjmp21test(uint64_t iterations);
extern uint64_t rortest(uint64_t iterations);
extern uint64_t mixmulrortest(uint64_t iterations);
extern uint64_t vecadd128test(uint64_t iterations, int arr[4]);
extern uint64_t latvecadd128test(uint64_t iterations, int arr[4]);
extern uint64_t vecmul128test(uint64_t iterations, int arr[4]);
extern uint64_t latvecmul128test(uint64_t iterations, int arr[4]);
extern uint64_t mixvecaddmul128test(uint64_t iterations, int arr[4]);
extern uint64_t faddtest(uint64_t iterations, float arr[4]);
extern uint64_t latfaddtest(uint64_t iterations, float arr[4]);
extern uint64_t vecfadd128test(uint64_t iterations, float arr[4]);
extern uint64_t vecfmul128test(uint64_t iterations, float arr[4]);
extern uint64_t latvecfadd128test(uint64_t iterations, float arr[4]);
extern uint64_t latvecfmul128test(uint64_t iterations, float arr[4]);
extern uint64_t mixvecfaddfmul128test(uint64_t iterations, float arr[4]);
extern uint64_t vecfma128test(uint64_t iterations, float arr[4]);
extern uint64_t scalarfmatest(uint64_t iterations, float arr[4]);
extern uint64_t latvecfma128test(uint64_t iterations, float arr[4]);
extern uint64_t latscalarfmatest(uint64_t iterations, float arr[4]);
extern uint64_t mixvecfaddfma128test(uint64_t iterations, float arr[4]);
extern uint64_t mixvecfmulfma128test(uint64_t iterations, float arr[4]);

// see if SIMD pipeline shares ports with scalar ALU ones
extern uint64_t mixaddvecadd128test(uint64_t iterations, int arr[4]);
extern uint64_t mix3to1addvecadd128test(uint64_t iterations, int arr[4]);
extern uint64_t mix1to1addvecadd128test(uint64_t iterations, int arr[4]);
extern uint64_t mixmulvecmultest(uint64_t iterations, int arr[4]);

// are vec int and vec fp on the same port?
extern uint64_t mixvecmulfmultest(uint64_t iterations, float farr[4], int iarr[4]);
extern uint64_t mixvecaddfaddtest(uint64_t iterations, float farr[4], int iarr[4]);

// where are the branch ports
extern uint64_t mixjmpvecaddtest(uint64_t iterations, int arr[4]);
extern uint64_t mixjmpvecmultest(uint64_t iterations, int arr[4]);

// load/store
extern uint64_t loadtest(uint64_t iterations, int arr[4]);
extern uint64_t mixloadstoretest(uint64_t iterations, int arr[4], int sink[4]);
extern uint64_t mix21loadstoretest(uint64_t iterations, int arr[4], int sink[4]);
extern uint64_t vecloadtest(uint64_t iterations, int arr[4]);
extern uint64_t vecstoretest(uint64_t iterations, int arr[4], int sink[4]);

// renamer tests
extern uint64_t indepmovtest(uint64_t iterations);
extern uint64_t depmovtest(uint64_t iterations);
extern uint64_t xorzerotest(uint64_t iterations);
extern uint64_t movzerotest(uint64_t iterations);
extern uint64_t subzerotest(uint64_t iterations);

float fpTestArr[4] __attribute__ ((aligned (64))) = { 0.2, 1.5, 2.7, 3.14 };
int intTestArr[4] __attribute__ ((aligned (64))) = { 1, 2, 3, 4 };
int sinkArr[4] __attribute__ ((aligned (64))) = { 2, 3, 4, 5 };

float measureFunction(uint64_t iterations, float clockSpeedGhz, uint64_t (*testfunc)(uint64_t));
uint64_t vecadd128wrapper(uint64_t iterations);
uint64_t latvecadd128wrapper(uint64_t iterations);
uint64_t vecmul128wrapper(uint64_t iterations);
uint64_t latvecmul128wrapper(uint64_t iterations);
uint64_t mixvecaddmul128wrapper(uint64_t iterations);
uint64_t faddwrapper(uint64_t iterations);
uint64_t latfaddwrapper(uint64_t iterations);
uint64_t vecfadd128wrapper(uint64_t iterations);
uint64_t latvecfadd128wrapper(uint64_t iterations);
uint64_t vecfmul128wrapper(uint64_t iterations);
uint64_t latvecfmul128wrapper(uint64_t iterations);
uint64_t mixvecfaddfmul128wrapper(uint64_t iterations);
uint64_t mixaddvecadd128wrapper(uint64_t iterations);
uint64_t mix3to1addvecadd128wrapper(uint64_t iterations);
uint64_t mix1to1addvecadd128wrapper(uint64_t iterations);
uint64_t mixmulvecmulwrapper(uint64_t iterations);
uint64_t mixvecmulfmulwrapper(uint64_t iterations);
uint64_t mixvecaddfaddwrapper(uint64_t iterations);
uint64_t mixjmpvecaddwrapper(uint64_t iterations);
uint64_t mixjmpvecmulwrapper(uint64_t iterations);
uint64_t vecloadwrapper(uint64_t iterations);
uint64_t loadwrapper(uint64_t iterations);
uint64_t vecstorewrapper(uint64_t iterations);
uint64_t mixloadstorewrapper(uint64_t iterations);
uint64_t mix21loadstorewrapper(uint64_t iterations);
uint64_t vecfma128wrapper(uint64_t iterations);
uint64_t scalarfmawrapper(uint64_t iterations);
uint64_t latscalarfmawrapper(uint64_t iterations);
uint64_t mixvecfaddfma128wrapper(uint64_t iterations);
uint64_t mixvecfmulfma128wrapper(uint64_t iterations);
uint64_t latvecfma128wrapper(uint64_t iteration);

int main(int argc, char *argv[]) {
  struct timeval startTv, endTv;
  struct timezone startTz, endTz;
  uint64_t iterations = 1500000000;
  uint64_t iterationsHigh = iterations * 5;
  uint64_t time_diff_ms;
  float latency, opsPerNs, clockSpeedGhz;
  
  if (argc > 1) {
    int targetCpu = atoi(argv[1]);
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(targetCpu, &cpuset);
    sched_setaffinity(gettid(), sizeof(cpu_set_t), &cpuset);
  }

  // figure out clock speed
  gettimeofday(&startTv, &startTz);
  clktest(iterations);
  gettimeofday(&endTv, &endTz);
  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
  latency = 1e6 * (float)time_diff_ms / (float)iterations;
  // clk speed should be 1/latency, assuming we got one add per clk, roughly
  clockSpeedGhz = 1/latency;
  printf("Estimated clock speed> %.2f GHz\n", clockSpeedGhz);

  printf("Adds per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addtest));
  printf("XORs per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, eortest));
  printf("CMPs per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, cmptest));
  printf("1:3 madd:add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, maddaddtest));
  printf("Nops per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, noptest));
  printf("Indepdent movs per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, indepmovtest));
  printf("Dependent movs per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, depmovtest));
  printf("eor -> 0 per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, xorzerotest));
  printf("mov -> 0 per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, movzerotest));
  printf("sub -> 0 per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, subzerotest));


  printf("Not taken jmps per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, jmptest));
  printf("Jump fusion test> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, fusejmptest));
  printf("1:1 mixed not taken jmps / muls per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixmuljmptest));
  printf("1:2 mixed not taken jmps / muls per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixmuljmptest21));
  printf("1:1 mixed not taken jmps / adds per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixaddjmptest));
  printf("1:2 mixed not taken jmps / adds per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixaddjmp21test));
  printf("1:1 mixed add/mul per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addmultest));
  printf("2:1 mixed add/mul per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addmul21test));
  printf("ror per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, rortest));
  printf("1:1 mixed mul/ror per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixmulrortest));
  printf("32-bit mul per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mul32test));
  printf("64-bit mul per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mul32test));
  printf("scalar fp32 add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, faddwrapper));
  printf("128-bit vec int32 add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecadd128wrapper));
  printf("128-bit vec int32 multiply per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecmul128wrapper));
  printf("128-bit vec int32 mixed multiply and add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixvecaddmul128wrapper));
  printf("128-bit vec fp32 add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecfadd128wrapper));
  printf("128-bit vec fp32 multiply per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecfmul128wrapper));
  printf("128-bit vec fp32 mixed multiply and add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixvecfaddfmul128wrapper));
  printf("2:1 mixed scalar adds and 128-bit vec int32 add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixaddvecadd128wrapper));
  printf("3:1 mixed scalar adds and 128-bit vec int32 add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mix3to1addvecadd128wrapper));
  printf("1:1 mixed scalar adds and 128-bit vec int32 add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mix1to1addvecadd128wrapper));
  printf("1:1 mixed scalar 32-bit multiply and 128-bit vec int32 multiply per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixmulvecmulwrapper));
  printf("1:1 mixed 128-bit vec fp32 multiply and 128-bit vec int32 multiply per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixvecmulfmulwrapper));
  printf("1:1 mixed 128-bit vec fp32 add and 128-bit vec int32 add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixvecaddfaddwrapper));
  printf("1:2 mixed not taken jumps and 128-bit vec int32 add per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixjmpvecaddwrapper));
  printf("1:1 mixed not taken jumps and 128-bit vec int32 mul per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixjmpvecmulwrapper));
  printf("128-bit vec loads per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecloadwrapper));
  printf("128-bit vec stores per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecstorewrapper));
  printf("64-bit loads per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, loadwrapper));
  printf("1:1 mixed 64-bit loads/stores per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixloadstorewrapper));
  printf("2:1 mixed 64-bit loads/stores per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mix21loadstorewrapper));
  printf("64-bit multiply latency> %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul64test));
  printf("128-bit vec int32 add latency> %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latvecadd128wrapper));
  printf("128-bit vec int32 mul latency> %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latvecmul128wrapper));
  printf("Scalar FADD Latency> %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latfaddwrapper));
  printf("128-bit vector FADD latency> %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latvecfadd128wrapper));
  printf("128-bit vector FMUL latency> %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latvecfmul128wrapper));

  printf("128-bit vector FMA per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecfma128wrapper));
  printf("128-bit vector FMA latency> %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latvecfma128wrapper));
  printf("Scalar FMA per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, scalarfmawrapper));
  printf("Scalar FMA latency> %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latscalarfmawrapper));
  printf("1:1 mixed 128-bit vector FMA/FADD per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixvecfaddfma128wrapper));
  printf("1:1 mixed 128-bit vector FMA/FMUL per clk> %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixvecfmulfma128wrapper));
  return 0;
}

float measureFunction(uint64_t iterations, float clockSpeedGhz, uint64_t (*testfunc)(uint64_t)) {
  struct timeval startTv, endTv;
  struct timezone startTz, endTz;
  uint64_t time_diff_ms;
  float latency, opsPerNs;

  gettimeofday(&startTv, &startTz);
  testfunc(iterations);
  gettimeofday(&endTv, &endTz);
  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
  latency = 1e6 * (float)time_diff_ms / (float)iterations;
  opsPerNs = 1/latency;
  //printf("%f adds/ns, %f adds/clk?\n", opsPerNs, opsPerNs / clockSpeedGhz);
  return opsPerNs / clockSpeedGhz;
}

uint64_t vecadd128wrapper(uint64_t iterations) {
  return vecadd128test(iterations, intTestArr);
}

uint64_t vecmul128wrapper(uint64_t iterations) {
  return vecmul128test(iterations, intTestArr);
}

uint64_t latvecadd128wrapper(uint64_t iterations) {
  return latvecadd128test(iterations, intTestArr);
}

uint64_t latvecmul128wrapper(uint64_t iterations) {
  return latvecmul128test(iterations, intTestArr);
}

uint64_t mixvecaddmul128wrapper(uint64_t iterations) {
  return mixvecaddmul128test(iterations, intTestArr);
}

uint64_t faddwrapper(uint64_t iterations) {
  return faddtest(iterations, fpTestArr);
}

uint64_t latfaddwrapper(uint64_t iterations) {
  return latfaddtest(iterations, fpTestArr);
}

uint64_t latvecfadd128wrapper(uint64_t iterations) {
  return latvecfadd128test(iterations, fpTestArr);
}

uint64_t latvecfmul128wrapper(uint64_t iterations) {
  return latvecfmul128test(iterations, fpTestArr);
}

uint64_t vecfadd128wrapper(uint64_t iterations) {
  return vecfadd128test(iterations, fpTestArr);
}

uint64_t vecfmul128wrapper(uint64_t iterations) {
  return vecfmul128test(iterations, fpTestArr);
}
uint64_t mixvecfaddfmul128wrapper(uint64_t iterations) {
  return mixvecfaddfmul128test(iterations, fpTestArr);
}

uint64_t mixaddvecadd128wrapper(uint64_t iterations) {
  return mixaddvecadd128test(iterations, intTestArr);
}

uint64_t mix3to1addvecadd128wrapper(uint64_t iterations) {
  return mix3to1addvecadd128test(iterations, intTestArr);
}

uint64_t mix1to1addvecadd128wrapper(uint64_t iterations) {
  return mix1to1addvecadd128test(iterations, intTestArr);
}

uint64_t mixmulvecmulwrapper(uint64_t iterations) {
  return mixmulvecmultest(iterations, intTestArr);
}

uint64_t mixvecmulfmulwrapper(uint64_t iterations) {
  return mixvecmulfmultest(iterations, fpTestArr, intTestArr);
}

uint64_t mixvecaddfaddwrapper(uint64_t iterations) {
  return mixvecaddfaddtest(iterations, fpTestArr, intTestArr);
}

uint64_t mixjmpvecaddwrapper(uint64_t iterations) {
  return mixjmpvecaddtest(iterations, intTestArr);
}

uint64_t mixjmpvecmulwrapper(uint64_t iterations) {
  return mixjmpvecmultest(iterations, intTestArr);
}

uint64_t vecloadwrapper(uint64_t iterations) {
  return vecloadtest(iterations, intTestArr);
}

uint64_t vecstorewrapper(uint64_t iterations) {
  return vecstoretest(iterations, intTestArr, sinkArr);
}

uint64_t loadwrapper(uint64_t iterations) {
  if (((uint64_t)intTestArr & 63) != 0) {
    printf("Warning - load may not be 64B aligned\n");
  }

  return loadtest(iterations, intTestArr);
}

uint64_t mixloadstorewrapper(uint64_t iterations) {
  return mixloadstoretest(iterations, intTestArr, sinkArr);
}

uint64_t mix21loadstorewrapper(uint64_t iterations) {
  return mix21loadstoretest(iterations, intTestArr, sinkArr);
}

uint64_t vecfma128wrapper(uint64_t iterations) {
  return vecfma128test(iterations, fpTestArr);
}

uint64_t scalarfmawrapper(uint64_t iterations) {
  return scalarfmatest(iterations, fpTestArr);
}

uint64_t latscalarfmawrapper(uint64_t iterations) {
  return latscalarfmatest(iterations, fpTestArr);
}

uint64_t latvecfma128wrapper(uint64_t iterations) {
  return latvecfma128test(iterations, fpTestArr);
}

uint64_t mixvecfmulfma128wrapper(uint64_t iterations) {
  return mixvecfmulfma128test(iterations, fpTestArr);
}

uint64_t mixvecfaddfma128wrapper(uint64_t iterations) {
  return mixvecfaddfma128test(iterations, fpTestArr);
}
