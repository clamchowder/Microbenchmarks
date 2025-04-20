using System.Text;

namespace AsmGen
{
    public class MixFaddAddSchedTest : UarchTest
    {
        public MixFaddAddSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixfaddaddsched";
            this.Description = "Integer Add and FP Add Scheduler";
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
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  addss %xmm0, %xmm1";
                unrolledAdds[1] = "  add %rdi, %r12";
                unrolledAdds[2] = "  addss %xmm0, %xmm3";
                unrolledAdds[3] = "  add %rdi, %r13";

                UarchTestHelpers.GenerateX86AsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
            }
        }
    }
}
