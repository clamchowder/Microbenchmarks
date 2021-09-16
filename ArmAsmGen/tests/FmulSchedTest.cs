using System.Text;

namespace AsmGen
{
    public class FmulSchedTest : UarchTest
    {
        public string Prefix { get => "fmulsched"; }
        public string Description { get => "FP (32-bit multiply) Scheduler Capacity Test"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr, float *floatArr"; }
        public string GetFunctionCallParameters { get => "structIterations, A, fpArr"; }

        public int[] Counts { get; private set; }
        public bool DivideTimeByCount => false;

        public FmulSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            // xmm0 is dependent on ptr chasing load
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  mulss %xmm0, %xmm1";
            unrolledAdds[1] = "  mulss %xmm0, %xmm2";
            unrolledAdds[2] = "  mulss %xmm0, %xmm3";
            unrolledAdds[3] = "  mulss %xmm0, %xmm4";

            UarchTestHelpers.GenerateX86AsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  mulss xmm1, xmm0";
            unrolledAdds[1] = "  mulss xmm2, xmm0";
            unrolledAdds[2] = "  mulss xmm3, xmm0";
            unrolledAdds[3] = "  mulss xmm4, xmm0";
            UarchTestHelpers.GenerateX86NasmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fmul s17, s17, s16";
            unrolledAdds[1] = "  fmul s18, s18, s16";
            unrolledAdds[2] = "  fmul s19, s19, s16";
            unrolledAdds[3] = "  fmul s20, s20, s16";
            UarchTestHelpers.GenerateArmAsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }
    }
}
