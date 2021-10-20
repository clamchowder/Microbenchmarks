# Memory Latency Test

This test measures random memory access latency within increasing array sizes, and (hopefully) shows the latency and size of caches as well as memory latency. Modes, passed as the first parameter:
- (no parameter) - Uses plain C code and `current = A[current]` to measure latency
- asm - Uses `mov r15, [r15]` for x86-64 or `ldr x15, [x15]`. This can help accurately measure L1D latency, because many x86 CPUs take an extra cycle to calculate "complex" addresses. And compilers like to do that for the plain C version above. This doesn't seem to make a difference for ARM
- tlb - Accesses just one element per 4 KB region to measure virtual to physical address translation latency (so TLBs and page walkers). Cache latency is subtracted out to isolate address translation latency.

# Building and Running

Make sure optimization is on, or L1D latencies may be quite a bit higher than expected.

## Windows
Under WSL, do `x86_64-w64-mingw32-gcc-win32 -O3 MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency.exe`

Run with
`MemoryLatency.exe`
`MemoryLatency.exe asm`
`MemoryLatency.exe tlb`
## Linux, x86-64
`gcc -O3 MemoryLatency.c MemoryLatency_x86.s -o MemoryLatency`

## Linux/Android+Termux, aarch64
`gcc -O3 MemoryLatency.c MemoryLatency_arm.s -o MemoryLatency`

## VS version
Open solution and build. But this will be removed in the near future because cross-compiling from WSL is sufficient to produce a Windows exe, since calling conventions are lined up.
