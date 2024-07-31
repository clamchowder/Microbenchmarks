using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    /// <summary>
    /// Looking for reordering capacity limits on A73 by combining several different instruction types
    /// </summary>
    public class A73RobTest : UarchTest
    {
        public A73RobTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "a73rob";
            this.Description = "Mixed integer/vec128 + stores";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
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
                string postLoadInstrs = UarchTestHelpers.GetArmDependentBranch(this.Prefix);
                string initInstrs = "  ldr q0, [x1]\n" +
                "  ldr q1, [x1, #0x10]\n" +
                "  ldr q2, [x1, #0x20]\n" +
                "  ldr q3, [x1, #0x30]\n" +
                "  ldr q4, [x1, #0x40]\n";

                List<string> fillerInstrs = new List<string>();
                for (int i = 0; i < this.Counts[this.Counts.Length - 1];i++)
                {
                    if (i < 33) fillerInstrs.Add("  add v1.4s, v1.4s, v0.4s");
                    else if (i < 66) fillerInstrs.Add("  add x15, x15, x11");
                    else fillerInstrs.Add("  str x12, [x2]");
                }

                string[] fillerInstrsArr = fillerInstrs.ToArray();
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, fillerInstrsArr, fillerInstrsArr, false, initInstrs, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
                sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
            }
        }
    }
}
