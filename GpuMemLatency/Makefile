UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	LDFLAGS += -framework OpenCL
else
	LDFLAGS += -lOpenCL
opencltest:
	gcc -O3 opencltest.cpp -o opencltest -lm $(LDFLAGS)
