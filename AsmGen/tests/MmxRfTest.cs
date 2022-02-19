using System.Text;

namespace AsmGen
{
    public class MmxRfTest : UarchTest
    {
        public MmxRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mmxrf";
            this.Description = "64-bit MMX RF Capacity Test. 1:1 mix of scalar/128 fp on ARM";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  movq (%rdx), %mm0\n" +
                "  movq 8(%rdx), %mm1\n" +
                "  movq 16(%rdx), %mm2\n" +
                "  movq 24(%rdx), %mm3\n" +
                "  movq 32(%rdx), %mm4\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddw %mm0, %mm1";
            unrolledAdds[1] = "  paddw %mm0, %mm2";
            unrolledAdds[2] = "  paddw %mm0, %mm3";
            unrolledAdds[3] = "  paddw %mm0, %mm4";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movq mm0, [rdx]\n" +
                "  movq mm1, [rdx + 8]\n" +
                "  movq mm2, [rdx + 16]\n" +
                "  movq mm3, [rdx + 24]\n" +
                "  movq mm4, [rdx + 32]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddw mm1, mm0";
            unrolledAdds[1] = "  paddw mm2, mm0";
            unrolledAdds[2] = "  paddw mm3, mm0";
            unrolledAdds[3] = "  paddw mm4, mm0";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string initInstrs = "  ldr q0, [x1]\n" +
                "  ldr s1, [x1, #0x10]\n" +
                "  ldr s2, [x1, #0x20]\n" +
                "  ldr s3, [x1, #0x30]\n" +
                "  ldr s4, [x1, #0x40]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fadd v0.4s, v0.4s, v0.4s";
            unrolledAdds[1] = "  fadd s1, s1, s1";
            unrolledAdds[2] = "  fadd v2.4s, v2.4s, v2.4s";
            unrolledAdds[3] = "  fadd s3, s3, s3";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }
    }
}
