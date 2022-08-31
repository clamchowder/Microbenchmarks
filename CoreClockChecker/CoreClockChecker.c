#define _GNU_SOURCE
#include <cpuid.h>
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
#include <math.h>

#define MSR_RAPL_PWR_UNIT 0xC0010299
#define HWCR 0xC0010015
#define MSR_CORE_ENERGY_STAT 0xC001029A
#define MSR_PKG_ENERGY_STAT 0xC001029B

#define INTEL_MSR_RAPL_PWR_UNIT 0x606
#define INTEL_MSR_PP0_ENERGY_STATUS 0x639
#define INTEL_MSR_PKG_ENERGY_STATUS 0x611

extern uint64_t clktest(uint64_t iterations) __attribute((sysv_abi));

void detectCpuMaker();
void setBoost(int on);
void setAffinity(int core);
int openMsr(int core);
uint64_t readMsr(int fd, uint32_t addr);
void writeMsr(int fd, uint32_t addr, uint64_t value);
float getEnergyStatusUnits();
uint64_t getCoreEnergyStat(int core);
uint64_t getPkgEnergyStat(int core);
uint64_t getTotalCoreEnergy();
int *msrFds;
int amdCpu = 1;
int numProcs = 0;

int main(int argc, char *argv[]) {
    struct timeval startTv, endTv;
    time_t time_diff_ms;
    float latency, clockSpeedGhz, energyUnits;
    uint64_t startEnergy, endEnergy, startPkgEnergy, endPkgEnergy;
    uint64_t iterationsHigh = 8e9;

    detectCpuMaker();
    numProcs = get_nprocs();
    fprintf(stderr, "Number of CPUs: %u\n", numProcs);
    msrFds = (int *)malloc(sizeof(int) * numProcs);
    memset(msrFds, 0, sizeof(int) * numProcs);

    if (argc > 1 && strncmp(argv[1], "disableboost", 12) == 0) {
        setBoost(0);
    } else if (argc > 1 && strncmp(argv[1], "enableboost", 11) == 0) {
        setBoost(1);
    } else if (argc > 1 && strncmp(argv[1], "power", 5) == 0) {
        iterationsHigh *= 2; // try for more accuracy
	energyUnits = getEnergyStatusUnits();
	printf("Core, Core Power, Package Power\n");
        for (int i = 0; i < numProcs; i++) {
            setAffinity(i);

            gettimeofday(&startTv, NULL);
            startEnergy = getCoreEnergyStat(i);
            startPkgEnergy = getPkgEnergyStat(i);
            clktest(iterationsHigh);
            endPkgEnergy = getPkgEnergyStat(i);
	    endEnergy = getCoreEnergyStat(i);
            gettimeofday(&endTv, NULL);

            time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
            latency = 1e6 * (float)time_diff_ms / (float)iterationsHigh;
            clockSpeedGhz = 1 / latency;
            //printf("runtime: %llu ms\n", time_diff_ms);
            //printf("%d, %f GHz\n", i, clockSpeedGhz);
	    printf("%d, %f, %f\n", i,
	        ((endEnergy - startEnergy) * energyUnits) / (time_diff_ms / 1000),
	        ((endPkgEnergy - startPkgEnergy) * energyUnits) / (time_diff_ms / 1000));
        }
    } else if (argc > 2 && strncmp(argv[1], "measurecmd", 9) == 0) {
        int rc;
	float coreJoules, pkgJoules;
        fprintf(stderr, "argv[2] is %s\nOnly handling Intel at the moment\n", argv[2]);
	energyUnits = getEnergyStatusUnits();

	gettimeofday(&startTv, NULL);
	startEnergy = getTotalCoreEnergy();
	startPkgEnergy = getPkgEnergyStat(0);
	rc = system(argv[2]);
	endEnergy = getTotalCoreEnergy();
	endPkgEnergy = getPkgEnergyStat(0);
	gettimeofday(&endTv, NULL);
	fprintf(stderr, "system() returned %d\n", rc);

        time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
	coreJoules = (endEnergy - startEnergy) * energyUnits;
	pkgJoules = (endPkgEnergy - startPkgEnergy) * energyUnits;
	printf("Core Joules: %f\n", coreJoules);
	printf("Package Joules: %f\n", pkgJoules);
	printf("Elapsed time, seconds: %f\n", (double)time_diff_ms / 1000);
    }
    else {
        for (int i = 0; i < numProcs; i++) {
            setAffinity(i);

            gettimeofday(&startTv, NULL);
            clktest(iterationsHigh);
            gettimeofday(&endTv, NULL);
            time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
            latency = 1e6 * (float)time_diff_ms / (float)iterationsHigh;
            clockSpeedGhz = 1 / latency;
            //printf("runtime: %llu ms\n", time_diff_ms);
            printf("%d, %f GHz\n", i, clockSpeedGhz);
        }
    }

    free(msrFds);
    return 0;
}

void detectCpuMaker() {
    uint32_t cpuidEax, cpuidEbx, cpuidEcx, cpuidEdx;
    uint32_t *uintPtr;
    char cpuName[13];
    amdCpu = 0;
    __cpuid_count(0, 0, cpuidEax, cpuidEbx, cpuidEcx, cpuidEdx);
    uintPtr = (uint32_t *)cpuName;
    uintPtr[0] = cpuidEbx;
    uintPtr[1] = cpuidEdx;
    uintPtr[2] = cpuidEcx;
    cpuName[12] = 0;
    fprintf(stderr, "CPU name: %s\n", cpuName);
    if (memcmp(cpuName, "GenuineIntel", 12) == 0) {
        amdCpu = 0;
	fprintf(stderr, "Looks like Intel\n");
    } else if (memcmp(cpuName, "AuthenticAMD", 12) == 0) {
        amdCpu = 1;
	fprintf(stderr, "Looks like AMD\n");
    }
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

void setBoost(int on) {
    uint64_t hwcrValue;
    for (int i = 0; i < numProcs; i++) {
        setAffinity(i);
	if (!msrFds[i]) msrFds[i] = openMsr(i);
	hwcrValue = readMsr(msrFds[i], HWCR);
        if (on) {
	    hwcrValue &= ~(1UL << 25);  // unset bit to request CPB on
	    //fprintf(stderr, "Requesting CPB on (unsetting bit 25 in HWCR): 0x%08x\n", hwcrValue);
	} else {
	    hwcrValue |= (1UL << 25);      // set bit to disable CPB
	    //fprintf(stderr, "Requesting CPB off (setting bit 25 in HWCR): 0x%08x\n", hwcrValue);
	}

	writeMsr(msrFds[i], HWCR, hwcrValue);
    }
}

float getEnergyStatusUnits() {
    uint64_t energyUnits, raplPwrUnit;
    setAffinity(0);
    if (!msrFds[0]) msrFds[0] = openMsr(0);

    if (amdCpu) {
        raplPwrUnit = readMsr(msrFds[0], MSR_RAPL_PWR_UNIT);
    }
    else
    {
        raplPwrUnit = readMsr(msrFds[0], INTEL_MSR_RAPL_PWR_UNIT);
    }

    energyUnits = (raplPwrUnit >> 8) & 0x1F;
    return (float)pow(0.5, (double)energyUnits);
}

uint64_t getCoreEnergyStat(int core) {
    if (!msrFds[core]) msrFds[core] = openMsr(core);

    if (amdCpu)
        return readMsr(msrFds[core], MSR_CORE_ENERGY_STAT);
    else
        return readMsr(msrFds[core], INTEL_MSR_PP0_ENERGY_STATUS);
}

uint64_t getPkgEnergyStat(int core) {
    if (!msrFds[core]) msrFds[core] = openMsr(core);
    if (amdCpu)
        return readMsr(msrFds[core], MSR_PKG_ENERGY_STAT);
    else
        return readMsr(msrFds[core], INTEL_MSR_PKG_ENERGY_STATUS);
}

uint64_t getTotalCoreEnergy() {
    if (amdCpu) {
        uint64_t totalCoreEnergy = 0;

	// only testing the 5950X and 3950X for now, and physical cores
	// are 0-15 on linux. hack around this until I have time to
	// programatically figure out SMT siblings
        for (int i = 0; i < 16; i++) {
            totalCoreEnergy += getCoreEnergyStat(i);
        }

	return totalCoreEnergy;
    } else {
        // intel does not track power per core
        return getCoreEnergyStat(0);
    }
}
