amd64:
	x86_64-linux-gnu-gcc -O3 MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency -lm
aarch64:
	aarch64-linux-gnu-gcc -O3 MemoryLatency.c MemoryLatency_arm.s -o MemoryLatency -lm
win64:
	x86_64-w64-mingw32-gcc -O3 MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency.exe -lm
win32:
	i686-w64-mingw32-gcc -O3 MemoryLatency.c MemoryLatency_i686.s -o MemoryLatency32.exe -lm
