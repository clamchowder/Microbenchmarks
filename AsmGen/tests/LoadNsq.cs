using System.Text;

namespace AsmGen
{
    public class LoadNsq : UarchTest
    {
        public LoadNsq(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "loadnsq";
            this.Description = "Load Address Scheduler, Excluding any NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
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
                string[] dep = new string[3];
                dep[0] = "  ldr w15, [x2, w25, uxtw #2]";
                dep[1] = "  ldr w14, [x2, w25, uxtw #2]";
                dep[2] = "  ldr w13, [x2, w25, uxtw #2]";

                string[] indep = new string[3];
                indep[0] = "  ldr w12, [x2]";
                indep[1] = "  ldr w11, [x2]";
                indep[2] = "  ldr w10, [x2]";
                UarchTestHelpers.GenerateArmAsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dep, indep);
            }
        }
    }
}
