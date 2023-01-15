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
            sb.AppendLine("  if (argc > 1 && strncmp(argv[1], \"" + Prefix + "\", " + Prefix.Length + ") == 0) {");
            sb.AppendLine("    printf(\"" + Description + ":\\n\");");

            for (int i = 0; i < Counts.Length; i++)
            {
                // use more iterations (iterations = structIterations * 100) and divide iteration count by tested-thing count
                // for certain tests like call stack depth
                if (DivideTimeByCount)
                {
                    sb.AppendLine("    tmp = structIterations;");
                    sb.AppendLine("    structIterations = iterations / " + Counts[i] + ";");
                }

                if (isa == IUarchTest.ISA.mips64)
                {
                    sb.AppendLine("preplatencyarr(arr, list_size);");
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
        public void GenerateMipsPrepArrayFunction(StringBuilder sb)
        {
            // r4 = ptr to arr, r5 = arr len, in 32-bit elements
            sb.AppendLine(".global preplatencyarr");
            sb.AppendLine("preplatencyarr:");
            sb.AppendLine("\n  xor $r12, $r12, $r12");
            sb.AppendLine("\n  xor $r13, $r13, $r13");
            sb.AppendLine("\n  xor $r14, $r14, $r14");
            sb.AppendLine("\n  addi.d $r14, $r14, 1");
            sb.AppendLine("preplatencyarr_loop:");
            sb.AppendLine("\n  alsl.d $r12, $r12, $r0, 0x2"); // shift by 2 = multiply by 4 for 32-bit
            sb.AppendLine("\n  add.d $r12, $r4, $r12"); // add loaded value to base address
            sb.AppendLine("\n ld.d $r13, $r12, 0");
            sb.AppendLine("\n  alsl.d $r13, $r13, $r0, 0x2"); // address calculation for loaded index
            sb.AppendLine("\n  add.d $r13, $r4, $r13");
            sb.AppendLine("\n  st.d $r13, $r12, 0");  // save calculated address
            sb.AppendLine("\n  add.d $r15, $r15, $r14");
            sb.AppendLine("\n  bne $r15, $r5, preplatencyarr_loop"); // while idx != len
            sb.AppendLine("\n  jr $r1");
        }
    }
}
