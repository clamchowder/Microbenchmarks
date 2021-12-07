using System.Text;

namespace AsmGen
{
    public class Add128SchedTest : UarchTest
    {
        public Add128SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "add128sched";
            this.Description = "128-bit Integer Add Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  movq %rdi, %xmm0";
            string postLoadInstr2 = "  movq %rsi, %xmm0";
            // xmm0 is dependent on ptr chasing load
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddd %xmm0, %xmm1";
            unrolledAdds[1] = "  paddd %xmm0, %xmm2";
            unrolledAdds[2] = "  paddd %xmm0, %xmm3";
            unrolledAdds[3] = "  paddd %xmm0, %xmm4";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, 
                this.Counts, 
                this.Prefix, 
                unrolledAdds, 
                unrolledAdds, 
                includePtrChasingLoads: false, 
                postLoadInstrs1: postLoadInstr1, 
                postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  movq xmm0, rdi\n  pshufd xmm0, xmm0, 0\n";
            string postLoadInstr2 = "  movq xmm0, rsi\n  pshufd xmm0, xmm0, 0\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddd xmm1, xmm0";
            unrolledAdds[1] = "  paddd xmm2, xmm0";
            unrolledAdds[2] = "  paddd xmm3, xmm0";
            unrolledAdds[3] = "  paddd xmm4, xmm0";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
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
