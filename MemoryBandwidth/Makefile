include ../Common/arch_detect.mk

CFLAGS = -pthread -O3
LDFLAGS= -lm

all: $(TARGET)

amd64:
	$(CC) $(CFLAGS) MemoryBandwidth.c MemoryBandwidth_x86.s -o MemoryBandwidth_amd64 $(LDFLAGS)

amd64-numa:
	$(CC) $(CFLAGS) -DNUMA MemoryBandwidth.c MemoryBandwidth_x86.s -o MemoryBandwidth_numa_amd64 $(LDFLAGS) -lnuma

aarch64:
	$(CC) $(CFLAGS) MemoryBandwidth.c MemoryBandwidth_arm.s -o MemoryBandwidth_aarch64 $(LDFLAGS)

termux:
	gcc -O3 -pthread MemoryBandwidth.c MemoryBandwidth_arm.s -o MemoryBandwidth_aarch64 -lm

aarch64-numa:
	$(CC) $(CFLAGS) -DNUMA MemoryBandwidth.c MemoryBandwidth_arm.s -o MemoryBandwidth_numa_aarch64 $(LDFLAGS) -lnuma

riscv64:
	$(CC) $(CFLAGS) -march=rv64gcv0p7 MemoryBandwidth.c MemoryBandwidth_riscv.s -o MemoryBandwidth_riscv64 $(LDFLAGS)

w64:
	$(CC) $(CFLAGS) MemoryBandwidth.c MemoryBandwidth_x86.s -o MemoryBandwidth_w64.exe $(LDFLAGS)

ci: amd64 amd64-numa aarch64 w64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: all ci clean
