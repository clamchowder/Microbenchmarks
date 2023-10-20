using System.Text;

namespace AsmGen
{
    public class MixAddvJsCvtSched : UarchTest
    {
        public MixAddvJsCvtSched(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixaddvjscvtsched";
            this.Description = "ADDV and fjcvtzs Scheduler";
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
                string postLoadInstrs1 = "  ldr q16, [x2, w25, sxtw #0]\n  ldr d2, [x2, w25, sxtw #0]";
                string postLoadInstrs2 = "  ldr q16, [x2, w26, sxtw #0]\n  ldr d2, [x2, w26, sxtw #0]";
                string[] unrolledInstrs = new string[4];
                unrolledInstrs[0] = "  addv h1, v16.4h";
                unrolledInstrs[1] = "  fjcvtzs w15, d2";
                unrolledInstrs[2] = "  addv h3, v16.4h";
                unrolledInstrs[3] = "  fjcvtzs w14, d2";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs, false, null,
                    postLoadInstrs1: postLoadInstrs1, postLoadInstrs2: postLoadInstrs2);
            }
        }
    }
}
