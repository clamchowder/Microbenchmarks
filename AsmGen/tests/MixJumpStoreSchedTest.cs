using System.Text;

namespace AsmGen
{
    public class MixJumpStoreSchedTest : UarchTest
    {
        public MixJumpStoreSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixjumpstoresched";
            this.Description = "Scheduler, Mixed Jumps and Stores (Address Dependency)";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatarr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            //if (isa == IUarchTest.ISA.aarch64) return true;
            // if (isa == IUarchTest.ISA.mips64) return true;
            // if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] unrolledJumps = new string[4];
                unrolledJumps[0] = "  cmp %rdi, %rsi\n  je mixstorejumpsched_reallybadthing";
                unrolledJumps[1] = "  mov %r14, (%r8, %rdi, 2)";
                unrolledJumps[2] = "  cmp %rdi, %rsi\n  je mixstorejumpsched_reallybadthing";
                unrolledJumps[3] = "  mov %r14, 64(%r8, %rdi, 2)";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, includePtrChasingLoads: true);

                sb.AppendLine("mixstorejumpsched_reallybadthing:\n  int3");
            }
        }
    }
}
