using System.Text;

namespace AsmGen
{
    public class Stq512Test : UarchTest
    {
        public Stq512Test(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "stq512";
            this.Description = "Store Queue with 512-bit stores - AVX-512 only";
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
                string initInstrs = "  vmovaps (%r8), %zmm0\n  vmovaps %zmm0, %zmm1";

                string[] unrolledStores = new string[2];
                unrolledStores[0] = "  vmovaps %zmm0, (%r8)";
                unrolledStores[1] = "  vmovaps %zmm1, (%r8)";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, includePtrChasingLoads: false, initInstrs: initInstrs);
            }
        }
    }
}
