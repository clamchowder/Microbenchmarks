using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace AsmGen
{
    class Program
    {
        static int iterations = 1000000000 / 2;
        static int structTestIterations = 5000000;
        static int latencyListSize = 131072 * 1024 / 4; // 128 MB

        static void Main(string[] args)
        {
            List<UarchTest> tests = new List<UarchTest>();
            tests.Add(new RobTest(4, 512, 1));
            tests.Add(new IntRfTest(4, 256, 1));
            tests.Add(new FpRfTest(4, 256, 1));
            tests.Add(new VecRfTest(4, 256, 1));
            tests.Add(new Vec256RfTest(4, 256, 1));
            tests.Add(new AddSchedTest(4, 160, 1));
            tests.Add(new MulSchedTest(4, 128, 1));
            tests.Add(new Mul16SchedTest(4, 128, 1));
            tests.Add(new FaddSchedTest(2, 128, 1));
            tests.Add(new FmulSchedTest(2, 128, 1));
            tests.Add(new Fadd256SchedTest(2, 128, 1));
            tests.Add(new MixFaddFmulSchedTest(2, 128, 1));
            tests.Add(new JumpSchedTest(4, 128, 1));
            tests.Add(new RobTest1(4, 512, 1));
            tests.Add(new MixIntFpRfTest(4, 256, 1));
            tests.Add(new LoadSchedTest(4, 128, 1));
            tests.Add(new StoreSchedTest(4, 128, 1));
            tests.Add(new LdqTest(4, 128, 1));
            tests.Add(new StqTest(4, 128, 1));

            StringBuilder cSourceFile = new StringBuilder();
            StringBuilder vsCSourceFile = new StringBuilder();
            StringBuilder armAsmFile = new StringBuilder();
            StringBuilder x86AsmFile = new StringBuilder();
            StringBuilder x86NasmFile = new StringBuilder();

            StringBuilder x86branchHistFile = new StringBuilder();
            StringBuilder branchHistHeaderFile = new StringBuilder();

            // Generate C file for linux
            cSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys/time.h>\n#include <stdlib.h>\n#include <string.h>\n");

            foreach (UarchTest test in tests) UarchTestHelpers.GenerateExternLines(cSourceFile, test);

            AddCommonInitCode(cSourceFile, tests);
            cSourceFile.AppendLine("  struct timeval startTv, endTv;");
            cSourceFile.AppendLine("  struct timezone startTz, endTz;");

            foreach (UarchTest test in tests) UarchTestHelpers.GenerateTestBlock(cSourceFile, test);
            cSourceFile.AppendLine("  free(A); free(B); free(fpArr);");
            cSourceFile.AppendLine("  return 0; }");
            File.WriteAllText("clammicrobench.c", cSourceFile.ToString());

            // Generate C file for VS
            vsCSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys\\timeb.h>\n#include <stdlib.h>\n");
            vsCSourceFile.AppendLine("#include <string.h>\n");

            foreach (UarchTest test in tests) UarchTestHelpers.GenerateVsExternLines(vsCSourceFile, test);
            AddCommonInitCode(vsCSourceFile, tests);
            vsCSourceFile.AppendLine("  struct timeb start, end;");

            foreach (UarchTest test in tests) UarchTestHelpers.GenerateVsTestBlock(vsCSourceFile, test);

            // after structure size tests we don't care about this array
            vsCSourceFile.AppendLine("  free(A); free(B); free(fpArr);");

            // BTB size test
            vsCSourceFile.AppendLine("  return 0; }");
            File.WriteAllText("clammicrobench.cpp", vsCSourceFile.ToString());

            armAsmFile.AppendLine(".arch armv8-a\n.text\n");
            armAsmFile.AppendLine(".global reallybadthing");
            foreach (UarchTest test in tests) UarchTestHelpers.GenerateAsmGlobalLines(armAsmFile, test);
            foreach (UarchTest test in tests) test.GenerateArmAsm(armAsmFile);
            File.WriteAllText("clammicrobench_arm.s", armAsmFile.ToString());

            x86AsmFile.AppendLine(".text\n");

            foreach (UarchTest test in tests) UarchTestHelpers.GenerateAsmGlobalLines(x86AsmFile, test);
            foreach (UarchTest test in tests) test.GenerateX86GccAsm(x86AsmFile);
            x86AsmFile.AppendLine("reallybadthing:");

            File.WriteAllText("clammicrobench_x86.s", x86AsmFile.ToString());

            x86NasmFile.AppendLine("section .text\n");
            x86NasmFile.AppendLine("bits 64\n\n");
            x86NasmFile.AppendLine("%define nop2 db 0x66, 0x90\n");
            x86NasmFile.AppendLine("%define nop4 db 0x0F, 0x1F, 0x40, 0x00\n");
            x86NasmFile.AppendLine("%define nop12 db 0x66, 0x66, 0x66, 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n\n");
            x86NasmFile.AppendLine("global reallybadthing");
            foreach (UarchTest test in tests) UarchTestHelpers.GenerateNasmGlobalLines(x86NasmFile, test);
            foreach (UarchTest test in tests) test.GenerateX86NasmAsm(x86NasmFile);
            x86NasmFile.AppendLine("reallybadthing:");
            x86NasmFile.AppendLine("  int3");
            File.WriteAllText("clammicrobench_nasm.asm", x86NasmFile.ToString());

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
                string[] clammicrobenchFiles = new[] { "clammicrobench_nasm.asm", "clammicrobench.cpp" };
                CopyFiles(clammicrobenchPath, clammicrobenchFiles);

                /*string branchhistPath = @"..\..\..\..\BranchHistoryLength";
                string[] branchhistFiles = new[] { "branchhist.h", "branchhist_x86.s" };
                CopyFiles(branchhistPath, branchhistFiles);*/
            }
        }

        public static string GetBranchFuncName(int branchCount, int padding) { return "branch" + branchCount + "pad" + padding; }
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

                File.Copy(fname, targetPath);
                Console.WriteLine("Copied " + fname);
            }
        }


        static void AddCommonInitCode(StringBuilder sb, List<UarchTest> tests)
        {
            sb.AppendLine("int main(int argc, char *argv[]) {");
            sb.AppendLine($"  uint64_t time_diff_ms, iterations = {iterations}, structIterations = {structTestIterations};");
            sb.AppendLine("  float latency; int *A = NULL, *B = NULL; float *fpArr = NULL;");
            sb.AppendLine("  uint64_t tmpsink;");

            // print a help message based on tests available
            sb.AppendLine($"  printf(\"Usage: [test name] [latency list size = {latencyListSize}] [struct iterations = {structTestIterations}]\\n\");");
            sb.AppendLine("  if (argc < 2) {");
            sb.AppendLine("    printf(\"List of tests:\\n\");");
            foreach (UarchTest test in tests) sb.AppendLine($"    printf(\"  {test.Prefix} - {test.Description}\\n\");");
            sb.AppendLine("  }");
            sb.AppendLine("  if (argc > 3) { structIterations = atoi(argv[3]); }");
            sb.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"branchtest\", 9) != 0) {");
            GenerateLatencyTestArray(sb);
            sb.AppendLine("  }");
        }

        static void GenerateLatencyTestArray(StringBuilder sb)
        {
            // Fill list to create random access pattern
            sb.AppendLine("  uint32_t list_size = " + latencyListSize + ";");

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

        static void GenerateTestBlock(StringBuilder sb, int[] counts, string prefix, string message)
        {
            sb.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"" + prefix + "\", " + prefix.Length + ") == 0) {");
            sb.AppendLine("  printf(\"" + message + ":\\n\");");
            GenerateTestFunctionCalls(sb, counts, prefix);
            sb.AppendLine("  free(A); free(B); return 0;");
            sb.AppendLine("  }\n");
        }

        static void GenerateFpSchedTestBlock(StringBuilder sb, int[] counts, string prefix, string message)
        {
            sb.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"" + prefix + "\", " + prefix.Length + ") == 0) {");
            sb.AppendLine("  printf(\"" + message + ":\\n\");");
            GenerateFpSchedTestFunctionCalls(sb, counts, prefix);
            sb.AppendLine("  free(A); free(B); return 0;");
            sb.AppendLine("  }\n");
        }

        static void GenerateTestFunctionCalls(StringBuilder sb, int[] counts, string prefix)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + prefix + counts[i] + "(structIterations, A);");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + counts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateFpSchedTestFunctionCalls(StringBuilder sb, int[] counts, string prefix)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + prefix + counts[i] + "(structIterations, A, fpArr);");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + counts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateVsTestBlock(StringBuilder sb, int[] counts, string prefix, string message)
        {
            sb.AppendLine("  if (argc == 1 || argc > 1 && _strnicmp(argv[1], \"" + prefix + "\", " + prefix.Length + ") == 0) {");
            sb.AppendLine("  printf(\"" + message + ":\\n\");");
            GenerateVsTestFunctionCalls(sb, counts, prefix);
            sb.AppendLine("  free(A); free(B); free(fpArr); return 0;");
            sb.AppendLine("  }\n");
        }

        static void GenerateVsTestFunctionCalls(StringBuilder sb, int[] counts, string prefix)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + prefix + counts[i] + "(structIterations, A);");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + counts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateBranchFunctionCalls(StringBuilder sb, int[] branchCounts, int padding)
        {
            sb.AppendLine("  iterations = " + iterations + ";");
            for (int i = 0; i < branchCounts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + GetBranchFuncName(branchCounts[i], padding) + "(" + iterations + "/" + branchCounts[i] + ");");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(iterations);");
                sb.AppendLine("  printf(\"" + branchCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateVSBranchFunctionCalls(StringBuilder sb, int[] branchCounts, int padding)
        {
            sb.AppendLine("  iterations = " + iterations + ";");
            for (int i = 0; i < branchCounts.Length; i++)
            {
                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + GetBranchFuncName(branchCounts[i], padding) + "(" + iterations + "/" + branchCounts[i] + ");");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(iterations);");
                sb.AppendLine("  printf(\"" + branchCounts[i] + ",%f\\n\", latency);\n");
            }
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
