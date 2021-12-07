using System.Text;

namespace AsmGen
{
    public class BtsSchedTest : UarchTest
    {
        public BtsSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "btssched";
            this.Description = "Bit Test + Set CF Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  mov %rdi, %r15";
            string postLoadInstr2 = "  mov %rsi, %r15";
            string[] instrs = new string[4];
            instrs[0] = "  bts %r14, %r15";
            instrs[1] = "  bts %r13, %r15";
            instrs[2] = "  bts %r12, %r15";
            instrs[3] = "  bts %r11, %r15";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            // todo im tired
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
