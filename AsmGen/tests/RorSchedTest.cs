using System.Text;

namespace AsmGen
{
    public class RorSchedTest : UarchTest
    {
        public RorSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "rorsched";
            this.Description = "Rotate Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  mov %rdi, %r15";
            string postLoadInstr2 = "  mov %rsi, %r15";
            string[] rors = new string[1];
            rors[0] = "  ror $1, %r15";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, rors, rors, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  mov r15, rdi";
            string postLoadInstr2 = "  mov r15, rsi";
            string[] rors = new string[1];
            rors[0] = "  ror r15, 1";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, rors, rors, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  mov x15, x25";
            string postLoadInstr2 = "  mov x15, x26";
            string[] rors = new string[1];
            rors[0] = "  ror x15, x15, #1";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, rors, rors, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }
    }
}
