CFLAGS = -O3 -fopenmp

machine: $(TARGET)

amd64:
	x86_64-linux-gnu-gcc $(CFLAGS) meshsim.c -o Meshsim_amd64

aarch64:
	aarch64-linux-gnu-gcc $(CFLAGS) meshsim.c -o Meshsim_aarch64

riscv64:
	riscv64-linux-gnu-gcc $(CFLAGS) meshsim.c -o Meshsim_riscv64

w64:
	x86_64-w64-mingw32-gcc $(CFLAGS) meshsim.c -o Meshsim_win64.exe

all: amd64 aarch64 riscv64 w64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: machine
