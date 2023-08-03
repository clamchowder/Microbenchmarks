using System.Text;

namespace AsmGen
{
    public class CvtSchedTest : UarchTest
    {
        public CvtSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "cvtsched";
            this.Description = "F2I Scheduler";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            // if (isa == IUarchTest.ISA.mips64) return true;
            // if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
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

                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs1);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] unrolledInstrs = new string[4];
                unrolledInstrs[0] = "  scvtf s0, w25";
                unrolledInstrs[1] = "  scvtf s1, w25";
                unrolledInstrs[2] = "  scvtf s2, w25";
                unrolledInstrs[3] = "  scvtf s3, w25";

                string[] unrolledInstrs1 = new string[4];
                unrolledInstrs1[0] = "  scvtf s0, w26";
                unrolledInstrs1[1] = "  scvtf s1, w26";
                unrolledInstrs1[2] = "  scvtf s2, w26";
                unrolledInstrs1[3] = "  scvtf s3, w26";

                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs1);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                
            }
        }
    }
}
