using System.Text;

namespace AsmGen
{
    public class MovElimRobTest : UarchTest
    {
        public MovElimRobTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "movelim";
            this.Description = "Do eliminated MOVs reach ROB capacity? Or does another limit show up first?";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledMovs = new string[2];
            unrolledMovs[0] = "  mov %r14, %r15";
            unrolledMovs[1] = "  mov %r14, %r13";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMovs, unrolledMovs, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledMovs = new string[2];
            unrolledMovs[0] = "  mov r15, r14";
            unrolledMovs[1] = "  mov r13, r14";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMovs, unrolledMovs, true);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[2];
            unrolledAdds[0] = "  mov x15, x14";
            unrolledAdds[1] = "  mov x13, x14";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }
    }
}
