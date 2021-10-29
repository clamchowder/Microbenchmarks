// partial C file that gets appended into generated code

float runBranchHistTest(uint32_t historyLen, uint32_t branchCountIdx, int random) {
    struct timeb start, end;
    uint32_t branchCount = branchCounts[branchCountIdx];
    uint64_t iterations = 80000000 / branchCount;
    uint64_t(*branchtestFunc)(uint64_t, uint32_t**, uint32_t) = branchtestFuncArr[branchCountIdx];

    uint32_t** testArrToArr = (uint32_t**)malloc(sizeof(uint32_t*) * branchCount);
    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) {
        uint32_t* testArr = (uint32_t*)malloc(sizeof(uint32_t) * historyLen);
        for (uint32_t i = 0; i < historyLen; i++) testArr[i] = random ? (rand() & 0x400U != 0) : 0;
        testArrToArr[testArrIdx] = testArr;
    }

    ftime(&start);
    branchtestFunc(iterations, testArrToArr, historyLen);
    ftime(&end);
    uint64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
    float latency = 1e6 * (float)time_diff_ms / (float)iterations;

    // give result in latency per branch
    latency = latency / branchCount;

    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) free(testArrToArr[testArrIdx]);
    free(testArrToArr);
    return latency;
}