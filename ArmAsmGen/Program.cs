using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace ArmAsmGen
{
    class Program
    {
        static int iterations = 1000000000 / 2;

        static void Main(string[] args)
        {
            int[] branchCounts = new[] { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 1536,
                2048, 3072, 4096, 5120, 6144, 7168, 8192, 10240, 16384, 32768 };
            /*int[] robTestCounts = new[] { 4, 8, 16, 24, 32, 48, 64, 72, 80, 96, 100, 112, 128, 140, 160, 192, 200, 
                220, 224, 225, 230, 256, 300, 324, 356, 384, 512, 768 };*/

            int robSizeMax = 768;
            int robSizeMin = 4;
            int[] robTestCounts = new int[robSizeMax - robSizeMin + 1];
            for (int i = robSizeMin; i < robSizeMax; i++)
            {
                robTestCounts[i - robSizeMin] = i;
            }

            int rfSizeMax = 512;
            int rfSizeMin = 4;
            List<int> rfTestCountsList = new List<int>();
            for (int i = rfSizeMin; i < rfSizeMax; i += 4)
            {
                rfTestCountsList.Add(i);
            }

            int[] rfTestCounts = rfTestCountsList.ToArray();

            // number of 4B nops to pad. 0, 1, 3 corresponds to jump per 4B, 8B, 16B
            int[] paddings = new[] { 0, 1, 3 };
            StringBuilder cSourceFile = new StringBuilder();
            StringBuilder vsCSourceFile = new StringBuilder();
            StringBuilder armAsmFile = new StringBuilder();
            StringBuilder x86AsmFile = new StringBuilder();
            StringBuilder x86NasmFile = new StringBuilder();

            // Generate C file for linux
            cSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys/time.h>\n#include <stdlib.h>\n");
            GenerateFunctionDeclarations(cSourceFile, branchCounts, paddings, robTestCounts, rfTestCounts);
            cSourceFile.AppendLine("int main(int argc, char *argv[]) {");
            cSourceFile.AppendLine("  struct timeval startTv, endTv;");
            cSourceFile.AppendLine("  struct timezone startTz, endTz;");
            cSourceFile.AppendLine("  uint64_t time_diff_ms, iterations = " + iterations + ";");
            cSourceFile.AppendLine("  float latency;");
            GenerateLatencyTestArray(cSourceFile);

            // linux string lib doesn't support safe (counted) comparisons
            cSourceFile.AppendLine("  if (argc == 1 || argc > 1 && strcmp(argv[1], \"rob\") == 0) {");
            cSourceFile.AppendLine("  printf(\"Testing ROB Capacity:\\n\");");
            GenerateRobTestFunctionCalls(cSourceFile, robTestCounts);
            cSourceFile.AppendLine("  }\n");

            cSourceFile.AppendLine("  if (argc == 1 || argc > 1 && strcmp(argv[1], \"prf\") == 0) {");
            cSourceFile.AppendLine("  printf(\"Testing Register File Capacity:\\n\");");
            GeneratePrfTestFunctionCalls(cSourceFile, rfTestCounts);
            cSourceFile.AppendLine("  }\n");

            cSourceFile.AppendLine("  printf(\"Branch Per 16B:\\n\");");
            GenerateFunctionCalls(cSourceFile, branchCounts, paddings[2]);
            cSourceFile.AppendLine("  printf(\"Branch Per 8B:\\n\");");
            GenerateFunctionCalls(cSourceFile, branchCounts, paddings[1]);
            cSourceFile.AppendLine("  printf(\"Branch Per 4B:\\n\");");
            GenerateFunctionCalls(cSourceFile, branchCounts, paddings[0]);
            cSourceFile.AppendLine("  return 0; }");
            File.WriteAllText("branchtest.c", cSourceFile.ToString());

            // Generate C file for VS
            vsCSourceFile.AppendLine("#include <stdio.h>\n#include<stdint.h>\n#include<sys\\timeb.h>\n#include <stdlib.h>\n");
            vsCSourceFile.AppendLine("#include <string.h>\n");
            GenerateVsFunctionDeclarations(vsCSourceFile, branchCounts, paddings, robTestCounts, rfTestCounts);
            vsCSourceFile.AppendLine("int main(int argc, char *argv[]) {");
            vsCSourceFile.AppendLine("  struct timeb start, end;");
            vsCSourceFile.AppendLine("  uint64_t time_diff_ms, iterations = " + iterations + ";");
            vsCSourceFile.AppendLine("  float latency;");
            GenerateLatencyTestArray(vsCSourceFile);

            // ROB size test
            vsCSourceFile.AppendLine("  if (argc == 1 || argc > 1 && _strnicmp(argv[1], \"rob\", 3) == 0) {");
            vsCSourceFile.AppendLine("  printf(\"Testing ROB Capacity:\\n\");");
            GenerateVSRobTestFunctionCalls(vsCSourceFile, robTestCounts);
            vsCSourceFile.AppendLine("  }\n");

            // PRF size test
            vsCSourceFile.AppendLine("  if (argc == 1 || argc > 1 && _strnicmp(argv[1], \"prf\", 3) == 0) {");
            vsCSourceFile.AppendLine("  printf(\"Testing Register File Capacity:\\n\");");
            GenerateVSPrfTestFunctionCalls(vsCSourceFile, rfTestCounts);
            vsCSourceFile.AppendLine("  }\n");

            // BTB size test
            vsCSourceFile.AppendLine("  printf(\"Branch Per 16B:\\n\");");
            GenerateVSFunctionCalls(vsCSourceFile, branchCounts, paddings[2]);
            vsCSourceFile.AppendLine("  printf(\"Branch Per 8B:\\n\");");
            GenerateVSFunctionCalls(vsCSourceFile, branchCounts, paddings[1]);
            vsCSourceFile.AppendLine("  printf(\"Branch Per 4B:\\n\");");
            GenerateVSFunctionCalls(vsCSourceFile, branchCounts, paddings[2]);
            vsCSourceFile.AppendLine("  return 0; }");
            File.WriteAllText("vsbranchtest.c", vsCSourceFile.ToString());

            armAsmFile.AppendLine(".arch armv8-a\n.text\n");
            GenerateAsmGlobalLines(armAsmFile, branchCounts, paddings, robTestCounts, rfTestCounts);
            GenerateAsmPrfFuncs(armAsmFile, rfTestCounts);
            GenerateAsmRobFuncs(armAsmFile, robTestCounts);
            GenerateAsmFuncs(armAsmFile, branchCounts, paddings);
            File.WriteAllText("branchtest_arm.s", armAsmFile.ToString());

            x86AsmFile.AppendLine(".text\n");
            GenerateAsmGlobalLines(x86AsmFile, branchCounts, paddings, robTestCounts, rfTestCounts);
            GenerateX86AsmRobFuncs(x86AsmFile, robTestCounts);
            GenerateX86AsmFuncs(x86AsmFile, branchCounts, paddings);
            File.WriteAllText("branchtest_x86.s", x86AsmFile.ToString());

            x86NasmFile.AppendLine("section .text\n");
            x86NasmFile.AppendLine("bits 64\n\n");
            x86NasmFile.AppendLine("%define nop2 db 0x66, 0x90\n");
            x86NasmFile.AppendLine("%define nop4 db 0x0F, 0x1F, 0x40, 0x00\n");
            x86NasmFile.AppendLine("%define nop12 db 0x66, 0x66, 0x66, 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n\n");
            GenerateNasmGlobalLines(x86NasmFile, branchCounts, paddings, robTestCounts, rfTestCounts);
            GenerateX86NasmRobFuncs(x86NasmFile, robTestCounts);
            GenerateX86NasmPrfFuncs(x86NasmFile, rfTestCounts);
            GenerateX86NasmFuncs(x86NasmFile, branchCounts, paddings);
            File.WriteAllText("branchtest_nasm.asm", x86NasmFile.ToString());
        }

        static string GetFuncName(int branchCount, int padding)
        {
            return "branch" + branchCount + "pad" + padding;
        }

        static string GetRobFuncName(int count) { return "rob" + count; }
        static string GetPrfFuncName(int count) { return "prf" + count; }

        static string GetLabelName(string funcName, int part)
        {
            return funcName + "part" + part;
        }

        static void GenerateFunctionDeclarations(StringBuilder sb, int[] branchCounts, int[] paddings, int[] robTestCounts, int[] rfCounts)
        {
            for (int i = 0; i < branchCounts.Length; i++)
                for (int p = 0; p < paddings.Length; p++)
                    sb.AppendLine("extern uint64_t " + GetFuncName(branchCounts[i], paddings[p]) + "(uint64_t iterations);");

            for (int i = 0; i < robTestCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + GetRobFuncName(robTestCounts[i]) + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + GetPrfFuncName(rfCounts[i]) + "(uint64_t iterations, int *arr);");
        }

        static void GenerateVsFunctionDeclarations(StringBuilder sb, int[] branchCounts, int[] paddings, int[] robTestCounts, int[] rfCounts)
        {
            // extern "C" uint64_t testfunc(uint64_t iterations);
            for (int i = 0; i < branchCounts.Length; i++)
                for (int p = 0; p < paddings.Length; p++)
                    sb.AppendLine("extern \"C\" uint64_t " + GetFuncName(branchCounts[i], paddings[p]) + "(uint64_t iterations);");

            for (int i = 0; i < robTestCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + GetRobFuncName(robTestCounts[i]) + "(uint64_t iterations, int *arr);");

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + GetPrfFuncName(rfCounts[i]) + "(uint64_t iterations, int *arr);");
        }

        static void GenerateLatencyTestArray(StringBuilder sb)
        {
            int list_size = 131072 * 1024 / 4; // 128 MB
                                               // Fill list to create random access pattern
            sb.AppendLine("  uint32_t list_size = " + list_size + ";");

            sb.AppendLine("  if (argc > 2) list_size = atoi(argv[2]);");

            sb.AppendLine("  int* A = (int*)malloc(sizeof(int) * list_size);");
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
        }

        static void GenerateRobTestFunctionCalls(StringBuilder sb, int[] robTestCounts)
        {
            for (int i = 0; i < robTestCounts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + GetRobFuncName(robTestCounts[i]) + "(iterations / 40, A);");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(iterations / 40);");
                sb.AppendLine("  printf(\"" + robTestCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GeneratePrfTestFunctionCalls(StringBuilder sb, int[] rfTestCounts)
        {
            for (int i = 0; i < rfTestCounts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + GetPrfFuncName(rfTestCounts[i]) + "(iterations / 40, A);");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(iterations / 40);");
                sb.AppendLine("  printf(\"" + rfTestCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateVSPrfTestFunctionCalls(StringBuilder sb, int[] rfTestCounts)
        {
            for (int i = 0; i < rfTestCounts.Length; i++)
            {
                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + GetPrfFuncName(rfTestCounts[i]) + "(iterations / 40, A);");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(iterations / 40);");
                sb.AppendLine("  printf(\"" + rfTestCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateVSRobTestFunctionCalls(StringBuilder sb, int[] robTestCounts)
        {
            for (int i = 0; i < robTestCounts.Length; i++)
            {
                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + GetRobFuncName(robTestCounts[i]) + "(iterations / 40, A);");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(iterations / 40);");
                sb.AppendLine("  printf(\"" + robTestCounts[i] + ",%f\\n\", latency);\n");
            }
        }

        static void GenerateFunctionCalls(StringBuilder sb, int[] branchCounts, int padding)
        {
            sb.AppendLine("  iterations = " + iterations + ";");
            for (int i = 0; i < branchCounts.Length; i++)
            {
                sb.AppendLine("  gettimeofday(&startTv, &startTz);");
                sb.AppendLine("  " + GetFuncName(branchCounts[i], padding) + "(" + iterations + "/" + branchCounts[i] + ");");
                sb.AppendLine("  gettimeofday(&endTv, &endTz);");
                sb.AppendLine("  time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(iterations);");
                sb.AppendLine("  printf(\"" + branchCounts[i] + ",%f\\n\", latency);\n");
                //sb.AppendLine("  if (time_diff_ms > 10000) iterations /= 10;");
            }
        }

        static void GenerateVSFunctionCalls(StringBuilder sb, int[] branchCounts, int padding)
        {
            sb.AppendLine("  iterations = " + iterations + ";");
            for (int i = 0; i < branchCounts.Length; i++)
            {
                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + GetFuncName(branchCounts[i], padding) + "(" + iterations + "/" + branchCounts[i] + ");");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                sb.AppendLine("  latency = 1e6 * (float)time_diff_ms / (float)(iterations);");
                sb.AppendLine("  printf(\"" + branchCounts[i] + ",%f\\n\", latency);\n");
                //sb.AppendLine("  if (time_diff_ms > 10000) iterations /= 10;");
            }
        }

        static void GenerateAsmGlobalLines(StringBuilder sb, int[] branchCounts, int[] paddings, int[] robCounts, int[] rfCounts)
        {
            for (int i = 0; i < robCounts.Length; i++)
                sb.AppendLine(".global " + GetRobFuncName(robCounts[i]));

            for (int i = 0; i < rfCounts.Length; i++)
                sb.AppendLine(".global " + GetPrfFuncName(rfCounts[i]));

            for (int i = 0; i < branchCounts.Length; i++)
                for (int p = 0; p < paddings.Length; p++)
                    sb.AppendLine(".global " + GetFuncName(branchCounts[i], paddings[p]));
        }

        static void GenerateNasmGlobalLines(StringBuilder sb, int[] branchCounts, int[] paddings, int[] robCounts, int[] prfCounts)
        {
            for (int i = 0; i < prfCounts.Length; i++)
                sb.AppendLine("global " + GetPrfFuncName(prfCounts[i]));

            for (int i = 0; i < robCounts.Length; i++)
                sb.AppendLine("global " + GetRobFuncName(robCounts[i]));

            for (int i = 0; i < branchCounts.Length; i++)
                for (int p = 0; p < paddings.Length; p++)
                    sb.AppendLine("global " + GetFuncName(branchCounts[i], paddings[p]));
        }

        static void GenerateAsmPrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = GetPrfFuncName(rfCounts[i]);

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  stp x29, x30, [sp]");
                sb.AppendLine("  stp x27, x28, [sp, #0x10]");
                sb.AppendLine("  mov w2, #0x0");
                sb.AppendLine("  mov w3, #0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w2, [x1, w2, uxtw #2]"); // current = A[current]
                for (int nopIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx += 4)
                {
                    sb.AppendLine("  add x30, x30, 1");
                    sb.AppendLine("  add x29, x29, 2");
                    sb.AppendLine("  add x28, x28, 3");
                    sb.AppendLine("  add x27, x27, 4");
                }

                sb.AppendLine("  ldr w3, [x1, w3, uxtw #2]");

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x27, x28, [sp, #0x10]");
                sb.AppendLine("  ldp x29, x30, [sp]");
                sb.AppendLine("  ret\n\n");
            }
        }

        static void GenerateAsmRobFuncs(StringBuilder sb, int[] robCounts)
        {
            for (int i = 0; i < robCounts.Length; i++)
            {
                string funcName = GetRobFuncName(robCounts[i]);

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  mov w2, #0x0");
                sb.AppendLine("  mov w3, #0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w2, [x1, w2, uxtw #2]"); // current = A[current]
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  ldr w3, [x1, w3, uxtw #2]");

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ret\n\n");
            }
        }

        static void GenerateAsmFuncs(StringBuilder sb, int[] branchCounts, int[] paddings)
        {
            for (int p = 0; p < paddings.Length; p++)
                for (int i = 0; i < branchCounts.Length; i++)
                {
                    string funcName = GetFuncName(branchCounts[i], paddings[p]);
                    //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                    sb.AppendLine(funcName + ":");
                    for (int branchIdx = 1; branchIdx < branchCounts[i]; branchIdx++)
                    {
                        string labelName = GetLabelName(funcName, branchIdx);
                        sb.AppendLine("  b " + labelName);
                        for (int paddingIdx = 0; paddingIdx < paddings[p]; paddingIdx++)
                            sb.AppendLine("  nop");
                        sb.AppendLine(labelName + ":");
                    }
                    
                    sb.AppendLine("  sub x0, x0, 1");
                    sb.AppendLine("  cbnz x0, " + funcName);
                    sb.AppendLine("  ret\n\n");
                }
        }

        static void GenerateX86AsmRobFuncs(StringBuilder sb, int[] robCounts)
        {
            for (int i = 0; i < robCounts.Length; i++)
            {
                // args in rdi, rsi, rdx, rcx
                string funcName = GetRobFuncName(robCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rdx");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  mov %rsi, %rdx");
                sb.AppendLine("  mov %rdi, %rcx");
                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        static void GenerateX86AsmFuncs(StringBuilder sb, int[] branchCounts, int[] paddings)
        {
            string paddingAlign = "";
            for (int p = 0; p < paddings.Length; p++)
            {
                if (paddings[p] == 1) paddingAlign = "  .align 8";
                else if (paddings[p] == 3) paddingAlign = "  .align 16";
                else if (paddings[p] != 0)
                {
                    Console.WriteLine($"Unsupported padding value {paddings[p]}");
                    continue;
                }

                for (int i = 0; i < branchCounts.Length; i++)
                {
                    string funcName = GetFuncName(branchCounts[i], paddings[p]);
                    //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                    sb.AppendLine(funcName + ":\n");
                    for (int branchIdx = 1; branchIdx < branchCounts[i]; branchIdx++)
                    {
                        string labelName = GetLabelName(funcName, branchIdx);
                        sb.AppendLine("  jmp " + labelName);
                        sb.AppendLine(paddingAlign);
                        sb.AppendLine(labelName + ":");
                    }

                    sb.AppendLine("  dec %rdi");
                    sb.AppendLine("  jne " + funcName);
                    sb.AppendLine("  ret\n\n");
                }
            }
        }

        static void GenerateX86NasmRobFuncs(StringBuilder sb, int[] robCounts)
        {
            for (int i = 0;i < robCounts.Length; i++)
            {
                string funcName = GetRobFuncName(robCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        static void GenerateX86NasmPrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = GetPrfFuncName(rfCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  xor r15, r15");
                sb.AppendLine("  mov r14, 1");
                sb.AppendLine("  mov r13, 2");
                sb.AppendLine("  mov r12, 3");
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                for (int nopIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx += 4)
                {
                    // actually write to the register
                    sb.AppendLine("  add r15, 1");
                    sb.AppendLine("  add r14, 2");
                    sb.AppendLine("  add r13, 3");
                    sb.AppendLine("  add r12, 4");
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        static void GenerateX86NasmFuncs(StringBuilder sb, int[] branchCounts, int[] paddings)
        {
            string paddingAlign = "";
            for (int p = 0; p < paddings.Length; p++)
            {
                // need 2 bytes, then a 4 byte nop
                if (paddings[p] == 1)
                {
                    paddingAlign = "  nop2\n  nop4\n";
                }
                // need 2 bytes, then 12 bytes of nops
                else if (paddings[p] == 3)
                {
                    paddingAlign = "  nop2\n  nop12\n";
                }
                else if (paddings[p] != 0)
                {
                    Console.WriteLine($"Unsupported padding value {paddings[p]}");
                    continue;
                }

                for (int i = 0; i < branchCounts.Length; i++)
                {
                    string funcName = GetFuncName(branchCounts[i], paddings[p]);
                    //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                    sb.AppendLine(funcName + ":\n");
                    for (int branchIdx = 1; branchIdx < branchCounts[i]; branchIdx++)
                    {
                        string labelName = GetLabelName(funcName, branchIdx);
                        sb.AppendLine("  jmp " + labelName);
                        sb.AppendLine(paddingAlign);
                        sb.AppendLine(labelName + ":");
                    }

                    sb.AppendLine("  dec rcx");
                    sb.AppendLine("  jne " + funcName);
                    sb.AppendLine("  ret\n\n");
                }
            }
        }
    }
}
