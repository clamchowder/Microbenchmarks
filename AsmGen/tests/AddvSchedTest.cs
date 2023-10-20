using System.Text;

namespace AsmGen
{
    public class AddvSched : UarchTest
    {
        public AddvSched(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "addvsched";
            this.Description = "ADDV Scheduler";
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
                string postLoadInstrs1 = "  ldr q16, [x2, w25, sxtw #0]";
                string postLoadInstrs2 = "  ldr q16, [x2, w25, sxtw #0]";
                string[] unrolledInstrs = new string[4];
                unrolledInstrs[0] = "  addv h1, v16.4h";
                unrolledInstrs[1] = "  addv h2, v16.4h";
                unrolledInstrs[2] = "  addv h3, v16.4h";
                unrolledInstrs[3] = "  addv h4, v16.4h";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs, false, null,
                    postLoadInstrs1: postLoadInstrs1, postLoadInstrs2: postLoadInstrs2);
            }
        }
    }
}
