using System.Text;

namespace AsmGen
{
    public class JumpAddNsqTest : UarchTest
    {
        public JumpAddNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "jumpaddnsq";
            this.Description = "Scheduler, Not-Taken Jumps and adds, excluding possible nsq";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] dependentJumps = new string[4];
                dependentJumps[0] = "  cmp %edi, %esi\n  je jumpaddnsq_reallybadthing";
                dependentJumps[1] = "  add %edi, %r15d";
                dependentJumps[2] = "  add %edi, %r15d";
                dependentJumps[3] = "  add %edi, %r15d";

                string[] independentJumps = new string[4];
                independentJumps[0] = "  cmp %r13d, %r14d\n  je jumpaddnsq_reallybadthing";
                independentJumps[1] = "  add %r11, %r12";
                independentJumps[2] = "  add %r11, %r12";
                independentJumps[3] = "  add %r11, %r12";
                UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentJumps, independentJumps);

                sb.AppendLine("jumpaddnsq_reallybadthing:\n  int3");
            }
        }
    }
}
