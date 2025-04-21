using System.Text;

namespace AsmGen
{
    public class Ldq256Test : UarchTest
    {
        public Ldq256Test(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "ldq256";
            this.Description = "Load Queue, 256-bit";
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
                string[] unrolledLoads = new string[4];
                unrolledLoads[0] = "  vmovups (%r8), %ymm0";
                unrolledLoads[1] = "  vmovups 32(%r8), %ymm1";
                unrolledLoads[2] = "  vmovups 64(%r8), %ymm2";
                unrolledLoads[3] = "  vmovups 96(%r8), %ymm3";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, includePtrChasingLoads: true);
            }
        }
    }
}
