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

#define PERF_NUM_EVENTS 4
struct perf_read_data {
    uint64_t nr;
    struct {
        uint64_t value;
        uint64_t id;
    } values[PERF_NUM_EVENTS];
};

struct perf_select_data {
    uint64_t id;   // id used to identify the event when it comes back in a group
    int fd;        // file descriptor
    struct perf_event_attr attr;
    uint64_t value;
    const char* description;
};

struct perf_select_data perf_selected_events[PERF_NUM_EVENTS];
struct perf_read_data perfReadData;
struct timeval perf_startTv, perf_endTv;
uint64_t perf_time_ms;

// populates basic properties
void initialize_hw_event(struct perf_event_attr* attr, uint64_t cfg, uint32_t hwid) {
    memset(attr, 0, sizeof(struct perf_event_attr));

    // low 32 bits of config = hardware event id
    // high 32 bits = PMU id (atom/core). Get from /sys/devices/<the thing>/type
    // on Arrow Lake, atom = 10, core = 4 
    attr->config = cfg | ((uint64_t)hwid << 32);
    attr->type = PERF_TYPE_HARDWARE;
    attr->size = sizeof(struct perf_event_attr);
    attr->disabled = 1;
    attr->exclude_kernel = 1;
    attr->exclude_hv = 1;
    attr->inherit = 1; // include child threads
    attr->read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
}

void set_hw_event(struct perf_select_data* evt, int groupfd) {
    evt->fd = syscall(__NR_perf_event_open, &(evt->attr), 0, -1, groupfd, 0);
    ioctl(evt->fd, PERF_EVENT_IOC_ID, &(evt->id));
    fprintf(stderr, "Opened event with fd %d\n", evt->fd);
}

void open_perf_monitoring() {
    int groupLeaderFd = -1;
    memset(perf_selected_events, 0, sizeof(struct perf_select_data) * PERF_NUM_EVENTS);

    // Predefined events: PERF_COUNT_HW_INSTRUCTIONS, PERF_COUNT_HW_CPU_CYCLES
    perf_selected_events[0].description = "cycles";
    initialize_hw_event(&(perf_selected_events[0].attr), PERF_COUNT_HW_CPU_CYCLES, 10);
    set_hw_event(perf_selected_events, -1);
    groupLeaderFd = perf_selected_events[0].fd;

    perf_selected_events[1].description = "bebound evt 74 umask 1";
    initialize_hw_event(&(perf_selected_events[1].attr), 0x174, 0);
    perf_selected_events[1].attr.type = 10;
    set_hw_event(perf_selected_events + 1, groupLeaderFd);

    perf_selected_events[2].description = "bebound evt 74 umask 4";
    initialize_hw_event(&(perf_selected_events[2].attr), 0x0474, 0);
    perf_selected_events[2].attr.type = 10;
    set_hw_event(perf_selected_events + 2, groupLeaderFd);

    perf_selected_events[3].description = "bebound evt 74 umask 80";
    initialize_hw_event(&(perf_selected_events[3].attr), 0x8074, 0);
    perf_selected_events[3].attr.type = 10;
    set_hw_event(perf_selected_events + 3, groupLeaderFd);
}

void start_perf_monitoring() {
    gettimeofday(&perf_startTv, NULL);
    int groupLeaderFd = perf_selected_events[0].fd;
    ioctl(groupLeaderFd, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP);
    ioctl(groupLeaderFd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);
}

uint64_t instrs, cycles, llcRef, llcMiss;
void stop_perf_monitoring() {
    int readbytes = 0;
    int groupLeaderFd = perf_selected_events[0].fd;
    ioctl(groupLeaderFd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
    // fprintf(stderr, "read %d bytes\n", sizeof(struct perf_read_data));
    readbytes = read(groupLeaderFd, &perfReadData, sizeof(struct perf_read_data));
    //fprintf(stderr, "Read %d bytes into perf_read_data. nr = %lu\n", readbytes, perfReadData.nr);
    for (int i = 0; i < perfReadData.nr; i++) {
        for (int evt_idx = 0; evt_idx < PERF_NUM_EVENTS; evt_idx++) {
            if (perf_selected_events[evt_idx].id == perfReadData.values[i].id) {
                struct perf_select_data* selected_evt = perf_selected_events + evt_idx;
                selected_evt->value = perfReadData.values[i].value;
                // fprintf(stderr, "%s: %lu\n", selected_evt->description, selected_evt->value);
            }
        }
    }

    gettimeofday(&perf_endTv, NULL);
    perf_time_ms = ((perf_endTv.tv_sec - perf_startTv.tv_sec) * 1000 + (perf_endTv.tv_usec - perf_startTv.tv_usec) / 1000);
}

void close_perf_monitoring() {
    for (int evt_idx = 0; evt_idx < PERF_NUM_EVENTS; evt_idx++) close(perf_selected_events[evt_idx].fd);
}

void append_perf_header() {
    for (int evt_idx = 0; evt_idx < PERF_NUM_EVENTS; evt_idx++) {
        printf(",%s", perf_selected_events[evt_idx].description);
    }

    printf(",Time (ms)");
}

void append_perf_values() {
    for (int evt_idx = 0; evt_idx < PERF_NUM_EVENTS; evt_idx++) {
        printf(",%lu", perf_selected_events[evt_idx].value);
    }

    printf(",%lu", perf_time_ms);
}