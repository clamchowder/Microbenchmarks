using System.Text;

namespace AsmGen
{
    public class Fadd256RfTest : UarchTest
    {
        public Fadd256RfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fadd256rf";
            this.Description = "256-bit FP/vector RF capacity";
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
                 "  vmovups %ymm0, %ymm1\n" +
                 "  vmovups %ymm0, %ymm2\n" +
                 "  vmovups %ymm0, %ymm3\n" +
                 "  vmovups %ymm0, %ymm4\n";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  vaddps %ymm0, %ymm1, %ymm1";
                unrolledAdds[1] = "  vaddps %ymm0, %ymm2, %ymm2";
                unrolledAdds[2] = "  vaddps %ymm0, %ymm3, %ymm3";
                unrolledAdds[3] = "  vaddps %ymm0, %ymm4, %ymm3";

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
                }

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  xvfadd.s $xr1, $xr1, $xr1";
                unrolledAdds[1] = "  xvfadd.s $xr2, $xr2, $xr2";
                unrolledAdds[2] = "  xvfadd.s $xr3, $xr3, $xr3";
                unrolledAdds[3] = "  xvfadd.s $xr4, $xr4, $xr4";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false, initInstrs: initInstrs);
            }
        }
    }
}
