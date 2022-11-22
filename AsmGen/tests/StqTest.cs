using System.Text;

namespace AsmGen
{
    public class StqTest : UarchTest
    {
        public StqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "stq";
            this.Description = "Store Queue Test (stores pending retire)";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  mov %r15, (%r8)";
            unrolledLoads[1] = "  mov %r14, (%r8)";
            unrolledLoads[2] = "  mov %r13, (%r8)";
            unrolledLoads[3] = "  mov %r12, (%r8)";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  mov [r8], r15";
            unrolledLoads[1] = "  mov [r8], r14";
            unrolledLoads[2] = "  mov [r8], r13";
            unrolledLoads[3] = "  mov [r8], r12";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  str x15, [x2]";
            unrolledLoads[1] = "  str x14, [x2]";
            unrolledLoads[2] = "  str x13, [x2]";
            unrolledLoads[3] = "  str x12, [x2]";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, false);
        }
    }
}
