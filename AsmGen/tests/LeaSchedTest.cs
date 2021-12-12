using System.Text;

namespace AsmGen
{
    public class LeaSchedTest : UarchTest
    {
        public LeaSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "leasched";
            this.Description = "lea [r+r*8] Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] instrs1 = new string[4];
            instrs1[0] = "  lea (%rdx,%rdi,8), %r15";
            instrs1[1] = "  lea (%rdx,%rdi,8), %r14";
            instrs1[2] = "  lea (%rdx,%rdi,8), %r13";
            instrs1[3] = "  lea (%rdx,%rdi,8), %r12";

            string[] instrs2 = new string[4];
            instrs2[0] = "  lea (%rdx,%rsi,8), %r15";
            instrs2[1] = "  lea (%rdx,%rsi,8), %r14";
            instrs2[2] = "  lea (%rdx,%rsi,8), %r13";
            instrs2[3] = "  lea (%rdx,%rsi,8), %r12";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs1, instrs1, false);
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
