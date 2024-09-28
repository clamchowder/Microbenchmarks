using System.Text;

namespace AsmGen
{
    public class AddNsq : UarchTest
    {
        private int totalOps;
        public AddNsq(int low, int high, int step, int totalOps)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "addnsq" + totalOps;
            this.Description = "Integer adds, excluding possible NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.totalOps = totalOps;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            // if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] depInstrs = new string[2];
                depInstrs[0] = "  add %rdi, %r15";
                depInstrs[1] = "  add %rdi, %r14";

                string[] indepInstrs = new string[2];
                indepInstrs[0] = "  add %r13, %r11";
                indepInstrs[1] = "  add %r12, %r11";
                UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.totalOps, this.Counts, this.Prefix, depInstrs, indepInstrs, false);
            }
        }
    }
}
