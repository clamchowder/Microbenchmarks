#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <stdint.h>
#include <stdlib.h> 
#include <string.h>
#include <unistd.h>
#include <errno.h>

#include <sys/syscall.h>
#include <sys/ioctl.h>
#include <linux/perf_event.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "../Common/perfmon.h"

#ifdef __MINGW32__
int posix_memalign(void **memptr, size_t alignment, size_t size)
{
    *memptr = _aligned_malloc(alignment, size);
    fprintf(stderr, "aligned malloc returned addr %lu for alignment %lu size %lu\n", *memptr, alignment, size);
    if (*memptr != NULL) {
        return 0;
    }

    return errno;
}
#endif 

#define DUMMY_ARR_SIZE 4096

extern uint64_t clktsctest(uint64_t iterations) __attribute((ms_abi));
extern uint64_t fma_tsctest(uint64_t iterations, float *arr) __attribute((ms_abi));
extern uint64_t fma_zmm_st_tsctest(uint64_t iterations, float *arr) __attribute((ms_abi));
extern uint64_t fma_zmm_add_tsctest(uint64_t iterations, float *arr) __attribute((ms_abi));
extern uint64_t fma_regonly_tsctest(uint64_t iterations, float *arr) __attribute((ms_abi));

int main(int argc, char *argv[]) {
    struct timeval startTv, endTv;
    uint64_t iterations = 500000, samples = 100;
    unsigned int sleepSeconds = 5, switchtests = 0;
    uint64_t switchpoint = 0, switchinterval = 0;
    time_t time_diff_ms;
    float *fpArr = NULL;

    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char *arg = argv[argIdx] + 1;
            if (strncmp(arg, "samples", 7) == 0) {
                argIdx++;
            samples = atol(argv[argIdx]);
            } else if (strncmp(arg, "iterations", 10) == 0) {
                argIdx++;
                iterations = atol(argv[argIdx]);
            } else if (strncmp(arg, "sleep", 5) == 0) {
                argIdx++;
                sleepSeconds = atoi(argv[argIdx]);
            } else if (strncmp(arg, "switchpoint", 11) == 0) {
                argIdx++;
                switchtests = 1;
                switchpoint = atol(argv[argIdx]);
                fprintf(stderr, "Switching at %lu\n", switchpoint);
            } else if (strncmp(arg, "interval", 8) == 0) {
                argIdx++;
                switchinterval = atol(argv[argIdx]);
                fprintf(stderr, "switch interval = %lu\n", switchinterval);
            }
        }
    }

    fprintf(stderr, "Alloc tscs\n");
    uint64_t *measuredTscs = (uint64_t *)malloc(samples * sizeof(uint64_t));
    fprintf(stderr, "Alloc switch\n");
    uint32_t *switchRecord = (uint32_t *)malloc(samples * sizeof(uint32_t)); 

    uint64_t *cycleCounts = (uint64_t *)malloc(samples * sizeof(uint64_t));
    uint64_t *instrCounts = (uint64_t *)malloc(samples * sizeof(uint64_t));
    uint64_t *nsqStallCounts = (uint64_t *)malloc(samples * sizeof(uint64_t));
    uint64_t *ldqStallCounts = (uint64_t *)malloc(samples * sizeof(uint64_t));

    if (switchtests)
    {
        int rc = posix_memalign((void **)(&fpArr), 64, sizeof(float) * DUMMY_ARR_SIZE);
        if (rc != 0) {
            fprintf(stderr, "Could not allocate memory\n");
            return 0;
        }

        if (fpArr == NULL) {
            fprintf(stderr, "Could not allocate aligned mem\n");
            return 0;
        }
        //fpArr = (float *)malloc(sizeof(float) * DUMMY_ARR_SIZE);
        fprintf(stderr, "Allocated aligned memory\n");
        for (int i = 0; i < DUMMY_ARR_SIZE; i++) fpArr[i] = 1.1f * i;
        fprintf(stderr, "Filled dummy array\n");
    }

    open_perf_monitoring();

    sleep(sleepSeconds);
    for (uint64_t sampleIdx = 0; sampleIdx < samples; sampleIdx++) {
        uint64_t elapsedTsc, sampleinstr, samplecycles, sampleFpNsqStall, sampleLdqStall;
        uint32_t isSwitched;

        // 0 = default (dependent adds)
        // 1 = avx-512 test function
        uint32_t functionSelection = 0;
        if (switchtests) {
            if (sampleIdx > switchpoint) {
                functionSelection = 1;
            }

            //fprintf(stderr, "sample %lu of %lu switch at %lu interval %lu\n", sampleIdx, samples, switchpoint, switchinterval);
            if (switchinterval > 0 && (((sampleIdx - switchpoint) / switchinterval) & 1)) {
                functionSelection = 0;
            }
        }

        start_perf_monitoring();
        if (!functionSelection) {
            //fprintf(stderr, "sample %lu of %lu switch at %lu\n", sampleIdx, samples, switchpoint);
            elapsedTsc = clktsctest(iterations);
            isSwitched = 0;
        }
        else {
            //fprintf(stderr, "sample %lu of %lu after switch\n", sampleIdx, samples);
            //elapsedTsc = fma_zmm_tsctest(iterations, fpArr);
            elapsedTsc = fma_regonly_tsctest(iterations, fpArr);
            //elapsedTsc = fma_tsctest(iterations, fpArr);
            isSwitched = 1;
        }
        stop_perf_monitoring();
        get_basic_perf_data(&sampleinstr, &samplecycles, &sampleFpNsqStall, &sampleLdqStall);
        measuredTscs[sampleIdx] = elapsedTsc;
        switchRecord[sampleIdx] = isSwitched;
        cycleCounts[sampleIdx] = samplecycles;
        instrCounts[sampleIdx] = sampleinstr;
        nsqStallCounts[sampleIdx] = sampleFpNsqStall;
        ldqStallCounts[sampleIdx] = sampleLdqStall;
    }

    fprintf(stderr, "Used %lu samples\n", samples);
    fprintf(stderr, "Used %lu iterations\n", iterations);
    // figure out TSC to real time ratio
    fprintf(stderr, "Checking TSC ratio...\n");
    uint64_t iterationsHi = 8e9; // should be a couple seconds at least?
    gettimeofday(&startTv, NULL);
    uint64_t referenceElapsedTsc = clktsctest(iterationsHi);
    gettimeofday(&endTv, NULL);
    time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    float tsc_per_ms = (float)referenceElapsedTsc / (float)time_diff_ms;
    float tsc_per_ns = tsc_per_ms / 1e6;
    fprintf(stderr, "TSC = %lu, elapsed ms = %lu\n", referenceElapsedTsc, time_diff_ms);
    fprintf(stderr, "TSC per ms: %f, TSC per ns: %f\n", tsc_per_ms, tsc_per_ns);

    if (switchtests) {
        printf("Time (ms), Clk (GHz), TSC, Switched");
    } else {
        printf("Time (ms), Clk (GHz), TSC");
    }

    printf(",instr,cycles,fpnsq_stall,ldq_stall\n");

    float elapsedTime = 0;
    for (uint64_t sampleIdx = 0; sampleIdx < samples; sampleIdx++) {
        // (tsc / ms) * tsc = 1 / ms
        float elapsedTimeMs = measuredTscs[sampleIdx] / tsc_per_ms;
        elapsedTime += elapsedTimeMs;
        float latency = 1e6 * elapsedTimeMs / (float)iterations;
        float addsPerNs = 1 / latency;
        if (switchtests) {
            printf("%f,%f,%lu,%u", elapsedTime, addsPerNs, measuredTscs[sampleIdx], switchRecord[sampleIdx]);
        } else {
            printf("%f,%f,%lu", elapsedTime, addsPerNs, measuredTscs[sampleIdx]);
        }

        printf(",%lu,%lu,%lu,%lu\n", 
          instrCounts[sampleIdx], cycleCounts[sampleIdx], nsqStallCounts[sampleIdx], ldqStallCounts[sampleIdx]);
    }

    if (fpArr != NULL) {
#ifdef __MINGW32__
      _aligned_free(fpArr);
#else
      free(fpArr);
#endif
    }
    free(measuredTscs);
    free(switchRecord);
    return 0;
}
