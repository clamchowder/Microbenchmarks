amd64:
	x86_64-linux-gnu-gcc -O3 MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency -lm
amd64_numa:
	x86_64-linux-gnu-gcc -O3 -DNUMA MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency -lm -lnuma
amd64_debug:
	gcc -g MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency -lm 
amd64_numa_debug:
	gcc -g -DNUMA MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency -lm -lnuma
aarch64:
	aarch64-linux-gnu-gcc -O3 MemoryLatency.c MemoryLatency_arm.s -o MemoryLatency -lm
win64:
	x86_64-w64-mingw32-gcc -O3 MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency.exe -lm
win32:
	i686-w64-mingw32-gcc -O3 MemoryLatency.c MemoryLatency_i686.s -o MemoryLatency32.exe -lm
