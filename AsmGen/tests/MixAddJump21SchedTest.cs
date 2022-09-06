using System.Text;

namespace AsmGen
{
    public class MixAddJmp21Sched : UarchTest
    {
        public MixAddJmp21Sched(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixaddjmp21sched";
            this.Description = "Not-taken Jump + Add Scheduler Capacity Test, 1:2 ratio";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  add %rdi, %r11";
            string postLoadInstr2 = "  add %rsi, %r11";
            string[] unrolledJumps = new string[3];
            unrolledJumps[0] = $"  cmp %rdi, %rsi\n  je jumpsched21_reallybadthing_jadd";
            unrolledJumps[1] = "  add %r11, %r15";
            unrolledJumps[2] = "  add %r11, %r14";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);

            sb.AppendLine("jumpsched21_reallybadthing_jadd:");
            sb.AppendLine("  int3");
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[3];
            unrolledJumps[0] = "  cmp rdi, rsi\n  je jumpsched21_reallybadthing_jadd";
            unrolledJumps[1] = "  add r15, rdi";
            unrolledJumps[2] = "  add r14, rdi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched21_reallybadthing_jadd:");
            sb.AppendLine("  int3");
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledJumps = new string[3];
            //string initInstrs = "jumpsched_reallybadthing_jadd:";
            unrolledJumps[0] = "  add x14, x13, x25";
            unrolledJumps[1] = "  add x12, x13, x25";
            unrolledJumps[2] = "  cbz w12, jumpsched21_reallybadthing_jadd";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched21_reallybadthing_jadd:");
            sb.AppendLine("  .word 0xf7f0a000");
        }
    }
}
