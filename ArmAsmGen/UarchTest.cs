using System.Text;

namespace AsmGen
{
    public interface UarchTest
    {
        // enough to generate global lines, function calls, and let user pick from tests
        public string Prefix { get; }
        public string Description { get; }
        public int[] Counts { get; }
        public string FunctionDefinitionParameters { get; }
        public string GetFunctionCallParameters { get; }
        public void GenerateX86GccAsm(StringBuilder sb);
        public void GenerateX86NasmAsm(StringBuilder sb);
        public void GenerateArmAsm(StringBuilder sb);
    }
}
