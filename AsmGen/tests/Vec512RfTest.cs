using System.Text;

namespace AsmGen
{
    public class Vec512RfTest : UarchTest
    {
        public Vec512RfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "vec512rf";
            this.Description = "Vector (512-bit packed fp) RF Test - x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            // it's ok, the ptr chasing arr should be way bigger than this
            string initInstrs = "  vmovups (%r8), %zmm1\n" +
                "  vmovups 64(%r8), %zmm2\n" +
                "  vmovups 128(%r8), %zmm3\n" +
                "  vmovups 192(%r8), %zmm4\n" +
                "  vmovups 256(%r8), %zmm5\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vaddps %zmm1, %zmm2, %zmm2";
            unrolledAdds[1] = "  vaddps %zmm1, %zmm3, %zmm3";
            unrolledAdds[2] = "  vaddps %zmm1, %zmm4, %zmm4";
            unrolledAdds[3] = "  vaddps %zmm1, %zmm5, %zmm5";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovups zmm1, [r8]\n" +
                "  vmovups zmm2, [r8 + 64]\n" +
                "  vmovups zmm3, [r8 + 128]\n" +
                "  vmovups zmm4, [r8 + 192]\n" +
                "  vmovups zmm5, [r8 + 256]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vaddps zmm2, zmm2, zmm1";
            unrolledAdds[1] = "  vaddps zmm3, zmm3, zmm1";
            unrolledAdds[2] = "  vaddps zmm4, zmm4, zmm1";
            unrolledAdds[3] = "  vaddps zmm5, zmm5, zmm1";
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
