#include <stdio.h>
#include <stdint.h>
#include <sys\timeb.h>
#include <intrin.h>
#include <windows.h>

#define ITERATIONS 10000000;

float RunTest(unsigned int processor1, unsigned int processor2, uint64_t iter);
DWORD WINAPI LatencyTestThread(LPVOID param);

typedef struct LatencyThreadData {
    uint64_t start;       // initial value to write into target
    uint64_t iterations;  // number of iterations to run
    LONG64 *target;       // value to bounce between threads, init with start - 1
    DWORD affinityMask;   // thread affinity mask to set
} LatencyData;

int main(int argc, char *argv[]) {
    SYSTEM_INFO sysInfo;
    DWORD numProcs;
    float* latencies;
    uint64_t iter = ITERATIONS;

    GetSystemInfo(&sysInfo);
    numProcs = sysInfo.dwNumberOfProcessors;
    fprintf(stderr, "Number of CPUs: %u\n", numProcs);
    latencies = (float *)malloc(sizeof(float) * numProcs * numProcs);
    if (latencies == NULL) {
        fprintf(stderr, "couldn't allocate result array\n");
        return 0;
    }

    if (argc > 1) {
        iter = atol(argv[1]);
        fprintf(stderr, "%lu iterations requested\n", iter);
    }
    else {
        fprintf(stderr, "Usage: coherencylatency.exe [iterations]\n");
    }

    // Run all to all, skipping testing a core against itself ofc
    // technically can skip the other way around (start j = i + 1) but meh
    for (DWORD i = 0; i < numProcs; i++) {
        for (DWORD j = 0; j < numProcs; j++) {
            latencies[j + i * numProcs] = i == j ? 0 : RunTest(i, j, iter);
        }
    }

    // print thing to copy to excel
    for (DWORD i = 0; i < numProcs; i++) {
        for (DWORD j = 0; j < numProcs; j++) {
            if (j != 0) printf(",");
            if (j == i) printf("x");
            // other latency test (run by AT) likely divides by 2
            // I personally disagree with this because writing to a line modified by another core
            // involves an unavoidable round trip (request line from other core and receive the response)
            else printf("%f", latencies[j + i * numProcs] / 2);
        }
        printf("\n");
    }
    
    free(latencies);
    return 0;
}

/// <summary>
/// Measures latency from one processor core to another
/// </summary>
/// <param name="processor1">processor number 1</param>
/// <param name="processor2">processor number 2</param>
/// <param name="iter">Number of iterations</param>
/// <returns>latency per iteration in ns</returns>
float RunTest(unsigned int processor1, unsigned int processor2, uint64_t iter)
{
    LONG64* bouncy;
    struct timeb start, end;
    HANDLE testThreads[2];
    DWORD tid1, tid2;
    LatencyData lat1, lat2;

    bouncy = (LONG64*)_aligned_malloc(sizeof(LONG64), sizeof(LONG64));
    if (bouncy == NULL) {
        fprintf(stderr, "Could not allocate aligned mem\n");
    }

    *bouncy = 0;
    lat1.iterations = iter;
    lat1.start = 1;
    lat1.target = bouncy;
    lat2.iterations = iter;
    lat2.start = 2;
    lat2.target = bouncy;

    testThreads[0] = CreateThread(NULL, 0, LatencyTestThread, &lat1, CREATE_SUSPENDED, &tid1);
    testThreads[1] = CreateThread(NULL, 0, LatencyTestThread, &lat2, CREATE_SUSPENDED, &tid2);

    if (testThreads[0] == NULL || testThreads[1] == NULL) {
        fprintf(stderr, "Failed to create test threads\n");
        return -1;
    }

    SetThreadAffinityMask(testThreads[0], 1ULL << (uint64_t)processor1);
    SetThreadAffinityMask(testThreads[1], 1ULL << (uint64_t)processor2);

    ftime(&start);
    ResumeThread(testThreads[0]);
    ResumeThread(testThreads[1]);
    WaitForMultipleObjects(2, testThreads, TRUE, INFINITE);
    ftime(&end);

    int64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
    float latency = 1e6 * (float)time_diff_ms / (float)iter;

    fprintf(stderr, "%d to %d: %f ns\n", processor1, processor2, latency);

    CloseHandle(testThreads[0]);
    CloseHandle(testThreads[1]);
    _aligned_free(bouncy);

    return latency;
}

/// <summary>
/// Runs one thread of the latency test. should be run in pairs
/// </summary>
/// <param name="param">Latency test params</param>
/// <returns>next value that would have been written to shared memory</returns>
DWORD WINAPI LatencyTestThread(LPVOID param) {
    LatencyData *latencyData = (LatencyData *)param;
    uint64_t current = latencyData->start;
    while (current <= 2 * latencyData->iterations) {
        if (_InterlockedCompareExchange64(latencyData->target, current, current - 1) == current - 1) current += 2;
    }

    return current;
}