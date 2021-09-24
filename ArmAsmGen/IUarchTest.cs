using System.Text;

namespace AsmGen
{
    public interface IUarchTest
    {
        // enough to generate global lines, function calls, and let user pick from tests
        public string Prefix { get; }
        public string Description { get; }
        public string FunctionDefinitionParameters { get; }
        public string GetFunctionCallParameters { get; }
        public bool DivideTimeByCount { get; }
        public void GenerateX86GccAsm(StringBuilder sb);
        public void GenerateX86NasmAsm(StringBuilder sb);
        public void GenerateArmAsm(StringBuilder sb);
        public void GenerateVsTestBlock(StringBuilder sb);
        public void GenerateTestBlock(StringBuilder sb);

        public void GenerateAsmGlobalLines(StringBuilder sb);
        public void GenerateNasmGlobalLines(StringBuilder sb);

        public void GenerateVsExternLines(StringBuilder sb);
        public void GenerateExternLines(StringBuilder sb);
    }
}
