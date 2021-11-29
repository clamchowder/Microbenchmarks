using System.Text;

namespace AsmGen
{
    public class NotIntRfTest : UarchTest
    {
        public NotIntRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "notintrf";
            this.Description = "Integer RF Test with not (no setting flags)";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  not %r15";
            unrolledAdds[1] = "  not %r14";
            unrolledAdds[2] = "  not %r13";
            unrolledAdds[3] = "  not %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  not r15";
            unrolledAdds[1] = "  not r14";
            unrolledAdds[2] = "  not r13";
            unrolledAdds[3] = "  not r12";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }

        // todo
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
