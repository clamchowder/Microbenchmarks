using System.Text;

namespace AsmGen
{
    public class FlagRfTest : UarchTest
    {
        public FlagRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "flagrf";
            this.Description = "Flags register file capacity";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] nops = new string[1];
            nops[0] = "test %r15, %r14";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] nops = new string[1];
            nops[0] = "test r15, r14";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] nops = new string[1];
            nops[0] = "cmp x14, x15";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }
    }
}
