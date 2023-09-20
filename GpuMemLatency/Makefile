include ../Common/arch_detect.mk

OCL_VER = v2023.04.17
CI_SCRIPT = ../Common/ci_gpumemlatency.sh

CFLAGS = -O3 -I ../Common
DEPS = ../Common/timings.h
OBJ = opencltest.o latency_test.o bw_test.o common.o atomic_test.o instruction_rate.o timing.o
LDFLAGS ?= -lm -lOpenCL
ifeq ($(TARGET), Darwin)
    LDFLAGS = -lm -framework OpenCL
endif

all: $(TARGET)

GpuMemLatency: $(OBJ)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -o $@ $(LDFLAGS)

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<

timing.o:
	$(CC) $(CFLAGS) -c ../Common/timing.c -o timing.o

amd64: $(OBJ)
	$(CC) $(CFLAGS) $^ -o GpuMemLatency_amd64 $(LDFLAGS)

aarch64: $(OBJ)
	$(CC) $(CFLAGS) $^ -o GpuMemLatency_aarch64 $(LDFLAGS)

riscv64: $(OBJ)
	$(CC) $(CFLAGS) $^ -o GpuMemLatency_riscv64 $(LDFLAGS)

w64: $(OBJ)
	$(CC) $(CFLAGS) $^ -o GpuMemLatency_w64.exe $(LDFLAGS)

darwin: $(OBJ)
	$(CC) $(CFLAGS) $^ -o GpuMemLatency_darwin $(LDFLAGS)

ci: clean
	@OCL_VER=$(OCL_VER) sh $(CI_SCRIPT)

clean-ci:
	rm -rf "*.deb" "*.zip" "ocl-icd-*" "OpenCL-SDK-*"

clean-obj: 
	rm -f *.o

clean: clean-ci clean-obj
	find . -type f -executable -delete

.PHONY: all ci clean-ci clean-obj clean
