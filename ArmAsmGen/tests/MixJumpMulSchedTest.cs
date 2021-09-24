using System.Text;

namespace AsmGen
{
    public class MixJmpMulSchedTest : UarchTest
    {
        public MixJmpMulSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixmuljmpsched";
            this.Description = "Mixed integer multiply and not-taken Jump Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[2];
            unrolledJumps[0] = "  cmp %rdi, %rsi\n  je muljmpsched_reallybadthing";
            unrolledJumps[1] = "  imul %edi, %r12d";

            string[] unrolledJumps1 = new string[2];
            unrolledJumps1[0] = "  cmp %rdi, %rsi\n  je muljmpsched_reallybadthing";
            unrolledJumps1[1] = "  imul %esi, %r11d";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps1, false);

            sb.AppendLine("muljmpsched_reallybadthing:");
            sb.AppendLine("  int3");
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[2];
            unrolledJumps[0] = "  cmp rdi, rsi\n  je muljmpsched_reallybadthing";
            unrolledJumps[0] = "  imul r12d, edi";

            string[] unrolledJumps1 = new string[2];
            unrolledJumps1[0] = "  cmp rdi, rsi\n  je muljmpsched_reallybadthing";
            unrolledJumps1[0] = "  imul r11d, esi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps1, false);

            sb.AppendLine("muljmpsched_reallybadthing:");
            sb.AppendLine("  int3");
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[2];
            unrolledJumps[0] = "  cmp x25, x26\n  b.eq muljmpsched_reallybadthing";
            unrolledJumps[1] = "  mul x12, x12, x25";

            string[] unrolledJumps1 = new string[2];
            unrolledJumps1[0] = "  cmp x25, x26\n  b.eq muljmpsched_reallybadthing";
            unrolledJumps1[1] = "  mul x14, x14, x26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("muljmpsched_reallybadthing:");
            sb.AppendLine("  .word 0xf7f0a000");
        }
    }
}
