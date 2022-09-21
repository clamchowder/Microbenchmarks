using System.Text;

namespace AsmGen
{
    public class MixIntFp13RfTest : UarchTest
    {
        public MixIntFp13RfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixintfp13rf";
            this.Description = "Mix of integer and FP register file, 1:3 ratio";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  movss (%r8), %xmm1\n" +
                "  movss 4(%r8), %xmm2\n" +
                "  movss 8(%r8), %xmm3\n" +
                "  movss 12(%r8), %xmm4\n" +
                "  movss 16(%r8), %xmm5\n";

            string[] instrs = new string[4];
            instrs[0] = "add %r15, %r14";
            instrs[1] = "addss %xmm1, %xmm2";
            instrs[2] = "addss %xmm1, %xmm3";
            instrs[3] = "addss %xmm1, %xmm4";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true, initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movss xmm1, [r8]\n" +
                "  movss xmm2, [r8 + 4]\n" +
                "  movss xmm3, [r8 + 8]\n" +
                "  movss xmm4, [r8 + 12]\n" +
                "  movss xmm5, [r8 + 16]\n";

            string[] instrs = new string[4];
            instrs[0] = "add r14, r15";
            instrs[1] = "addss xmm2, xmm1";
            instrs[2] = "addss xmm3, xmm1";
            instrs[3] = "addss xmm4, xmm1";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true, initInstrs);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string initInstrs = "  ldr s17, [x2]\n" +
                "  ldr s18, [x2, 4]\n" +
                "  ldr s19, [x2, 8]\n" +
                "  ldr s20, [x2, 12]\n" +
                "  ldr s21, [x2, 16]\n";

            string[] instrs = new string[4];
            instrs[0] = "  add x15, x15, x11";
            instrs[1] = "  fadd s18, s18, s17";
            instrs[2] = "  fadd s19, s19, s17";
            instrs[3] = "  fadd s20, s20, s17";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true, initInstrs);
        }
    }
}
