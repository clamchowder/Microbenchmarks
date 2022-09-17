using System.Text;

namespace AsmGen
{
    public class Add512SchedTest : UarchTest
    {
        public Add512SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "add512sched";
            this.Description = "512-bit Integer Add Scheduler Capacity Test (AVX-512 only)";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  movq %rdi, %xmm0\n  vpbroadcastd %xmm0, %zmm0\n";
            string postLoadInstr2 = "  movq %rsi, %xmm0\n  vpbroadcastd %xmm0, %zmm0\n";
            // ymm0 is dependent on ptr chasing load
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vpaddd %zmm0, %zmm1, %zmm1";
            unrolledAdds[1] = "  vpaddd %zmm0, %zmm2, %zmm2";
            unrolledAdds[2] = "  vpaddd %zmm0, %zmm3, %zmm3";
            unrolledAdds[3] = "  vpaddd %zmm0, %zmm4, %zmm3";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
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
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string initInstrs = "  ldr q18, [x1]\n  ldr q18, [x1]\n  ldr q19, [x2]\n  ldr q20, [x2]\n  ldr q21, [x2]\n";
            string postLoadInstr1 = "  mov v17.s[0], w25\n";
            string postLoadInstr2 = "  mov v17.s[0], w26\n";
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add v18.4s, v18.4s, v17.4s";
            unrolledAdds[1] = "  add v19.4s, v19.4s, v17.4s";
            unrolledAdds[2] = "  add v20.4s, v20.4s, v17.4s";
            unrolledAdds[3] = "  add v21.4s, v21.4s, v17.4s";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs, postLoadInstr1, postLoadInstr2);
        }
    }
}
