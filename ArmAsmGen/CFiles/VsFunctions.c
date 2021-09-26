// partial C file that gets appended into generated code

float runBranchHistTest(uint32_t historyLen, uint32_t branchCountIdx, int random) {
    struct timeb start, end;
    uint32_t branchCount = branchCounts[branchCountIdx];
    uint64_t iterations = 80000000 / branchCount;
    uint64_t(*branchtestFunc)(uint64_t, uint32_t**, uint32_t) = branchtestFuncArr[branchCountIdx];

    uint32_t** testArrToArr = (uint32_t**)malloc(sizeof(uint32_t*) * branchCount);
    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) {
        uint32_t* testArr = (uint32_t*)malloc(sizeof(uint32_t) * historyLen);
        for (uint32_t i = 0; i < historyLen; i++) testArr[i] = random ? rand() % 2 : 0;
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

// similar but for indirect branch test
// needs indirectBranchTestFuncArr generated
float runIndirectBranchTest(uint32_t branchCountIdx, uint32_t targetCountIdx, uint32_t random) {
    struct timeb start, end;
    uint32_t branchCount = indirectBranchCounts[branchCountIdx];
    uint32_t targetCount = indirectBranchTargetCounts[targetCountIdx];
    uint64_t iterations = 80000000 / branchCount;
    uint64_t(*branchtestFunc)(uint64_t, uint32_t**, uint32_t, uint64_t**) = indirectBranchTestFuncArr[branchCountIdx][targetCountIdx];

    // generate an array containing jump target indexes for every branch
    uint32_t** testArrToArr = (uint32_t**)malloc(sizeof(uint32_t*) * branchCount);
    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) {
        uint32_t* testArr = (uint32_t*)malloc(sizeof(uint32_t) * targetCount);
        if (random)
            for (uint32_t i = 0; i < targetCount; i++) testArr[i] = rand() % targetCount;
        else
            for (uint32_t i = 0; i < targetCount; i++) testArr[i] = i;
        testArrToArr[testArrIdx] = testArr;
    }

    // each branch needs a jump table
    uint64_t** jumpTables = (uint64_t**)malloc(sizeof(uint64_t*) * branchCount);
    for (int jumpTableIdx = 0; jumpTableIdx < branchCount; jumpTableIdx++)
    {
        uint64_t* jumpTable = (uint64_t*)malloc(sizeof(uint64_t) * targetCount);
        jumpTables[jumpTableIdx] = jumpTable;
    }

    ftime(&start);
    // uint64_t iterations, uint32_t **arr, uint32_t arrLen, uint64_t **scratch
    branchtestFunc(iterations, testArrToArr, targetCount, jumpTables);
    ftime(&end);
    uint64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
    float latency = 1e6 * (float)time_diff_ms / (float)iterations;

    // give result in latency per branch
    latency = latency / branchCount;

    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) free(testArrToArr[testArrIdx]);
    free(testArrToArr);
    for (int jumpTableIdx = 0; jumpTableIdx < branchCount; jumpTableIdx++) free(jumpTables[jumpTableIdx]);
    free(jumpTables);
    return latency;
}