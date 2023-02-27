# CUDA Latency Test
Some Nvidia GPUs do not use the L1 to cache global loads, and some can have flexible L1/shard memory allocations. These options aren't exposed through OpenCL, so this is a very basic test written in CUDA to explore those aspects. It's not going to be easy to use, sorry.

## Compile
You need to know your Nvidia GPU's compute capability version. For example:
- 3.0: GK104, GK106, other early consumer Kepler chips
- 3.7: GK210
- 7.5: Turing

To compile and opt-in to L1 caching, do `nvcc -Xptxas -dlcm=ca -arch=compute_37 -code=sm_37 kernel.cu`. You must have Nvidia's CUDA build toolchain installed. You can build through Visual Studio as well, but that might not opt-in to L1 caching.

## Run
`a.exe [millions of iterations] [l/s/e]`
By default, millions of iterations = 7, or 7 million. Increase if it doesn't run for long enough and results are noisy. Decrease if it runs for too long and you get TDR-ed.

Second option: Hints to Nvidia how the L1/shmem block should be split up
- `l`: Prefer larger L1 allocation
- `s`: Prefer larger shared memory allocation (and thus smaller L1)
- `e`: Prefer equal allocation

Note that specifying a different preference might not show a different L1 size, because splits are set on a coarse granularity. And some architectures like Pascal and Maxwell have separate, dedicated L1 and shared memory blocks.