using System.Text;

namespace AsmGen
{
    public class MixAddFadd128SchedTest : UarchTest
    {
        public MixAddFadd128SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixaddfadd128sched";
            this.Description = "128-bit Vector Add/FP Add Scheduler";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string postLoadInstr1 = "  movq %rdi, %xmm0\n  cvtsi2ss %rdi, %xmm1";
                string postLoadInstr2 = "  movq %rsi, %xmm0\n  cvtsi2ss %rsi, %xmm1";
                string[] unrolledAdds = new string[2];
                unrolledAdds[0] = "  paddq %xmm0, %xmm2";
                unrolledAdds[1] = "  paddq %xmm1, %xmm3";

                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false,
                    postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
            }
        }
    }
}
