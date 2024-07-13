using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class MixJumpThenAddSched : UarchTest
    {
        public MixJumpThenAddSched(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixjumpthenaddsched";
            this.Description = "Scheduler, 40 NT jumps + adds";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            // if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            // if (isa == IUarchTest.ISA.mips64) return true;
            // if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64)
            {
                List<string> unrolledJumps = new List<string>();
                int instrIdx;
                for (instrIdx = 0; instrIdx < 40; instrIdx++) unrolledJumps.Add("  cmp x25, x26\n  b.eq mixaddthenjumpsched_reallybadthing");
                for (; instrIdx < this.Counts[this.Counts.Length - 1]; instrIdx++) unrolledJumps.Add("  add x15, x15, x25");
                string[] instrs = unrolledJumps.ToArray();
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, includePtrChasingLoads: true, dsb: true);
                sb.AppendLine("mixaddthenjumpsched_reallybadthing:\n  .word 0xf7f0a000");
            }
        }
    }
}
