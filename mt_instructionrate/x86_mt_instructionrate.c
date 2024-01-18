extern uint64_t sse_int32_add_test(uint64_t iterations, void *data) __attribute((ms_abi));

void RunTests() {
  uint64_t iterations = 5500000000;
  int testDataLength = 256; 
  uint32_t *intTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  uint32_t *fpTestArr = (uint32_t *)malloc(sizeof(uint32_t) * testDataLength);
  for (int i = 0; i < testDataLength; i++) {
    intTestArr[i] = i;
    fpTestArr[i] = i * 1.2f;
  }

  fprintf(stderr, "Measuring INT32 adds with SSE\n");
  float sseInt32Adds = measureFunction(iterations, sse_int32_add_test, intTestArr);

  printf("-----GOPS/s-----\n");
  printf("SSE INT32 Adds: %f\n", sseInt32Adds);
  
  free(intTestArr);
  free(fpTestArr);
  return;
}
