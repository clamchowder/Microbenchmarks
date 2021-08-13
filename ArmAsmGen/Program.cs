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
            int[] branchCounts = new[] { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 1536,
                2048, 3072, 4096, 5120, 6144, 7168, 8192, 10240, 16384, 32768 };

            int robSizeMax = 500;
            int robSizeMin = 8;
            int[] robTestCounts = new int[robSizeMax - robSizeMin + 1];
            for (int i = robSizeMin; i <= robSizeMax; i++)
            {
                robTestCounts[i - robSizeMin] = i;
            }

            int rfSizeMax = 400;
            int rfSizeMin = 8;
            List<int> rfTestCountsList = new List<int>();
            for (int i = rfSizeMin; i < rfSizeMax; i ++)
            {
                rfTestCountsList.Add(i);
            }
            int[] rfTestCounts = rfTestCountsList.ToArray();

            int ldmSizeMax = 128;
            int ldmSizeMin = 2;
            int[] ldmTestCounts = new int[ldmSizeMax - ldmSizeMin + 1];
            for (int i = ldmSizeMin; i <= ldmSizeMax; i++)
            {
                ldmTestCounts[i - ldmSizeMin] = i;
            }

            int ldqSizeMax = 200;
            int ldqSizeMin = 3;
            int[] ldqTestCounts = new int[ldqSizeMax - ldqSizeMin + 1];
            for (int i = ldqSizeMin; i <= ldqSizeMax; i++)
            {
                ldqTestCounts[i - ldqSizeMin] = i;
            }

            /*int branchHistMax = 16;
            int branchHistMin = 1;
            int[] branchHistCounts = new int[branchHistMax - branchHistMin + 1];
            for (int i = branchHistMin; i <= branchHistCounts.Length; i++)
            {
                branchHistCounts[i - branchHistMin] = i;
            }*/
            int[] branchHistCounts = new[] { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 };

            // number of 4B nops to pad. 0, 1, 3 corresponds to jump per 4B, 8B, 16B
            int[] paddings = new[] { 0, 1, 3 };
            StringBuilder cSourceFile = new StringBuilder();
            StringBuilder vsCSourceFile = new StringBuilder();
            StringBuilder armAsmFile = new StringBuilder();
            StringBuilder x86AsmFile = new StringBuilder();
            StringBuilder x86NasmFile = new StringBuilder();

            StringBuilder x86branchHistFile = new StringBuilder();
            StringBuilder branchHistHeaderFile = new StringBuilder();

            // Generate C file for linux
            cSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys/time.h>\n#include <stdlib.h>\n#include <string.h>\n");
            GenerateFunctionDeclarations(cSourceFile, branchCounts, paddings, robTestCounts, rfTestCounts, ldmTestCounts, ldqTestCounts);
            AddCommonInitCode(cSourceFile);
            cSourceFile.AppendLine("  struct timeval startTv, endTv;");
            cSourceFile.AppendLine("  struct timezone startTz, endTz;");

            GenerateTestBlock(cSourceFile, robTestCounts, robPrefix, "Testing ROB capacity");
            GenerateTestBlock(cSourceFile, rfTestCounts, prfPrefix, "Testing integer register file capacity");
            GenerateTestBlock(cSourceFile, rfTestCounts, frfPrefix, "Testing FP/SIMD register file capacity");
            GenerateTestBlock(cSourceFile, ldmTestCounts, ldmPrefix, "Testing adds dependent on load result (ALU scheduler capacity?)");
            GenerateTestBlock(cSourceFile, ldqTestCounts, ldqPrefix, "Testing load queue capacity");
            GenerateTestBlock(cSourceFile, ldmTestCounts, mulSchedPrefix, "Testing integer (multiply) scheduler capacity");
            GenerateTestBlock(cSourceFile, ldmTestCounts, mul16SchedPrefix, "Testing integer (16-bit multiply) scheduler capacity");
            GenerateTestBlock(cSourceFile, ldmTestCounts, rorSchedPrefix, "Testing integer (rotate right) scheduler capacity");
            GenerateTestBlock(cSourceFile, ldmTestCounts, cvtSchedPrefix, "Testing FP (convert int to FP) scheduler capacity");

            // store queue requires a sink
            cSourceFile.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"stq\", 3) == 0) {");
            cSourceFile.AppendLine("  printf(\"Testing STQ Capacity:\\n\");");
            GenerateStqTestFunctionCalls(cSourceFile, ldqTestCounts);
            cSourceFile.AppendLine("  free(A); free(B); return 0;");
            cSourceFile.AppendLine("  }\n");

            // store/load queue also requires a sink
            cSourceFile.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"mixldqstq\", 9) == 0) {");
            cSourceFile.AppendLine("  printf(\"Testing mixed LDQ+STQ Capacity:\\n\");");
            GenerateLdqStqTestFunctionCalls(cSourceFile, ldqTestCounts);
            cSourceFile.AppendLine("  free(A); free(B); return 0;");
            cSourceFile.AppendLine("  }\n");

            // mem sched test requires second array
            cSourceFile.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"memsched\", 8) == 0) {");
            cSourceFile.AppendLine("  printf(\"Testing Mem Scheduler Capacity:\\n\");");
            GenerateMemSchedTestFunctionCalls(cSourceFile, ldmTestCounts);
            cSourceFile.AppendLine("  free(A); free(B); return 0;");
            cSourceFile.AppendLine("  }\n");

            // same with store scheduler test
            cSourceFile.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"storesched\", 10) == 0) {");
            cSourceFile.AppendLine("  printf(\"Testing Store Scheduler Capacity:\\n\");");
            GenerateStoreSchedTestFunctionCalls(cSourceFile, ldmTestCounts);
            cSourceFile.AppendLine("  free(A); free(B); return 0;");
            cSourceFile.AppendLine("  }\n");

            cSourceFile.AppendLine("  free(A);");

            cSourceFile.AppendLine("  printf(\"Branch Per 16B:\\n\");");
            GenerateBranchFunctionCalls(cSourceFile, branchCounts, paddings[2]);
            cSourceFile.AppendLine("  printf(\"Branch Per 8B:\\n\");");
            GenerateBranchFunctionCalls(cSourceFile, branchCounts, paddings[1]);
            cSourceFile.AppendLine("  printf(\"Branch Per 4B:\\n\");");
            GenerateBranchFunctionCalls(cSourceFile, branchCounts, paddings[0]);
            cSourceFile.AppendLine("  return 0; }");
            File.WriteAllText("clammicrobench.c", cSourceFile.ToString());

            // Generate C file for VS
            vsCSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys\\timeb.h>\n#include <stdlib.h>\n");
            vsCSourceFile.AppendLine("#include <string.h>\n");
            GenerateVsFunctionDeclarations(vsCSourceFile, branchCounts, paddings, robTestCounts, rfTestCounts, ldmTestCounts, ldqTestCounts);
            AddCommonInitCode(vsCSourceFile);
            vsCSourceFile.AppendLine("  struct timeb start, end;");

            // ROB size test
            GenerateVsTestBlock(vsCSourceFile, robTestCounts, robPrefix, "Testing ROB capacity");
            GenerateVsTestBlock(vsCSourceFile, rfTestCounts, prfPrefix, "Testing integer register file capacity");
            GenerateVsTestBlock(vsCSourceFile, rfTestCounts, frfPrefix, "Testing FP/SIMD register file capacity");
            GenerateVsTestBlock(vsCSourceFile, ldmTestCounts, ldmPrefix, "Testing adds dependent on load result (ALU scheduler capacity?)");
            GenerateVsTestBlock(vsCSourceFile, ldqTestCounts, ldqPrefix, "Testing load queue capacity");
            GenerateVsTestBlock(vsCSourceFile, ldmTestCounts, mulSchedPrefix, "Testing integer scheduler capacity");

            vsCSourceFile.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"stq\", 3) == 0) {");
            vsCSourceFile.AppendLine("  printf(\"Testing STQ Capacity:\\n\");");
            GenerateVSStqFunctionCalls(vsCSourceFile, ldqTestCounts);
            vsCSourceFile.AppendLine("  return 0;");
            vsCSourceFile.AppendLine("  }\n");

            vsCSourceFile.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"memsched\", 8) == 0) {");
            vsCSourceFile.AppendLine("  printf(\"Testing Mem Scheduler Capacity:\\n\");");
            GenerateVSMemSchedFunctionCalls(vsCSourceFile, ldmTestCounts);
            vsCSourceFile.AppendLine("  return 0;");
            vsCSourceFile.AppendLine("  }\n");

            // after structure size tests we don't care about this array
            vsCSourceFile.AppendLine("  free(A); free(B);");

            // BTB size test
            vsCSourceFile.AppendLine("  printf(\"Branch Per 16B:\\n\");");
            GenerateVSBranchFunctionCalls(vsCSourceFile, branchCounts, paddings[2]);
            vsCSourceFile.AppendLine("  printf(\"Branch Per 8B:\\n\");");
            GenerateVSBranchFunctionCalls(vsCSourceFile, branchCounts, paddings[1]);
            vsCSourceFile.AppendLine("  printf(\"Branch Per 4B:\\n\");");
            GenerateVSBranchFunctionCalls(vsCSourceFile, branchCounts, paddings[2]);
            vsCSourceFile.AppendLine("  return 0; }");
            File.WriteAllText("clammicrobench.cpp", vsCSourceFile.ToString());

            armAsmFile.AppendLine(".arch armv8-a\n.text\n");
            GenerateAsmGlobalLines(armAsmFile, branchCounts, paddings, robTestCounts, rfTestCounts, ldmTestCounts, ldqTestCounts);
            ARM.GenerateArmAsmRobFuncs(armAsmFile, robTestCounts);
            ARM.GenerateArmAsmPrfFuncs(armAsmFile, rfTestCounts);
            ARM.GenerateArmAsmFrfFuncs(armAsmFile, rfTestCounts);
            ARM.GenerateArmAsmLdmFuncs(armAsmFile, ldmTestCounts);
            ARM.GenerateArmAsmLdqFuncs(armAsmFile, ldqTestCounts);
            ARM.GenerateArmAsmStqFuncs(armAsmFile, ldqTestCounts);
            ARM.GenerateArmAsmIntSchedFuncs(armAsmFile, ldmTestCounts);
            ARM.GenerateArmAsmMemSchedFuncs(armAsmFile, ldmTestCounts);
            ARM.GenerateArmAsmBranchFuncs(armAsmFile, branchCounts, paddings);
            File.WriteAllText("clammicrobench_arm.s", armAsmFile.ToString());

            x86AsmFile.AppendLine(".text\n");
            GenerateAsmGlobalLines(x86AsmFile, branchCounts, paddings, robTestCounts, rfTestCounts, ldmTestCounts, ldqTestCounts);
            x86.GenerateX86AsmRobFuncs(x86AsmFile, robTestCounts);
            x86.GenerateX86AsmPrfFuncs(x86AsmFile, rfTestCounts);
            x86.GenerateX86AsmFrfFuncs(x86AsmFile, rfTestCounts);
            x86.GenerateX86AsmLdmFuncs(x86AsmFile, ldmTestCounts);
            x86.GenerateX86AsmLdqFuncs(x86AsmFile, ldqTestCounts);
            x86.GenerateX86AsmStqFuncs(x86AsmFile, ldqTestCounts);
            x86.GenerateX86AsmLdqStqFuncs(x86AsmFile, ldqTestCounts);
            x86.GenerateX86AsmMulSchedFuncs(x86AsmFile, ldmTestCounts);
            x86.GenerateX86AsmMemSchedFuncs(x86AsmFile, ldmTestCounts);
            x86.GenerateX86AsmMul16SchedFuncs(x86AsmFile, ldmTestCounts);
            x86.GenerateX86AsmRorSchedFuncs(x86AsmFile, ldmTestCounts);
            x86.GenerateX86AsmCvtSchedFuncs(x86AsmFile, ldmTestCounts);
            x86.GenerateX86AsmStoreSchedFuncs(x86AsmFile, ldmTestCounts);
            x86.GenerateX86AsmBranchFuncs(x86AsmFile, branchCounts, paddings);
            File.WriteAllText("clammicrobench_x86.s", x86AsmFile.ToString());

            x86NasmFile.AppendLine("section .text\n");
            x86NasmFile.AppendLine("bits 64\n\n");
            x86NasmFile.AppendLine("%define nop2 db 0x66, 0x90\n");
            x86NasmFile.AppendLine("%define nop4 db 0x0F, 0x1F, 0x40, 0x00\n");
            x86NasmFile.AppendLine("%define nop12 db 0x66, 0x66, 0x66, 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n\n");
            x86Nasm.GenerateGlobalLines(x86NasmFile, branchCounts, paddings, robTestCounts, rfTestCounts, ldmTestCounts, ldqTestCounts);
            x86Nasm.GenerateX86NasmRobFuncs(x86NasmFile, robTestCounts);
            x86Nasm.GenerateX86NasmPrfFuncs(x86NasmFile, rfTestCounts);
            x86Nasm.GenerateX86NasmFrfFuncs(x86NasmFile, rfTestCounts);
            x86Nasm.GenerateX86NasmLdmFuncs(x86NasmFile, ldmTestCounts);
            x86Nasm.GenerateX86NasmStqFuncs(x86NasmFile, ldqTestCounts);
            x86Nasm.GenerateX86NasmLdqFuncs(x86NasmFile, ldqTestCounts);
            x86Nasm.GenerateX86NasmIntSchedFuncs(x86NasmFile, ldmTestCounts);
            x86Nasm.GenerateX86NasmMemSchedFuncs(x86NasmFile, ldmTestCounts);
            x86Nasm.GenerateX86NasmBranchFuncs(x86NasmFile, branchCounts, paddings);
            File.WriteAllText("clammicrobench_nasm.asm", x86NasmFile.ToString());

            GenerateBranchHistHeader(branchHistHeaderFile, branchHistCounts);
            File.WriteAllText("branchhist.h", branchHistHeaderFile.ToString());
            x86.GenerateX86AsmBranchHistFuncs(x86branchHistFile, branchHistCounts);
            File.WriteAllText("branchhist_x86.s", x86branchHistFile.ToString());

            if (args.Length > 0 && args[0].Equals("autocopy", StringComparison.OrdinalIgnoreCase))
            {
                Console.WriteLine("Automatically copying files, based on default VS paths");
                string clammicrobenchPath = @"..\..\..\..\clammicrobench";
                string[] clammicrobenchFiles = new[] { "clammicrobench_nasm.asm", "clammicrobench.cpp" };
                CopyFiles(clammicrobenchPath, clammicrobenchFiles);

                string branchhistPath = @"..\..\..\..\BranchHistoryLength";
                string[] branchhistFiles = new[] { "branchhist.h", "branchhist_x86.s" };
                CopyFiles(branchhistPath, branchhistFiles);
            }
        }

        public static string GetBranchFuncName(int branchCount, int padding) { return "branch" + branchCount + "pad" + padding; }
        public static string GetLabelName(string funcName, int part) { return funcName + "part" + part; }

        public const string ldqPrefix = "ldq";
        public const string stqPrefix = "stq";
        public const string ldqStqPrefix = "mixldqstq";
        public const string prfPrefix = "prf";
        public const string frfPrefix = "frf";
        public const string ldmPrefix = "ldm";
        public const string robPrefix = "rob";
        public const string mulSchedPrefix = "mulsched"; // specifically for VIA Nano because it goes to MA
        public const string memSchedPrefix = "memsched";
        public const string storeSchedPrefix = "storesched";
        public const string mul16SchedPrefix = "mul16sched"; // specifically for VIA because it goes to I2
        public const string rorSchedPrefix = "rorsched"; // specifically for VIA Nano because it goes to I1
        public const string cvtSchedPrefix = "cvtsched"; // specifically for VIA Nano because it goes to MB
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


        static void AddCommonInitCode(StringBuilder sb)
        {
            sb.AppendLine("int main(int argc, char *argv[]) {");
            sb.AppendLine($"  uint64_t time_diff_ms, iterations = {iterations}, structIterations = {structTestIterations};");
            sb.AppendLine("  float latency; int *A = NULL, *B = NULL;");
            sb.AppendLine("  uint64_t tmpsink;");
            sb.AppendLine($"  printf(\"Usage: [rob/prf/frf/ldm/ldq/stq/mulsched/memsched/branch] [latency list size] [struct iterations = {structTestIterations}]\\n\");");
            sb.AppendLine("  if (argc > 3) { structIterations = atoi(argv[3]); }");
            sb.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"branchtest\", 9) != 0) {");
            GenerateLatencyTestArray(sb);
            sb.AppendLine("  }");
        }

        static void GenerateTestBlock(StringBuilder sb, int[] counts, string prefix, string message)
        {
            sb.AppendLine("  if (argc == 1 || argc > 1 && strncmp(argv[1], \"" + prefix + "\", " + prefix.Length + ") == 0) {");
            sb.AppendLine("  printf(\"" + message + ":\\n\");");
            GenerateTestFunctionCalls(sb, counts, prefix);
            sb.AppendLine("  free(A); free(B); return 0;");
            sb.AppendLine("  }\n");
        }

        static void GenerateFunctionDeclarations(StringBuilder sb, int[] branchCounts, int[] paddings, int[] robTestCounts, int[] rfCounts, int[] ldmCounts, int[] ldqCounts)
        {
            for (int i = 0; i < branchCounts.Length; i++)
                for (int p = 0; p < paddings.Length; p++)
                    sb.AppendLine("extern uint64_t " + GetBranchFuncName(branchCounts[i], paddings[p]) + "(uint64_t iterations);");

            for (int i = 0; i < robTestCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + robPrefix + robTestCounts[i] + "(uint64_t iterations, int *arr);"); ;

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + prfPrefix + rfCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + frfPrefix + rfCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + ldmPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + mulSchedPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + memSchedPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr, int *arr2);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + rorSchedPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + mul16SchedPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + cvtSchedPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + storeSchedPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr, int *arr2);");

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + ldqPrefix + ldqCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + stqPrefix + ldqCounts[i] + "(uint64_t iterations, int *arr, uint64_t *sink);");

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + ldqStqPrefix + ldqCounts[i] + "(uint64_t iterations, int *arr, uint64_t *sink);");
        }

        static void GenerateVsFunctionDeclarations(StringBuilder sb, int[] branchCounts, int[] paddings, int[] robTestCounts, int[] rfCounts, int[] ldmCounts, int[] ldqCounts)
        {
            // extern "C" uint64_t testfunc(uint64_t iterations);
            for (int i = 0; i < branchCounts.Length; i++)
                for (int p = 0; p < paddings.Length; p++)
                    sb.AppendLine("extern \"C\" uint64_t " + GetBranchFuncName(branchCounts[i], paddings[p]) + "(uint64_t iterations);");

            for (int i = 0; i < robTestCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + robPrefix + robTestCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + prfPrefix + rfCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + frfPrefix + rfCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + ldmPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + mulSchedPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + memSchedPrefix + ldmCounts[i] + "(uint64_t iterations, int *arr, int *arr2);");

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + ldqPrefix + ldqCounts[i] + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + stqPrefix + ldqCounts[i] + "(uint64_t iterations, int *arr, uint64_t *sink);");
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

        static void GenerateMemSchedTestFunctionCalls(StringBuilder sb, int[] schedTestCounts)
        {
            for (int i = 0; i < schedTestCounts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + memSchedPrefix + schedTestCounts[i] + "(structIterations, A, B);");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + schedTestCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateStoreSchedTestFunctionCalls(StringBuilder sb, int[] schedTestCounts)
        {
            for (int i = 0; i < schedTestCounts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + storeSchedPrefix + schedTestCounts[i] + "(structIterations, A, B);");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + schedTestCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateStqTestFunctionCalls(StringBuilder sb, int[] ldqTestCounts)
        {
            for (int i = 0; i < ldqTestCounts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + stqPrefix + ldqTestCounts[i] + "(structIterations, A, &tmpsink);");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + ldqTestCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateLdqStqTestFunctionCalls(StringBuilder sb, int[] ldqTestCounts)
        {
            for (int i = 0; i < ldqTestCounts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + ldqStqPrefix + ldqTestCounts[i] + "(structIterations, A, &tmpsink);");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + ldqTestCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateVsTestBlock(StringBuilder sb, int[] counts, string prefix, string message)
        {
            sb.AppendLine("  if (argc == 1 || argc > 1 && _strnicmp(argv[1], \"" + prefix + "\", " + prefix.Length + ") == 0) {");
            sb.AppendLine("  printf(\"" + message + ":\\n\");");
            GenerateVsTestFunctionCalls(sb, counts, prefix);
            sb.AppendLine("  free(A); free(B); return 0;");
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

        static void GenerateVSMemSchedFunctionCalls(StringBuilder sb, int[] schedCounts)
        {
            for (int i = 0; i < schedCounts.Length; i++)
            {
                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + memSchedPrefix + schedCounts[i] + "(structIterations, A, B);");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + schedCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateVSStqFunctionCalls(StringBuilder sb, int[] stqCounts)
        {
            for (int i = 0; i < stqCounts.Length; i++)
            {
                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + stqPrefix + stqCounts[i] + "(structIterations, A, &tmpsink);");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + stqCounts[i] + ",%f\\n\", latency);\n");
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

        static void GenerateAsmGlobalLines(StringBuilder sb, int[] branchCounts, int[] paddings, int[] robCounts, int[] rfCounts, int[] ldmCounts, int[] ldqCounts)
        {
            for (int i = 0; i < robCounts.Length; i++)
                sb.AppendLine(".global " + robPrefix + robCounts[i]);

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine(".global " + prfPrefix + rfCounts[i]);

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine(".global " + frfPrefix + rfCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine(".global " + ldmPrefix + ldmCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine(".global " + mulSchedPrefix + ldmCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine(".global " + mul16SchedPrefix + ldmCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine(".global " + rorSchedPrefix + ldmCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine(".global " + memSchedPrefix + ldmCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine(".global " + cvtSchedPrefix + ldmCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine(".global " + storeSchedPrefix + ldmCounts[i]);

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine(".global " + ldqPrefix + ldqCounts[i]);

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine(".global " + stqPrefix + ldqCounts[i]);

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine(".global " + ldqStqPrefix + ldqCounts[i]);

            for (int i = 0; i < branchCounts.Length; i++)
                for (int p = 0; p < paddings.Length; p++)
                    sb.AppendLine(".global " + GetBranchFuncName(branchCounts[i], paddings[p]));
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
