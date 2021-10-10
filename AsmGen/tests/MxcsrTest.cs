using System.Text;

namespace AsmGen
{
    public class MxcsrTest : UarchTest
    {
        public MxcsrTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mxcsrrename";
            this.Description = "MXCSR renamed registers";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] nops = new string[2];
            nops[0] = "  mov $0x1f80, %r15\n  mov %r15, (%r8)\n  ldmxcsr (%r8)\n  addss %xmm0, %xmm1"; // default
            nops[1] = "  mov $0x9fc0, %r15\n  mov %r15, (%r8)\n  ldmxcsr (%r8)\n  addss %xmm0, %xmm1"; // set denormals are zero, flush to zero
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        // todo
        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] nops = new string[1];
            nops[0] = "test r15, r14";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }

        // todo
        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] nops = new string[1];
            nops[0] = "cmp x14, x15";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
        }
    }
}
