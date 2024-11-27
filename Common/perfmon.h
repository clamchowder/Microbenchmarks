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
