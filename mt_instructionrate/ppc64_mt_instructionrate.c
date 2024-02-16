extern uint64_t vec_int32_add_test(uint64_t iterations, void *data);
extern uint64_t vec_int32_mul_test(uint64_t iterations, void *data);
extern uint64_t vec_fp32_add_test(uint64_t iterations, void *data);
extern uint64_t vec_fp32_fma_test(uint64_t iterations, void *data);
extern uint64_t vec_fp32_isqrt_test(uint64_t iterations, void *data);
extern uint64_t fp64_add_test(uint64_t iterations, void *data);
extern uint64_t fp64_fma_test(uint64_t iterations, void *data);

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
  float int32muls = measureFunction(iterations, vec_int32_mul_test, intTestArr);
  float fp32adds = measureFunction(iterations, vec_fp32_add_test, fpTestArr);
  float fp32fmas = measureFunction(iterations, vec_fp32_fma_test, fpTestArr);
  float fp32isqrt = measureFunction(iterations, vec_fp32_isqrt_test, fpTestArr);
  float fp64adds = measureFunction(iterations, fp64_add_test, fpTestArr);
  float fp64fmas = measureFunction(iterations, fp64_fma_test, fpTestArr);

  printf("-----GOPS/s-----\n");
  printf("Altivec INT32 Add: %f\n", int32adds); 
  printf("Altivec INT32 Multiply: %f\n", int32muls); 
  printf("Altivec FP32 Add: %f\n", fp32adds);
  printf("Altivec FP32 FMA: %f (%f GFLOPS)\n", fp32fmas, 2 * fp32fmas);
  printf("Altivec FP32 Inverse Square Root: %f\n", fp32isqrt);
  printf("FP64 Add: %f\n", fp64adds);
  printf("FP64 FMA: %f (%f GFLOPS)\n", fp64fmas, 2 * fp64fmas);
  
  free(intTestArr);
  free(fpTestArr); 
  return;
}
