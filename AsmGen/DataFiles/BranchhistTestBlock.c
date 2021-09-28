uint32_t testSizeCount = sizeof(branchHistoryLengths) / sizeof(int);
initializeBranchHistFuncArr();
srand(time(NULL));

size_t resultSize = sizeof(float) * maxBranchCount * testSizeCount;
float* randomResults = (float*)malloc(resultSize);
float* predictableResults = (float*)malloc(resultSize);
for (uint32_t branchCountIdx = 0; branchCountIdx < maxBranchCount; branchCountIdx++) {
    for (uint32_t testSizeIdx = 0; testSizeIdx < testSizeCount; testSizeIdx++) {
        uint32_t testSize = branchHistoryLengths[testSizeIdx];
        uint32_t branchCount = branchCounts[branchCountIdx];
        printf("Testing branch count %d history length %d\n", branchCount, testSize);
        randomResults[branchCountIdx * testSizeCount + testSizeIdx] = runBranchHistTest(testSize, branchCountIdx, 1);
        predictableResults[branchCountIdx * testSizeCount + testSizeIdx] = runBranchHistTest(testSize, branchCountIdx, 0);
        printf("%d, %f, %f\n", testSize,
            randomResults[branchCountIdx * testSizeCount + testSizeIdx],
            predictableResults[branchCountIdx * testSizeCount + testSizeIdx]);
    }
}

printf("Random:\n");
printResultFloatArr(randomResults, branchHistoryLengths, testSizeCount, branchCounts, maxBranchCount);
printf("\nPredictable:\n");
printResultFloatArr(predictableResults, branchHistoryLengths, testSizeCount, branchCounts, maxBranchCount);

free(randomResults);
free(predictableResults);