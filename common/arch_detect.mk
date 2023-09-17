TARGET ?= amd64

ifeq ($(OS),Windows_NT)
    TARGET := w64
else
    UNAME_P := $(shell uname -p)
    ifeq ($(UNAME_P),x86_64)
        TARGET := amd64
    endif
    ifneq ($(filter arm%,$(UNAME_P)),)
        TARGET := aarch64
    endif
endif
