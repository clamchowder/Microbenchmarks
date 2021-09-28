# Microbenchmark Generator
C# project to generate C and assembly for CPU structure size benchmarks that use different code for each data point, making them 
impractical to write by hand. For more details on methodology for out-of-order structure size measurement, see https://blog.stuffedcow.net/2013/05/measuring-rob-capacity/

BTB size benchmarks are slightly different - that's simply spamming different numbers of unconditional jumps in a loop.

# Building
Compile the project and run AsmGen.exe. That gives several output files. Copy clammicrobench.cpp and clammicrobench_nasm.asm to (repo root)/clammicrobench,
and then build the clammicrobench solution. You need nasm in your path for that, as covered on README.md at repo root.
