#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <stdint.h>
#include <stdlib.h> 
#include <string.h>
#include <unistd.h>
#include <errno.h>

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
extern uint64_t fma_zmm_tsctest(uint64_t iterations, float *arr) __attribute((ms_abi));
extern uint64_t fma_zmm_regonly_tsctest(uint64_t iterations, float *arr) __attribute((ms_abi));

int main(int argc, char *argv[]) {
    struct timeval startTv, endTv;
    uint64_t iterations = 500000, samples = 100;
    unsigned int sleepSeconds = 5, switchtests = 0;
    uint64_t switchpoint = 0;
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
            }
        }
    }

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

    sleep(sleepSeconds);

    uint64_t *measuredTscs = malloc(samples * sizeof(uint64_t));
    uint32_t *switchRecord = malloc(samples * sizeof(uint32_t));
    for (uint64_t sampleIdx = 0; sampleIdx < samples; sampleIdx++) {
        uint64_t elapsedTsc;
        uint32_t isSwitched;
        if (!switchtests || (sampleIdx < switchpoint)) {
            //fprintf(stderr, "sample %lu of %lu switch at %lu\n", sampleIdx, samples, switchpoint);
            elapsedTsc = clktsctest(iterations);
            isSwitched = 0;
        }
        else {
            //fprintf(stderr, "sample %lu of %lu after switch\n", sampleIdx, samples);
            // elapsedTsc = fma_zmm_tsctest(iterations, fpArr);
            elapsedTsc = fma_zmm_regonly_tsctest(iterations, fpArr);
            isSwitched = 1;
        }
	      measuredTscs[sampleIdx] = elapsedTsc;
        switchRecord[sampleIdx] = isSwitched;
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
        printf("Time (ms), Clk (GHz), TSC, Switched\n");
    } else {
        printf("Time (ms), Clk (GHz), TSC\n");
    }

    float elapsedTime = 0;
    for (uint64_t sampleIdx = 0; sampleIdx < samples; sampleIdx++) {
        // (tsc / ms) * tsc = 1 / ms
        float elapsedTimeMs = measuredTscs[sampleIdx] / tsc_per_ms;
        elapsedTime += elapsedTimeMs;
        float latency = 1e6 * elapsedTimeMs / (float)iterations;
        float addsPerNs = 1 / latency;
        if (switchtests) {
            printf("%f,%f,%lu,%u\n", elapsedTime, addsPerNs, measuredTscs[sampleIdx], switchRecord[sampleIdx]);
        } else {
            printf("%f,%f,%lu\n", elapsedTime, addsPerNs, measuredTscs[sampleIdx]);
        }
    }

    if (fpArr != NULL) free(fpArr);
    free(measuredTscs);
    free(switchRecord);
    return 0;
}
