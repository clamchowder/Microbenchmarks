amd64:
	gcc -pthread -O3 MemoryBandwidth.c MemoryBandwidth_x86.s -o membw -lm

aarch64:
	gcc -pthread -O3 MemoryBandwidth.c MemoryBandwidth_arm.s -o membw -lm

crossaarch64:
	aarch64-linux-gnu-gcc -pthread -O3 MemoryBandwidth.c MemoryBandwidth_arm.s -o membw -lm

win64:
	x86_64-w64-mingw32-gcc-win32 -pthread -O3 MemoryBandwidth.c MemoryBandwidth_x86.s -o membw.exe -lm

crossamd64:
	x86_64-linux-gnu-gcc -pthread -O3 MemoryBandwidth.c MemoryBandwidth_x86.s -o membw
