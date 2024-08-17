using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class MixVec512Vec256BlockRfTest : UarchTest
    {
        // number of tiny registers
        private int nTiny;

        public MixVec512Vec256BlockRfTest(int low, int high, int step, int nTiny)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixvec512vec256blockrf" + nTiny;
            this.Description = $"Mixed zmm/ymm regs - AVX-512 only, {nTiny} 256-bit then 512-bit";
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
            if (isa == IUarchTest.ISA.amd64)
            {
                // use even numbered regs for ymm testing
                string initInstrs = "  vmovups (%r8), %zmm1\n" +
                "  vmovups 64(%r8), %ymm2\n" +
                "  vmovups 128(%r8), %zmm3\n" +
                "  vmovups 192(%r8), %ymm4\n" +
                "  vmovups 256(%r8), %zmm5\n";

                // use all zmm regs
                for (int i = 6; i < 32; i++)
                {
                    if ((i & 1) == 0) initInstrs += "vmovups %ymm2, %ymm" + i + "\n";
                    else initInstrs += "vmovups %zmm5, %zmm" + i + "\n";
                }

                List<string> instrsList = new List<string>();
                for (int i = 0; i < nTiny; i++)
                {
                    int regNum = ((i & 1) == 0) ? i & 0x1F : (i + 1) & 0x1F;
                    instrsList.Add($"  vxorps %ymm2, %ymm{regNum}, %ymm{regNum}");
                }

                for (int i = nTiny; i < this.Counts[this.Counts.Length - 1];i++)
                {
                    int regNum = ((i & 1) == 0) ? i: (i + 1);
                    regNum = (regNum + 1) & 0x1F;
                    instrsList.Add($"  vxorps %zmm1, %zmm{regNum}, %zmm{regNum}");
                }

                string[] unrolledAdds = instrsList.ToArray();
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
            }
        }
    }
}