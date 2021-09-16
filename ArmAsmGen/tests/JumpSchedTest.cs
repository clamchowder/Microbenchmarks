using System.Text;

namespace AsmGen
{
    public class JumpSchedTest : UarchTest
    {
        public string Prefix { get => "jmpsched"; }
        public string Description { get => "Not-taken Jump Scheduler Capacity Test"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr"; }
        public string GetFunctionCallParameters { get => "structIterations, A"; }

        public int[] Counts { get; private set; }

        public JumpSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[1];
            unrolledJumps[0] = $"  cmp %rdi, %rsi\n  je jumpsched_reallybadthing";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched_reallybadthing:");
            sb.AppendLine("  int3");
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[1];
            unrolledJumps[0] = "  cmp rdi, rsi\n  je jumpsched_reallybadthing";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched_reallybadthing:");
            sb.AppendLine("  int3");
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[1];
            unrolledJumps[0] = "  cmp x25, x26\n  b.eq jumpsched_reallybadthing";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched_reallybadthing:");
            sb.AppendLine("  .word 0xf7f0a000");
        }
    }
}
