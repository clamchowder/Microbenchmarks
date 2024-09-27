using System.Text;

namespace AsmGen
{
    public class StoreDataNsq : UarchTest
    {
        public StoreDataNsq(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "storedatansq";
            this.Description = "Store Data Scheduler, excluding NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            // if (isa == IUarchTest.ISA.aarch64) return true;
            // if (isa == IUarchTest.ISA.mips64) return true;
            // if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] dependentLoads = new string[4];
                dependentLoads[0] = "  mov %rdi, (%r8)";
                dependentLoads[1] = "  mov %rdi, 8(%r8)";
                dependentLoads[2] = "  mov %rdi, 16(%r8)";
                dependentLoads[3] = "  mov %rdi, 24(%r8)";

                string[] independentLoads = new string[4];
                independentLoads[0] = "  mov %r14, (%r8)";
                independentLoads[1] = "  mov %r14, 8(%r8)";
                independentLoads[2] = "  mov %r14, 16(%r8)";
                independentLoads[3] = "  mov %r14, 24(%r8)";
                UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentLoads, independentLoads);
            }
        }
    }
}
