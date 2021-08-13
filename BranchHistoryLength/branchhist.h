uint32_t maxBranchCount = 10;
uint32_t branchCounts[10] = { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 };
uint64_t (*branchtestFuncArr[10])(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist1(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist2(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist4(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist8(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist16(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist32(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist64(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist128(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist256(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
extern uint64_t branchhist512(uint64_t iterations, uint32_t **arr, uint32_t arrLen);
void initializeFuncArr() {
  branchtestFuncArr[0] = branchhist1;
  branchtestFuncArr[1] = branchhist2;
  branchtestFuncArr[2] = branchhist4;
  branchtestFuncArr[3] = branchhist8;
  branchtestFuncArr[4] = branchhist16;
  branchtestFuncArr[5] = branchhist32;
  branchtestFuncArr[6] = branchhist64;
  branchtestFuncArr[7] = branchhist128;
  branchtestFuncArr[8] = branchhist256;
  branchtestFuncArr[9] = branchhist512;
}
