using System.Text;

namespace AsmGen
{
    public class LeaSchedTest : UarchTest
    {
        public LeaSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "leasched";
            this.Description = "Scheduler, lea with base + index + offset";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
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
                unrolledAdds[0] = "  lea 128(%r15, %rdi), %r15";
                unrolledAdds[1] = "  lea 128(%r14, %rdi), %r14";
                unrolledAdds[2] = "  lea 128(%r13, %rdi), %r13";
                unrolledAdds[3] = "  lea 128(%r12, %rdi), %r12";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false);
            }
        }
    }
}
