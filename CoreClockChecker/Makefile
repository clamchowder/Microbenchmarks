include ../Common/arch_detect.mk

CFLAGS = -O3
LDFLAGS = -lm

all: $(TARGET)

amd64:
	$(CC) $(CFLAGS) -pthread CoreClockChecker.c CoreClockChecker_x86.s -o CoreClockChecker_amd64 $(LDFLAGS)
	$(CC) $(CFLAGS) BoostClockChecker.c BoostClockChecker_x86.s -o BoostClockChecker_amd64 $(LDFLAGS)

aarch64:
	$(CC) $(CFLAGS) BoostClockChecker.c BoostClockChecker_arm.s -o BoostClockChecker_aarch64 $(LDFLAGS)

w64:
	$(CC) $(CFLAGS) BoostClockChecker.c BoostClockChecker_x86.s -o BoostClockChecker_w64.exe $(LDFLAGS)

ci: amd64 aarch64 w64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: all ci clean
