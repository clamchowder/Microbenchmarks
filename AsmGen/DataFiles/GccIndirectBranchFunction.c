// similar but for indirect branch test
// needs indirectBranchTestFuncArr generated
// mode:
// 0 - cycle through targets
// 1 - random target selection
// 2 - jump to middle
float runIndirectBranchTest(uint32_t branchCountIdx, uint32_t targetCountIdx, uint32_t mode) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t branchCount = indirectBranchCounts[branchCountIdx];
    uint32_t targetCount = indirectBranchTargetCounts[targetCountIdx];
    uint64_t iterations = 80000000 / branchCount;
    uint64_t(*branchtestFunc)(uint64_t, uint32_t**, uint32_t, uint64_t **) __attribute((sysv_abi)) = indirectBranchTestFuncArr[branchCountIdx][targetCountIdx];

    // generate an array containing jump target indexes for every branch
    uint32_t** testArrToArr = (uint32_t**)malloc(sizeof(uint32_t*) * branchCount);
    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) {
        uint32_t* testArr = (uint32_t*)malloc(sizeof(uint32_t) * targetCount);
        if (mode == 1)
            for (uint32_t i = 0; i < targetCount; i++) testArr[i] = rand() % targetCount;
        else if (mode == 0)
            for (uint32_t i = 0; i < targetCount; i++) testArr[i] = i;
        else if (mode == 2)
            for (uint32_t i = 0; i < targetCount; i++) testArr[i] = targetCount / 2;
        testArrToArr[testArrIdx] = testArr;
    }

    // each branch needs a jump table
    uint64_t** jumpTables = (uint64_t**)malloc(sizeof(uint64_t*) * branchCount);
    for (int jumpTableIdx = 0; jumpTableIdx < branchCount; jumpTableIdx++)
    {
        uint64_t* jumpTable = (uint64_t*)malloc(sizeof(uint64_t) * targetCount);
        jumpTables[jumpTableIdx] = jumpTable;
    }

    gettimeofday(&startTv, &startTz);
    // uint64_t iterations, uint32_t **arr, uint32_t arrLen, uint64_t **scratch
    branchtestFunc(iterations, testArrToArr, targetCount, jumpTables);
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float latency = 1e6 * (float)time_diff_ms / (float)iterations;

    // give result in latency per branch
    latency = latency / branchCount;

    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) free(testArrToArr[testArrIdx]);
    free(testArrToArr);
    for (int jumpTableIdx = 0; jumpTableIdx < branchCount; jumpTableIdx++) free(jumpTables[jumpTableIdx]);
    free(jumpTables);
    return latency;
}
