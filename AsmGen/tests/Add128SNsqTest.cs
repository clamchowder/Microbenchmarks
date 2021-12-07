using System.Text;

namespace AsmGen
{
    public class Add128NsqTest : UarchTest
    {
        private int high;
        public Add128NsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "add128nsq";
            this.Description = "128-bit Integer Add Scheduler Capacity Test, excluding NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
            this.high = high;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  vzeroupper\n  pxor %xmm3, %xmm3\n  pxor %xmm4, %xmm4\n  movq %r15, %xmm5\n";
            string postLoadInstr = "  movq %rdi, %xmm0\n";
            //string postLoadInstr2 = "  movq %rsi, %xmm0\n  pshufd $0, %xmm0, %xmm0\n";
            // xmm0 is dependent on ptr chasing load
            string[] depAdds = new string[2];
            depAdds[0] = "  paddd %xmm0, %xmm1";
            depAdds[1] = "  paddd %xmm0, %xmm2";

            string[] indepAdds = new string[2];
            indepAdds[0] = "  paddd %xmm3, %xmm5";
            indepAdds[1] = "  paddd %xmm4, %xmm5";

            UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.high, this.Counts, this.Prefix, depAdds, indepAdds, false, initInstrs, postLoadInstr);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vzeroupper\n  pxor xmm3, xmm3\n  pxor xmm4, xmm4\n  movq r15, xmm5\n";
            string postLoadInstr = "  movq xmm0, rdi";
            //string postLoadInstr2 = "  movq xmm0, rsi";

            string[] depAdds = new string[2];
            depAdds[0] = "  paddd xmm1, xmm0";
            depAdds[1] = "  paddd xmm2, xmm0";

            string[] indepAdds = new string[2];
            indepAdds[0] = "  paddd xmm5, xmm3";
            indepAdds[1] = "  paddd xmm6, xmm4";
            UarchTestHelpers.GenerateX86NasmNsqTestFuncs(sb, this.high, this.Counts, this.Prefix, depAdds, indepAdds, false, initInstrs, postLoadInstr);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            // todo
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
