using System.Text;

namespace AsmGen
{
    public class JumpNsqTest : UarchTest
    {
        public JumpNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "jmpnsq";
            this.Description = "Not-taken Jump Scheduler Capacity Test, Excluding NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string ohnoLabelName = "jumpnsq_reallybadthing";
            string[] dependentJumps = new string[1];
            dependentJumps[0] = $"  cmp %rdi, %rsi\n  je {ohnoLabelName}";

            // R14 is set to 1, so the test instruction will never set the zero flag
            string[] independentJumps = new string[1];
            independentJumps[0] = $" test %r14, %r14\n  je {ohnoLabelName}";

            UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentJumps, independentJumps, false);

            sb.AppendLine(ohnoLabelName + ":");
            sb.AppendLine("  int3");
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string ohnoLabelName = "jumpnsq_reallybadthing";
            string[] dependentJumps = new string[1];
            dependentJumps[0] = $"  cmp rdi, rsi\n  je {ohnoLabelName}";

            // R14 is set to 1, so the test instruction will never set the zero flag
            string[] independentJumps = new string[1];
            independentJumps[0] = $" test r14, r14\n  je {ohnoLabelName}";

            UarchTestHelpers.GenerateX86NasmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentJumps, independentJumps, false);

            sb.AppendLine(ohnoLabelName + ":");
            sb.AppendLine("  int3");
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            // todo
            string[] unrolledJumps = new string[1];
            unrolledJumps[0] = "  cmp x25, x26\n  b.eq jumpsched_reallybadthing";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched_reallybadthing:");
            sb.AppendLine("  .word 0xf7f0a000");
        }
    }
}
