#define _GNU_SOURCE
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h> 
#include <pthread.h>

#define ITERATIONS 

extern uint64_t clktest(uint64_t iteratoins) __attribute((sysv_abi));

int main(int argc, char *argv[]) {
    struct timeval startTv, endTv;
    time_t time_diff_ms;
    float latency, clockSpeedGhz;
    uint64_t iterationsHigh = 2e9;
    int numProcs;
    cpu_set_t cpuset;
    pthread_t thread = pthread_self();
  
    numProcs = get_nprocs();
    fprintf(stderr, "Number of CPUs: %u\n", numProcs);
    
    for (int i = 0; i < numProcs; i++) {
        CPU_ZERO(&cpuset);
        CPU_SET(i, &cpuset);

        gettimeofday(&startTv, NULL);  
        clktest(iterationsHigh);
        gettimeofday(&endTv, NULL);  
        time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
        //time_diff_ms = 1e6 * (endTv.tv_sec - startTv.tv_sec) + (endTv.tv_usec - startTv.tv_usec);
        latency = 1e6 * (float)time_diff_ms / (float)iterationsHigh; 
        clockSpeedGhz = 1 / latency;
        //printf("runtime: %llu ms\n", time_diff_ms);
        printf("%d, %f GHz\n", i, clockSpeedGhz);
    }
  
    return 0;
}
