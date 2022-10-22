using System.Text;

namespace AsmGen
{
    public class VecMovElimRobTest : UarchTest
    {
        public VecMovElimRobTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "vecmovelim";
            this.Description = "Do eliminated MOVs on vec regs reach ROB capacity? Or does another limit show up first?";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledMovs = new string[2];
            unrolledMovs[0] = "  movaps %xmm14, %xmm15";
            unrolledMovs[1] = "  movaps %xmm14, %xmm13";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMovs, unrolledMovs, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledMovs = new string[2];
            unrolledMovs[0] = "  movaps xmm15, xmm14";
            unrolledMovs[1] = "  movaps xmm13, xmm14";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMovs, unrolledMovs, true);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[2];
            unrolledAdds[0] = "  mov v1.4s, v2.4s";
            unrolledAdds[1] = "  mov v3.4s, v4.4s";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }
    }
}
