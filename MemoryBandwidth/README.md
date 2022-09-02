# Memory Bandwidth Benchmark
This is a C and assembly project that tests memory bandwidth. There's a version in this directory for Linux that uses POSIX threads for multithreading. There's a Windows version in the MemoryBandwidth subdirectory that uses Windows threading APIs. The Windows version requires Visual Studio and nasm in the path to compile.

To compile the linux version, do `make amd64` or `make aarch64`, depending on the target architecture

# Example usage

Testing single threaded bandwidth: `MemoryBandwidth.exe` or `./membw_amd64` or `./membw_aarch64`

# General parameters
`-threads` - How many threads to spawn. If you spawn more than one (i.e. with `-threads 4`) you might want to specify `-private` or `-shared`

`-private` - A separate test array is allocated for each thread. Each thread will access its own block of data, with the total amount of test data equal to the test size. For example, with a test size of 16 KB and 4 threads, each thread is given a 4 KB array. With this mode, test results will reflect combined cache capacity. If you have four cores, each with a private 32 KB L1D, expect to see L1D bandwidth up to 4 * 32 KB = 128 KB. This is usually the best mode to use because memory bandwidth results won't be inflated by request combining.

`-shared` - A single test array is accessed by all threads. For example, with 4 threads and a 16 KB test size, a single 16 KB array will be allocated and all four threads will hit it. Useful for seeing small shared caches, where the sum of private cache capacity is very close to (or exceeds) shared cache capacity. This mode often gives erroneously high memory bandwidth results because requests to the same cachelines from multiple cores may be combined. Of course using this mode with anything other than read-only access patterns is....stupid.

`-method` - What test to run. Methods will vary depending on what platform you're targeting and what version (Windows or Linux) you're using. There's some naming inconsistency here that I have to clean up. Good luck. If you don't specify it, it should pick the best read-only test function to use on your system. But a few options:
- `asm` (Linux only) - Uses a default read-only test function with a handwritten, unrolled assembly loop. On x86, AVX is used. NEON is used on aarch64.
- `avx512` (Linux, x86-64 only) - Uses AVX-512 instructions
- `write` (Linux) - Tests write bandwidth instead of read bandwidth. Will use AVX-512 if available
- `copy` (Linux) - Copies one half of the array to the other
- `scalar` - Plain C code that should work on any system. Only option available if you're on a weird (not x86 or aarch64) platform. Unsuitable for testing cache bandwidth because compilers are really really bad at autovectorization
- `instr8`, `instr4` - Tests instruction-side bandwidth (as opposed to data side) by filling an array with NOPs and a return at the end, marking it executable, and calling it as if it were a function. On x86-64, `instr8` uses 8 byte NOPs, while `instr4` uses 4 byte NOPs.
