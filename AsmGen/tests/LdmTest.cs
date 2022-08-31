using System.Text;

namespace AsmGen
{
    public class LdmTest : UarchTest
    {
        public LdmTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "ldm";
            this.Description = "Integer (add) without Load Dependency Matrix Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  add %rdi, %r11";
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add %r11, %r15";
            unrolledAdds[1] = "  add %r11, %r14";
            unrolledAdds[2] = "  add %r11, %r13";
            unrolledAdds[3] = "  add %r11, %r12";

            string postLoadInstr2 = "  add %rsi, %r11";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(
                sb,
                this.Counts,
                this.Prefix,
                unrolledAdds,
                unrolledAdds,
                false,
                postLoadInstrs1: postLoadInstr1,
                postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  add r11, rdi";
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add r15, r11";
            unrolledAdds[1] = "  add r14, r11";
            unrolledAdds[2] = "  add r13, r11";
            unrolledAdds[3] = "  add r12, r11";

            string postLoadInstr2 = "  add r11, rsi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(
                sb,
                this.Counts,
                this.Prefix,
                unrolledAdds,
                unrolledAdds,
                false,
                postLoadInstrs1: postLoadInstr1,
                postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  add x11, x11, x25";
            string postLoadInstr2 = "  add x11, x11, x26";
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x25";
            unrolledAdds[1] = "  add x14, x14, x25";
            unrolledAdds[2] = "  add x13, x13, x25";
            unrolledAdds[3] = "  add x12, x12, x25";

            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(
                sb,
                this.Counts,
                this.Prefix,
                unrolledAdds,
                unrolledAdds,
                false,
                postLoadInstrs1: postLoadInstr1,
                postLoadInstrs2: postLoadInstr2);
        }
    }
}
