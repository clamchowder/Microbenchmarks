using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class MixIntRfDepBranchTest : UarchTest
    {
        private int interval;
        public MixIntRfDepBranchTest(int low, int high, int step, int interval)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixintrfdepbranch" + interval;
            this.Description = "Integer Register File, with some dependent branches";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
            this.interval = interval;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64)
            {
                List<string> unrolledAddsList = new List<string>();
                for (int i = 1; i < this.Counts[this.Counts.Length - 1] + 1; i++)
                {
                    int regnum = 12 + (i % 4);
                    unrolledAddsList.Add($"  add x{regnum}, x{regnum}, x11");
                    if (i % interval == 0) unrolledAddsList.Add("  cmp x25, x26\n  b.eq mixintjumpsched_badthing" + interval);
                }
                string[] unrolledAdds = unrolledAddsList.ToArray();
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: true);

                sb.AppendLine($"mixintjumpsched_badthing{interval}:\n  .word 0xf7f0a000");
            }
        }
    }
}
