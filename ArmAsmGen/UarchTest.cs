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
                sb.AppendLine("extern uint64_t " + Prefix + Counts[i] + $"({FunctionDefinitionParameters});"); ;
        }

        public void GenerateVsExternLines(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + Prefix + Counts[i] + $"({FunctionDefinitionParameters});");
        }
    }
}
