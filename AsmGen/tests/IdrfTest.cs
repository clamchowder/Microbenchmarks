using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class IdrfTest : UarchTest
    {
        public IdrfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "idrf";
            this.Description = "Immediate/Displacement Register File";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            const string dummyBranchTargetName = "idrftest_badtarget";
            if (isa == IUarchTest.ISA.amd64)
            {
                const int storeCount = 40;
                const int addCount = 130;
                List<string> testInstructions = new List<string>();
                int storeIdx = 0, addIdx = 0;
                for (int i = 0; i < this.Counts[this.Counts.Length - 1]; i++)
                {
                    if (addIdx < addCount)
                    {
                        string addInstr = "  add $" + (i + 1) + ", %r1" + (12 + (i % 4));
                        testInstructions.Add(addInstr);
                        addIdx++;
                    }
                    else if (storeIdx < storeCount)
                    {
                        string storeInstr = "  mov %r11d, " + +(((i + 1) & 0xFF) * 4) + "(%r8)";
                        testInstructions.Add(storeInstr);
                        storeIdx++;
                    }
                    else
                    {
                        string branchInstr = "  test %r11, %r11\n  je {dummyBranchTargetName}";
                        testInstructions.Add(branchInstr);
                    }
                }

                string[] unrolledAdds = testInstructions.ToArray();
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: true);

                sb.AppendLine($"{dummyBranchTargetName}:\n  int3");
            }
        }
    }
}
