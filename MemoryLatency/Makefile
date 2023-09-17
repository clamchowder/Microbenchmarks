include ../common/arch_detect.mk

CFLAGS = -O3
LDFLAGS = -lm

machine: $(TARGET)

amd64:
	x86_64-linux-gnu-gcc $(CFLAGS) MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency_amd64 $(LDFLAGS)

amd64_numa:
	x86_64-linux-gnu-gcc $(CFLAGS) -DNUMA MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency_numa_amd64 $(LDFLAGS) -lnuma

aarch64:
	aarch64-linux-gnu-gcc $(CFLAGS) MemoryLatency.c MemoryLatency_arm.s -o MemoryLatency_aarch64 $(LDFLAGS)

w64:
	x86_64-w64-mingw32-g++ $(CFLAGS) MemoryLatency.cpp MemoryLatency_x86.s -o MemoryLatency_win64.exe $(LDFLAGS)

all: amd64 aarch64 w64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: machine
