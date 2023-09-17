include ../common/arch_detect.mk

CFLAGS = -pthread -O3

machine: $(TARGET)

amd64:
	x86_64-linux-gnu-gcc $(CFLAGS) PThreadsCoherencyLatency.c -o CoherencyLatency_amd64

aarch64:
	aarch64-linux-gnu-gcc $(CFLAGS) PThreadsCoherencyLatency.c -o CoherencyLatency_aarch64

riscv64:
	riscv64-linux-gnu-gcc $(CFLAGS) PThreadsCoherencyLatency.c -o CoherencyLatency_riscv64

w64:
	x86_64-w64-mingw32-g++ $(CFLAGS) CoherencyLatency.cpp -o CoherencyLatency_win64.exe

all: amd64 aarch64 riscv64 w64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: machine
