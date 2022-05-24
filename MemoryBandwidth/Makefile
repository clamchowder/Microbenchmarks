amd64:
	x86_64-linux-gnu-gcc -pthread -O3 MemoryBandwidth.c MemoryBandwidth_x86.s -o membw_amd64 -lm

aarch64:
	aarch64-linux-gnu-gcc -pthread -O3 -mcpu=neoverse-v1 MemoryBandwidth.c MemoryBandwidth_arm.s -o membw_aarch64 -lm
sve:
	clang -pthread -O3 -march=armv8-a+sve MemoryBandwidth.c MemoryBandwidth_arm.s -o membw_aarch64 -lm
win64:
	x86_64-w64-mingw32-gcc-win32 -pthread -O3 MemoryBandwidth.c MemoryBandwidth_x86.s -o membw.exe -lm
