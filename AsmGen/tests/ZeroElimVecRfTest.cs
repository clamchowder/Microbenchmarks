using System.Text;

namespace AsmGen
{
    public class ZeroElimVecRfTest : UarchTest
    {
        public ZeroElimVecRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "zeroelimvecrf";
            this.Description = "Do zeroing idioms consume vector registers?";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledXors = new string[2];
            unrolledXors[0] = "  xorps %xmm15, %xmm15";
            unrolledXors[1] = "  xorps %xmm14, %xmm14";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledXors, unrolledXors, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledXors = new string[2];
            unrolledXors[0] = "  xorps xmm15, xmm15";
            unrolledXors[1] = "  xorps xmm14, xmm14";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledXors, unrolledXors, true);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {

            string[] unrolledMovZero = new string[2];
            unrolledMovZero[0] = "  mov x15, 0";
            unrolledMovZero[1] = "  mov x14, 0";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMovZero, unrolledMovZero, true);
        }
    }
}
