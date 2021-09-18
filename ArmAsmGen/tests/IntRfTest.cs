using System.Text;

namespace AsmGen
{
    public class IntRfTest : UarchTest
    {
        public IntRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "intrf";
            this.Description = "Integer RF Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add %r11, %r15";
            unrolledAdds[1] = "  add %r11, %r14";
            unrolledAdds[2] = "  add %r11, %r13";
            unrolledAdds[3] = "  add %r11, %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add r15, r11";
            unrolledAdds[1] = "  add r14, r11";
            unrolledAdds[2] = "  add r13, r11";
            unrolledAdds[3] = "  add r12, r11";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x11";
            unrolledAdds[1] = "  add x14, x14, x11";
            unrolledAdds[2] = "  add x13, x13, x11";
            unrolledAdds[3] = "  add x12, x12, x11";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }
    }
}
