extern uint64_t vec_int32_add_test(uint64_t iterations, void *data);
extern uint64_t vec_int32_mul_test(uint64_t iterations, void *data);
extern uint64_t vec_fp32_add_test(uint64_t iterations, void *data);
extern uint64_t vec_fp32_fma_test(uint64_t iterations, void *data);

void RunTests() {
  uint64_t iterations = 3500000000;
  int testDataLength = 256; 
  uint32_t *intTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  uint32_t *fpTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  for (int i = 0; i < testDataLength; i++) {
    intTestArr[i] = i;
    fpTestArr[i] = i * 1.2f;
  }

  fprintf(stderr, "Measuring INT32 adds\n");
  float int32adds = measureFunction(iterations, vec_int32_add_test, intTestArr);
  fprintf(stderr, "Measuring INT32 multiplies\n");
  float int32muls = measureFunction(iterations, vec_int32_mul_test, intTestArr);
  fprintf(stderr, "Measuring FP32 adds\n");
  float fp32adds = measureFunction(iterations, vec_fp32_add_test, fpTestArr);
  fprintf(stderr, "Measuring FP32 FMAs\n");
  float fp32fmas = measureFunction(iterations, vec_fp32_fma_test, fpTestArr);

  printf("-----GOPS/s-----\n");
  printf("INT32 Add: %f\n", int32adds);
  printf("INT32 Multiply: %f\n", int32muls);
  printf("FP32 Add: %f\n", fp32adds);
  printf("FP32 FMA: %f\n", fp32fmas);

  free(intTestArr);
  free(fpTestArr);
  return;
}
