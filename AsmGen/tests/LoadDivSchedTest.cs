using System.Text;

namespace AsmGen
{
    public class LoadDivSchedTest : UarchTest
    {
        public LoadDivSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "loaddivsched";
            this.Description = "Load Scheduler Capacity Test, using divs to block retirement";
            this.FunctionDefinitionParameters = "uint64_t iterations, int count, int *arr2";
            this.GetFunctionCallParameters = "structIterations, list_size, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] dependentLoads = new string[1];
            dependentLoads[0] = "  mov (%r8, %rdx, 4), %r15";

            UarchTestHelpers.GenerateX86AsmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] dependentLoads = new string[1];
            dependentLoads[0] = "  mov r15, [r8 + rdx * 4]";

            UarchTestHelpers.GenerateX86NasmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] dependentLoads = new string[1];
            dependentLoads[0] = "  ldr w15, [x2, w25, uxtw #2]";

            string[] dependentLoads1 = new string[1];
            dependentLoads1[0] = "  ldr w15, [x2, w26, uxtw #2]";

            UarchTestHelpers.GenerateArmAsmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, false);
        }
    }
}
