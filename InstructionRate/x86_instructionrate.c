/* This is a one-off microbenchmark for attempts to dissect
 * Zhaoxin's KX-6640MA (LuJiaZui) architecture
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
extern uint64_t noptest1b(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t clktest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t clkmovtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t addtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t addnoptest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t addmovtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t leatest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t leamultest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t rortest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t shltest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t rorbtstest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixrormultest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixrorshltest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t btstest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t btsmultest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t addmultest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t jmpmultest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t jmptest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t ntjmptest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixadd256int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixadd256int11(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixadd256fpint(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mix256fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mix256fp11(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latadd512int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latadd256int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latadd128int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latadd256fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmul128int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmul256int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmul512int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmulq512int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmuldq512int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmul256fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latadd128fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmul128fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latfma512(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latfma256(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latfma128(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t add128int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t add256int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t add512int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mul512int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t muldq512int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mul128int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t add128fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mul128fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t fma512(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixfma256fma512(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mix21fma256fma512(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t fma256(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t fma128(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixfmafadd256(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixfmaadd256(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixfmaadd512(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixfma512add256(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixfmaand256(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixfmaandmem256(uint64_t iterations, float *arr) __attribute((sysv_abi));
extern uint64_t mixfmaaddmem256(uint64_t iterations, float *arr) __attribute((sysv_abi));
extern uint64_t nemesfpumix21(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t nemesfpu512mix21(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mul256fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t add256fp(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmul64(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t latmul16(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mul16(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mul64(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t load128(uint64_t iterations, int *arr) __attribute((sysv_abi));
extern uint64_t spacedload128(uint64_t iterations, int *arr) __attribute((sysv_abi));
extern uint64_t loadscalar(uint64_t iterations, int *arr) __attribute((sysv_abi));
extern uint64_t load256(uint64_t iterations, float *arr) __attribute((sysv_abi));
extern uint64_t load512(uint64_t iterations, float *arr) __attribute((sysv_abi));
extern uint64_t store128(uint64_t iterations, int *arr, int *sink) __attribute((sysv_abi));
extern uint64_t store256(uint64_t iterations, float *arr, float *sink) __attribute((sysv_abi));
extern uint64_t store512(uint64_t iterations, float *arr, float *sink) __attribute((sysv_abi));
extern uint64_t mixaddmul128int(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixmul16mul64(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mixmul16mul64_21(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t pdeptest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t pdepmultest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t pexttest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t indepmovtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t vecindepmovtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t depmovtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t vecdepmovtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t xorzerotest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t vecxorzerotest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t movzerotest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t subzerotest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t vecsubzerotest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t depinctest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t depdectest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t depaddimmtest(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t spacedstorescalar(uint64_t iterations, int *arr) __attribute((sysv_abi));
extern uint64_t aesenc128(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t aesdec128(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t aesencfadd128(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t aesencadd128(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t aesencfma128(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t aesencmul128(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t mix256faddintadd(uint64_t iterations) __attribute((sysv_abi));

extern uint64_t fma4_256(uint64_t iterations) __attribute((sysv_abi));
extern uint64_t fma4_128(uint64_t iterations) __attribute((sysv_abi));

float fpTestArr[8] __attribute__ ((aligned (64))) = { 0.2, 1.5, 2.7, 3.14, 5.16, 6.3, 7.7, 9.45 };
float fpSinkArr[8] __attribute__ ((aligned (64))) = { 2.1, 3.2, 4.3, 5.4, 6.2, 7.8, 8.3, 9.4 };
int *intTestArr;
int intSinkArr[8] __attribute__ ((aligned (64))) = { 2, 3, 4, 5, 6, 7, 8, 9 };

uint64_t load128wrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t loadscalarwrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t spacedload128wrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t spacedstorescalarwrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t load256wrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t load512wrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t store128wrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t store256wrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t store512wrapper(uint64_t iterations) __attribute((sysv_abi));
uint64_t mixfmaandmem256wrapper(uint64_t iterations)  __attribute((sysv_abi));
uint64_t mixfmaaddmem256wrapper(uint64_t iterations)  __attribute((sysv_abi));

float measureFunction(uint64_t iterations, float clockSpeedGhz, __attribute((sysv_abi)) uint64_t (*testfunc)(uint64_t));

int main(int argc, char *argv[]) {
  struct timeval startTv, endTv;
  struct timezone startTz, endTz;
  uint64_t iterations = 1500000000;
  uint64_t iterationsHigh = iterations * 5;
  uint64_t time_diff_ms;
  float latency, opsPerNs, clockSpeedGhz;
  uint64_t intTestArrLength = 1024;
  int avxSupported = 0, avx2Supported = 0, bmi2Supported = 0, avx512Supported = 0;
  int fmaSupported = 0, fma4Supported = 0;

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

  if (__builtin_cpu_supports("avx")) {
    fprintf(stderr, "avx supported\n");
    avxSupported = 1;
  }

  if (__builtin_cpu_supports("avx2")) {
    fprintf(stderr, "avx2 supported\n");
    avx2Supported = 1;
  }

  if (__builtin_cpu_supports("bmi2")) {
    fprintf(stderr, "bmi2 supported\n");
    bmi2Supported = 1;
  }

  if (__builtin_cpu_supports("fma")) {
      fprintf(stderr, "fma3 supported\n");
      fmaSupported = 1;
  }

  if (__builtin_cpu_supports("fma4")) {
      fprintf(stderr, "fma4 supported\n");
      fma4Supported = 1;
  }

  uint32_t cpuidEax, cpuidEbx, cpuidEcx, cpuidEdx;
  __cpuid_count(7, 0, cpuidEax, cpuidEbx, cpuidEcx, cpuidEdx);
  if (cpuidEbx & (1UL << 16)) {
      fprintf(stderr, "AVX512 supported\n");
      avx512Supported = 1;
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

  // avx-512 testing
  if (avx512Supported) {
    if (argc == 1 || argc > 1 && strncmp(argv[1], "fma512", 6) == 0)
      printf("512-bit FMA per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, fma512));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "latfma512", 9) == 0)
      printf("512-bit FMA latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latfma512));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "mixfma256fma512", 15) == 0)
      printf("1:1 256-bit/512-bit FMA per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mixfma256fma512));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "mix21fma256fma512", 17) == 0)
      printf("2:1 256-bit/512-bit FMA per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mix21fma256fma512));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "nemesfpumix21", 13) == 0)
      printf("1:2 512b FMA:FADD per clk (nemes): %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, nemesfpu512mix21));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "add512int", 9) == 0)
      printf("512-bit int add per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, add512int));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "latadd512int", 12) == 0)
      printf("512-bit int add latency: %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latadd256int));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "mul512int", 9) == 0)
      printf("512-bit 32-bit int mul per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mul512int));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "muldq512int", 9) == 0)
      printf("512-bit 32->64-bit int mul per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, muldq512int));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "latmulq512int", 13) == 0)
      printf("512-bit 64-bit int mul latency: %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latmulq512int));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul512int", 12) == 0)
      printf("512-bit 32-bit int mul latency: %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latmul512int));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "latmuldq512int", 13) == 0)
      printf("512-bit 32->64-bit int mul latency: %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latmuldq512int));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "mixfmaadd512", 11) == 0)
      printf("1:2 512b PADDQ:FMA per clk: %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, mixfmaadd512));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "mixfma512add256", 11) == 0)
      printf("1:2 256b PADDQ : 512b FMA per clk: %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, mixfma512add256));


    if (argc == 1 || argc > 1 && strncmp(argv[1], "load512", 7) == 0)
      printf("512-bit loads per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, load512wrapper));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "store512", 7) == 0)
      printf("512-bit stores per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, store512wrapper));

    if (argc == 1 || argc > 1 && strncmp(argv[1], "aesenc128", 9) == 0)
      printf("aesenc per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, aesenc128));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "aesdec128", 9) == 0)
      printf("aesdec per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, aesdec128));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "aesencadd128", 12) == 0)
      printf("1:3 aesenc+paddd per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, aesencadd128));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "aesencfma128", 12) == 0)
      printf("1:2 aesenc+fma per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, aesencfma128));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "aesencmul128", 12) == 0)
      printf("1:2 aesenc+pmullw per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, aesencmul128));
    if (argc == 1 || argc > 1 && strncmp(argv[1], "aesencmul128", 12) == 0)
      printf("1:2 aesenc+addps per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, aesencfadd128));
  }

  // throughput
  if (argc == 1 || argc > 1 && strncmp(argv[1], "1bnop", 5) == 0)
    printf("1-byte nops per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, noptest1b));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "2bnop", 5) == 0)
    printf("2-byte nops per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, noptest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "add", 3) == 0)
    printf("Adds per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "addnop", 7) == 0)
    printf("1:4 nops/adds per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addnoptest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "addmov", 7) == 0)
    printf("1:4 movs/adds per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addnoptest));

  // renamer throughput
  if (argc == 1 || argc > 1 && strncmp(argv[1], "depmov", 6) == 0)
    printf("Dependent movs per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, depmovtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "indepmov", 8) == 0)
    printf("Independent movs per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, indepmovtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "xorzero", 7) == 0)
    printf("xor -> 0 per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, xorzerotest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "movzero", 7) == 0)
    printf("mov -> 0 per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, movzerotest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "subzero", 7) == 0)
    printf("sub -> 0 per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, subzerotest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "depinc", 6) == 0)
    printf("dep inc per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, depinctest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "depdec", 6) == 0)
    printf("dep dec per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, depdectest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "depdec", 6) == 0)
    printf("dep add immediate per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, depaddimmtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "clkmov", 6) == 0)
    printf("dep add + mov pair per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, clkmovtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "vecdepmov", 9) == 0)
    printf("Dependent vec movs per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecdepmovtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "vecindepmov", 12) == 0)
    printf("Independent vec movs per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecindepmovtest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "vecxorzero", 10) == 0)
    printf("xor xmm -> 0 per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecxorzerotest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "vecsubzero", 10) == 0)
    printf("sub xmm -> 0 per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, vecsubzerotest));

  // misc mixed integer tests
  if (argc == 1 || argc > 1 && strncmp(argv[1], "miximuladd", 10) == 0)
    printf("4:1 adds/imul per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, addmultest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "jmpmul", 6) == 0)
    printf("1:1 mul/jmp per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, jmpmultest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "jmp", 3) == 0)
    printf("taken jmp per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, jmptest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "ntjmp", 5) == 0)
    printf("nt jmp per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, ntjmptest));
  if (bmi2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "pdep", 4) == 0))
    printf("pdep per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, pdeptest));
  if (bmi2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "pext", 4) == 0))
    printf("pext per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, pexttest));
  if (bmi2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "pdepmul", 7) == 0))
    printf("1:1 pdep/mul per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, pdepmultest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "shl", 3) == 0)
    printf("shl r,1 per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, shltest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "ror", 3) == 0)
    printf("ror r,1 per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, rortest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixrorshl", 9) == 0)
    printf("1:1 shl/ror r,1 per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixrorshltest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixrormul", 3) == 0)
    printf("1:1 ror/mul per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixrormultest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "bts", 3) == 0)
    printf("bts per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, btstest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixmulbts", 9) == 0)
    printf("1:1 bts/mul per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, btsmultest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixrorbts", 9) == 0)
    printf("1:1 bts/ror per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, rorbtstest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "lea", 3) == 0)
    printf("lea r+r*8 per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, leatest));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixmullea", 9) == 0)
    printf("1:1 lea r+r*8/mul per clk: %.4f\n", measureFunction(iterationsHigh, clockSpeedGhz, leamultest));

  // vector and FP
  if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "avx256int", 9) == 0))
    printf("256-bit avx integer add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, add256int));
  if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mixavx256int", 12) == 0))
    printf("2:1 scalar add/256-bit avx integer add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixadd256int));
  if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mix11avx256int", 14) == 0))
    printf("1:1 scalar add/256-bit avx integer add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixadd256int11));
  if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mixavx256fpint", 14) == 0))
    printf("1:1 256-bit avx int add/avx fadd per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mixadd256fpint));
  if (avxSupported && (argc == 1 || argc > 1 && strncmp(argv[1], "mix256fp", 8) == 0))
    printf("1:1 256-bit avx fp mul/add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mix256fp));
  if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "latadd256int", 12) == 0))
    printf("256-bit avx2 integer add latency: %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latadd256int));
  if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "latmul256int", 12) == 0))
    printf("256-bit avx2 integer multiply latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul256int));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latadd128int", 12) == 0)
    printf("128-bit sse integer add latency: %.2f clocks\n", 1 / measureFunction(iterationsHigh, clockSpeedGhz, latadd128int));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul128int", 12) == 0)
    printf("128-bit sse integer multiply latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul128int));
  if (avxSupported && (argc == 1 || argc > 1 && strncmp(argv[1], "latadd256fp", 11) == 0))
    printf("256-bit avx fadd latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latadd256fp));
  if (avxSupported && (argc == 1 || argc > 1 && strncmp(argv[1], "latmul256fp", 11) == 0))
    printf("256-bit avx fmul latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul256fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latadd128fp", 11) == 0)
    printf("128-bit sse fadd latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latadd128fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "latmul128fp", 11) == 0)
    printf("128-bit sse fmul latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latmul128fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "add128fp", 8) == 0)
    printf("128-bit sse fadd per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, add128fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mul128fp", 8) == 0)
    printf("128-bit sse fmul per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mul128fp));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "add128int", 9) == 0)
    printf("128-bit sse int add per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, add128int));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mul128int", 9) == 0)
    printf("128-bit sse int mul per clk: %.2f\n", measureFunction(iterationsHigh, clockSpeedGhz, mul128int));

  if (fmaSupported) {
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "fma256", 6) == 0))
          printf("256-bit FMA per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, fma256));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "fma128", 6) == 0))
          printf("128-bit FMA per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, fma128));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "latfma256", 9) == 0))
          printf("256-bit FMA latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latfma256));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "latfma128", 9) == 0))
          printf("128-bit FMA latency: %.2f clocks\n", 1 / measureFunction(iterations, clockSpeedGhz, latfma128));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mixfmafadd256", 12) == 0))
          printf("1:2 256b FMA:FADD per clk: %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, mixfmafadd256));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mixfmaadd256", 11) == 0))
          printf("2:1 256b FMA:PADDQ per clk: %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, mixfmaadd256));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mixfmaandmem256", 14) == 0))
          printf("2:1 256b FMA:PADDQ load-op per clk: %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, mixfmaaddmem256wrapper));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mixfmaand256", 11) == 0))
          printf("2:1 256b FMA:PAND per clk: %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, mixfmaand256));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mixfmaandmem256", 14) == 0))
          printf("2:1 256b FMA:PAND load-op per clk: %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, mixfmaandmem256wrapper));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "nemesfpumix21", 13) == 0))
          printf("1:2 256b FMA:FADD per clk (nemes): %.2f\n", measureFunction(iterations * 22, clockSpeedGhz, nemesfpumix21));
      if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "mix256faddintadd", 15) == 0))
          printf("1:2 256b FMA:PADD per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mix256faddintadd));
  }

  if (fma4Supported)
  {
      if (argc == 1 || argc > 1 && strncmp(argv[1], "fma4_256", 8) == 0)
          printf("256-bit FMA4 per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, fma4_256));
      if (argc == 1 || argc > 1 && strncmp(argv[1], "fma4_256", 8) == 0)
          printf("128-bit FMA4 per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, fma4_128));
  }

  if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "fadd256", 6) == 0))
    printf("256-bit FADD per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, add256fp));
  if (avx2Supported && (argc == 1 || argc > 1 && strncmp(argv[1], "fmul256", 6) == 0))
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
  if (argc == 1 || argc > 1 && strncmp(argv[1], "loadscalar", 10) == 0)
    printf("64-bit scalar loads per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, loadscalarwrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "load128", 7) == 0)
    printf("128-bit loads per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, load128wrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "spacedload128", 13) == 0)
    printf("128-bit loads (spaced) per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, spacedload128wrapper));
  if (avxSupported && (argc == 1 || argc > 1 && strncmp(argv[1], "load256", 7) == 0))
    printf("256-bit loads per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, load256wrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "spacedstorescalar", 13) == 0)
    printf("scalar stores (spaced) per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, spacedstorescalarwrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "store128", 7) == 0)
    printf("128-bit stores per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, store128wrapper));
  if (avxSupported && (argc == 1 || argc > 1 && strncmp(argv[1], "store256", 7) == 0))
    printf("256-bit stores per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, store256wrapper));
  if (argc == 1 || argc > 1 && strncmp(argv[1], "mixaddmul128int", 15) == 0)
    printf("1:1 mixed 128-bit vec add/mul per clk: %.2f\n", measureFunction(iterations, clockSpeedGhz, mixaddmul128int));

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

__attribute((sysv_abi)) uint64_t load128wrapper(uint64_t iterations) {
  return load128(iterations, intTestArr);
}

__attribute((sysv_abi)) uint64_t spacedload128wrapper(uint64_t iterations) {
  return spacedload128(iterations, intTestArr);
}

__attribute((sysv_abi)) uint64_t spacedstorescalarwrapper(uint64_t iterations) {
  return spacedstorescalar(iterations, intTestArr);
}

__attribute((sysv_abi)) uint64_t load256wrapper(uint64_t iterations) {
  return load256(iterations, fpTestArr);
}

__attribute((sysv_abi)) uint64_t loadscalarwrapper(uint64_t iterations) {
  return loadscalar(iterations, intTestArr);
}

__attribute((sysv_abi)) uint64_t load512wrapper(uint64_t iterations) {
  return load512(iterations, fpTestArr);
}

__attribute((sysv_abi)) uint64_t spacedload256wrapper(uint64_t iterations) {
  return spacedload128(iterations, intTestArr);
}

__attribute((sysv_abi)) uint64_t store128wrapper(uint64_t iterations) {
  return store128(iterations, intTestArr, intSinkArr);
}

__attribute((sysv_abi)) uint64_t store256wrapper(uint64_t iterations) {
  return store256(iterations, fpTestArr, fpSinkArr);
}

__attribute((sysv_abi)) uint64_t store512wrapper(uint64_t iterations) {
  return store512(iterations, fpTestArr, fpSinkArr);
}

__attribute((sysv_abi)) uint64_t mixfmaandmem256wrapper(uint64_t iterations) {
  return mixfmaandmem256(iterations, fpTestArr);
}

__attribute((sysv_abi)) uint64_t mixfmaaddmem256wrapper(uint64_t iterations) {
  return mixfmaaddmem256(iterations, fpTestArr);
}
