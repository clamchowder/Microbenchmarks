# Microbenchmark Generator
C# project to generate C and assembly for CPU structure size benchmarks that use different code for each data point, making them 
impractical to write by hand. For more details on methodology for out-of-order structure size measurement, see https://blog.stuffedcow.net/2013/05/measuring-rob-capacity/

Branch predictor benchmarks are different:
- BTB tests: Spams different numbers of unconditional jumps in a loop, spaced by different distances because branch predictors sometimes have trouble tracking branches that are too close together.
- Branch history test: Generates branches that are taken or not taken in some random pattern, then increases the length of that pattern and the number of branches. Each branch is given its own pattern. This test thus tries to see how long of a pattern the branch predictor can track before getting a lot of mispredicts.
- Indirect branch prediction test: Varies the number of branch targets and branches to see how many total targets the indirect branch predictor can track

# Building

Compile the project and run AsmGen.exe. That gives several output files. Compilation for Linux:
`gcc clammicrobench.c clammicrobench_x86.s -o clammicrobench` for x86_64
`gcc clammicrobench.c clammicrobench_arm.s -o clammicrobench` for aarch64

For Windows, run `AsmGen.exe autocopy`. That copies generated files to the /clammicrobench directory, assuming it's run from the default VS output location. Then, open /clammicrobench/clammicrobench.sln and build. You need nasm in your path for that, as covered on README.md at repo root.

The indirect branch test can take a while to build with nasm, so you might want to reduce the branch and target counts for that.
