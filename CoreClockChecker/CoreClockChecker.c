#define _GNU_SOURCE
#include <stdio.h>
#include <time.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h> 
#include <pthread.h>
#include <sys/sysinfo.h>
#include <sys/time.h>
#include <unistd.h>
#include <fcntl.h>

#define ITERATIONS 

extern uint64_t clktest(uint64_t iteratoins) __attribute((sysv_abi));

void setBoost(int on); 
void setAffinity(int core);
int openMsr(int core);
uint64_t readMsr(int fd, uint32_t addr);
void writeMsr(int fd, uint32_t addr, uint64_t value); 
int *msrFds;

int main(int argc, char *argv[]) {
    struct timeval startTv, endTv;
    time_t time_diff_ms;
    float latency, clockSpeedGhz;
    uint64_t iterationsHigh = 8e9;
    int numProcs;
  
    numProcs = get_nprocs();
    fprintf(stderr, "Number of CPUs: %u\n", numProcs);
    msrFds = (int *)malloc(sizeof(int) * numProcs);
    memset(msrFds, 0, sizeof(int) * numProcs);
    
    if (argc > 1 && strncmp(argv[1], "disableboost", 12) == 0) {
        setBoost(0);
    } else if (argc > 1 && strncmp(argv[1], "enableboost", 11) == 0) {
        setBoost(1);
    }
    else {
        for (int i = 0; i < numProcs; i++) {
            setAffinity(i);

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
    }
  
    free(msrFds);
    return 0;
}

void setAffinity(int core) {
   int rc;
   cpu_set_t cpuset;
   pthread_t thread = pthread_self();
   CPU_ZERO(&cpuset);
   CPU_SET(core, &cpuset);
   rc = pthread_setaffinity_np(thread, sizeof(cpuset), &cpuset);
   if (rc != 0) {
       fprintf(stderr, "unable to set thread affinity to %d\n", core);
   } 
}

int openMsr(int core) {
    char msrFilename[255];
    int fd;
    sprintf(msrFilename, "/dev/cpu/%d/msr", core);
    fd = open(msrFilename, O_RDWR);
    if (fd < 0) {
        fprintf(stderr, "Could not open MSR file, core %d\n", core);
        return -1;
    }
    return fd;
}

uint64_t readMsr(int fd, uint32_t addr) {
    uint64_t result, bytesRead;
    bytesRead = pread(fd, &result, sizeof(result), addr);
    if (bytesRead != sizeof(result)) {
        fprintf(stderr, "Could not read from fd %d, msr %u\n", fd, addr);
    }
    return result;
}

void writeMsr(int fd, uint32_t addr, uint64_t value) {
    uint64_t bytesWritten, newValue;
    bytesWritten = pwrite(fd, &value, sizeof(value), addr);
    if (bytesWritten != sizeof(value)) {
        fprintf(stderr, "Could not write to fd %d, msr %u, value %lu\n", fd, addr, value);
    }

    newValue = readMsr(fd, addr);
    if (value != newValue) {
        fprintf(stderr, "Wrote to fd %d, msr %u, value %lu, but write did not take effect\n", fd, addr, value);
    }
}

#define HWCR 0xC0010015
void setBoost(int on) {
    uint64_t hwcrValue;
    int numProcs = get_nprocs();
    for (int i = 0; i < numProcs; i++) {
        setAffinity(i);
	if (!msrFds[i]) msrFds[i] = openMsr(i);
	hwcrValue = readMsr(msrFds[i], HWCR);
        if (on) hwcrValue &= ~(1UL << 25);  // unset bit to request CPB on
	else hwcrValue |= (1UL << 25);      // set bit to disable CPB
	writeMsr(msrFds[i], HWCR, hwcrValue);
    }
}

