using System.Text;

namespace AsmGen
{
    public class Vec256RfTest : UarchTest
    {
        public Vec256RfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "vec256rf";
            this.Description = "Vector (256-bit packed fp) RF Test - x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            // it's ok, the ptr chasing arr should be way bigger than this
            string initInstrs = "  vmovups (%r8), %ymm1\n" +
                "  vmovups 32(%r8), %ymm2\n" +
                "  vmovups 64(%r8), %ymm3\n" +
                "  vmovups 96(%r8), %ymm4\n" +
                "  vmovups 128(%r8), %ymm5\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vaddps %ymm1, %ymm2, %ymm2";
            unrolledAdds[1] = "  vaddps %ymm1, %ymm3, %ymm3";
            unrolledAdds[2] = "  vaddps %ymm1, %ymm4, %ymm4";
            unrolledAdds[3] = "  vaddps %ymm1, %ymm5, %ymm5";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovups ymm1, [r8]\n" +
                "  vmovups ymm2, [r8 + 32]\n" +
                "  vmovups ymm3, [r8 + 64]\n" +
                "  vmovups ymm4, [r8 + 96]\n" +
                "  vmovups ymm5, [r8 + 128]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vaddps ymm2, ymm2, ymm1";
            unrolledAdds[1] = "  vaddps ymm3, ymm3, ymm1";
            unrolledAdds[2] = "  vaddps ymm4, ymm4, ymm1";
            unrolledAdds[3] = "  vaddps ymm5, ymm5, ymm1";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string initInstrs = "  ldr q0, [x1]\n" +
                "  ldr q1, [x1, #0x10]\n" +
                "  ldr q2, [x1, #0x20]\n" +
                "  ldr q3, [x1, #0x30]\n" +
                "  ldr q4, [x1, #0x40]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add v1.4s, v1.4s, v0.4s";
            unrolledAdds[1] = "  add v2.4s, v2.4s, v0.4s";
            unrolledAdds[2] = "  add v3.4s, v3.4s, v0.4s";
            unrolledAdds[3] = "  add v4.4s, v4.4s, v0.4s";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }
    }
}
