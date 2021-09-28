using System.Text;

namespace AsmGen
{
    public class RobTest : UarchTest
    {
        private string[] nops;

        public RobTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "rob";
            this.Description = "Reorder Buffer Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
            this.nops = new string[] { "nop" };
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }
    }
}
