using System.Text;

namespace AsmGen
{
    public class CvtSchedTest : UarchTest
    {
        public CvtSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "cvtsched";
            this.Description = "I2F (cvtsi2ss) Scheduler Capacity Test - x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledInstrs = new string[4];
            unrolledInstrs[0] = "  cvtsi2ss %rdi, %xmm1";
            unrolledInstrs[1] = "  cvtsi2ss %rdi, %xmm2";
            unrolledInstrs[2] = "  cvtsi2ss %rdi, %xmm3";
            unrolledInstrs[3] = "  cvtsi2ss %rdi, %xmm4";

            string[] unrolledInstrs1 = new string[4];
            unrolledInstrs1[0] = "  cvtsi2ss %rsi, %xmm1";
            unrolledInstrs1[1] = "  cvtsi2ss %rsi, %xmm2";
            unrolledInstrs1[2] = "  cvtsi2ss %rsi, %xmm3";
            unrolledInstrs1[3] = "  cvtsi2ss %rsi, %xmm4";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledInstrs = new string[4];
            unrolledInstrs[0] = "  cvtsi2ss xmm1, rdi";
            unrolledInstrs[1] = "  cvtsi2ss xmm2, rdi";
            unrolledInstrs[2] = "  cvtsi2ss xmm3, rdi";
            unrolledInstrs[3] = "  cvtsi2ss xmm4, rdi";

            string[] unrolledInstrs1 = new string[4];
            unrolledInstrs1[0] = "  cvtsi2ss xmm1, rsi";
            unrolledInstrs1[1] = "  cvtsi2ss xmm2, rsi";
            unrolledInstrs1[2] = "  cvtsi2ss xmm3, rsi";
            unrolledInstrs1[3] = "  cvtsi2ss xmm4, rsi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs1, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledInstrs = new string[4];
            unrolledInstrs[0] = "  scvtf s0, w25";
            unrolledInstrs[1] = "  scvtf s0, w25";
            unrolledInstrs[2] = "  scvtf s0, w25";
            unrolledInstrs[3] = "  scvtf s0, w25";

            string[] unrolledInstrs1 = new string[4];
            unrolledInstrs1[0] = "  scvtf s0, w26";
            unrolledInstrs1[1] = "  scvtf s0, w26";
            unrolledInstrs1[2] = "  scvtf s0, w26";
            unrolledInstrs1[3] = "  scvtf s0, w26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs1, false);
        }
    }
}
