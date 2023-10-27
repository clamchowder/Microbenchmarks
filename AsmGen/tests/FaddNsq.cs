using System.Text;

namespace AsmGen
{
    public class FaddNsq : UarchTest
    {
        private int totalOps;
        public FaddNsq(int low, int high, int step, int totalOps)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "faddnsq";
            this.Description = "FADD, excluding possible NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.totalOps = totalOps;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string postLoadInstrs = "  cvtsi2ss %edi, %xmm1";
                string initInstrs = "  cvtsi2ss %r12, %xmm2";
                string[] depInstrs = new string[4];
                depInstrs[0] = "  addss %xmm1, %xmm0";
                depInstrs[1] = "  addss %xmm1, %xmm3";
                depInstrs[2] = "  addss %xmm1, %xmm4";
                depInstrs[3] = "  addss %xmm1, %xmm5";

                string[] indepInstrs = new string[2];
                indepInstrs[0] = "  addss %xmm2, %xmm6";
                indepInstrs[1] = "  addss %xmm2, %xmm7";
                UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.totalOps, this.Counts, this.Prefix, depInstrs, indepInstrs, false, initInstrs, postLoadInstrs);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string postLoadInstrs1 = "  ldr s16, [x2, w25, uxtw #2]";
                string initInstrs = "  ldr s15, [x2]";
                string[] depInstrs = new string[4];
                depInstrs[0] = "  fadd s0, s0, s16";
                depInstrs[1] = "  fadd s1, s1, s16";
                depInstrs[2] = "  fadd s2, s2, s16";
                depInstrs[3] = "  fadd s3, s3, s16";

                string[] indepInstrs = new string[4];
                indepInstrs[0] = "  fadd s17, s17, s15";
                indepInstrs[1] = "  fadd s18, s18, s15";
                indepInstrs[2] = "  fadd s19, s19, s15";
                indepInstrs[3] = "  fadd s20, s20, s15";
                UarchTestHelpers.GenerateArmAsmNsqTestFuncs(sb, this.totalOps, this.Counts, this.Prefix, depInstrs, indepInstrs, false, initInstrs,
                    postLoadInstrs: postLoadInstrs1);
            }
        }
    }
}
