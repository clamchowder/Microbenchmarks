extern uint64_t vec_int32_add_test(uint64_t iterations, void *data);
extern uint64_t vec_int32_mul_test(uint64_t iterations, void *data);
extern uint64_t vec_fp32_add_test(uint64_t iterations, void *data);
extern uint64_t vec_fp32_fma_test(uint64_t iterations, void *data);
extern uint64_t vec_fp32_rsqrt_test(uint64_t iterations, void *data);
extern uint64_t vec_fp64_add_test(uint64_t iterations, void *data);
extern uint64_t vec_fp64_fma_test(uint64_t iterations, void *data);
extern uint64_t vec_int64_add_test(uint64_t iterations, void *data);
//extern uint64_t vec_int64_mul_test(uint64_t iterations, void *data);


void RunTests() {
  uint64_t iterations = 3500000000;
  int testDataLength = 256; 
  uint32_t *intTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  uint32_t *fpTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  uint64_t* int64TestArr = (uint64_t*)malloc(sizeof(uint64_t) * testDataLength);
  double* fp64TestArr = (double*)malloc(sizeof(double) * testDataLength);
  for (int i = 0; i < testDataLength; i++) {
    intTestArr[i] = i;
    fpTestArr[i] = i * 1.2f;
    int64TestArr[i] = i * 2;
    fp64TestArr[i] = 2.0f + 0.01f * i;
  }

  fprintf(stderr, "Measuring INT32 adds\n");
  float int32adds = measureFunction(iterations, vec_int32_add_test, intTestArr);
  fprintf(stderr, "Measuring INT32 multiplies\n");
  float int32muls = measureFunction(iterations, vec_int32_mul_test, intTestArr);
  fprintf(stderr, "Measuring FP32 adds\n");
  float fp32adds = measureFunction(iterations, vec_fp32_add_test, fpTestArr);
  fprintf(stderr, "Measuring FP32 FMAs\n");
  float fp32fmas = measureFunction(iterations, vec_fp32_fma_test, fpTestArr);
  fprintf(stderr, "Measuring FP32 inverse square roots\n");
  float fp32rsqrts = measureFunction(iterations, vec_fp32_rsqrt_test, fpTestArr);

  fprintf(stderr, "Measuring INT64 Adds\n");
  float int64adds = measureFunction(iterations, vec_int64_add_test, int64TestArr);
  //fprintf(stderr, "Measuring INT64 Multiplies\n");
  //float int64muls = measureFunction(iterations, vec_int64_mul_test, int64TestArr);
  fprintf(stderr, "Measuring FP64 Adds\n");
  float fp64adds = measureFunction(iterations, vec_fp64_add_test, fp64TestArr);
  fprintf(stderr, "Measuring FP64 FMAs\n");
  float fp64fmas = measureFunction(iterations, vec_fp64_fma_test, fp64TestArr);

  printf("-----GOPS/s-----\n");
  printf("INT32 Add: %f\n", int32adds);
  printf("INT32 Multiply: %f\n", int32muls);
  printf("FP32 Add: %f\n", fp32adds);
  printf("FP32 FMA: %f\n", fp32fmas);
  printf("FP32 Inverse Square Roots: %f\n", fp32rsqrts);
  printf("INT64 Adds: %f\n", int64adds);
  //printf("INT64 Multiply: %f\n", int64muls);
  printf("FP64 Adds: %f\n", fp64adds);
  printf("FP64 FMAs: %f\n", fp64fmas);

  free(intTestArr);
  free(fpTestArr);
  return;
}
