using System.Text;

namespace AsmGen
{
    public class StoreSchedTest : UarchTest
    {
        public StoreSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "storesched";
            this.Description = "Store Address Scheduler";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            // if (isa == IUarchTest.ISA.mips64) return true;
            // if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] dependentStores = new string[4];
                dependentStores[0] = "  mov %r15, (%r8, %rdi, 4)";
                dependentStores[1] = "  mov %r14, (%r8, %rdi, 4)";
                dependentStores[2] = "  mov %r13, (%r8, %rdi, 4)";
                dependentStores[3] = "  mov %r12, (%r8, %rdi, 4)";

                string[] dependentStores1 = new string[4];
                dependentStores1[0] = "  mov %r15, (%r8, %rsi, 4)";
                dependentStores1[1] = "  mov %r14, (%r8, %rsi, 4)";
                dependentStores1[2] = "  mov %r13, (%r8, %rsi, 4)";
                dependentStores1[3] = "  mov %r12, (%r8, %rsi, 4)";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores1, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] dependentStores = new string[4];
                dependentStores[0] = "  str w15, [x2, w25, uxtw #2]";
                dependentStores[1] = "  str w14, [x2, w25, uxtw #2]";
                dependentStores[2] = "  str w13, [x2, w25, uxtw #2]";
                dependentStores[3] = "  str w12, [x2, w25, uxtw #2]";

                string[] dependentStores1 = new string[4];
                dependentStores1[0] = "  str w15, [x2, w26, uxtw #2]";
                dependentStores1[1] = "  str w14, [x2, w26, uxtw #2]";
                dependentStores1[2] = "  str w13, [x2, w26, uxtw #2]";
                dependentStores1[3] = "  str w12, [x2, w26, uxtw #2]";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores1, includePtrChasingLoads: true);
            }
        }
    }
}
