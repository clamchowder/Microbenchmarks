UNAME_S := $(shell uname -s)
CC = gcc
CFLAGS = -O3
DEPS = ../common/timings.h
OBJ = opencltest.o latency_test.o bw_test.o common.o atomic_test.o instruction_rate.o timing.o

ifeq ($(UNAME_S),Darwin)
	LDFLAGS += -framework OpenCL
else
	LDFLAGS += -lOpenCL
endif

opencltest: $(OBJ)
	gcc $(CFLAGS) $^ -o $@ -lm $(LDFLAGS)

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<

timing.o:
	$(CC) $(CFLAGS) -c ../common/timing.c -o timing.o
