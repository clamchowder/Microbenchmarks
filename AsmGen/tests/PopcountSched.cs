using System.Text;

namespace AsmGen
{
    public class PopcountSchedTest : UarchTest
    {
        public PopcountSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "popcountsched";
            this.Description = "POPCOUNT Scheduler Capacity Test, x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  popcnt %rdi, %r15";
            unrolledAdds[1] = "  popcnt %rdi, %r14";
            unrolledAdds[2] = "  popcnt %rdi, %r13";
            unrolledAdds[3] = "  popcnt %rdi, %r12";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  popcnt %rsi, %r15";
            unrolledAdds1[1] = "  popcnt %rsi, %r14";
            unrolledAdds1[2] = "  popcnt %rsi, %r13";
            unrolledAdds1[3] = "  popcnt %rsi, %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  popcnt r15, rdi";
            unrolledAdds[1] = "  popcnt r14, rdi";
            unrolledAdds[2] = "  popcnt r13, rdi";
            unrolledAdds[3] = "  popcnt r12, rdi";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  popcnt r15, rsi";
            unrolledAdds1[1] = "  popcnt r14, rsi";
            unrolledAdds1[2] = "  popcnt r13, rsi";
            unrolledAdds1[3] = "  popcnt r12, rsi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x25";
            unrolledAdds[1] = "  add x14, x14, x25";
            unrolledAdds[2] = "  add x13, x13, x25";
            unrolledAdds[3] = "  add x12, x12, x25";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add x15, x15, x26";
            unrolledAdds1[1] = "  add x14, x14, x26";
            unrolledAdds1[2] = "  add x13, x13, x26";
            unrolledAdds1[3] = "  add x12, x12, x26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
        }
    }
}
