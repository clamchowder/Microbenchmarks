using System.Text;

namespace AsmGen
{
    public class MixLoadStoreSched : UarchTest
    {
        public MixLoadStoreSched(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixloadstoresched";
            this.Description = "Mixed Load/Store Address Scheduler";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] dependentLoads = new string[4];
                dependentLoads[0] = "  mov %r15, (%r8, %rdi, 4)";
                dependentLoads[1] = "  mov (%r8, %rdi, 2), %r14";
                dependentLoads[2] = "  mov %r13, (%r8, %rdi, 4)";
                dependentLoads[3] = "  mov (%r8, %rdi, 2), %r12";

                string[] dependentLoads1 = new string[4];
                dependentLoads1[0] = "  mov %r15, (%r8, %rsi, 4)";
                dependentLoads1[1] = "  mov (%r8, %rsi, 4), %r14";
                dependentLoads1[2] = "  mov %r13, (%r8, %rsi, 4)";
                dependentLoads1[3] = "  mov (%r8, %rsi, 4), %r12";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] dependentLoads = new string[4];
                dependentLoads[0] = "  str w15, [x2, w25, uxtw #2]";
                dependentLoads[1] = "  ldr w14, [x1, w25, uxtw #0]";
                dependentLoads[2] = "  str w13, [x2, w25, uxtw #2]";
                dependentLoads[3] = "  ldr w12, [x1, w25, uxtw #0]";

                string[] dependentLoads1 = new string[4];
                dependentLoads1[0] = "  str w15, [x2, w26, uxtw #2]";
                dependentLoads1[1] = "  ldr w14, [x1, w26, uxtw #0]";
                dependentLoads1[2] = "  str w13, [x2, w26, uxtw #2]";
                dependentLoads1[3] = "  ldr w12, [x1, w26, uxtw #0]";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, includePtrChasingLoads: true);
            }
        }
    }
}
