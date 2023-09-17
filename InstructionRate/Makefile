include ../common/arch_detect.mk

CFLAGS = -O3

machine: $(TARGET)

amd64:
	x86_64-linux-gnu-gcc $(CFLAGS) x86_instructionrate.s x86_instructionrate.c -o InstructionRate_amd64

aarch64:
	aarch64-linux-gnu-gcc $(CFLAGS) arm_instructionrate.s arm_instructionrate.c -o InstructionRate_aarch64

amd64_fusion:
	x86_64-linux-gnu-gcc $(CFLAGS) x86_fusion.s x86_fusion.c -o Fusion_amd64

w64:
	x86_64-w64-mingw32-gcc $(CFLAGS) x86_instructionrate.c x86_instructionrate.s -o InstructionRate_win64.exe

all: amd64 aarch64 w64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: machine