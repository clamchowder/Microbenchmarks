using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AsmGen
{
    public static class UarchTestHelpers
    {
        public static int[] GenerateCountArray(int low, int high, int step)
        {
            List<int> countList = new List<int>();
            for (int i = low; i <= high; i += step)
            {
                countList.Add(i);
            }

            return countList.ToArray();
        }

        public static void GenerateNasmGlobalLines(StringBuilder sb, UarchTest test)
        {
            int[] counts = test.Counts;
            for (int i = 0; i < counts.Length; i++)
                sb.AppendLine("global " + test.Prefix + counts[i]);
        }

        public static void GenerateAsmGlobalLines(StringBuilder sb, UarchTest test)
        {
            int[] counts = test.Counts;
            for (int i = 0; i < counts.Length; i++)
                sb.AppendLine(".global " + test.Prefix + counts[i]);
        }

        public static void GenerateExternLines(StringBuilder sb, UarchTest test)
        {
            int[] counts = test.Counts;
            for (int i = 0; i < counts.Length; i++)
                sb.AppendLine("extern uint64_t " + test.Prefix + counts[i] + $"({test.FunctionDefinitionParameters});"); ;
        }

        public static void GenerateVsExternLines(StringBuilder sb, UarchTest test)
        {
            int[] counts = test.Counts;
            for (int i = 0; i < counts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + test.Prefix + counts[i] + $"({test.FunctionDefinitionParameters});");
        }

        public static void GenerateTestBlock(StringBuilder sb, UarchTest test)
        {
            sb.AppendLine("  if (argc > 1 && strncmp(argv[1], \"" + test.Prefix + "\", " + test.Prefix.Length + ") == 0) {");
            sb.AppendLine("    printf(\"" + test.Description + ":\\n\");");
            
            int[] counts = test.Counts;
            for (int i = 0; i < counts.Length; i++)
            {
                // use more iterations (iterations = structIterations * 100) and divide iteration count by tested-thing count
                // for certain tests like call stack depth
                if (test.DivideTimeByCount)
                {
                    sb.AppendLine("    tmp = structIterations;");
                    sb.AppendLine("    structIterations = iterations / " + counts[i] + ";");
                }
                
                sb.AppendLine("    gettimeofday(&startTv, &startTz);");
                sb.AppendLine("    " + test.Prefix + counts[i] + $"({test.GetFunctionCallParameters});");
                sb.AppendLine("    gettimeofday(&endTv, &endTz);");
                sb.AppendLine("    time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                if (test.DivideTimeByCount)
                    sb.AppendLine("    latency = 1e6 * (float)time_diff_ms / (float)(iterations);");
                else
                    sb.AppendLine("    latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("    printf(\"" + counts[i] + ",%f\\n\", latency);\n");

                if (test.DivideTimeByCount)
                {
                    sb.AppendLine("    structIterations = tmp;");
                }
            }

            sb.AppendLine("  }\n");
        }

        public static void GenerateVsTestBlock(StringBuilder sb, UarchTest test)
        {
            sb.AppendLine("  if (argc > 1 && _strnicmp(argv[1], \"" + test.Prefix + "\", " + test.Prefix.Length + ") == 0) {");
            sb.AppendLine("  printf(\"" + test.Description + ":\\n\");");

            int[] counts = test.Counts;
            for (int i = 0; i < counts.Length; i++)
            {
                if (test.DivideTimeByCount)
                {
                    sb.AppendLine("    tmp = structIterations;");
                    sb.AppendLine("    structIterations = iterations / " + counts[i] + ";");
                }

                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + test.Prefix + counts[i] + $"({test.GetFunctionCallParameters});");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                if (test.DivideTimeByCount)
                    sb.AppendLine("    latency = 1e6 * (float)time_diff_ms / (float)(iterations);");
                else
                    sb.AppendLine("    latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + counts[i] + ",%f\\n\", latency);\n");

                if (test.DivideTimeByCount)
                {
                    sb.AppendLine("    structIterations = tmp;");
                }
            }

            sb.AppendLine("  }\n");
        }

        /// <summary>
        /// Generates test functions in assembly, with filler instructions between two divs
        /// Args are put into rcx, rdx, r8 (in that order) to match Windows calling convention
        /// </summary>
        /// <param name="sb">StringBuilder to append to</param>
        /// <param name="counts">Sizes to test the structure at</param>
        /// <param name="funcNamePrefix">Function name prefix</param>
        /// <param name="fillerInstrs1">Filler instructions after first ptr chasing load</param>
        /// <param name="fillerInstrs2">Filler instructions after second ptr chasing load</param>
        /// <param name="includePtrChasingLoads">If true, count pointer chasing loads as consuming the tested resource 
        /// (i.e. ptr chasing loads consume a ROB and integer RF slot) </param>
        /// <param name="initInstrs">Any extra initialization instructions</param>
        public static void GenerateX86AsmDivStructureTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2, bool includePtrChasingLoads = true, string initInstrs = null)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %r11");
                sb.AppendLine("  push %r8");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");

                // arguments are in RDI, RSI, RDX, RCX, R8, and R9
                // move them into familiar windows argument regs (rcx, rdx, r8)
                sb.AppendLine("  mov %rdx, %r8"); // r8 <- rdx
                sb.AppendLine("  mov %rsi, %rdx"); // rdx <- rsi
                sb.AppendLine("  mov %rdi, %rcx"); // rcx <- rdi

                sb.AppendLine("  xor %r15, %r15");
                sb.AppendLine("  mov $0x10, %r14");
                sb.AppendLine("  mov $0x20, %r13");
                sb.AppendLine("  mov $0x30, %r12");
                sb.AppendLine("  mov $0x40, %r11");

                if (initInstrs != null) sb.AppendLine(initInstrs);

                sb.AppendLine("  mov %rdx, %rdi");
                sb.AppendLine("  mov %rdx, %rsi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  mov %rdi, %rax");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rsi");
                sb.AppendLine("  sub %rax, %rsi");
                sb.AppendLine("  inc %rsi");
                int fillerInstrCount = includePtrChasingLoads ? counts[i] - 2 : counts[i];
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs1[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  mov %rsi, %rax");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  xor %rdx, %rdx");
                sb.AppendLine("  idiv %rdi");
                sb.AppendLine("  sub %rax, %rdi");
                sb.AppendLine("  inc %rdi");
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs2[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %r11");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86AsmStructureTestFuncs(StringBuilder sb, 
            int[] counts, 
            string funcNamePrefix, 
            string[] fillerInstrs1, 
            string[] fillerInstrs2, 
            bool divs = true, 
            string initInstrs = null, 
            string postLoadInstrs1 = null, 
            string postLoadInstrs2 = null)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %r11");
                sb.AppendLine("  push %r8");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");

                // arguments are in RDI, RSI, RDX, RCX, R8, and R9
                // move them into familiar windows argument regs (rcx, rdx, r8)
                sb.AppendLine("  mov %rdx, %r8"); // r8 <- rdx
                sb.AppendLine("  mov %rsi, %rdx"); // rdx <- rsi
                sb.AppendLine("  mov %rdi, %rcx"); // rcx <- rdi

                sb.AppendLine("  xor %r15, %r15");
                sb.AppendLine("  mov $0x1, %r14");
                sb.AppendLine("  mov $0x2, %r13");
                sb.AppendLine("  mov $0x3, %r12");
                sb.AppendLine("  mov $0x4, %r11");

                if (initInstrs != null) sb.AppendLine(initInstrs);

                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                if (postLoadInstrs1 != null) sb.AppendLine(postLoadInstrs1);
                int fillerInstrCount = divs ? counts[i] - 2 : counts[i];
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs1[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                if (postLoadInstrs2 != null) sb.AppendLine(postLoadInstrs2);
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs2[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %r11");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        /// <summary>
        /// Generate test functions for testing integer scheduler capacity
        /// R15's value is dependent on the pointer chasing load results
        /// </summary>
        /// <param name="sb"></param>
        /// <param name="counts"></param>
        /// <param name="funcNamePrefix"></param>
        /// <param name="fillerInstrs1"></param>
        /// <param name="fillerInstrs2"></param>
        /// <param name="divs"></param>
        /// <param name="initInstrs"></param>
        public static void GenerateX86AsmIntSchedTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2, bool divs = true, string initInstrs = null)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %r11");
                sb.AppendLine("  push %r8");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");

                // arguments are in RDI, RSI, RDX, RCX, R8, and R9
                // move them into familiar windows argument regs (rcx, rdx, r8)
                sb.AppendLine("  mov %rdx, %r8"); // r8 <- rdx
                sb.AppendLine("  mov %rsi, %rdx"); // rdx <- rsi
                sb.AppendLine("  mov %rdi, %rcx"); // rcx <- rdi

                sb.AppendLine("  xor %r15, %r15");
                sb.AppendLine("  mov $0x1, %r14");
                sb.AppendLine("  mov $0x2, %r13");
                sb.AppendLine("  mov $0x3, %r12");
                sb.AppendLine("  mov $0x4, %r11");

                if (initInstrs != null) sb.AppendLine(initInstrs);

                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                sb.AppendLine("  mov %rdi, %r15");
                int fillerInstrCount = divs ? counts[i] - 2 : counts[i];
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs1[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("  mov %rsi, %r15");
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs2[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %r11");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        /// <summary>
        /// Generates pointer chasing test functions in assembly, with xmm0 <- [address using offset from ptr chasing result]
        /// xmm1-4 can be used for 
        /// </summary>
        /// <param name="sb"></param>
        /// <param name="counts"></param>
        /// <param name="funcNamePrefix"></param>
        /// <param name="fillerInstrs1"></param>
        /// <param name="fillerInstrs2"></param>
        public static void GenerateX86AsmFpSchedTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %r8");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");

                // arguments are in RDI, RSI, RDX, RCX, R8, and R9
                // move them into familiar windows argument regs (rcx, rdx, r8)
                sb.AppendLine("  mov %rdx, %r8"); // r8 <- rdx
                sb.AppendLine("  mov %rsi, %rdx"); // rdx <- rsi
                sb.AppendLine("  mov %rdi, %rcx"); // rcx <- rdi

                sb.AppendLine("  xor %r15, %r15");
                sb.AppendLine("  mov $0x1, %r14");
                sb.AppendLine("  mov $0x1, %r13");
                sb.AppendLine("  mov $0x3, %r12");

                // initialize some FP values off r8 (third argument)
                sb.AppendLine("  movss (%r8), %xmm1");
                sb.AppendLine("  movss 4(%r8), %xmm2");
                sb.AppendLine("  movss 8(%r8), %xmm3");
                sb.AppendLine("  movss 12(%r8), %xmm4");
                sb.AppendLine("  movss 16(%r8), %xmm5");

                // start one chain at 0, and the other at 0x40
                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                sb.AppendLine("  cvtsi2ss %rdi, %xmm0");
                int fillerInstrCount = counts[i];
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs1[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("  cvtsi2ss %rsi, %xmm0");
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs2[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86AsmFp256SchedTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %r8");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");

                // arguments are in RDI, RSI, RDX, RCX, R8, and R9
                // move them into familiar windows argument regs (rcx, rdx, r8)
                sb.AppendLine("  mov %rdx, %r8"); // r8 <- rdx
                sb.AppendLine("  mov %rsi, %rdx"); // rdx <- rsi
                sb.AppendLine("  mov %rdi, %rcx"); // rcx <- rdi

                sb.AppendLine("  xor %r15, %r15");
                sb.AppendLine("  mov $0x1, %r14");
                sb.AppendLine("  mov $0x1, %r13");
                sb.AppendLine("  mov $0x3, %r12");

                // initialize some FP values off r8 (third argument)
                sb.AppendLine("  vzeroupper");
                sb.AppendLine("  vmovups (%r8), %ymm1");
                sb.AppendLine("  vmovups 32(%r8), %ymm2");
                sb.AppendLine("  vmovups 64(%r8), %ymm3");
                sb.AppendLine("  vmovups 96(%r8), %ymm4");
                sb.AppendLine("  vmovups 128(%r8), %ymm5");

                // start one chain at 0, and the other at 0x40
                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                sb.AppendLine("  vbroadcastss (%r8,%rdi,4), %ymm0");
                int fillerInstrCount = counts[i];
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs1[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("  vbroadcastss (%r8,%rsi,4), %ymm0");
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs2[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        /// <summary>
        /// Generates test functions in assembly, with filler instructions between two divs
        /// Args are put into rcx, rdx, r8 (in that order) to match Windows calling convention
        /// </summary>
        /// <param name="sb">StringBuilder to append to</param>
        /// <param name="counts">Sizes to test the structure at</param>
        /// <param name="funcNamePrefix">Function name prefix</param>
        /// <param name="fillerInstrs1">Filler instructions after first ptr chasing load</param>
        /// <param name="fillerInstrs2">Filler instructions after second ptr chasing load</param>
        /// <param name="includePtrChasingLoads">If true, count pointer chasing loads as consuming the tested resource 
        /// (i.e. ptr chasing loads consume a ROB and integer RF slot) </param>
        /// <param name="initInstrs">Any extra initialization instructions</param>
        public static void GenerateX86NasmDivStructureTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2, bool includePtrChasingLoads = true, string initInstrs = null)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  push r11");

                sb.AppendLine("  xor r15, r15");
                sb.AppendLine("  mov r14, 0x10");
                sb.AppendLine("  mov r13, 0x20");
                sb.AppendLine("  mov r12, 0x30");
                sb.AppendLine("  mov r11, 0x40");


                if (initInstrs != null) sb.AppendLine(initInstrs);

                sb.AppendLine("  mov rdi, rdx");
                sb.AppendLine("  mov rsi, rdx");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  mov rax, rdi");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rsi");
                sb.AppendLine("  sub rsi, rax");
                sb.AppendLine("  inc rsi");
                int fillerInstrCount = includePtrChasingLoads ? counts[i] - 2 : counts[i];
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs1[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  mov rax, rsi");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  xor rdx, rdx");
                sb.AppendLine("  idiv rdi");
                sb.AppendLine("  sub rdi, rax");
                sb.AppendLine("  inc rdi");
                for (int fillerIdx = 0, instrIdx = 0; fillerIdx < fillerInstrCount; fillerIdx++)
                {
                    sb.AppendLine(fillerInstrs2[instrIdx]);
                    instrIdx = (instrIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r11");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86NasmFpSchedTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  push r11");
                sb.AppendLine("  xor r15, r15");
                sb.AppendLine("  mov r14, 1");
                sb.AppendLine("  mov r13, 2");
                sb.AppendLine("  mov r12, 3");
                sb.AppendLine("  mov r11, 4");
                sb.AppendLine("  xor rdi, rdi");

                sb.AppendLine("  movss xmm1, [r8]");
                sb.AppendLine("  movss xmm2, [r8 + 4]");
                sb.AppendLine("  movss xmm3, [r8 + 8]");
                sb.AppendLine("  movss xmm4, [r8 + 12]");
                sb.AppendLine("  movss xmm5, [r8 + 16]");

                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                sb.AppendLine("  cvtsi2ss xmm0, rdi");
                int fillerInstrCount = counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                sb.AppendLine("  cvtsi2ss xmm0, rsi");
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r11");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86NasmFp256SchedTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  push r11");
                sb.AppendLine("  xor r15, r15");
                sb.AppendLine("  mov r14, 1");
                sb.AppendLine("  mov r13, 2");
                sb.AppendLine("  mov r12, 3");
                sb.AppendLine("  mov r11, 4");
                sb.AppendLine("  vzeroupper");
                sb.AppendLine("  vmovups ymm1, [r8]");
                sb.AppendLine("  vmovups ymm2, [r8 + 32]");
                sb.AppendLine("  vmovups ymm3, [r8 + 64]");
                sb.AppendLine("  vmovups ymm4, [r8 + 96]");
                sb.AppendLine("  vmovups ymm5, [r8 + 128]");
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                sb.AppendLine("  vbroadcastss ymm0, [r8 + rdi * 4]");
                int fillerInstrCount = counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                sb.AppendLine("  vbroadcastss ymm0, [r8 + rsi * 4]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r11");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86NasmStructureTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2, bool includePtrChasingLoads = true, string initInstrs = null, string postLoadInstrs1 = null, string postLoadInstrs2 = null)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  push r11");
                sb.AppendLine("  xor r15, r15");
                sb.AppendLine("  mov r14, 1");
                sb.AppendLine("  mov r13, 2");
                sb.AppendLine("  mov r12, 3");
                sb.AppendLine("  mov r11, 4");
                if (initInstrs != null) sb.AppendLine(initInstrs);
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                if (postLoadInstrs1 != null) sb.AppendLine(postLoadInstrs1);
                int fillerInstrCount = includePtrChasingLoads ? counts[i] - 2 : counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                if (postLoadInstrs2 != null) sb.AppendLine(postLoadInstrs2);
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r11");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86NasmIntSchedTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2, bool includePtrChasingLoads = true, string initInstrs = null)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  push r11");
                sb.AppendLine("  xor r15, r15");
                sb.AppendLine("  mov r14, 1");
                sb.AppendLine("  mov r13, 2");
                sb.AppendLine("  mov r12, 3");
                sb.AppendLine("  mov r11, 4");
                if (initInstrs != null) sb.AppendLine(initInstrs);
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                sb.AppendLine("  mov r15, rdi");
                int fillerInstrCount = includePtrChasingLoads ? counts[i] - 2 : counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                sb.AppendLine("  mov r15, rsi");
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r11");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        /// <summary>
        /// Generates test functions in ARM assembly.
        /// Registers x15-x10 can be used for integer stuff
        /// Args are in x0, x1, x2
        /// </summary>
        /// <param name="sb"></param>
        /// <param name="counts"></param>
        /// <param name="funcNamePrefix"></param>
        /// <param name="fillerInstrs1"></param>
        /// <param name="fillerInstrs2"></param>
        /// <param name="includePtrChasingLoads"></param>
        public static void GenerateArmAsmStructureTestFuncs(StringBuilder sb, 
            int[] counts, 
            string funcNamePrefix, 
            string[] fillerInstrs1, 
            string[] fillerInstrs2, 
            bool includePtrChasingLoads = false, 
            string initInstrs = null, 
            string postLoadInstrs1 = null, 
            string postLoadInstrs2 = null)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  sub sp, sp, #0x50");
                sb.AppendLine("  stp x14, x15, [sp, #0x10]");
                sb.AppendLine("  stp x12, x13, [sp, #0x20]");
                sb.AppendLine("  stp x10, x11, [sp, #0x30]");
                sb.AppendLine("  stp x25, x26, [sp, #0x40]");
                sb.AppendLine("  mov x15, 1");
                sb.AppendLine("  mov x14, 2");
                sb.AppendLine("  mov x13, 3");
                sb.AppendLine("  mov x12, 4");
                sb.AppendLine("  mov x11, 5");
                sb.AppendLine("  mov x10, 6");
                if (initInstrs != null) sb.AppendLine(initInstrs);
                sb.AppendLine("  mov w25, 0x0");
                sb.AppendLine("  mov w26, 0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w25, [x1, w25, uxtw #2]"); // current = A[current]
                if (postLoadInstrs1 != null) sb.AppendLine(postLoadInstrs1);
                int fillerInstrCount = includePtrChasingLoads ? counts[i] - 2 : counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  ldr w26, [x1, w26, uxtw #2]");
                if (postLoadInstrs2 != null) sb.AppendLine(postLoadInstrs2);
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x25, x26, [sp, #0x40]");
                sb.AppendLine("  ldp x10, x11, [sp, #0x30]");
                sb.AppendLine("  ldp x12, x13, [sp, #0x20]");
                sb.AppendLine("  ldp x14, x15, [sp, #0x10]");
                sb.AppendLine("  add sp, sp, #0x50");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateArmAsmFpStructureTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];

                // x0 = iteration count, x1 = ptr chasing arr, x2 = fp array
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  sub sp, sp, #0x50");
                sb.AppendLine("  stp x14, x15, [sp, #0x10]");
                sb.AppendLine("  stp x12, x13, [sp, #0x20]");
                sb.AppendLine("  stp x10, x11, [sp, #0x30]");
                sb.AppendLine("  stp x25, x26, [sp, #0x40]"); ;
                sb.AppendLine("  ldr s17, [x2]");
                sb.AppendLine("  ldr s18, [x2, 4]");
                sb.AppendLine("  ldr s19, [x2, 8]");
                sb.AppendLine("  ldr s20, [x2, 12]");
                sb.AppendLine("  ldr s21, [x2, 16]");
                sb.AppendLine("  mov w25, 0x0");
                sb.AppendLine("  mov w26, 0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w25, [x1, w25, uxtw #2]"); // current = A[current]

                int fillerInstrCount = counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  ldr w26, [x1, w26, uxtw #2]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x25, x26, [sp, #0x40]");
                sb.AppendLine("  ldp x10, x11, [sp, #0x30]");
                sb.AppendLine("  ldp x12, x13, [sp, #0x20]");
                sb.AppendLine("  ldp x14, x15, [sp, #0x10]");
                sb.AppendLine("  add sp, sp, #0x50");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateArmAsmFpSchedTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];

                // x0 = iteration count, x1 = ptr chasing arr, x2 = fp array
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  sub sp, sp, #0x50");
                sb.AppendLine("  stp x14, x15, [sp, #0x10]");
                sb.AppendLine("  stp x12, x13, [sp, #0x20]");
                sb.AppendLine("  stp x10, x11, [sp, #0x30]");
                sb.AppendLine("  stp x25, x26, [sp, #0x40]"); ;
                sb.AppendLine("  ldr s17, [x2]");
                sb.AppendLine("  ldr s18, [x2, 4]");
                sb.AppendLine("  ldr s19, [x2, 8]");
                sb.AppendLine("  ldr s20, [x2, 12]");
                sb.AppendLine("  ldr s21, [x2, 16]");
                sb.AppendLine("  mov w25, 0x0");
                sb.AppendLine("  mov w26, 0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w25, [x1, w25, uxtw #2]"); // current = A[current]
                // x2 = ptr to FP array. do a FP load dependent on that
                sb.AppendLine("  ldr s16, [x2, w25, uxtw #2]");

                int fillerInstrCount = counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  ldr w26, [x1, w26, uxtw #2]");
                sb.AppendLine("  ldr s16, [x2, w26, uxtw #2]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x25, x26, [sp, #0x40]");
                sb.AppendLine("  ldp x10, x11, [sp, #0x30]");
                sb.AppendLine("  ldp x12, x13, [sp, #0x20]");
                sb.AppendLine("  ldp x14, x15, [sp, #0x10]");
                sb.AppendLine("  add sp, sp, #0x50");
                sb.AppendLine("  ret\n\n");
            }
        }
    }
}
