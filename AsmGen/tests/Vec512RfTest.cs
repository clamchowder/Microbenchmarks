using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class Vec512RfTest : UarchTest
    {
        public Vec512RfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "vec512rf";
            this.Description = "Vector (512-bit packed fp) RF Test - AVX-512 only";
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
                // it's ok, the ptr chasing arr should be way bigger than this
                string initInstrs = "  vmovups (%r8), %zmm1\n" +
                "  vmovups 64(%r8), %zmm2\n" +
                "  vmovups 128(%r8), %zmm3\n" +
                "  vmovups 192(%r8), %zmm4\n" +
                "  vmovups 256(%r8), %zmm5\n";

                // use all zmm regs
                for (int i = 6; i < 32; i++)
                {
                    initInstrs += "vmovups %zmm5, %zmm" + i + "\n";
                }

                List<string> instrsList = new List<string>();
                for (int i = 1; i < 32; i++)
                {
                    instrsList.Add($"  vaddps %zmm1, %zmm{i}, %zmm{i}");
                }

                string[] unrolledAdds = instrsList.ToArray();
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
            }
        }
    }
}