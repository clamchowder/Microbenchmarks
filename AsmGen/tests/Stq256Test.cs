using System.Text;

namespace AsmGen
{
    public class Stq256Test : UarchTest
    {
        public Stq256Test(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "stq256";
            this.Description = "Store Queue with 256-bit stores";
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
                string initInstrs = "  vmovups (%rdx), %ymm1";
                string[] unrolledStores = new string[1];
                unrolledStores[0] = "  vmovaps %ymm1, (%r8)";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, initInstrs: initInstrs, includePtrChasingLoads: false);
            }
        }
    }
}
