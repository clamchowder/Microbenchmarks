using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

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
            tests.Add(new IndirectBranchTest(8));

            StringBuilder cSourceFile = new StringBuilder();
            StringBuilder vsCSourceFile = new StringBuilder();
            StringBuilder armAsmFile = new StringBuilder();
            StringBuilder x86AsmFile = new StringBuilder();
            StringBuilder x86NasmFile = new StringBuilder();

            string commonFunctions = File.ReadAllText($"{DataFilesDir}\\CommonFunctions.c");

            // Generate C file for linux
            cSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys/time.h>\n#include <stdlib.h>\n#include <string.h>\n#include <time.h>\n");
            cSourceFile.AppendLine("#pragma GCC diagnostic ignored \"-Wattributes\"");
            cSourceFile.AppendLine(commonFunctions);

            foreach (IUarchTest test in tests) test.GenerateExternLines(cSourceFile);

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
            vsCSourceFile.AppendLine(commonFunctions);

            foreach (IUarchTest test in tests) test.GenerateVsExternLines(vsCSourceFile);

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

            x86NasmFile.AppendLine("section .text");
            x86NasmFile.AppendLine("bits 64\n");

            // stupidly parallelize build, since it's taking too long
            List<string> vsFileNames = new List<string>();
            List<string> additionalFileNames = new List<string>();
            string nasmInitStr = x86NasmFile.ToString();
            foreach (IUarchTest test in tests)
            {
                if (test is IUarchTestParallelBuild)
                {
                    IUarchTestParallelBuild parallelBuildTest = test as IUarchTestParallelBuild;
                    List<string> generatedFiles = parallelBuildTest.GenerateNasmFiles();
                    additionalFileNames.AddRange(generatedFiles);
                }
                else
                {
                    StringBuilder nasmFile = new StringBuilder();
                    nasmFile.AppendLine(nasmInitStr);
                    test.GenerateNasmGlobalLines(nasmFile);
                    test.GenerateX86NasmAsm(nasmFile);
                    File.WriteAllText(GetNasmFileName(test.Prefix), nasmFile.ToString());
                    vsFileNames.Add(GetNasmFileName(test.Prefix));
                }
            }

            vsFileNames.AddRange(additionalFileNames);
            UarchTestHelpers.GenerateVsProjectFile(tests, additionalFileNames);
            vsFileNames.Add("clammicrobench.vcxproj");
            vsFileNames.Add("clammicrobench.cpp");
            if (args.Length > 0 && args[0].Equals("autocopy", StringComparison.OrdinalIgnoreCase))
            {
                Console.WriteLine("Automatically copying files, based on default VS paths");
                string clammicrobenchPath = @"..\..\..\..\clammicrobench";
                string[] clammicrobenchFiles = vsFileNames.ToArray();
                CopyFiles(clammicrobenchPath, clammicrobenchFiles);
            }
        }

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

        public static string GetNasmFileName(string testName, bool obj = false) { return $"clammicrobench_nasm_{testName}" + (obj ? ".obj" : ".asm"); }

        static void AddCommonInitCode(StringBuilder sb, List<IUarchTest> tests)
        {
            sb.AppendLine("int main(int argc, char *argv[]) {");
            sb.AppendLine($"  uint64_t time_diff_ms, iterations = {iterations}, structIterations = {structTestIterations}, tmp;");
            sb.AppendLine("  double latency; int *A = NULL, *B = NULL; float *fpArr = NULL;");
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
            sb.AppendLine("  srand(time(NULL));");
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

            sb.AppendLine("#ifdef _WIN32");
            sb.AppendLine("  B = (int*)_aligned_malloc(sizeof(int) * list_size, 64);\n");
            sb.AppendLine("#else");
            sb.AppendLine("  B = (int*)aligned_alloc(64, sizeof(int) * list_size);\n");
            sb.AppendLine("#endif");
            sb.AppendLine("  for (int i = 0; i < list_size; i++) { B[i] = i; }\n");
            sb.AppendLine("  fpArr = (float*)malloc(sizeof(float) * list_size);\n");
            sb.AppendLine("  for (int i = 0;i < list_size; i++) { fpArr[i] = i + .1; }\n");
        }
    }
}
