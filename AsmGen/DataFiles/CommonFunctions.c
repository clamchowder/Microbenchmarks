// this is a partial C file that's appended into generated code
// stuff here is generic enough to work for both windows/vs and gcc

#ifndef __MINGW32__
// optional affinity setting for effed up qualcomm/android bs
#include <sched.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <pthread.h>

void setAffinity(int core) {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(core, &cpuset);
    printf("Set affinity to core %d\n", core);
    // sched_setaffinity(gettid(), sizeof(cpu_set_t), &cpuset);
}
#endif

struct ThreadData {
    int* A;
    int* B;
    float* fpArr;
    uint32_t list_size;
    uint64_t structIterations;
};

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

/*
#define MSR_PATH_BUF_SIZE 256
uint64_t readmsr(uint32_t coreindex, uint32_t msrindex) {
    char buf[MSR_PATH_BUF_SIZE];
    memset(buf, 0, MSR_PATH_BUF_SIZE);
    snprintf(buf, MSR_PATH_BUF_SIZE, "/dev/cpu/%d/msr", coreindex);
    int fd;
    uint64_t msrvalue = 0;
    fd = open(buf, O_RDWR);
    if (fd == -1) {
        fprintf(stderr, "Could not open msr at path %s\n", buf);
        return 0;
    }

    lseek(fd, msrindex, SEEK_SET);
    read(fd, &msrvalue, 8);
    close(fd);
    return msrvalue;
}

void writemsr(uint32_t coreindex, uint32_t msrindex, uint64_t msrvalue) {
    char buf[MSR_PATH_BUF_SIZE];
    memset(buf, 0, MSR_PATH_BUF_SIZE);
    snprintf(buf, MSR_PATH_BUF_SIZE, "/dev/cpu/%d/msr", coreindex);
    int fd;
    fd = open(buf, O_RDWR);
    if (fd == -1) {
        fprintf(stderr, "Could not open msr at path %s\n", buf);
    }

    lseek(fd, msrindex, SEEK_SET);
    write(fd, &msrvalue, 8);
    close(fd);
}

#define IA32_PERF_GLOBAL_CTRL 0x38F
void enableIntelCounters(uint32_t coreindex)
{
    // IA32_PERF_GLOBAL_CTRL, enable four programmable counters and three fixed counters
    uint64_t msrvalue = readmsr(coreindex, 0x38F);
    msrvalue |= 0x70000000F; // software should read-modify-write to preserve reserved bits
    writemsr(coreindex, 0x38F, msrvalue);
}

#define IA32_INSTR_CTR 0x309
#define IA32_CYCLES_CTR 0x30A
#define IA32_PERFEVTSEL0 0x186
#define IA32_A_PMC0 0x4C1

void ClearIntelInstructionsCounter(uint32_t coreindex) { writemsr(coreindex, IA32_INSTR_CTR, 0); }
void ClearIntelCyclesCounter(uint32_t coreindex) { writemsr(coreindex, IA32_CYCLES_CTR, 0); }
uint64_t ReadIntelInstructionsCounter(uint32_t coreindex) { return readmsr(coreindex, IA32_INSTR_CTR); }
uint64_t ReadIntelCyclesCounter(uint32_t coreindex) { return readmsr(coreindex, IA32_CYCLES_CTR); }
void SetAndClearPMC(uint32_t coreindex, uint32_t pmcindex, uint32_t event, uint32_t umask, uint32_t cmask)
{
    uint64_t msrvalue = (event & 0xFF) | (umask & 0xFF) << 8
        // | 1UL << 16 // os
        // | 1UL << 17 // usr
        | 1UL << 22
        | cmask << 24;
    writemsr(coreindex, IA32_PERFEVTSEL0 + pmcindex, msrvalue);
    writemsr(coreindex, IA32_A_PMC0 + pmcindex, 0);
}

uint64_t ReadPMC(uint32_t coreindex, uint32_t pmcindex)
{
    return readmsr(coreindex, IA32_A_PMC0 + pmcindex);
}
*/

struct perf_read_data {
    uint64_t nr;
    struct {
        uint64_t value;
        uint64_t id;
    } values[4];
};

struct perf_event_attr perfInstrsAttr, perfCyclesAttr;
int perfInstrsFd = -1, perfCyclesFd = -1;
uint64_t perfInstrsId, perfCyclesId;
struct perf_read_data perfReadData;
void start_perf_monitoring() {
    if (perfInstrsFd == -1) close(perfInstrsFd);
    if (perfCyclesFd == -1) close(perfCyclesFd);

    memset(&perfInstrsAttr, 0, sizeof(struct perf_event_attr));
    perfInstrsAttr.type = PERF_TYPE_HARDWARE;
    perfInstrsAttr.size = sizeof(struct perf_event_attr);
    perfInstrsAttr.config = PERF_COUNT_HW_INSTRUCTIONS;
    perfInstrsAttr.disabled = 1;
    perfInstrsAttr.exclude_kernel = 1;
    perfInstrsAttr.exclude_hv = 1;
    perfInstrsAttr.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
    perfInstrsFd = syscall(__NR_perf_event_open, &perfInstrsAttr, 0, -1, -1, 0);
    ioctl(perfInstrsFd, PERF_EVENT_IOC_ID, &perfInstrsId);

    memset(&perfCyclesAttr, 0, sizeof(struct perf_event_attr));
    perfCyclesAttr.type = PERF_TYPE_HARDWARE;
    perfCyclesAttr.size = sizeof(struct perf_event_attr);
    perfCyclesAttr.config = PERF_COUNT_HW_CPU_CYCLES;
    perfCyclesAttr.disabled = 1;
    perfCyclesAttr.exclude_kernel = 1;
    perfCyclesAttr.exclude_hv = 1;
    perfCyclesAttr.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
    perfCyclesFd = syscall(__NR_perf_event_open, &perfCyclesAttr, 0, -1, perfInstrsFd, 0);
    ioctl(perfCyclesFd, PERF_EVENT_IOC_ID, &perfCyclesId);

    ioctl(perfInstrsFd, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP);
    ioctl(perfInstrsFd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);
}

void stop_perf_monitoring(uint64_t *instrs, uint64_t *cycles) {
    ioctl(perfInstrsFd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
    read(perfInstrsFd, &perfReadData, sizeof(struct perf_read_data));
    uint64_t instrs, cycles;
    for (int i = 0; i < 2; i++) {
        if (perfReadData.values[i].id == perfInstrsId)
        {
            instrs = perfReadData.values[i].value;
            fprintf(stderr, "Instructions: %lu\n", instrs);
        }
        else if (perfReadData.values[i].id == perfCyclesId) {
            cycles = perfReadData.values[i].value;
            fprintf(stderr, "Cycles: %lu\n", cycles);
        }
    }
    close(perfInstrsFd);
    close(perfCyclesFd);
}

// returns fd for event
int perf_event_open(struct perf_event_attr *hw)
{
    return syscall(__NR_perf_event_open, hw, 0, -1, -1, 0);
}

void perf_start_event(int fd) { 
    ioctl(fd, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP); 
    ioctl(fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);
}

uint64_t perf_read_event(int fd) {
    uint64_t rc;
    ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
    int readrc = read(fd, &rc, 8);
    if (readrc != 8) fprintf(stderr, "readrc is %d\n", readrc);
    return rc;
}


void perf_start_instrs_count() {
    if (perfInstrsFd == -1) {
        memset(&perfInstrsAttr, 0, sizeof(struct perf_event_attr));
        perfInstrsAttr.type = PERF_TYPE_HARDWARE;
        perfInstrsAttr.size = sizeof(struct perf_event_attr);
        perfInstrsAttr.config = PERF_COUNT_HW_INSTRUCTIONS;

        perfInstrsFd = perf_event_open(&perfInstrsAttr);
        fprintf(stderr, "perf instructions on fd %d\n", perfInstrsFd);
    }

    perf_start_event(perfInstrsFd);
}

void perf_start_cycles_count() {
    if (perfCyclesFd == -1) {
        memset(&perfCyclesAttr, 0, sizeof(struct perf_event_attr));
        perfCyclesAttr.type = PERF_TYPE_HARDWARE;
        perfCyclesAttr.size = sizeof(struct perf_event_attr);
        perfCyclesAttr.config = PERF_COUNT_HW_CPU_CYCLES;
        perfCyclesAttr.disabled = 1;
        perfCyclesFd = perf_event_open(&perfCyclesAttr);
        fprintf(stderr, "perf cycles on fd %d\n", perfCyclesFd);
    }

    perf_start_event(perfCyclesFd);
}

uint64_t perf_get_instrs_count() { return perf_read_event(perfInstrsFd); }
uint64_t perf_get_cycles_count() { return perf_read_event(perfCyclesFd); }