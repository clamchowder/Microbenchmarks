using System.Text;

namespace AsmGen
{
    public interface IUarchTest
    {
        // enough to generate global lines, function calls, and let user pick from tests
        public string Prefix { get; }
        public string Description { get; }
        public bool DivideTimeByCount { get; }
        public bool SupportsIsa(ISA isa);

        public void GenerateAsm(StringBuilder sb, ISA isa);
        public void GenerateTestBlock(StringBuilder sb, ISA isa);
        public void GenerateAsmGlobalLines(StringBuilder sb);
        public void GenerateExternLines(StringBuilder sb);

        public enum ISA
        {
            amd64,   // 64-bit x86
            aarch64, // 64-bit arm
            mips64,   // 64-bit MIPS, for loongson
            riscv,   // 64-bit risc-v
        }
    }
}
