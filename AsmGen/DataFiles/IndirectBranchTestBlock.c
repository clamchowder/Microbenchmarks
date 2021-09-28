// generated code will have:
// - indirectBranchTargetCounts = array containing # of targets per branch
// - indirectBranchCounts = array containing # of branches to test
// - maxIndirectBranchCount = length of ^^
// - initializeIndirectBranchFuncArr = populates

uint32_t testSizeCount = sizeof(indirectBranchTargetCounts) / sizeof(int);
initializeIndirectBranchFuncArr();
srand(time(NULL));

size_t resultSize = sizeof(float) * maxIndirectBranchCount * testSizeCount;
float* results = (float*)malloc(resultSize);
for (uint32_t branchCountIdx = 0; branchCountIdx < maxIndirectBranchCount; branchCountIdx++) {
    for (uint32_t targetCountIdx = 0; targetCountIdx < testSizeCount; targetCountIdx++) {
        uint32_t testSize = indirectBranchTargetCounts[targetCountIdx];
        uint32_t branchCount = indirectBranchCounts[branchCountIdx];
        printf("Testing branch count %d target count %d\n", branchCount, testSize);
        results[branchCountIdx * testSizeCount + targetCountIdx] = runIndirectBranchTest(branchCountIdx, targetCountIdx, 0);
        printf("%d, %f\n", testSize, results[branchCountIdx * testSizeCount + targetCountIdx]);
    }
}

printf("Indirect branch results:\n");
printResultFloatArr(results, indirectBranchTargetCounts, testSizeCount, indirectBranchCounts, maxIndirectBranchCount);

free(results);