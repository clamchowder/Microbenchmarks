using System.Text;

namespace AsmGen
{
    public class MixFAdd256and32RfTest : UarchTest
    {
        public MixFAdd256and32RfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fadd256and32rf";
            this.Description = "Mixed 32-bit scalar and 256-bit FP RF capacity";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return false;
            if (isa == IUarchTest.ISA.mips64) return true;
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
                unrolledAdds[0] = "  vaddps %ymm0, %ymm1, %ymm1";
                unrolledAdds[1] = "  addss %xmm5, %xmm2";
                unrolledAdds[2] = "  vaddps %ymm0, %ymm3, %ymm3";
                unrolledAdds[3] = "  addss %xmm5, %xmm4";

                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string initInstrs = "";
                for (int regIdx = 0; regIdx < 32; regIdx++)
                {
                    initInstrs += "  xvld $xr" + regIdx + ", $r6, " + regIdx * 32 + "\n";
                    initInstrs += "  fld.s $f" + regIdx + ", $r6, " + regIdx * 4 + "\n";
                }

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  xvfadd.s $xr1, $xr1, $xr1";
                unrolledAdds[1] = "  fadd.s $f11, $f11, $f11";
                unrolledAdds[2] = "  xvfadd.s $xr3, $xr3, $xr3";
                unrolledAdds[3] = "  fadd.s $f12, $f12, $f12";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false, initInstrs: initInstrs);
            }
        }
    }
}
