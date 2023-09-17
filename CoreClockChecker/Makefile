include ../common/arch_detect.mk

CFLAGS = -O3
LDFLAGS = -lm

machine: $(TARGET)

amd64:
	x86_64-linux-gnu-gcc $(CFLAGS) -pthread CoreClockChecker.c CoreClockChecker_x86.s -o CoreClockChecker_amd64 $(LDFLAGS)
	x86_64-linux-gnu-gcc $(CFLAGS) BoostClockChecker.c BoostClockChecker_x86.s -o BoostClockChecker_amd64 $(LDFLAGS)

aarch64:
	aarch64-linux-gnu-gcc $(CFLAGS) BoostClockChecker.c BoostClockChecker_arm.s -o BoostClockChecker_aarch64 $(LDFLAGS)

all: amd64 aarch64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: machine
