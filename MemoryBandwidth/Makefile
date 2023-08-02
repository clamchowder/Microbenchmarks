amd64:
	x86_64-linux-gnu-gcc -pthread -O3 MemoryBandwidth.c MemoryBandwidth_x86.s -o membw_amd64 -lm
amd64_numa:
	x86_64-linux-gnu-gcc -pthread -DNUMA -O3 MemoryBandwidth.c MemoryBandwidth_x86.s -o membw_amd64 -lm -lnuma
aarch64:
	aarch64-linux-gnu-gcc -pthread -O3 MemoryBandwidth.c MemoryBandwidth_arm.s -o membw_aarch64 -lm 

win64:
	x86_64-w64-mingw32-gcc-win32 -pthread -O3 MemoryBandwidth.c MemoryBandwidth_x86.s -o membw.exe -lm
riscv:
	~/riscv/bin/riscv64-unknown-linux-gnu-gcc -pthread -O3 -march=rv64gcv0p7 MemoryBandwidth.c MemoryBandwidth_riscv.s -o membw_riscv -lm
