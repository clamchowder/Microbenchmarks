using System.Text;

namespace AsmGen
{
    public class MixAddvJsCvtNsq : UarchTest
    {
        public MixAddvJsCvtNsq(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixaddvjscvtnsq";
            this.Description = "ADDV and fjcvtzs Scheduler, Excluding any NSQ";
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
                string initInstrs = "  ldr q17, [x2]\n  ldr d15, [x2]";
                string[] depInstrs = new string[4];
                depInstrs[0] = "  addv h1, v16.4h";
                depInstrs[1] = "  fjcvtzs w15, d2";
                depInstrs[2] = "  addv h3, v16.4h";
                depInstrs[3] = "  fjcvtzs w14, d2";

                string[] indepInstrs = new string[4];
                indepInstrs[0] = "  addv h4, v17.4h";
                indepInstrs[1] = "  fjcvtzs w12, d15";
                indepInstrs[2] = "  addv h5, v17.4h";
                indepInstrs[3] = "  fjcvtzs w13, d15";
                UarchTestHelpers.GenerateArmAsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, depInstrs, indepInstrs, false, initInstrs: initInstrs,
                    postLoadInstrs: postLoadInstrs1);
            }
        }
    }
}
