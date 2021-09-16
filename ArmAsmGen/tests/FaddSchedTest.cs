using System.Text;

namespace AsmGen
{
    public class FaddSchedTest : UarchTest
    {
        public string Prefix { get => "faddsched"; }
        public string Description { get => "FP (32-bit add) Scheduler Capacity Test"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr, float *floatArr"; }
        public string GetFunctionCallParameters { get => "structIterations, A, fpArr"; }

        public int[] Counts { get; private set; }
        public bool DivideTimeByCount => false;

        public FaddSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            // xmm0 is dependent on ptr chasing load
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  addss %xmm0, %xmm1";
            unrolledAdds[1] = "  addss %xmm0, %xmm2";
            unrolledAdds[2] = "  addss %xmm0, %xmm3";
            unrolledAdds[3] = "  addss %xmm0, %xmm4";

            UarchTestHelpers.GenerateX86AsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  addss xmm1, xmm0";
            unrolledAdds[1] = "  addss xmm2, xmm0";
            unrolledAdds[2] = "  addss xmm3, xmm0";
            unrolledAdds[3] = "  addss xmm4, xmm0";
            UarchTestHelpers.GenerateX86NasmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fadd s17, s17, s16";
            unrolledAdds[1] = "  fadd s18, s18, s16";
            unrolledAdds[2] = "  fadd s19, s19, s16";
            unrolledAdds[3] = "  fadd s20, s20, s16";
            UarchTestHelpers.GenerateArmAsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }
    }
}
