// this is a partial C file that's appended into generated code
// stuff here is generic enough to work for both windows/vs and gcc

void printCsvHeader(uint32_t* xCounts, uint32_t xLen) {
    printf("x");
    for (uint32_t testSizeIdx = 0; testSizeIdx < xLen; testSizeIdx++) {
        printf(", %d", xCounts[testSizeIdx]);
    }

    printf("\n");
}

// print results in format that excel can take
void printResultFloatArr(float* arr, uint32_t *xCounts, uint32_t xLen, uint32_t *yCounts, uint32_t yLen) {
    uint32_t testSizeCount = xLen;
    printCsvHeader(xCounts, xLen);
    for (uint32_t branchCountIdx = 0; branchCountIdx < yLen; branchCountIdx++) {
        // row header
        printf("%d", yCounts[branchCountIdx]);
        for (uint32_t testSizeIdx = 0; testSizeIdx < testSizeCount; testSizeIdx++) {
            printf(",%f", arr[branchCountIdx * testSizeCount + testSizeIdx]);
        }

        printf("\n");
    }
}

