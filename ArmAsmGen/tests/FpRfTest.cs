using System.Text;

namespace AsmGen
{
    public class FpRfTest : UarchTest
    {
        public string Prefix { get => "fprf"; }
        public string Description { get => "FP (64-bit scalar) RF Test"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr, float *floatArr"; }
        public string GetFunctionCallParameters { get => "structIterations, A, fpArr"; }

        public int[] Counts { get; private set; }
        public bool DivideTimeByCount => false;

        public FpRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  movss (%r8), %xmm1\n" +
                "  movss 4(%r8), %xmm2\n" +
                "  movss 8(%r8), %xmm3\n" +
                "  movss 12(%r8), %xmm4\n" +
                "  movss 16(%r8), %xmm5\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  addss %xmm1, %xmm2";
            unrolledAdds[1] = "  addss %xmm1, %xmm3";
            unrolledAdds[2] = "  addss %xmm1, %xmm4";
            unrolledAdds[3] = "  addss %xmm1, %xmm5";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movss xmm1, [r8]\n" +
                "  movss xmm2, [r8 + 4]\n" +
                "  movss xmm3, [r8 + 8]\n" +
                "  movss xmm4, [r8 + 12]\n" +
                "  movss xmm5, [r8 + 16]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  addss xmm2, xmm1";
            unrolledAdds[1] = "  addss xmm3, xmm1";
            unrolledAdds[2] = "  addss xmm4, xmm1";
            unrolledAdds[3] = "  addss xmm5, xmm1";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string initInstrs = "  ldr s17, [x2]\n" +
                "  ldr s18, [x2, 4]\n" +
                "  ldr s19, [x2, 8]\n" +
                "  ldr s20, [x2, 12]\n" +
                "  ldr s21, [x2, 16]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fadd s18, s18, s17";
            unrolledAdds[1] = "  fadd s19, s19, s17";
            unrolledAdds[2] = "  fadd s20, s20, s17";
            unrolledAdds[3] = "  fadd s21, s21, s17";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }
    }
}
