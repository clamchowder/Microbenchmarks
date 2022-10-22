using System.Text;

namespace AsmGen
{
    public class ZeroElimIntRf : UarchTest
    {
        public ZeroElimIntRf(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "zeroelimintrf";
            this.Description = "Do zeroing idioms consume integer registers?";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledXors = new string[2];
            unrolledXors[0] = "  xor %r15, %r15";
            unrolledXors[1] = "  xor %r14, %r14";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledXors, unrolledXors, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledXors = new string[2];
            unrolledXors[0] = "  xor r15, r15";
            unrolledXors[1] = "  xor r14, r14";
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
