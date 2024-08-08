using System.Text;

namespace AsmGen
{
    public class MmxRfTest : UarchTest
    {
        public MmxRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mmxrf";
            this.Description = "64-bit MMX RF Capacity Test. x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }
        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) GenerateX86GccAsm(sb);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = 
                "  fsave (%r8)\n" +
                "  movq (%rdx), %mm0\n" +
                "  movq 8(%rdx), %mm1\n" +
                "  movq 16(%rdx), %mm2\n" +
                "  movq 24(%rdx), %mm3\n" +
                "  movq 32(%rdx), %mm4\n";

            string cleanupInstrs = "  frstor (%r8)";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddw %mm0, %mm1";
            unrolledAdds[1] = "  paddw %mm0, %mm2";
            unrolledAdds[2] = "  paddw %mm0, %mm3";
            unrolledAdds[3] = "  paddw %mm0, %mm4";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(
                sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs, cleanupInstrs: cleanupInstrs);
        }
    }
}