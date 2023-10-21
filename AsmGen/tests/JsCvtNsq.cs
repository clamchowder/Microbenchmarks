using System.Text;

namespace AsmGen
{
    public class JsCvtNsq : UarchTest
    {
        private int totalOps;
        public JsCvtNsq(int low, int high, int step, int totalOps)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "jscvtnsq";
            this.Description = "FJCVTZS (FP Javascript Convert to Signed Fixed Point, Rounding toward Zero) Scheduler, excluding possible NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.totalOps = totalOps;
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
                string postLoadInstrs1 = "  ldr d16, [x2, w25, sxtw #0]";
                string initInstrs = "  ldr d15, [x2]";
                string[] depInstrs = new string[4];
                depInstrs[0] = "  fjcvtzs w15, d16";
                depInstrs[1] = "  fjcvtzs w14, d16";
                depInstrs[2] = "  fjcvtzs w13, d16";
                depInstrs[3] = "  fjcvtzs w12, d16";

                string[] indepInstrs = new string[4];
                indepInstrs[0] = "  fjcvtzs w15, d15";
                indepInstrs[1] = "  fjcvtzs w14, d15";
                indepInstrs[2] = "  fjcvtzs w13, d15";
                indepInstrs[3] = "  fjcvtzs w12, d15";
                UarchTestHelpers.GenerateArmAsmNsqTestFuncs(sb, this.totalOps, this.Counts, this.Prefix, depInstrs, indepInstrs, false, initInstrs,
                    postLoadInstrs: postLoadInstrs1);
            }
        }
    }
}
