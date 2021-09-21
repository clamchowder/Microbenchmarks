using System.Text;

namespace AsmGen
{
    public class Add256SchedTest : UarchTest
    {
        public Add256SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "add256sched";
            this.Description = "256-bit Integer Add Scheduler Capacity Test - x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  movq %rdi, %xmm0\n  vpbroadcastd %xmm0, %ymm0\n";
            string postLoadInstr2 = "  movq %rsi, %xmm0\n  vpbroadcastd %xmm0, %ymm0\n";
            // ymm0 is dependent on ptr chasing load
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vpaddd %ymm0, %ymm1, %ymm1";
            unrolledAdds[1] = "  vpaddd %ymm0, %ymm2, %ymm2";
            unrolledAdds[2] = "  vpaddd %ymm0, %ymm3, %ymm3";
            unrolledAdds[3] = "  vpaddd %ymm0, %ymm4, %ymm3";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  movq xmm0, rdi\n  vpbroadcastd ymm0, xmm0\n";
            string postLoadInstr2 = "  movq xmm0, rsi\n  vpbroadcastd ymm0, xmm0\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vpaddd ymm1, ymm1, ymm0";
            unrolledAdds[1] = "  vpaddd ymm2, ymm2, ymm0";
            unrolledAdds[2] = "  vpaddd ymm3, ymm3, ymm0";
            unrolledAdds[3] = "  vpaddd ymm4, ymm4, ymm0";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateArmAsm(StringBuilder sb)
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
