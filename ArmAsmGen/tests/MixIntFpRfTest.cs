using System.Text;

namespace AsmGen
{
    public class MixIntFpRfTest : UarchTest
    {
        public string Prefix { get => "mixintfprf"; }
        public string Description { get => "Mix of integer and FP register file"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr, float *floatArr"; }
        public string GetFunctionCallParameters { get => "structIterations, A, fpArr"; }

        public int[] Counts { get; private set; }
        public bool DivideTimeByCount => false;

        public MixIntFpRfTest(int low, int high, int step)
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

            string[] instrs = new string[8];
            instrs[0] = "add %r15, %r14";
            instrs[1] = "addss %xmm1, %xmm2";
            instrs[2] = "add %r15, %r13";
            instrs[3] = "addss %xmm1, %xmm3";
            instrs[4] = "add %r15, %r12";
            instrs[5] = "addss %xmm1, %xmm4";
            instrs[6] = "add %r15, %r11";
            instrs[7] = "addss %xmm1, %xmm5";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true, initInstrs);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movss xmm1, [r8]\n" +
                "  movss xmm2, [r8 + 4]\n" +
                "  movss xmm3, [r8 + 8]\n" +
                "  movss xmm4, [r8 + 12]\n" +
                "  movss xmm5, [r8 + 16]\n";

            string[] instrs = new string[8];
            instrs[0] = "add r14, r15";
            instrs[1] = "addss xmm2, xmm1";
            instrs[2] = "add r13, r15";
            instrs[3] = "addss xmm3, xmm1";
            instrs[4] = "add r12, r15";
            instrs[5] = "addss xmm4, xmm1";
            instrs[6] = "add r11, r15";
            instrs[7] = "addss xmm5, xmm1";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true, initInstrs);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string initInstrs = "  ldr s17, [x2]\n" +
                "  ldr s18, [x2, 4]\n" +
                "  ldr s19, [x2, 8]\n" +
                "  ldr s20, [x2, 12]\n" +
                "  ldr s21, [x2, 16]\n";

            string[] instrs = new string[8];
            instrs[0] = "  add x15, x15, x11";
            instrs[1] = "  fadd s18, s18, s17";
            instrs[2] = "  add x14, x14, x11";
            instrs[3] = "  fadd s19, s19, s17";
            instrs[4] = "  add x13, x13, x11";
            instrs[3] = "  fadd s20, s20, s17";
            instrs[6] = "  add x12, x12, x11";
            instrs[7] = "  fadd s21, s21, s17";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true, initInstrs);
        }
    }
}
