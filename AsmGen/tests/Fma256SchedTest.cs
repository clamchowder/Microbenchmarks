using System.Text;

namespace AsmGen
{
    public class Fma256SchedTest : UarchTest
    {
        public Fma256SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fma256sched";
            this.Description = "256-bit FP add scheduler";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return false;
            if (isa == IUarchTest.ISA.aarch64) return false;
            if (isa == IUarchTest.ISA.mips64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                // ymm0 is dependent on ptr chasing load
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  vaddps %ymm0, %ymm1, %ymm1";
                unrolledAdds[1] = "  vaddps %ymm0, %ymm2, %ymm2";
                unrolledAdds[2] = "  vaddps %ymm0, %ymm3, %ymm3";
                unrolledAdds[3] = "  vaddps %ymm0, %ymm4, %ymm3";

                UarchTestHelpers.GenerateX86AsmFp256SchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
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
                initInstrs += "  move $r16, $r0\n  addi.d $r16, $r16, 0xF"; // load mask into r16

                string postLoadInstrs1 = "  and $r15, $r12, $r16\n  xvldx $xr1, $r6, $r15";
                string postLoadInstrs2 = "  and $r15, $r13, $r16\n  xvldx $xr1, $r6, $r15";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  xvfmadd.s $xr2, $xr2, $xr2, $xr1";
                unrolledAdds[1] = "  xvfmadd.s $xr3, $xr3, $xr3, $xr1";
                unrolledAdds[2] = "  xvfmadd.s $xr4, $xr4, $xr4, $xr1";
                unrolledAdds[3] = "  xvfmadd.s $xr5, $xr5, $xr5, $xr1";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false, initInstrs: initInstrs,
                    postLoadInstrs1: postLoadInstrs1, postLoadInstrs2: postLoadInstrs2);
            }
        }
    }
}
