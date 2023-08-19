using System.Text;

namespace AsmGen
{
    public class MaddSchedTest : UarchTest
    {
        public MaddSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "maddsched";
            this.Description = "Scheduler, Integer Multiply-Add";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64)
            {
                string[] unrolledMuls = new string[4];
                unrolledMuls[0] = "  madd x15, x15, x25, x10";
                unrolledMuls[1] = "  madd x14, x14, x25, x10";
                unrolledMuls[2] = "  madd x13, x13, x25, x10";
                unrolledMuls[3] = "  madd x12, x12, x25, x10";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls, includePtrChasingLoads: false);
            }
        }
    }
}
