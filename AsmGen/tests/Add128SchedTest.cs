using System.Text;

namespace AsmGen
{
    public class Add128SchedTest : UarchTest
    {
        public Add128SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "add128sched";
            this.Description = "128-bit Vector Add Scheduler";
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
                string postLoadInstr1 = "  movq %rdi, %xmm0";
                string postLoadInstr2 = "  movq %rsi, %xmm0";
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  paddq %xmm0, %xmm1";
                unrolledAdds[1] = "  paddq %xmm0, %xmm2";
                unrolledAdds[2] = "  paddq %xmm0, %xmm3";
                unrolledAdds[3] = "  paddq %xmm0, %xmm4";

                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false,
                    postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
            }
        }
    }
}
