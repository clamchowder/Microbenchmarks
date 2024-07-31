using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class MixFpRfDepBranchTest : UarchTest
    {
        private int interval;
        public MixFpRfDepBranchTest(int low, int high, int step, int interval)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixfprfdepbranch" + interval;
            this.Description = "FP Register File, with some dependent branches";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *fpArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
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
                string initInstrs = "  ldr s17, [x2]\n" +
                    "  ldr s18, [x2, 4]\n" +
                    "  ldr s19, [x2, 8]\n" +
                    "  ldr s20, [x2, 12]\n" +
                    "  ldr s21, [x2, 16]\n";

                List<string> unrolledAddsList = new List<string>();
                for (int i = 0; i < this.Counts[this.Counts.Length - 1]; i++)
                {
                    int regnum = 18 + (i % 4);
                    unrolledAddsList.Add($"  fadd s{regnum}, s{regnum}, s17");
                    if (i % interval == 0) unrolledAddsList.Add("  cmp x25, x26\n  b.eq mixfpjumpsched_badthing" + interval);
                }
                string[] unrolledAdds = unrolledAddsList.ToArray();
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: true, initInstrs: initInstrs);

                sb.AppendLine($"mixfpjumpsched_badthing{interval}:\n  .word 0xf7f0a000");
            }
        }
    }
}
