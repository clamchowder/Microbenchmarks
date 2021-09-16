using System.Text;

namespace AsmGen
{
    public class AddSchedTest : UarchTest
    {
        public string Prefix { get => "addsched"; }
        public string Description { get => "Integer (add) Scheduler Capacity Test"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr"; }
        public string GetFunctionCallParameters { get => "structIterations, A"; }

        public int[] Counts { get; private set; }

        public AddSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add %rdi, %r15";
            unrolledAdds[1] = "  add %rdi, %r14";
            unrolledAdds[2] = "  add %rdi, %r13";
            unrolledAdds[3] = "  add %rdi, %r12";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add %rsi, %r15";
            unrolledAdds1[1] = "  add %rsi, %r14";
            unrolledAdds1[2] = "  add %rsi, %r13";
            unrolledAdds1[3] = "  add %rsi, %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add r15, rdi";
            unrolledAdds[1] = "  add r14, rdi";
            unrolledAdds[2] = "  add r13, rdi";
            unrolledAdds[3] = "  add r12, rdi";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add r15, rsi";
            unrolledAdds1[1] = "  add r14, rsi";
            unrolledAdds1[2] = "  add r13, rsi";
            unrolledAdds1[3] = "  add r12, rsi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
        }

        public void GenerateArmAsm(StringBuilder sb)
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
