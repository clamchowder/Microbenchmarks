using System.Text;

namespace AsmGen
{
    public class PdepSchedTest : UarchTest
    {
        public PdepSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "pdepsched";
            this.Description = "PDEP Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] instrs1 = new string[4];
            instrs1[0] = "  pdep %rdi, %r14, %r15";
            instrs1[1] = "  pdep %rdi, %r13, %r15";
            instrs1[2] = "  pdep %rdi, %r12, %r15";
            instrs1[3] = "  pdep %rdi, %r11, %r15";

            string[] instrs2 = new string[4];
            instrs2[0] = "  pdep %rsi, %r14, %r15";
            instrs2[1] = "  pdep %rsi, %r13, %r15";
            instrs2[2] = "  pdep %rsi, %r12, %r15";
            instrs2[3] = "  pdep %rsi, %r11, %r15";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs1, instrs1, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] instrs = new string[4];
            instrs[0] = "  pdep r15, rdi, r14";
            instrs[1] = "  pdep r15, rdi, r13";
            instrs[2] = "  pdep r15, rdi, r12";
            instrs[3] = "  pdep r15, rdi, r11";

            string[] instrs1 = new string[4];
            instrs1[0] = "  pdep r15, rsi, r14";
            instrs1[1] = "  pdep r15, rsi, r13";
            instrs1[2] = "  pdep r15, rsi, r12";
            instrs1[3] = "  pdep r15, rsi, r11";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs1, false);
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
