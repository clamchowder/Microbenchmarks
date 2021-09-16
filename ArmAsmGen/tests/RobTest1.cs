using System.Text;

namespace AsmGen
{
    public class RobTest1 : UarchTest
    {
        public string Prefix { get => "flagrf"; }
        public string Description { get => "Test flags RF capacity with test/cmp instructions"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr"; }
        public string GetFunctionCallParameters { get => "structIterations, A"; }

        public int[] Counts { get; private set; }
        public bool DivideTimeByCount => false;

        public RobTest1(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] nops = new string[1];
            nops[0] = "test %r15, %r14";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] nops = new string[1];
            nops[0] = "test r15, r14";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] nops = new string[1];
            nops[0] = "cmp x14, x15";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }
    }
}
