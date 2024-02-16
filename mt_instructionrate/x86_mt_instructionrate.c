extern uint64_t sse_int32_add_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t sse_int32_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t sse_int64_add_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t sse_int64_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx2_int32_add_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx2_int32_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx2_int64_add_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx2_int64_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t sse_fp32_add_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t sse_fp32_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t sse_fp32_muladd_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx_fp32_add_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx_fp32_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx_fp32_muladd_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t sse_fp64_add_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t sse_fp64_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t sse_fp64_muladd_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx_fp64_add_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx_fp64_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx_fp64_muladd_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t fp32_fma_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t fp64_fma_test(uint64_t iterations, void* data) SMALLKITTEN;

extern uint64_t avx_fp32_rsqrt_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t sse_fp32_rsqrt_test(uint64_t iterations, void *data) SMALLKITTEN;

extern uint64_t avx512_int32_add_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t avx512_int32_mul_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t avx512_int64_add_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t avx512_int64_mul_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t avx512_fp32_rsqrt_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t avx512_fp32_add_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t avx512_fp32_fma_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t avx512_fp64_add_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t avx512_fp64_fma_test(uint64_t iterations, void *data) SMALLKITTEN;

#ifndef _MSC_VER
#include <cpuid.h>
void __cpuidex(int *data, int function, int subfunction) {
  int eax, ebx, ecx, edx;
  __cpuid_count(function, subfunction, eax, ebx, ecx, edx);
  data[0] = eax;
  data[1] = ebx;
  data[2] = ecx;
  data[3] = edx;
}
#endif


void RunTests() {
  int cpuid_data[4];
  int avx_supported = 0, avx2_supported = 0, avx512_supported = 0, fma_supported = 0;
  uint64_t iterations = 5500000000;
  int testDataLength = 512; 
  uint32_t *intTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  uint64_t* int64TestArr = (uint64_t*)malloc(sizeof(uint64_t) * testDataLength);
  float *fpTestArr = (float *)malloc(sizeof(uint32_t) * testDataLength);
  double* fp64TestArr = (double*)malloc(sizeof(double) * testDataLength);
  for (int i = 0; i < testDataLength; i++) {
    intTestArr[i] = i;
    int64TestArr[i] = i * 2;
    fpTestArr[i] = 1.0f + 0.02f * i;
    fp64TestArr[i] = 2.0f + 0.01f * i;
  }

  __cpuidex(cpuid_data, 1, 0);
  if (cpuid_data[2] & (1UL << 28)) {
      fprintf(stderr, "AVX supported\n");
      avx_supported = 1;
  }

  if (cpuid_data[2] & (1UL << 28)) {
      fprintf(stderr, "AVX2 supported\n");
      avx2_supported = 1;
  }

  if (cpuid_data[2] & (1UL << 12)) {
      fprintf(stderr, "FMA supported\n");
      fma_supported = 1;
  }

  __cpuidex(cpuid_data, 7, 0);
  if (cpuid_data[1] & (1UL << 16)) {
      fprintf(stderr, "AVX512 supported\n");
      avx512_supported = 1;
  }

  fprintf(stderr, "Measuring INT32 adds with SSE\n");
  float sseInt32Adds = measureFunction(iterations, sse_int32_add_test, intTestArr);
  float sseInt32Muls = measureFunction(iterations, sse_int32_mul_test, intTestArr);
  float sseInt64Adds = measureFunction(iterations, sse_int64_add_test, intTestArr);
  float sseInt64Muls = measureFunction(iterations, sse_int64_mul_test, intTestArr);
  float sseFp32Adds = measureFunction(iterations, sse_fp32_add_test, fpTestArr);
  float sseFp32Muls = measureFunction(iterations, sse_fp32_mul_test, fpTestArr);
  float sseFp32MulAdds = measureFunction(iterations, sse_fp32_muladd_test, fpTestArr);
  float sseFp64Adds = measureFunction(iterations, sse_fp64_add_test, fp64TestArr);
  float sseFp64Muls = measureFunction(iterations, sse_fp64_mul_test, fp64TestArr);
  float sseFp64Muladds = measureFunction(iterations, sse_fp64_muladd_test, fp64TestArr);
  float sseFp32Rsqrts = measureFunction(iterations, sse_fp32_rsqrt_test, fpTestArr);

  float avx2Int32Adds, avx2Int32Muls, avx2Int64Adds, avx2Int64Muls;
  if (avx2_supported) {
      avx2Int32Adds = measureFunction(iterations, avx2_int32_add_test, intTestArr);
      avx2Int32Muls = measureFunction(iterations, avx2_int32_mul_test, intTestArr);
      avx2Int64Adds = measureFunction(iterations, avx2_int64_add_test, int64TestArr);
      avx2Int64Muls = measureFunction(iterations, avx2_int64_mul_test, int64TestArr);
  }

  float avxFp32Adds, avxFp32Muls, avxFp32Muladds, avxFp64Adds, avxFp64Muls, avxFp64Muladds;
  float avxFp32Rsqrts;
  if (avx_supported)
  {
      avxFp32Adds = measureFunction(iterations, avx_fp32_add_test, fpTestArr);
      avxFp32Muls = measureFunction(iterations, avx_fp32_mul_test, fpTestArr);
      avxFp32Muladds = measureFunction(iterations, avx_fp32_muladd_test, fpTestArr);
      avxFp64Adds = measureFunction(iterations, avx_fp64_add_test, fp64TestArr);
      avxFp64Muls = measureFunction(iterations, avx_fp64_mul_test, fp64TestArr);
      avxFp64Muladds = measureFunction(iterations, avx_fp64_muladd_test, fp64TestArr);
      avxFp32Rsqrts = measureFunction(iterations, avx_fp32_rsqrt_test, fpTestArr);
  }

  float fmaFp32, fmaFp64;
  if (fma_supported) {
      fmaFp32 = measureFunction(iterations, fp32_fma_test, fpTestArr);
      fmaFp64 = measureFunction(iterations, fp64_fma_test, fpTestArr);
  }

  float avx512Fp32Rsqrts, avx512Fp32Adds, avx512Fp32Fmas, avx512Fp64Adds, avx512Fp64Fmas;
  float avx512Int32Adds, avx512Int32Muls, avx512Int64Adds, avx512Int64Muls;
  if (avx512_supported) {
    avx512Fp32Rsqrts = measureFunction(iterations, avx512_fp32_rsqrt_test, fpTestArr);
    avx512Fp32Adds = measureFunction(iterations, avx512_fp32_add_test, fpTestArr);
    avx512Fp32Fmas = measureFunction(iterations, avx512_fp32_fma_test, fpTestArr);
    avx512Fp64Adds = measureFunction(iterations, avx512_fp64_add_test, fp64TestArr);
    avx512Fp64Fmas = measureFunction(iterations, avx512_fp64_fma_test, fp64TestArr);
    avx512Int32Adds = measureFunction(iterations, avx512_int32_add_test, intTestArr);
    avx512Int32Muls = measureFunction(iterations, avx512_int32_mul_test, intTestArr);
    avx512Int64Adds = measureFunction(iterations, avx512_int64_add_test, int64TestArr);
    avx512Int64Muls = measureFunction(iterations, avx512_int64_mul_test, int64TestArr);
  }

  printf("\n-----GOPS/s-----\n");

  // INT32
  printf("\n-----INT32-----\n");
  printf("SSE INT32 Adds: %f\n", sseInt32Adds);
  if (avx2_supported) printf("AVX2 INT32 Adds: %f\n", avx2Int32Adds);
  if (avx512_supported) printf("AVX512 INT32 Adds: %f\n", avx512Int32Adds);
  printf("SSE INT32 Multiplies: %f\n", sseInt32Muls);
  if (avx2_supported) printf("AVX2 INT32 Multiplies: %f\n", avx2Int32Muls);
  if (avx512_supported) printf("AVX512 INT32 Multiplies: %f\n", avx512Int32Muls);

  // FP32
  printf("\n-----FP32-----\n");
  printf("SSE FP32 Adds: %f\n", sseFp32Adds);
  if (avx_supported) printf("AVX FP32 Adds: %f\n", avxFp32Adds);
  if (avx512_supported) printf("AVX512 FP32 Adds: %f\n", avx512Fp32Adds);
  printf("SSE FP32 Multiplies: %f\n", sseFp32Muls);
  if (avx_supported) printf("AVX FP32 Multiplies: %f\n", avxFp32Muls);
  printf("SSE FP32 Multiply+Adds: %f\n", sseFp32MulAdds);
  if (avx_supported) printf("AVX FP32 Multiply+Adds: %f (%f GFLOPS)\n", avxFp32Muladds, 2 * avxFp32Muladds);
  if (fma_supported) printf("FP32 FMAs: %f (%f GFLOPS)\n", fmaFp32, 2 * fmaFp32);
  if (avx512_supported) printf("AVX512 FP32 FMAs: %f (%f GFLOPS)\n", avx512Fp32Fmas, avx512Fp32Fmas * 2);
  printf("SSE FP32 Inverse Square Roots: %f\n", sseFp32Rsqrts);
  if (avx_supported) printf("AVX FP32 Inverse Square Roots: %f\n", avxFp32Rsqrts);
  if (avx512_supported) printf("AVX512 FP32 Inverse Square Roots: %f\n", avx512Fp32Rsqrts);
  
  // INT64
  printf("\n-----INT64-----\n");
  printf("SSE INT64 Adds: %f\n", sseInt64Adds);
  if (avx2_supported) printf("AVX2 INT64 Adds: %f\n", avx2Int64Adds);
  if (avx512_supported) printf("AVX512 INT64 Adds: %f\n", avx512Int64Adds);
  printf("SSE INT64 Multiplies: %f\n", sseInt64Muls);
  if (avx2_supported) printf("AVX2 INT64 Multiplies: %f\n", avx2Int64Muls);
  if (avx512_supported) printf("AVX512 INT64 Multiplies: %f\n", avx512Int64Muls);

  // FP64
  printf("\n-----FP64-----\n");
  printf("SSE FP64 Adds: %f\n", sseFp64Adds);
  if (avx_supported) printf("AVX FP64 Adds: %f\n", avxFp64Adds);
  if (avx512_supported) printf("AVX512 FP64 Adds: %f\n", avx512Fp64Adds);
  printf("SSE FP64 Multiplies: %f\n", sseFp64Muls);
  if (avx_supported) printf("AVX FP64 Multiplies: %f\n", avxFp64Muls);
  printf("SSE FP64 Multiply+Adds: %f (%f GFLOPS)\n", sseFp64Muladds, 2 * sseFp64Muladds);
  if (avx_supported) printf("AVX FP64 Multiply+Adds: %f (%f GFLOPS)\n", avxFp64Muladds, 2 * avxFp64Muladds);
  if (fma_supported) printf("AVX FP64 FMAs: %f (%f GFLOPS)\n", fmaFp64, 2 * fmaFp64);
  if (avx512_supported) printf("AVX512 FP64 FMAs: %f (%f GFLOPS)\n", avx512Fp64Fmas, avx512Fp64Fmas * 2);

  free(intTestArr);
  free(fpTestArr);
  return;
}
