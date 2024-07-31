using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class Stq512Test : UarchTest
    {
        private bool differentLines;
        public Stq512Test(int low, int high, int step, bool differentLines)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "stq512" + (differentLines ? "dl" : string.Empty);
            this.Description = "Store Queue with 512-bit stores - AVX-512 only";
            if (differentLines) this.Description += " with multiple lines";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.differentLines = differentLines;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string initInstrs = "  vmovaps (%r8), %zmm0\n  vmovaps %zmm0, %zmm1";
                string[] unrolledStores;
                if (differentLines)
                {
                    List<string> unrolledStoresList = new List<string>();
                    int maxOffset = 512, currentOffset = 0;
                    for (int i = 0; i < this.Counts[this.Counts.Length - 1]; i++)
                    {
                        string loadOffset = currentOffset > 0 ? currentOffset.ToString() : string.Empty;
                        string nextInstr = $"  vmovaps %zmm0, {loadOffset}(%r8)";
                        unrolledStoresList.Add(nextInstr);
                        if (currentOffset >= maxOffset)
                        {
                            currentOffset = 0;
                        }
                        else currentOffset += 64;
                        unrolledStoresList.Add("  vmovaps %zmm0, (%r8)");
                    }

                    unrolledStores = unrolledStoresList.ToArray();
                }
                else
                {
                    unrolledStores = new string[2];
                    unrolledStores[0] = "  vmovaps %zmm0, (%r8)";
                    unrolledStores[1] = "  vmovaps %zmm1, (%r8)";
                }

                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, includePtrChasingLoads: false, initInstrs: initInstrs);
            }
        }
    }
}
