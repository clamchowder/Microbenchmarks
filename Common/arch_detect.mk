TARGET ?= amd64

ifeq ($(OS),Windows_NT)
    TARGET = w64
else
    UNAME_M := $(shell uname -m)
    ifeq ($(UNAME_M),x86_64)
        TARGET = amd64
    endif
    ifeq ($(UNAME_M),aarch64)
        TARGET = aarch64
    endif
    ifeq ($(UNAME_M),riscv64)
        TARGET = riscv64
    endif
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Darwin)
    TARGET = darwin
    endif
endif

amd64: CC = x86_64-linux-gnu-gcc
amd64_numa: CC = x86_64-linux-gnu-gcc
aarch64: CC := aarch64-linux-gnu-gcc
aarch64_numa: CC = aarch64-linux-gnu-gcc
riscv64: CC = riscv64-linux-gnu-gcc
w64: CC = x86_64-w64-mingw32-gcc
darwin: CC = clang
