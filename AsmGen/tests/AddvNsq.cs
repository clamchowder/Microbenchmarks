using System.Text;

namespace AsmGen
{
    public class AddvNsq : UarchTest
    {
        private int totalOps;
        public AddvNsq(int low, int high, int step, int totalOps)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "addvnsq";
            this.Description = "ADDV, excluding possible NSQ";
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
                depInstrs[0] = "  addv h1, v16.4h";
                depInstrs[1] = "  addv h2, v16.4h";
                depInstrs[2] = "  addv h3, v16.4h";
                depInstrs[3] = "  addv h4, v16.4h";

                string[] indepInstrs = new string[4];
                indepInstrs[0] = "  addv h1, v15.4h";
                indepInstrs[1] = "  addv h2, v15.4h";
                indepInstrs[2] = "  addv h3, v15.4h";
                indepInstrs[3] = "  addv h4, v15.4h";
                UarchTestHelpers.GenerateArmAsmNsqTestFuncs(sb, this.totalOps, this.Counts, this.Prefix, depInstrs, indepInstrs, false, initInstrs,
                    postLoadInstrs: postLoadInstrs1);
            }
        }
    }
}
