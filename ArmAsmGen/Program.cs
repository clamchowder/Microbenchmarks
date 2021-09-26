using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace AsmGen
{
    class Program
    {
        static int structTestIterations = 5000000;
        static int iterations = 100 * structTestIterations;
        static int latencyListSize = 131072 * 1024 / 4; // 128 MB

        static void Main(string[] args)
        {
            List<IUarchTest> tests = new List<IUarchTest>();
            tests.Add(new RobTest(4, 512, 1));
            tests.Add(new IntRfTest(4, 256, 1));
            tests.Add(new FpRfTest(4, 256, 1));
            tests.Add(new VecRfTest(4, 256, 1));
            tests.Add(new Vec256RfTest(4, 256, 1));
            tests.Add(new AddSchedTest(4, 160, 1));
            tests.Add(new MulSchedTest(4, 128, 1));
            tests.Add(new Mul16SchedTest(4, 128, 1));
            tests.Add(new Mul32SchedTest(4, 48, 1));
            tests.Add(new FaddSchedTest(1, 128, 1));
            tests.Add(new FmulSchedTest(1, 128, 1));
            tests.Add(new Fadd256SchedTest(1, 128, 1));
            tests.Add(new MixFaddFmulSchedTest(2, 128, 1));
            tests.Add(new JumpSchedTest(4, 128, 1));
            tests.Add(new RobTest1(4, 512, 1));
            tests.Add(new MixIntFpRfTest(4, 256, 1));
            tests.Add(new LoadSchedTest(4, 128, 1));
            tests.Add(new StoreSchedTest(4, 128, 1));
            tests.Add(new StoreDataSchedTest(2, 128, 1));
            tests.Add(new LdqTest(4, 128, 1));
            tests.Add(new StqTest(4, 128, 1));
            tests.Add(new LdqStqTest(4, 128, 1));
            tests.Add(new ReturnStackTest(1, 64, 1));
            tests.Add(new MshrsTest(1, 12, 1));
            tests.Add(new CvtSchedTest(1, 128, 1));
            tests.Add(new RorSchedTest(1, 48, 1));
            tests.Add(new MixMulSchedTest(1, 48, 1));
            tests.Add(new TakenBranchBufferTest(1, 256, 1));
            tests.Add(new BranchBufferTest(1, 356, 1));
            tests.Add(new YmmStateIntRfTest(1, 64, 1));
            tests.Add(new Add256RfTest(1, 256, 1));
            tests.Add(new Add256SchedTest(1, 256, 1));
            tests.Add(new BtbTest(4));
            tests.Add(new BtbTest(8));
            tests.Add(new BtbTest(16));
            tests.Add(new MixJmpMulSchedTest(2, 128, 1));
            tests.Add(new MixMulRorSchedTest(2, 128, 1));
            tests.Add(new BranchHistoryTest());
            tests.Add(new IndirectBranchTest());

            StringBuilder cSourceFile = new StringBuilder();
            StringBuilder vsCSourceFile = new StringBuilder();
            StringBuilder armAsmFile = new StringBuilder();
            StringBuilder x86AsmFile = new StringBuilder();
            StringBuilder x86NasmFile = new StringBuilder();
            StringBuilder x86NasmFile1 = new StringBuilder();

            string commonFunctions = File.ReadAllText("CFiles\\CommonFunctions.c");
            string vsFunctions = File.ReadAllText("CFiles\\VsFunctions.c");
            string gccFunctions = File.ReadAllText("CFiles\\GccFunctions.c");

            // Generate C file for linux
            cSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys/time.h>\n#include <stdlib.h>\n#include <string.h>\n#include <time.h>\n");

            foreach (IUarchTest test in tests) test.GenerateExternLines(cSourceFile);

            cSourceFile.AppendLine(commonFunctions);
            cSourceFile.AppendLine(gccFunctions);
            AddCommonInitCode(cSourceFile, tests);
            cSourceFile.AppendLine("  struct timeval startTv, endTv;");
            cSourceFile.AppendLine("  struct timezone startTz, endTz;");

            foreach (IUarchTest test in tests) test.GenerateTestBlock(cSourceFile);
            cSourceFile.AppendLine("  free(A); free(B); free(fpArr);");
            cSourceFile.AppendLine("  return 0; }");
            File.WriteAllText("clammicrobench.c", cSourceFile.ToString());

            // Generate C file for VS
            vsCSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys\\timeb.h>\n#include <stdlib.h>\n");
            vsCSourceFile.AppendLine("#include <string.h>\n#include <time.h>\n");

            foreach (IUarchTest test in tests) test.GenerateVsExternLines(vsCSourceFile);
            vsCSourceFile.AppendLine(commonFunctions);
            vsCSourceFile.AppendLine(vsFunctions);
            AddCommonInitCode(vsCSourceFile, tests);
            vsCSourceFile.AppendLine("  struct timeb start, end;");

            foreach (IUarchTest test in tests) test.GenerateVsTestBlock(vsCSourceFile);

            // after structure size tests we don't care about this array
            vsCSourceFile.AppendLine("  free(A); free(B); free(fpArr);");

            // BTB size test
            vsCSourceFile.AppendLine("  return 0; }");
            File.WriteAllText("clammicrobench.cpp", vsCSourceFile.ToString());

            armAsmFile.AppendLine(".arch armv8-a\n.text\n");
            foreach (IUarchTest test in tests) test.GenerateAsmGlobalLines(armAsmFile);
            foreach (IUarchTest test in tests) test.GenerateArmAsm(armAsmFile);
            File.WriteAllText("clammicrobench_arm.s", armAsmFile.ToString());

            x86AsmFile.AppendLine(".text\n");

            foreach (IUarchTest test in tests) test.GenerateAsmGlobalLines(x86AsmFile);
            foreach (IUarchTest test in tests) test.GenerateX86GccAsm(x86AsmFile);

            File.WriteAllText("clammicrobench_x86.s", x86AsmFile.ToString());

            x86NasmFile.AppendLine("section .text\n");
            x86NasmFile.AppendLine("bits 64\n\n");

            // stupidly parallelize build a bit, since it's taking too long
            x86NasmFile1.Append(x86NasmFile.ToString());
            int testIdx = 0;
            foreach (IUarchTest test in tests)
            {
                if (testIdx < tests.Count / 2) 
                {
                    test.GenerateNasmGlobalLines(x86NasmFile);
                    test.GenerateX86NasmAsm(x86NasmFile);
                }
                else 
                {
                    test.GenerateNasmGlobalLines(x86NasmFile1);
                    test.GenerateX86NasmAsm(x86NasmFile1);
                }
                
                testIdx++;
            }
            File.WriteAllText("clammicrobench_nasm.asm", x86NasmFile.ToString());
            File.WriteAllText("clammicrobench1_nasm.asm", x86NasmFile1.ToString());

            // redo this later
            /*int[] branchHistCounts = new[] { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 };
            GenerateBranchHistHeader(branchHistHeaderFile, branchHistCounts);
            File.WriteAllText("branchhist.h", branchHistHeaderFile.ToString());
            x86.GenerateX86AsmBranchHistFuncs(x86branchHistFile, branchHistCounts);
            File.WriteAllText("branchhist_x86.s", x86branchHistFile.ToString());*/

            if (args.Length > 0 && args[0].Equals("autocopy", StringComparison.OrdinalIgnoreCase))
            {
                Console.WriteLine("Automatically copying files, based on default VS paths");
                string clammicrobenchPath = @"..\..\..\..\clammicrobench";
                string[] clammicrobenchFiles = new[] { "clammicrobench_nasm.asm", "clammicrobench1_nasm.asm", "clammicrobench.cpp" };
                CopyFiles(clammicrobenchPath, clammicrobenchFiles);

                /*string branchhistPath = @"..\..\..\..\BranchHistoryLength";
                string[] branchhistFiles = new[] { "branchhist.h", "branchhist_x86.s" };
                CopyFiles(branchhistPath, branchhistFiles);*/
            }
        }

        public static string GetLabelName(string funcName, int part) { return funcName + "part" + part; }

        public const string branchHistPrefix = "branchhist";

        static void CopyFiles(string targetDir, string[] fileNames)
        {
            foreach (string fname in fileNames)
            {
                string targetPath = Path.Join(targetDir, fname);
                if (File.Exists(targetPath))
                {
                    File.Delete(targetPath);
                }

                File.Move(fname, targetPath);
                Console.WriteLine("Moved " + fname);
            }
        }


        static void AddCommonInitCode(StringBuilder sb, List<IUarchTest> tests)
        {
            sb.AppendLine("int main(int argc, char *argv[]) {");
            sb.AppendLine($"  uint64_t time_diff_ms, iterations = {iterations}, structIterations = {structTestIterations}, tmp;");
            sb.AppendLine("  float latency; int *A = NULL, *B = NULL; float *fpArr = NULL;");
            sb.AppendLine("  uint64_t tmpsink;");
            sb.AppendLine("  uint32_t list_size = " + latencyListSize + ";");

            // print a help message based on tests available
            sb.AppendLine($"  printf(\"Usage: [test name] [latency list size = {latencyListSize}] [struct iterations = {structTestIterations}]\\n\");");
            sb.AppendLine("  if (argc < 2) {");
            sb.AppendLine("    printf(\"List of tests:\\n\");");
            foreach (IUarchTest test in tests) sb.AppendLine($"    printf(\"  {test.Prefix} - {test.Description}\\n\");");
            sb.AppendLine("  }");
            sb.AppendLine("  if (argc > 3) { structIterations = atoi(argv[3]); iterations = 100 * structIterations; }");
            sb.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"branchtest\", 9) != 0) {");
            GenerateLatencyTestArray(sb);
            sb.AppendLine("  }");
        }

        static void GenerateLatencyTestArray(StringBuilder sb)
        {
            // Fill list to create random access pattern
            sb.AppendLine("  if (argc > 2) list_size = atoi(argv[2]);");

            sb.AppendLine("  A = (int*)malloc(sizeof(int) * list_size);");
            sb.AppendLine("  for (int i = 0; i < list_size; i++) { A[i] = i; }\n");
            sb.AppendLine("  int iter = list_size;");
            sb.AppendLine("  while (iter > 1)");
            sb.AppendLine("  {");
            sb.AppendLine("      iter -= 1;");
            sb.AppendLine("      int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);");
            sb.AppendLine("      uint32_t tmp = A[iter];");
            sb.AppendLine("      A[iter] = A[j];");
            sb.AppendLine("      A[j] = tmp;");
            sb.AppendLine("  }");

            sb.AppendLine("  B = (int*)malloc(sizeof(int) * list_size);\n");
            sb.AppendLine("  for (int i = 0; i < list_size; i++) { B[i] = i; }\n");
            sb.AppendLine("  fpArr = (float*)malloc(sizeof(float) * list_size);\n");
            sb.AppendLine("  for (int i = 0;i < list_size; i++) { fpArr[i] = i + .1; }\n");
        }

        static void GenerateBranchHistHeader(StringBuilder sb, int[] counts)
        {
            sb.AppendLine($"uint32_t maxBranchCount = {counts.Length};");
            sb.Append($"uint32_t branchCounts[{counts.Length}] = ");
            sb.Append("{ " + counts[0]);
            for (int i = 1; i < counts.Length; i++) sb.Append(", " + counts[i]);
            sb.AppendLine(" };");
            sb.AppendLine($"uint64_t (*branchtestFuncArr[{counts.Length}])(uint64_t iterations, uint32_t **arr, uint32_t arrLen);");
            for (int i = 0; i < counts.Length; i++)
            {
                sb.AppendLine("extern uint64_t " + branchHistPrefix + counts[i] + "(uint64_t iterations, uint32_t **arr, uint32_t arrLen);");
            }

            sb.AppendLine("void initializeFuncArr() {");
            for (int i = 0; i < counts.Length; i++)
            {
                sb.AppendLine($"  branchtestFuncArr[{i}] = {branchHistPrefix + counts[i]};");
            }

            sb.AppendLine("}");
        }
    }
}
