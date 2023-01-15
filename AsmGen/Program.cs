using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using static System.Net.Mime.MediaTypeNames;

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
            tests.Add(new RobTest(4, 384, 1));

            GenerateCFile(tests, IUarchTest.ISA.amd64);
            GenerateCFile(tests, IUarchTest.ISA.aarch64);
            GenerateCFile(tests, IUarchTest.ISA.mips64);

            GenerateAsmFile(tests, IUarchTest.ISA.amd64);
            GenerateAsmFile(tests, IUarchTest.ISA.aarch64);
            GenerateAsmFile(tests, IUarchTest.ISA.mips64);
        }

        static void GenerateCFile(List<IUarchTest> tests, IUarchTest.ISA isa)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys/time.h>\n#include <stdlib.h>\n#include <string.h>\n#include <time.h>\n");
            sb.AppendLine("#pragma GCC diagnostic ignored \"-Wattributes\"");
            string commonFunctions = File.ReadAllText($"{DataFilesDir}\\CommonFunctions.c");
            sb.AppendLine(commonFunctions);
            foreach (IUarchTest test in tests)
            {
                if (test.SupportsIsa(isa)) test.GenerateExternLines(sb);
            }

            AddCommonInitCode(sb, tests);
            foreach(IUarchTest test in tests)
            {
                if (test.SupportsIsa(isa)) test.GenerateTestBlock(sb, isa);
            }

            AddCommonEndCode(sb);

            File.WriteAllText("clammicrobench_" + isa.ToString() + ".c", sb.ToString());
        }

        static void GenerateAsmFile(List<IUarchTest> tests, IUarchTest.ISA isa)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(".text");
            foreach (IUarchTest test in tests)
            {
                if (test.SupportsIsa(isa))
                {
                    test.GenerateAsmGlobalLines(sb);
                    test.GenerateAsm(sb, isa);
                }
            }
            File.WriteAllText("clammicrobench_" + isa.ToString() + ".s", sb.ToString());
        }

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
            sb.AppendLine("  struct timeval startTv, endTv;");
            sb.AppendLine("  struct timezone startTz, endTz;");
        }


        static void AddCommonEndCode(StringBuilder sb)
        {
            sb.AppendLine("  free(A); free(B); free(fpArr);");
            sb.AppendLine("  return 0; }");
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
