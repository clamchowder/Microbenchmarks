using System.Text;

namespace AsmGen
{
    public class JumpNsqTest : UarchTest
    {
        public JumpNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "jumpnsq";
            this.Description = "Scheduler, Not-Taken Jumps, excluding possible nsq";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
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
                string[] dependentJumps = new string[1];
                dependentJumps[0] = "  cmp %rdi, %rsi\n  je jumpnsq_reallybadthing";
                string[] independentJumps = new string[1];
                independentJumps[0] = "  cmp %r13, %r14\n  je jumpnsq_reallybadthing";
                UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentJumps, independentJumps);

                sb.AppendLine("jumpnsq_reallybadthing:\n  int3");
            }
        }
    }
}
