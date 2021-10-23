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

        public abstract void GenerateArmAsm(StringBuilder sb);

        public abstract void GenerateX86GccAsm(StringBuilder sb);
        public abstract void GenerateX86NasmAsm(StringBuilder sb);

        public void GenerateNasmGlobalLines(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
                sb.AppendLine("global " + Prefix + Counts[i]);
        }

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

        public void GenerateVsExternLines(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + Prefix + Counts[i] + $"({FunctionDefinitionParameters});");
        }

        public void GenerateTestBlock(StringBuilder sb)
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

        public void GenerateVsTestBlock(StringBuilder sb)
        {
            sb.AppendLine("  if (argc > 1 && _strnicmp(argv[1], \"" + Prefix + "\", " + Prefix.Length + ") == 0) {");
            sb.AppendLine("  printf(\"" + Description + ":\\n\");");

            for (int i = 0; i < Counts.Length; i++)
            {
                if (DivideTimeByCount)
                {
                    sb.AppendLine("    tmp = structIterations;");
                    sb.AppendLine("    structIterations = iterations / " + Counts[i] + ";");
                }

                sb.AppendLine("  ftime(&start);");
                sb.AppendLine("  " + Prefix + Counts[i] + $"({GetFunctionCallParameters});");
                sb.AppendLine("  ftime(&end);");
                sb.AppendLine("  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);");
                if (DivideTimeByCount)
                    sb.AppendLine("    latency = 1e6 * (float)time_diff_ms / (float)(iterations);");
                else
                    sb.AppendLine("    latency = 1e6 * (float)time_diff_ms / (float)(structIterations);");
                sb.AppendLine("  printf(\"" + Counts[i] + ",%f\\n\", latency);\n");

                if (DivideTimeByCount)
                {
                    sb.AppendLine("    structIterations = tmp;");
                }
            }

            sb.AppendLine("  }\n");
        }
    }
}
