using System.Text;

namespace AsmGen
{
    public class FaddNsqTest : UarchTest
    {
        private int high;

        public FaddNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "faddnsq";
            this.Description = "FP (32-bit add) Scheduler Test, excluding any NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.high = high;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            // xmm0 is dependent on ptr chasing load
            string initInstrs = "  vzeroupper\n  cvtsi2ss %r11, %xmm3\n";
            string postLoadInstr = "  cvtsi2ss %rdi, %xmm0";
            string[] depAdds = new string[2];
            depAdds[0] = "  addss %xmm0, %xmm1";
            depAdds[1] = "  addss %xmm0, %xmm2";

            string[] indepAdds = new string[2];
            indepAdds[0] = "  addss %xmm3, %xmm4";
            indepAdds[1] = "  addss %xmm3, %xmm5";

            UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.high, this.Counts, this.Prefix, depAdds, indepAdds, false, initInstrs, postLoadInstr);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movq xmm3, r11\n  xorps xmm1, xmm1\n  xorps xmm2, xmm2\n  xorps xmm4, xmm4\n  xorps xmm5, xmm5\n";
            string postLoadInstr = "  cvtsi2ss xmm0, rdi";
            string[] depAdds = new string[2];
            depAdds[0] = "  addss xmm1, xmm0";
            depAdds[1] = "  addss xmm2, xmm0";

            string[] indepAdds = new string[2];
            indepAdds[0] = "  addss xmm4, xmm3";
            indepAdds[1] = "  addss xmm5, xmm3";

            UarchTestHelpers.GenerateX86NasmNsqTestFuncs(sb, this.high, this.Counts, this.Prefix, depAdds, indepAdds, false, initInstrs, postLoadInstr);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            // todo
        }
    }
}
