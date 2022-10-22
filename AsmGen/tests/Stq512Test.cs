using System.Text;

namespace AsmGen
{
    public class Stq512Test : UarchTest
    {
        public Stq512Test(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "stq512";
            this.Description = "Store Queue Test with 512-bit stores, x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovaps (%r8), %zmm0\n  vmovaps %zmm0, %zmm1";

            string[] unrolledStores = new string[2];
            unrolledStores[0] = "  vmovaps %zmm0, (%r8)";
            unrolledStores[1] = "  vmovaps %zmm1, (%r8)";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, false, initInstrs: initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovaps zmm0, [r8]\n  vmovaps zmm0, zmm1";
            string[] unrolledStores = new string[2];
            unrolledStores[0] = "  vmovaps [r8], zmm0";
            unrolledStores[1] = "  vmovaps [r8], zmm1";

            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, false, initInstrs: initInstrs);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  str x15, [x2]";
            unrolledLoads[1] = "  str x14, [x2]";
            unrolledLoads[2] = "  str x13, [x2]";
            unrolledLoads[3] = "  str x12, [x2]";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, true);
        }
    }
}
