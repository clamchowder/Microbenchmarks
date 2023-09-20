include ../Common/arch_detect.mk

CFLAGS = -O3 -fopenmp

all: $(TARGET)

amd64:
	$(CC) $(CFLAGS) meshsim.c -o Meshsim_amd64 $(LDFLAGS)

aarch64:
	$(CC) $(CFLAGS) meshsim.c -o Meshsim_aarch64 $(LDFLAGS)

riscv64:
	$(CC) $(CFLAGS) meshsim.c -o Meshsim_riscv64 $(LDFLAGS)

w64:
	$(CC) $(CFLAGS) meshsim.c -o Meshsim_w64.exe $(LDFLAGS)

ci: amd64 aarch64 riscv64 w64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: all ci clean
