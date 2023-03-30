// this is a partial C file that's appended into generated code

// Run a test, return the result in time (ns) per branch
// historyLen: length of random array that the test loops through
// branchCountIdx: index into array of branch counts, max determined by generated header/asm
// random: if 1, randomize test array contents. If 0, fill with zeroes
float runBranchHistTest(uint32_t historyLen, uint32_t branchCountIdx, int random) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    uint32_t branchCount = branchCounts[branchCountIdx];
    uint64_t iterations = 320000000 / branchCount;
    uint64_t(*branchtestFunc)(uint64_t, uint32_t**, uint32_t) __attribute((sysv_abi)) = branchtestFuncArr[branchCountIdx];
    float onesCount = 0.0f;

    uint32_t** testArrToArr = (uint32_t**)malloc(sizeof(uint32_t*) * branchCount);
    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) {
        uint32_t* testArr = (uint32_t*)malloc(sizeof(uint32_t) * historyLen);
        for (uint32_t i = 0; i < historyLen; i++) {
            testArr[i] = random ? rand() % 2 : 0;
            if (testArr[i] > 0)
            {
                onesCount += 1.0f;
            }
        }
        testArrToArr[testArrIdx] = testArr;
    }

    fprintf(stderr, "Starting test, should have %0.2f percent ones\n", onesCount / ((float)historyLen * branchCount));
    gettimeofday(&startTv, &startTz);
    uint64_t takenBranchCount = branchtestFunc(iterations, testArrToArr, historyLen);
    gettimeofday(&endTv, &endTz);
    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float latency = 1e6 * (float)time_diff_ms / (float)iterations;

    // give result in latency per branch
    latency = latency / branchCount;
    fprintf(stderr, "History length %u, branch count %u: %0.2f percent not-taken\n", historyLen, branchCount, 100 * (float)takenBranchCount / ((float)iterations * branchCount));

    for (int testArrIdx = 0; testArrIdx < branchCount; testArrIdx++) free(testArrToArr[testArrIdx]);
    free(testArrToArr);
    return latency;
}
