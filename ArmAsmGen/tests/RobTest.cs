using System.Text;

namespace AsmGen
{
    public class RobTest : UarchTest
    {
        public string Prefix { get => "rob"; }
        public string Description { get => "Reorder Buffer Test"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr"; }
        public string GetFunctionCallParameters { get => "structIterations, A"; }

        public int[] Counts { get; private set; }
        public bool DivideTimeByCount => false;

        private string[] nops;

        public RobTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.nops = new string[] { "nop" };
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }
    }
}
