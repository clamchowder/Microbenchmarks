include ../common/arch_detect.mk

CFLAGS = -pthread -O3
LDFLAGS= -lm

machine: $(TARGET)

amd64:
	x86_64-linux-gnu-gcc $(CFLAGS) MemoryBandwidth.c MemoryBandwidth_x86.s -o MemoryBandwidth_amd64 $(LDFLAGS)

amd64_numa:
	x86_64-linux-gnu-gcc $(CFLAGS) -DNUMA MemoryBandwidth.c MemoryBandwidth_x86.s -o MemoryBandwidth_numa_amd64 $(LDFLAGS) -lnuma

aarch64:
	aarch64-linux-gnu-gcc $(CFLAGS) MemoryBandwidth.c MemoryBandwidth_arm.s -o MemoryBandwidth_aarch64 $(LDFLAGS)

riscv64:
	riscv64-linux-gnu-gcc $(CFLAGS) -march=rv64gcv0p7 MemoryBandwidth.c MemoryBandwidth_riscv.s -o MemoryBandwidth_riscv64 $(LDFLAGS)

w64:
	x86_64-w64-mingw32-gcc $(CFLAGS) -Iinclude MemoryBandwidth.c MemoryBandwidth_x86.s -o MemoryBandwidth_win64.exe $(LDFLAGS)

all: amd64 aarch64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: machine
