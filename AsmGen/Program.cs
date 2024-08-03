using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace AsmGen
{
    class Program
    {
        public static string DataFilesDir = "DataFiles";

        static int structTestIterations = 5000000;
        static int iterations = 100 * structTestIterations;
        static int latencyListSize = 131072 * 1024 / 4; // 128 MB

        static void Main(string[] args)
        {
            List<IUarchTest> tests = new List<IUarchTest>();
            tests.Add(new RobTest(12, 800, 1, initialDependentBranch: false));
            tests.Add(new A73RobTest(4, 160, 1));

            // avx-512
            tests.Add(new Vec512RfTest(128, 600, 1));
            tests.Add(new Stq512Test(16, 128, 1, differentLines: true));
            tests.Add(new Stq512Test(16, 128, 1, differentLines: false));
            tests.Add(new MaskRfTest(32, 256, 1));

            tests.Add(new ZeroRobTest(12, 800, 1, initialDependentBranch: false));
            tests.Add(new IntRfTest(60, 400, 1, initialDependentBranch: false));
            tests.Add(new FpRfTest(60, 800, 1, initialDependentBranch: false));;
            tests.Add(new FlagRfTest(8, 100, 1, initialDependentBranch: false));
            tests.Add(new LdqTest(80, 250, 1, initialDependentBranch: false));
            tests.Add(new StqTest(4, 200, 1, initialDependentBranch: false));
            tests.Add(new MixIntVec128RfTest(4, 600, 1, initialDependentBranch: false));
            tests.Add(new MixIntRfDepBranchTest(4, 100, 1, 2));
            tests.Add(new MixIntRfDepBranchTest(4, 100, 1, 4));
            tests.Add(new MixIntRfDepBranchTest(4, 100, 1, 8));
            tests.Add(new MixIntRfDepBranchTest(4, 100, 1, 16));
            tests.Add(new AddSchedTest(16, 100, 1));
            tests.Add(new MulSchedTest(4, 64, 1));
            tests.Add(new LeaSchedTest(4, 64, 1));
            tests.Add(new MaddSchedTest(4, 64, 1));
            tests.Add(new JumpSchedTest(4, 64, 1));
            tests.Add(new MixJumpThenAddSched(20, 160, 1));
            tests.Add(new TakenJumpSchedTest(4, 64, 1));
            tests.Add(new LoadSchedTest(4, 72, 1));
            tests.Add(new StoreSchedTest(4, 72, 1));
            tests.Add(new StoreDataSchedTest(4, 80, 1));
            tests.Add(new MixAddJumpSchedTest(64, 100, 1));
            tests.Add(new FaddSchedTest(10, 200, 1));
            tests.Add(new FmulSchedTest(10, 80, 1));
            tests.Add(new FcmpSchedTest(10, 60, 1));
            tests.Add(new JsCvtSched(8, 120, 1));
            tests.Add(new MixAddvJsCvtSched(8, 120, 1));
            tests.Add(new AddvSched(8, 120, 1));
            tests.Add(new FmovSched(8, 120, 1));
            tests.Add(new Fadd128SchedTest(4, 200, 1));
            tests.Add(new Fadd256SchedTest(4, 200, 1));
            tests.Add(new Fma256SchedTest(4, 200, 1));
            tests.Add(new CvtSchedTest(64, 180, 1));
            tests.Add(new Fadd128RfTest(4, 200, 1, initialDependentBranch: true));
            tests.Add(new MixLdqStqTest(4, 120, 1, initialDependentBranch: true));
            tests.Add(new BtbTest(4, BtbTest.BranchType.Unconditional));
            tests.Add(new BtbTest(8, BtbTest.BranchType.Unconditional));
            tests.Add(new BtbTest(16, BtbTest.BranchType.Unconditional));
            tests.Add(new BtbTest(32, BtbTest.BranchType.Unconditional));
            tests.Add(new BtbTest(64, BtbTest.BranchType.Unconditional));
            tests.Add(new BtbTest(4, BtbTest.BranchType.Conditional));
            tests.Add(new BtbTest(8, BtbTest.BranchType.Conditional));
            tests.Add(new BtbTest(16, BtbTest.BranchType.Conditional));
            tests.Add(new BtbTest(32, BtbTest.BranchType.Conditional));
            tests.Add(new ReturnStackTest(1, 128, 1));
            tests.Add(new BranchBufferTest(4, 300, 1, initialDependentBranch: false));
            tests.Add(new TakenBranchBufferTest(4, 300, 1, initialDependentBranch: false));
            tests.Add(new MixBranchStoreTest(4, 100, 1, initialDependentBranch: true));
            tests.Add(new IndirectBranchTest(false));
            tests.Add(new BranchHistoryTest());
            tests.Add(new NopLoopTest(512, 1));
            tests.Add(new AddLoopTest(4, 100, 1));
            tests.Add(new AeseSchedTest(4, 64, 1));
            tests.Add(new FpStoreDataNsqTest(20, 150, 1));

            List<Task> tasks = new List<Task>();
            tasks.Add(Task.Run(() => GenerateCFile(tests, IUarchTest.ISA.amd64)));
            tasks.Add(Task.Run(() => GenerateCFile(tests, IUarchTest.ISA.aarch64)));
            tasks.Add(Task.Run(() => GenerateCFile(tests, IUarchTest.ISA.mips64)));
            tasks.Add(Task.Run(() => GenerateCFile(tests, IUarchTest.ISA.riscv)));

            tasks.Add(Task.Run(() => GenerateAsmFile(tests, IUarchTest.ISA.amd64)));
            tasks.Add(Task.Run(() => GenerateAsmFile(tests, IUarchTest.ISA.aarch64)));
            tasks.Add(Task.Run(() => GenerateAsmFile(tests, IUarchTest.ISA.mips64)));
            tasks.Add(Task.Run(() => GenerateAsmFile(tests, IUarchTest.ISA.riscv)));
            Task.WaitAll(tasks.ToArray());

            GenerateMakefile();
        }

        static void GenerateCFile(List<IUarchTest> tests, IUarchTest.ISA isa)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("#define _GNU_SOURCE");
            sb.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys/time.h>\n#include <stdlib.h>\n#include <string.h>\n#include <time.h>\n");
            sb.AppendLine("#pragma GCC diagnostic ignored \"-Wattributes\"");
            string commonFunctions = File.ReadAllText($"{DataFilesDir}\\CommonFunctions.c");
            sb.AppendLine(commonFunctions);

            foreach (IUarchTest test in tests)
            {
                if (test.SupportsIsa(isa))
                {
                    test.GenerateExternLines(sb);
                    Console.WriteLine("Test " + test.Prefix + " supports ISA " + isa);
                }
            }

            // no indexed addressing mode on these architectures, so make sure we can do pointer
            // chasing with a single instruction
            if (isa == IUarchTest.ISA.mips64 || isa == IUarchTest.ISA.riscv)
            {
                sb.AppendLine("extern void preplatencyarr(int *arr, uint32_t list_size);");
            }

            AddCommonInitCode(sb, tests, isa);
            foreach (IUarchTest test in tests)
            {
                if (test.SupportsIsa(isa)) test.GenerateTestBlock(sb, isa);
            }

            AddCommonEndCode(sb);

            File.WriteAllText("clammicrobench_" + isa.ToString() + ".c", sb.ToString());
        }

        static void GenerateAsmFile(List<IUarchTest> tests, IUarchTest.ISA isa)
        {
            string filename = "clammicrobench_" + isa.ToString() + ".s";
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(".text");

            if (isa == IUarchTest.ISA.mips64)
            {
                UarchTest.GenerateMipsPrepArrayFunction(sb);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                UarchTest.GenerateRiscvPrepArrayFunction(sb);
            }

            File.WriteAllText(filename, sb.ToString());
            sb.Clear();

            foreach (IUarchTest test in tests)
            {
                if (test.SupportsIsa(isa))
                {
                    sb.Clear();
                    test.GenerateAsmGlobalLines(sb);
                    test.GenerateAsm(sb, isa);
                    File.AppendAllText(filename, sb.ToString());
                }
            }
        }

        static void GenerateMakefile()
        {
            StringBuilder sb = new StringBuilder();
            foreach (IUarchTest.ISA isa in Enum.GetValues(typeof(IUarchTest.ISA)))
            {
                sb.AppendLine(isa.ToString() + ":");
                if (isa == IUarchTest.ISA.aarch64)
                {
                    sb.AppendLine($"\tgcc -march=armv8.5-a+aes clammicrobench_{isa.ToString()}.c clammicrobench_{isa.ToString()}.s -o cb -static");
                    // hack for stupid compilers that need a ton of flags to do basic things
                    sb.AppendLine("android:");
                    sb.AppendLine("\tclang -march=armv8.3-a -mfpu=neon-fp-armv8 clammicrobench_aarch64.c clammicrobench_aarch64.s -o cb");
                }
                else sb.AppendLine($"\tgcc -pthread clammicrobench_{isa.ToString()}.c clammicrobench_{isa.ToString()}.s -o cb");
            }

            sb.AppendLine("win64:");
            sb.AppendLine($"\tx86_64-w64-mingw32-gcc clammicrobench_{IUarchTest.ISA.amd64.ToString()}.c clammicrobench_{IUarchTest.ISA.amd64.ToString()}.s -o cb.exe");

            File.WriteAllText("Makefile", sb.ToString());
        }

        // Adds largely ISA independent initialization code that gives tests a basic foundation,
        // like a pointer chasing array
        static void AddCommonInitCode(StringBuilder sb, List<IUarchTest> tests, IUarchTest.ISA isa)
        {
            sb.AppendLine("int main(int argc, char *argv[]) {");
            sb.AppendLine($"  uint64_t time_diff_ms, iterations = {iterations}, structIterations = {structTestIterations}, tmp;");
            sb.AppendLine("  double latency; int *A = NULL, *B = NULL; float *fpArr = NULL; char *test_name = NULL; int core_affinity = -1; int threads = 1;");
            sb.AppendLine("  uint64_t tmpsink;");
            sb.AppendLine("  uint32_t list_size = " + latencyListSize + ";");

            // print a help message based on tests available
            sb.AppendLine($"  printf(\"Usage: -test [test name] -listsize [latency list size = {latencyListSize}] -iterations [struct iterations = {structTestIterations}]\\n\");");
            sb.AppendLine("  if (argc < 2) {");
            sb.AppendLine("    printf(\"List of tests:\\n\");");
            foreach (IUarchTest test in tests)
            {
                if (test.SupportsIsa(isa)) sb.AppendLine($"    printf(\"  {test.Prefix} - {test.Description}\\n\");");
            }

            // args provided. parse them and run test
            sb.AppendLine("  } else {");

            // args handling
            sb.AppendLine("    for (int argIdx = 1; argIdx < argc; argIdx++) {");
            sb.AppendLine("      if (*(argv[argIdx]) == '-') { char *arg = argv[argIdx] + 1;");
            sb.AppendLine("        if (strncmp(arg, \"test\", 4) == 0) { argIdx++; test_name = argv[argIdx]; }");
            sb.AppendLine("        if (strncmp(arg, \"iterations\", 10) == 0) { argIdx++; iterations = 100 * atoi(argv[argIdx]); }");
            sb.AppendLine("        if (strncmp(arg, \"listsize\", 8) == 0) { argIdx++; list_size = atoi(argv[argIdx]); }");
            sb.AppendLine("        if (strncmp(arg, \"affinity\", 8) == 0) { argIdx++; core_affinity = atoi(argv[argIdx]); }");
            sb.AppendLine("        if (strncmp(arg, \"threads\", 7) == 0) { argIdx++; threads = atoi(argv[argIdx]); }");
            sb.AppendLine("      }"); // end -arg handling if
            sb.AppendLine("    }"); // end args handling for loop

            sb.AppendLine("    if (test_name == NULL) { fprintf(stderr, \"No test specified\\n\"); return 0; }");

            // Optional affinity setting for certain troublesome platforms
            // don't need a version that uses Windows affinity APIs because Windows platforms never have this issue
            sb.AppendLine("#ifndef __MINGW32__");
            sb.AppendLine("  if (core_affinity != -1) setAffinity(core_affinity);");
            sb.AppendLine("#endif");

            // Generate array for pointer chasing unless we're doing a BTB test
            sb.AppendLine("  if (argc == 1 || argc > 1 && strncmp(test_name, \"btb\", 3) != 0) {");
            GenerateLatencyTestArray(sb);
            sb.AppendLine("  }"); // end of ptr chasing array generation
            sb.AppendLine("  struct timeval startTv, endTv;");
            sb.AppendLine("  struct timezone startTz, endTz;");
        }


        static void AddCommonEndCode(StringBuilder sb)
        {
            sb.AppendLine("  free(A); free(B); free(fpArr);");
            sb.AppendLine("  }"); // end else
            sb.AppendLine("  return 0; }");
        }

        static void GenerateLatencyTestArray(StringBuilder sb)
        {
            // Fill list to create random access pattern
            sb.AppendLine("  A = (int*)malloc(sizeof(int) * list_size);");
            sb.AppendLine("  srand(time(NULL));");
            sb.AppendLine("  FillPatternArr(A, list_size, 64);\n");

            sb.AppendLine("#ifdef _WIN32");
            sb.AppendLine("  B = (int*)_aligned_malloc(sizeof(int) * list_size, 64);\n");
            sb.AppendLine("#else");
            sb.AppendLine("  posix_memalign((void **)&B, 64, sizeof(int) * list_size);\n");
            sb.AppendLine("#endif");
            sb.AppendLine("  for (int i = 0; i < list_size; i++) { B[i] = i; }\n");
            sb.AppendLine("  posix_memalign((void **)&fpArr, 64, sizeof(float) * list_size);");
            sb.AppendLine("  for (int i = 0;i < list_size; i++) { fpArr[i] = i + .1; }\n");
        }
    }
}
