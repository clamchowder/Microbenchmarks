using System.Text;

namespace AsmGen
{
    public class LdqStqTest : UarchTest
    {
        public LdqStqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixldqstq";
            this.Description = "Mixed Load/Store Queue Test (mem ops pending retire)";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] instrs = new string[4];
            instrs[0] = "  mov %r15, (%r8)";
            instrs[1] = "  mov (%rdx), %r14";
            instrs[2] = "  mov %r13, (%r8)";
            instrs[3] = "  mov (%rdx), %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] instrs = new string[4];
            instrs[0] = "  mov [r8], r15";
            instrs[1] = "  mov r14, [rdx]";
            instrs[2] = "  mov [r8], r13";
            instrs[3] = "  mov r12, [rdx]";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] instrs = new string[4];
            instrs[0] = "  str x15, [x2]";
            instrs[1] = "  ldr x14, [x1]";
            instrs[2] = "  str x13, [x2]";
            instrs[3] = "  ldr x12, [x1]";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true);
        }
    }
}
