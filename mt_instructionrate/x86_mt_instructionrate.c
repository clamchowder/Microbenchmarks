extern uint64_t sse_int32_add_test(uint64_t iterations, void *data) SMALLKITTEN;
extern uint64_t sse_int32_mul_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx2_int32_add_test(uint64_t iterations, void* data) SMALLKITTEN;
extern uint64_t avx2_int32_mul_test(uint64_t iterations, void* data) SMALLKITTEN;


void RunTests() {
  int cpuid_data[4];
  int avx_supported = 0, avx2_supported = 0, avx512_supported = 0;
  uint64_t iterations = 5500000000;
  int testDataLength = 512; 
  uint32_t *intTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  uint32_t *fpTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  for (int i = 0; i < testDataLength; i++) {
    intTestArr[i] = i;
    fpTestArr[i] = i * 1.2f;
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

  __cpuidex(cpuid_data, 7, 0);
  if (cpuid_data[1] & (1UL << 16)) {
      fprintf(stderr, "AVX512 supported\n");
      avx512_supported = 1;
  }

  fprintf(stderr, "Measuring INT32 adds with SSE\n");
  float sseInt32Adds = measureFunction(iterations, sse_int32_add_test, intTestArr);

  float avx2Int32Adds;
  if (avx2_supported) avx2Int32Adds = measureFunction(iterations, avx2_int32_add_test, intTestArr);
  float sseInt32Muls = measureFunction(iterations, sse_int32_mul_test, intTestArr);

  float avx2Int32Muls;
  if (avx2_supported) avx2Int32Muls = measureFunction(iterations, avx2_int32_mul_test, intTestArr);

  printf("-----GOPS/s-----\n");
  printf("SSE INT32 Adds: %f\n", sseInt32Adds);
  if (avx2_supported) printf("AVX2 INT32 Adds: %f\n", avx2Int32Adds);
  printf("SSE INT32 Multiplies: %f\n", sseInt32Muls);
  if (avx2_supported) printf("AVX2 INT32 Multiplies: %f\n", avx2Int32Muls);
  
  free(intTestArr);
  free(fpTestArr);
  return;
}
