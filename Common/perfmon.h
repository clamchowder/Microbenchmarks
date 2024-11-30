// Stuff that only works on Linux. Should be #ifdef-ed out for mingw cross compilation
uint64_t readmsr(uint32_t coreindex, uint32_t msrindex) {
    char buf[256];
    memset(buf, 0, 256);
    snprintf(buf, 256, "/dev/cpu/%d/msr", coreindex);
    int fd;
    uint64_t msrvalue = 0;
    fd = open(buf, O_RDWR);
    if (fd == -1) {
        fprintf(stderr, "Could not open msr\n");
        return 0;
    }
    
    lseek(fd, msrindex, SEEK_SET);
    read(fd, &msrvalue, 8);
    close(fd);
    return msrvalue;
}

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
    const char *description;
};

struct perf_select_data perf_selected_events[PERF_NUM_EVENTS];
struct perf_read_data perfReadData;
struct timeval perf_startTv, perf_endTv;
uint64_t perf_time_ms;

// populates basic properties
void initialize_hw_event(struct perf_event_attr *attr, uint64_t cfg, uint32_t hwid) {
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

void set_hw_event(struct perf_select_data *evt, int groupfd) {
    evt->fd = syscall(__NR_perf_event_open, &(evt->attr), 0, -1, groupfd, 0);
    ioctl(evt->fd, PERF_EVENT_IOC_ID, &(evt->id));
}

void open_perf_monitoring() {
    int groupLeaderFd = -1;
    memset(perf_selected_events, 0, sizeof(struct perf_select_data) * PERF_NUM_EVENTS);
    
    perf_selected_events[0].description = "instructions";
    initialize_hw_event(&(perf_selected_events[0].attr), PERF_COUNT_HW_INSTRUCTIONS, 0);
    set_hw_event(perf_selected_events, -1);
    groupLeaderFd = perf_selected_events[0].fd;

    perf_selected_events[1].description = "cycles";
    initialize_hw_event(&(perf_selected_events[1].attr), PERF_COUNT_HW_CPU_CYCLES, 0);
    set_hw_event(perf_selected_events + 1, groupLeaderFd);

    perf_selected_events[2].description = "llc_ref";
    initialize_hw_event(&(perf_selected_events[2].attr), 0x4F2E, 0);
    perf_selected_events[2].attr.type = PERF_TYPE_RAW;
    set_hw_event(perf_selected_events + 2, groupLeaderFd);

    perf_selected_events[3].description = "llc_miss";
    initialize_hw_event(&(perf_selected_events[3].attr), 0x412E, 0);
    perf_selected_events[3].attr.type = PERF_TYPE_RAW;
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
                struct perf_select_data *selected_evt = perf_selected_events + evt_idx;
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
