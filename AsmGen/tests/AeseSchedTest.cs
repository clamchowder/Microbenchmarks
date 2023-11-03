using System.Text;

namespace AsmGen
{
    public class AeseSchedTest : UarchTest
    {
        public AeseSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "aesesched";
            this.Description = "aese scheduler";
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
                string postLoadInstrs1 = "  ldr q0, [x2, w25, uxtw#0]";
                string postLoadInstrs2 = "  ldr q0, [x2, w26, uxtw#0]";
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  aese v1.16b, v0.16b";
                unrolledAdds[1] = "  aese v2.16b, v0.16b";
                unrolledAdds[2] = "  aese v3.16b, v0.16b";
                unrolledAdds[3] = "  aese v4.16b, v0.16b";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, null, postLoadInstrs1, postLoadInstrs2);
            }
        }
    }
}
