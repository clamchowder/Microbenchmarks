using System.Runtime.Serialization;
using System.Text;

namespace AsmGen
{
    public abstract class UarchTest : IUarchTest
    {
        public string Prefix { get; set; }

        public string Description { get; set; }

        public int[] Counts;

        public string FunctionDefinitionParameters { get; set; }

        public string GetFunctionCallParameters { get; set; }

        public bool DivideTimeByCount { get; set; }

        public abstract bool SupportsIsa(IUarchTest.ISA isa);
        public abstract void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa);

        public void GenerateAsmGlobalLines(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
                sb.AppendLine(".global " + Prefix + Counts[i]);
        }

        public void GenerateExternLines(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
                sb.AppendLine("extern uint64_t " + Prefix + Counts[i] + $"({FunctionDefinitionParameters}) __attribute((sysv_abi));"); ;
        }

        public void GenerateTestBlock(StringBuilder sb, IUarchTest.ISA isa)
        {
            sb.AppendLine("  if (argc > 1 && strncmp(test_name, \"" + Prefix + "\", " + Prefix.Length + ") == 0) {");
            sb.AppendLine("    printf(\"" + Description + ":\\n\");");

            if (isa == IUarchTest.ISA.mips64 || isa == IUarchTest.ISA.riscv)
            {
                sb.AppendLine("  if (argc == 1 || argc > 1 && strncmp(test_name, \"btb\", 3) != 0) {");
                sb.AppendLine("preplatencyarr(A, list_size);");
                sb.AppendLine("  }");
            }

            for (int i = 0; i < Counts.Length; i++)
            {
                // use more iterations (iterations = structIterations * 100) and divide iteration count by tested-thing count
                // for certain tests like call stack depth
                if (DivideTimeByCount)
                {
                    sb.AppendLine("    tmp = structIterations;");
                    sb.AppendLine("    structIterations = iterations / " + Counts[i] + ";");
                }

                sb.AppendLine("    gettimeofday(&startTv, &startTz);");
                sb.AppendLine("    " + Prefix + Counts[i] + $"({GetFunctionCallParameters});");
                sb.AppendLine("    gettimeofday(&endTv, &endTz);");
                sb.AppendLine("    time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);");
                if (DivideTimeByCount)
                    sb.AppendLine("    latency = 1e6 * (float)time_diff_ms / (float)(iterations);");
                else
                    sb.AppendLine("    latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("    printf(\"" + Counts[i] + ",%f\\n\", latency);\n");

                if (DivideTimeByCount)
                {
                    sb.AppendLine("    structIterations = tmp;");
                }
            }

            sb.AppendLine("  }\n");
        }

        /// <summary>
        /// MIPS doesn't have an indexed load instruction which means we'd have to use an
        /// add+shift (extra two instructions), which would complicate measurements
        /// So screw around in order to use direct addressing
        /// </summary>
        /// <param name="sb"></param>
        public static void GenerateMipsPrepArrayFunction(StringBuilder sb)
        {
            // r4 = ptr to arr, r5 = arr len, in 32-bit elements
            sb.AppendLine(".global preplatencyarr");
            sb.AppendLine("preplatencyarr:");
            sb.AppendLine("  xor $r12, $r12, $r12");
            sb.AppendLine("  xor $r13, $r13, $r13");
            sb.AppendLine("  xor $r14, $r14, $r14");
            sb.AppendLine("  xor $r15, $r15, $r15"); // array index
            sb.AppendLine("  addi.d $r14, $r14, 1");
            sb.AppendLine("preplatencyarr_loop:");
            sb.AppendLine("  alsl.d $r12, $r15, $r0, 0x3"); // shift by 3 = multiply by 8 for 64-bit
            sb.AppendLine("  add.d $r12, $r4, $r12"); // add loaded value to base address
            sb.AppendLine(" ld.d $r13, $r12, 0");
            sb.AppendLine("  alsl.d $r13, $r13, $r0, 0x2"); // address calculation for loaded index. this is in 32-bit values
            sb.AppendLine("  add.d $r13, $r4, $r13");
            sb.AppendLine("  st.d $r13, $r12, 0");  // save calculated address
            sb.AppendLine("  add.d $r15, $r15, $r14");
            sb.AppendLine("  alsl.d $r16, $r15, $r0, 0x1"); // muliply 64-bit index by 2 to prevent out of bounds for 32-bit list size count
            sb.AppendLine("  bne $r16, $r5, preplatencyarr_loop"); // while idx != len
            sb.AppendLine("  jr $r1");
        }

        public static void GenerateRiscvPrepArrayFunction(StringBuilder sb)
        {
            sb.AppendLine(".global preplatencyarr");
            sb.AppendLine("preplatencyarr:");
            sb.AppendLine("  li x7, 0");
            sb.AppendLine("  mv x5, x10");
            sb.AppendLine("preplatencyarr_loop:");
            sb.AppendLine("  ld x28, (x5)");
            sb.AppendLine("  slli x28, x28, 2"); // index specified in 32-bit values
            sb.AppendLine("  add x28, x28, x10");
            sb.AppendLine("  sd x28, (x5)");
            sb.AppendLine("  addi x5, x5, 8"); // next element
            sb.AppendLine("  addi x7, x7, 2"); // list size is given in 32-bit elements
            sb.AppendLine("  blt x7, x11, preplatencyarr_loop");
            sb.AppendLine("  ret");
        }
    }
}
