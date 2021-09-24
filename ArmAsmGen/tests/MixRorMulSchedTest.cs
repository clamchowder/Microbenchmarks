using System.Text;

namespace AsmGen
{
    public class MixMulRorSchedTest : UarchTest
    {
        public MixMulRorSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixmulrorsched";
            this.Description = "Mixed Multiply/Rotate Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  mov %rdi, %r15";
            string postLoadInstr2 = "  mov %rsi, %r15";
            string[] instrs1 = new string[2];
            instrs1[0] = "  ror $1, %r15";
            instrs1[1] = "  imul %edi, %r12d";
            string[] instrs2 = new string[2];
            instrs2[0] = "  ror $1, %r15";
            instrs2[1] = "  imul %esi, %r11d";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs1, instrs1, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  mov r15, rdi";
            string postLoadInstr2 = "  mov r15, rsi";
            string[] instrs = new string[2];
            instrs[0] = "  ror r15, 1";
            instrs[1] = "  imul r12d, edi";
            string[] instrs1 = new string[2];
            instrs1[0] = "  ror r15, 1";
            instrs1[1] = "  imul r11d, esi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs1, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  mov x15, x25";
            string postLoadInstr2 = "  mov x15, x26";
            string[] instrs = new string[2];
            instrs[0] = "  ror x15, x15, #1";
            instrs[1] = "  mul x12, x12, x25";
            string[] instrs1 = new string[2];
            instrs1[0] = "  ror x15, x15, #1";
            instrs1[1] = "  mul x11, x11, x26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }
    }
}
