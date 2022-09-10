#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <stdint.h>
#include <stdlib.h> 
#include <string.h>

extern uint64_t clktsctest(uint64_t iterations) __attribute((ms_abi));

int main(int argc, char *argv[]) {
    struct timeval startTv, endTv;
    uint64_t iterations = 500000, samples = 100;
    time_t time_diff_ms;

    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char *arg = argv[argIdx] + 1;
	    if (strncmp(arg, "samples", 7) == 0) {
	        argIdx++;
		samples = atol(argv[argIdx]);
	    } else if (strncmp(arg, "iterations", 10) == 0) {
	        argIdx++;
		iterations = atol(argv[argIdx]);
	    }
	}
    }

    fflush(stdin);
    printf("Hit ENTER to start\n");
    getchar();

    uint64_t *measuredTscs = malloc(samples * sizeof(uint64_t));
    for (uint64_t sampleIdx = 0; sampleIdx < samples; sampleIdx++) {
        uint64_t elapsedTsc = clktsctest(iterations);
	measuredTscs[sampleIdx] = elapsedTsc;
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

    printf("Time (ms), Clk (GHz), TSC\n");
    float elapsedTime = 0;
    for (uint64_t sampleIdx = 0; sampleIdx < samples; sampleIdx++) {
	// (tsc / ms) * tsc = 1 / ms
	float elapsedTimeMs = measuredTscs[sampleIdx] / tsc_per_ms;
	elapsedTime += elapsedTimeMs;
	float latency = 1e6 * elapsedTimeMs / (float)iterations;
	float addsPerNs = 1 / latency;
	printf("%f,%f,%lu\n", elapsedTime, addsPerNs, measuredTscs[sampleIdx]);
    }

    return 0;
}
