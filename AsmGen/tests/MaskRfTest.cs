using System.Text;

namespace AsmGen
{
    public class MaskRfTest : UarchTest
    {
        public MaskRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "maskrf";
            this.Description = "Mask Registers - AVX-512 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
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
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  kaddb %k0, %k1, %k1";
                unrolledAdds[1] = "  kaddb %k0, %k2, %k2";
                unrolledAdds[2] = "  kaddb %k0, %k3, %k3";
                unrolledAdds[3] = "  kaddb %k0, %k4, %k4";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false);
            }
        }
    }
}
