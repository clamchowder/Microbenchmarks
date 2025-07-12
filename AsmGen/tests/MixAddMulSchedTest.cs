using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class MixAddMulSchedTest : UarchTest
    {
        public MixAddMulSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixaddmulsched";
            this.Description = "Scheduler, Mixed Integer Adds and Multiplies";
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
                List<string> unrolledAddsList = new List<string>();
                for (int i = 0; i < this.Counts[this.Counts.Length - 1]; i++)
                {
                    if (i < 30) unrolledAddsList.Add("  add x15, x15, x25");
                    else unrolledAddsList.Add("  mul x13, x13, x25");
                }

                string[] unrolledAdds = unrolledAddsList.ToArray();
                /*string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  add x15, x15, x25";
                unrolledAdds[1] = "  mul x14, x14, x25";
                unrolledAdds[2] = "  add x13, x13, x25";
                unrolledAdds[3] = "  mul x12, x12, x25";*/
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false);
            }
        }
    }
}
