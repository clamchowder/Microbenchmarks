include ../common/arch_detect.mk

CFLAGS = -O3
LDFLAGS = -lm
DEPS = ../common/timings.h
OBJ = opencltest.o latency_test.o bw_test.o common.o atomic_test.o instruction_rate.o timing.o

ifeq ($(UNAME_S),Darwin)
	TARGET := darwin
	LDFLAGS += -framework OpenCL
else
	LDFLAGS += -lOpenCL
endif

machine: $(TARGET)

GpuMemLatency: $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@ -lm $(LDFLAGS)

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<

timing.o:
	$(CC) $(CFLAGS) -c ../common/timing.c -o timing.o

amd64: $(OBJ)
	x86_64-linux-gnu-gcc $(CFLAGS) $^ -o GpuMemLatency_amd64 $(LDFLAGS)

aarch64: $(OBJ)
	aarch64-linux-gnu-gcc $(CFLAGS) $^ -o GpuMemLatency_aarch64 $(LDFLAGS)

darwin: $(OBJ)
	clang $(CFLAGS) $^ -o GpuMemLatency_darwin $(LDFLAGS)

all: amd64

clean:
	rm -f *.o && find . -type f -executable -delete

.PHONY: machine
