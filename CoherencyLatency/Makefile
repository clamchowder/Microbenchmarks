include ../Common/arch_detect.mk

CFLAGS = -pthread -O3

all: $(TARGET)

amd64:
	$(CC) $(CFLAGS) PThreadsCoherencyLatency.c -o CoherencyLatency_amd64 $(LDFLAGS)

aarch64:
	$(CC) $(CFLAGS) PThreadsCoherencyLatency.c -o CoherencyLatency_aarch64 $(LDFLAGS)

riscv64:
	$(CC) $(CFLAGS) PThreadsCoherencyLatency.c -o CoherencyLatency_riscv64 $(LDFLAGS)

w64:
	$(CC) $(CFLAGS) CoherencyLatency.cpp -o CoherencyLatency_w64.exe $(LDFLAGS)

# w64 can build with mingw 11, which isn't available on jammy

ci: amd64 aarch64 riscv64

clean:
	rm -rf *.o *.zip "ocl-icd-libopencl1*" "OpenCL-SDK*" && find . -type f -executable -delete

.PHONY: all ci clean
