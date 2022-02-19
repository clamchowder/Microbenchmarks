using System.Text;

namespace AsmGen
{
    public class Stq256Test : UarchTest
    {
        public Stq256Test(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "vecstq";
            this.Description = "Vector Store Queue Test, 256-bit (stores pending retire)";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovups (%r8), %ymm0";
            string[] unrolledStores = new string[4];
            unrolledStores[0] = "  vmovups %ymm0, (%r8)";
            unrolledStores[1] = "  vmovups %ymm0, 32(%r8)";
            unrolledStores[2] = "  vmovups %ymm0, 64(%r8)";
            unrolledStores[3] = "  vmovups %ymm0, 128(%r8)";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, false, initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovups ymm0, [r8]";
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  vmovups [r8], ymm0";
            unrolledLoads[1] = "  vmovups [r8 + 32], ymm0";
            unrolledLoads[2] = "  vmovups [r8 + 64], ymm0";
            unrolledLoads[3] = "  vmovups [r8 + 128], ymm0";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, false, initInstrs);
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
