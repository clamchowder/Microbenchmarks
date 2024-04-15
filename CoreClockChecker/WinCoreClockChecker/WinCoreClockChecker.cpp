// WinCoreClockChecker.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys\timeb.h>
#include <windows.h>

extern "C" uint64_t clktest(uint64_t iterations, uint64_t *flag);

int ECoreTestOrder[] = { 2, 3, 4, 5, 6, 7, 8, 9 };
int BackwardECoreTestOrder[] = { 9, 8, 7, 6, 5, 4, 3, 2 };
int AlternatingECoreTestOrder[] = { 2, 6, 3, 7, 4, 8, 5, 9 };
int PCoreTestOrder[] = { 12, 10, 14, 16, 18, 0 };
int AllECores[] = { 20, 21, 2, 3, 4, 5, 6, 7, 8, 9 };
int AllCores[] = { 12, 10, 14, 16, 18, 0, 2, 3, 4, 5, 6, 7, 8, 9, 20, 21 };

struct ClockTestData {
    uint64_t iterations;
    uint64_t completed_iterations;
    uint64_t *flag;
};

float* runMtClockTest(int* cores, int nCores);
void PrintResults(int* cores, float* results, int coreCount);
void RunCoreByCoreClockTest(int* cores, int coreCount);

uint64_t start_iterations = 8e9;

int main(int argc, char *argv[])
{
    // Test E-Cores one by one
    start_iterations = 8e9;
    int eCoreCount = sizeof(ECoreTestOrder) / sizeof(int);
    printf("E-Cores, Warmup:\n");
    RunCoreByCoreClockTest(ECoreTestOrder, sizeof(ECoreTestOrder) / sizeof(int));
    printf("E-Cores, filling one cluster first:\n");
    RunCoreByCoreClockTest(ECoreTestOrder, sizeof(ECoreTestOrder) / sizeof(int));
    printf("E-Cores, filling other cluster first but still one cluster at a time:\n");
    RunCoreByCoreClockTest(BackwardECoreTestOrder, sizeof(BackwardECoreTestOrder) / sizeof(int));
    printf("E-Cores, alternating cores between clusters:\n");
    RunCoreByCoreClockTest(AlternatingECoreTestOrder, sizeof(AlternatingECoreTestOrder) / sizeof(int));
    printf("E-Cores, LPE first:\n");
    RunCoreByCoreClockTest(AllECores, sizeof(AllECores) / sizeof(int));

    start_iterations = 12e9;
    printf("P-Cores, warmup:\n");
    RunCoreByCoreClockTest(PCoreTestOrder, sizeof(PCoreTestOrder) / sizeof(int));
    printf("P-Cores, fastest core first:\n");
    RunCoreByCoreClockTest(PCoreTestOrder, sizeof(PCoreTestOrder) / sizeof(int));
    printf("All cores, fastest core first:\n");
    RunCoreByCoreClockTest(AllCores, sizeof(AllCores) / sizeof(int));

    return 0;
}

void RunCoreByCoreClockTest(int *cores, int coreCount)
{
    float* coreByCoreResults = (float*)malloc(sizeof(float) * coreCount * coreCount);
    memset(coreByCoreResults, 0, sizeof(float) * coreCount * coreCount);
    for (int i = 0; i < coreCount; i++)
    {
        float* results = runMtClockTest(cores, i + 1);
        for (int j = 0; j < (i + 1); j++)
        {
            coreByCoreResults[coreCount * i + j] = results[j];
        }

        free(results);
    }

    PrintResults(cores, coreByCoreResults, coreCount);
    free(coreByCoreResults);
}

void PrintResults(int *cores, float* results, int coreCount)
{
    // print csv header
    for (int i = 0; i < coreCount; i++)
    {
        printf(",%d", cores[i]);
    }

    printf("\n");
    for (int currentCoreCountIndex = 0; currentCoreCountIndex < coreCount; currentCoreCountIndex++)
    {
        printf("%d", currentCoreCountIndex + 1);
        for (int currentCoreIdx = 0; currentCoreIdx < coreCount; currentCoreIdx++)
        {
            float currentResult = results[coreCount * currentCoreCountIndex + currentCoreIdx];
            if (currentResult != 0.0f) printf(",%f", currentResult);
            else printf(",-");
        }

        printf("\n");
    }
}

DWORD WINAPI ClockTestThread(LPVOID param)
{
    struct ClockTestData* testData = (struct ClockTestData*)param;
    testData->completed_iterations = clktest(testData->iterations, testData->flag);
    return 0;
}

// cores = array of test order -> logical core id
float* runMtClockTest(int* cores, int nCores)
{
    struct timeb start, end;
    struct ClockTestData* threadData = (struct ClockTestData*)malloc(sizeof(struct ClockTestData) * nCores);
    float* results = (float*)malloc(sizeof(float) * nCores);
    memset(results, 0, sizeof(float) * nCores);
    HANDLE* testThreads = (HANDLE*)malloc(sizeof(HANDLE) * nCores);

    // try to align test times
    float maxThreadTsc, minThreadTsc;
    float time_diff_sec;
    uint64_t flag = 0;

    for (int i = 0; i < nCores; i++)
    {
        threadData[i].iterations = start_iterations;
        threadData[i].flag = &flag;
        testThreads[i] = CreateThread(NULL, 0, ClockTestThread, threadData + i, CREATE_SUSPENDED, NULL);
        SetThreadAffinityMask(testThreads[i], 1ULL << (uint64_t)cores[i]);
    }

    ftime(&start);
    for (int i = 0; i < nCores; i++)
    {
        ResumeThread(testThreads[i]);
    }

    WaitForMultipleObjects(nCores, testThreads, TRUE, INFINITE);
    ftime(&end);
    time_diff_sec = (float)(end.time - start.time) + 0.001f * (end.millitm - start.millitm);
    for (int i = 0; i < nCores; i++)
    {
        // fprintf(stderr, "Core %d: %llu iterations in %f sec\n", cores[i], threadData[i].completed_iterations, time_diff_sec);
        float ghz = ((float)threadData[i].completed_iterations / 1e9) / time_diff_sec;
        // fprintf(stderr, "Core %d: %f GHz\n", cores[i], ghz);
        results[i] = ghz;
    }

    free(testThreads);
    free(threadData);
    return results;
}