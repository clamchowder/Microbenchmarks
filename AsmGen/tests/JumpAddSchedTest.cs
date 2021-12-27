using System.Text;

namespace AsmGen
{
    public class JumpAddSchedTest : UarchTest
    {
        public JumpAddSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "jmpaddsched";
            this.Description = "Not-taken Jump + Add Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  add %rdi, %r11";
            string postLoadInstr2 = "  add %rsi, %r11";
            string[] unrolledJumps = new string[2];
            unrolledJumps[0] = $"  cmp %rdi, %rsi\n  je jumpsched_reallybadthing_jadd";
            unrolledJumps[1] = "  add %r11, %r15";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);

            sb.AppendLine("jumpsched_reallybadthing_jadd:");
            sb.AppendLine("  int3");
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[2];
            unrolledJumps[0] = "  cmp rdi, rsi\n  je jumpsched_reallybadthing_jadd";
            unrolledJumps[1] = "  add r15, rdi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched_reallybadthing_jadd:");
            sb.AppendLine("  int3");
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[2];
            //string initInstrs = "jumpsched_reallybadthing_jadd:";
            unrolledJumps[0] = "  cmp x25, x26\n  b.eq jumpsched_reallybadthing_jadd";
            unrolledJumps[1] = "  add w14, w13, w25";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched_reallybadthing_jadd:");
            sb.AppendLine("  .word 0xf7f0a000");
        }
    }
}
