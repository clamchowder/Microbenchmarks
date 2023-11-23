// this is a partial C file that's appended into generated code
// stuff here is generic enough to work for both windows/vs and gcc

#ifndef __MINGW32__
// optional affinity setting for effed up qualcomm/android bs
#include <sched.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/syscall.h>

void setAffinity(int core) {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(core, &cpuset);
    printf("Set affinity to core %d\n", core);
    // sched_setaffinity(gettid(), sizeof(cpu_set_t), &cpuset);
}
#endif

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

void FillPatternArr(uint32_t* pattern_arr, uint32_t list_size, uint32_t byte_increment) {
    uint32_t increment = byte_increment / sizeof(uint32_t);
    uint32_t element_count = list_size / increment;
    for (int i = 0; i < element_count; i++) {
        pattern_arr[i * increment] = i * increment;
    }

    int iter = element_count;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint32_t tmp = pattern_arr[iter * increment];
        pattern_arr[iter * increment] = pattern_arr[j * increment];
        pattern_arr[j * increment] = tmp;
    }
}