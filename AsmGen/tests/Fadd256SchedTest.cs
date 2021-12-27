using System.Text;

namespace AsmGen
{
    public class Fadd256SchedTest : UarchTest
    {
        public Fadd256SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fadd256sched";
            this.Description = "256-bit FADD Scheduler Capacity Test, 128-bit on ARM";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            // ymm0 is dependent on ptr chasing load
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vaddps %ymm0, %ymm1, %ymm1";
            unrolledAdds[1] = "  vaddps %ymm0, %ymm2, %ymm2";
            unrolledAdds[2] = "  vaddps %ymm0, %ymm3, %ymm3";
            unrolledAdds[3] = "  vaddps %ymm0, %ymm4, %ymm3";

            UarchTestHelpers.GenerateX86AsmFp256SchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vaddps ymm1, ymm1, ymm0";
            unrolledAdds[1] = "  vaddps ymm2, ymm2, ymm0";
            unrolledAdds[2] = "  vaddps ymm3, ymm3, ymm0";
            unrolledAdds[3] = "  vaddps ymm4, ymm4, ymm0";
            UarchTestHelpers.GenerateX86NasmFp256SchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fadd v20.4s, v15.4s, v16.4s";
            unrolledAdds[1] = "  fadd v17.4s, v15.4s, v16.4s";
            unrolledAdds[2] = "  fadd v18.4s, v15.4s, v16.4s";
            unrolledAdds[3] = "  fadd v19.4s, v15.4s, v16.4s";
            UarchTestHelpers.GenerateArmAsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }
    }
}
