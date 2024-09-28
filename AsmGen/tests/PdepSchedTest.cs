using System.Text;

namespace AsmGen
{
    public class PdepSchedTest : UarchTest
    {
        public PdepSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "pdepsched";
            this.Description = "Scheduler, PDEP";
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
                unrolledAdds[0] = "  pdep %rdi, %r15, %r15";
                unrolledAdds[1] = "  pdep %rdi, %r14, %r14";
                unrolledAdds[2] = "  pdep %rdi, %r13, %r13";
                unrolledAdds[3] = "  pdep %rdi, %r12, %r12";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false);
            }
        }
    }
}
