using System.Text;

namespace AsmGen
{
    public class MixIntVec128RfTest : UarchTest
    {
        public MixIntVec128RfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixintvec128";
            this.Description = "Mixed integer and 128-bit vector register file capacity";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return false;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string initInstrs = "  vmovups (%r8), %ymm0\n" +
                 "  movss (%r8), %xmm1\n" +
                 "  vmovups %ymm0, %ymm2\n" +
                 "  movss (%r8), %xmm3\n" +
                 "  vmovups %ymm0, %ymm4\n" +
                 "  movss (%r8), %xmm5\n";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  add %r11, %r15";
                unrolledAdds[1] = "  addss %xmm5, %xmm2";
                unrolledAdds[2] = "  add %r11, %r14";
                unrolledAdds[3] = "  addss %xmm5, %xmm4";

                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string initInstrs = "  ldr q0, [x1]\n" +
                "  ldr q1, [x1, #0x10]\n" +
                "  ldr q2, [x1, #0x20]\n" +
                "  ldr q3, [x1, #0x30]\n" +
                "  ldr q4, [x1, #0x40]\n";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  add v1.4s, v1.4s, v0.4s";
                unrolledAdds[1] = "  add x15, x15, x11";
                unrolledAdds[2] = "  add v2.4s, v2.4s, v0.4s";
                unrolledAdds[3] = "  add x14, x14, x11";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
            }
        }
    }
}
