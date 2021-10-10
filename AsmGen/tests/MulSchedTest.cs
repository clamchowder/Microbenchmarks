using System.Text;

namespace AsmGen
{
    public class MulSchedTest : UarchTest
    {
        public MulSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mulsched";
            this.Description = "Integer (64-bit mul) Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  imul %rdi, %r15";
            unrolledMuls[1] = "  imul %rdi, %r14";
            unrolledMuls[2] = "  imul %rdi, %r13";
            unrolledMuls[3] = "  imul %rdi, %r12";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  imul %rsi, %r15";
            unrolledMuls1[1] = "  imul %rsi, %r14";
            unrolledMuls1[2] = "  imul %rsi, %r13";
            unrolledMuls1[3] = "  imul %rsi, %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls1, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  imul r15, rdi";
            unrolledMuls[1] = "  imul r14, rdi";
            unrolledMuls[2] = "  imul r13, rdi";
            unrolledMuls[3] = "  imul r12, rdi";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  imul r15, rsi";
            unrolledMuls1[1] = "  imul r14, rsi";
            unrolledMuls1[2] = "  imul r13, rsi";
            unrolledMuls1[3] = "  imul r12, rsi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  mul x10, x10, x25";
            unrolledAdds[1] = "  mul x14, x14, x25";
            unrolledAdds[2] = "  mul x13, x13, x25";
            unrolledAdds[3] = "  mul x12, x12, x25";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  mul x10, x10, x26";
            unrolledAdds1[1] = "  mul x14, x14, x26";
            unrolledAdds1[2] = "  mul x13, x13, x26";
            unrolledAdds1[3] = "  mul x12, x12, x26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
        }
    }
}
