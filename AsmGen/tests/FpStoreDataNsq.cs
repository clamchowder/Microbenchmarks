using System.Text;

namespace AsmGen
{
    public class FpStoreDataNsqTest : UarchTest
    {
        public FpStoreDataNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fpstoredatansq" + high;
            this.Description = "Store FP 32-bit data scheduler capacity, excluding nsq";
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
                string initInstrs = "  vzeroupper\n  vpcmpeqd %xmm2, %xmm2, %xmm2\n  vpxor %xmm2, %xmm3, %xmm3\n  cvtsi2ss %r11, %xmm3\n movss %xmm3, %xmm4\n  movss %xmm3, %xmm5\n  movss %xmm3, %xmm6";
                string postLoadInstr = "  cvtsi2ss %rdi, %xmm1";
                string[] dependentStores = new string[4];
                dependentStores[0] = "  movss %xmm1, (%r8)";
                dependentStores[1] = "  movss %xmm1, (%r8, %r14, 4)";
                dependentStores[2] = "  movss %xmm1, (%r8, %r13, 4)";
                dependentStores[3] = "  movss %xmm1, (%r8, %r12, 4)";

                string[] indepFpInstrs = new string[4];
                indepFpInstrs[0] = "  addss %xmm2, %xmm3";
                indepFpInstrs[1] = "  addss %xmm2, %xmm4";
                indepFpInstrs[2] = "  addss %xmm2, %xmm5";
                indepFpInstrs[3] = "  addss %xmm2, %xmm6";

                UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, indepFpInstrs, false, initInstrs: initInstrs, postLoadInstrs: postLoadInstr);
            }
        }
    }
}
