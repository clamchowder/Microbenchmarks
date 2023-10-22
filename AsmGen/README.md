# Microbenchmark Generator
C# project to generate C and assembly for CPU structure size benchmarks that use different code for each data point, making them
impractical to write by hand. For more details on methodology for out-of-order structure size measurement, see https://blog.stuffedcow.net/2013/05/measuring-rob-capacity/

First, go to Program.cs and set the expected sizes for the structures you want to measure. The constructor for each test generally has the same (low, high, step) format. For example if you anticipate ROB capacity will be between 128 and 512 entries, you can do `tests.Add(new RobTest(128, 1, 512))`

# Building

Compile the project and run AsmGen.exe. That gives several output files. Compilation for Linux:
`gcc clammicrobench.c clammicrobench_x86.s -o clammicrobench` for x86_64
`gcc clammicrobench.c clammicrobench_arm.s -o clammicrobench` for aarch64
`aarch64-linux-gnu-gcc clammicrobench.c clammicrobench_arm.s -o clammicrobench` to cross compile for aarch64 (for example from a fast desktop)

For Windows, run `AsmGen.exe autocopy`. That copies generated files to the /clammicrobench directory, assuming it's run from the default VS output location. Then, open /clammicrobench/clammicrobench.sln and build. You need nasm in your path for that, as covered on README.md at repo root.

The indirect branch test can take a while to build with nasm, so you might want to reduce the branch and target counts for that. Or just keep it commented out.

# Running
Generally, the syntax is `clammicrobench -test [test name] -listsize [list size for latency test] -iterations [iteration count]`. The last two parameters are optional.

# Tests

Running the program without parameters will spit out a list of tests and brief descriptions. Most are structure size tests. Instructions that consume certain core resources are placed between two pointer chasing loads. Once the two cache misses can't overlap, the structure being tested is full. Some tests, especially those measuring scheduler capacity, will hit a mix of instructions to see whether capacity is shared across different categories of instructions. 

Alongside structure size tests, AsmGen is a convenient place to put other microbenchmarks that involve generating tons of code. There are several branch predictor tests:
- btb16Unconditional, etc: Creates a chain of taken branches in a loop to measure taken branch latency. Useful for showing BTB size and speed. Different distances between branches are useful because branch predictors sometimes have dtrouble tracking branches that are too close together.
- btb16Conditional: Same as above but with always-taken conditional branches
- branchhist - Branch history test: Generates branches that are taken or not taken in some random pattern, then increases the length of that pattern and the number of branches. Each branch is given its own pattern. This test thus tries to see how long of a pattern the branch predictor can track before getting a lot of mispredicts.
- indirectbranch - Indirect branch prediction test: Varies the number of branch targets and branches to see how many total targets the indirect branch predictor can track
- returnstack - Tests return prediction with a nested calls of varying depths. When the return stack overflows, you'll see an increase in time per call/return pair.
