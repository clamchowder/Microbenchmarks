using System.Text;

namespace AsmGen
{
    public class MixLoadStoreSchedTest : UarchTest
    {
        public MixLoadStoreSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixloadstoresched";
            this.Description = "Mixed Load/Store (Address Dependency) scheduler capacity test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] ops1 = new string[4];
            ops1[0] = "  mov (%rdx, %rdi, 4), %r15";
            ops1[1] = "  mov %r11, (%r8, %rdi, 4)";
            ops1[2] = "  mov (%rdx, %rdi, 4), %r13";
            ops1[3] = "  mov %r11, (%r8, %rdi)";

            string[] ops2 = new string[4];
            ops2[0] = "  mov (%rdx, %rsi, 4), %r15";
            ops2[1] = "  mov %r11, (%r8, %rsi, 4)";
            ops2[2] = "  mov (%rdx, %rsi, 4), %r13";
            ops2[3] = "  mov %r11, (%r8, %rsi)";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, ops1, ops2, true);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            // todo
            string[] dependentLoads = new string[4];
            dependentLoads[0] = "  mov r15, [r8 + rdi * 4]";
            dependentLoads[1] = "  mov r14, [r8 + rdi * 4]";
            dependentLoads[2] = "  mov r13, [r8 + rdi * 4]";
            dependentLoads[3] = "  mov r12, [r8 + rdi * 4]";

            string[] dependentLoads1 = new string[4];
            dependentLoads1[0] = "  mov r15, [r8 + rsi * 4]";
            dependentLoads1[1] = "  mov r14, [r8 + rsi * 4]";
            dependentLoads1[2] = "  mov r13, [r8 + rsi * 4]";
            dependentLoads1[3] = "  mov r12, [r8 + rsi * 4]";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            // todo
            string[] dependentLoads = new string[4];
            dependentLoads[0] = "  ldr w15, [x2, w25, uxtw #2]";
            dependentLoads[1] = "  ldr w14, [x2, w25, uxtw #2]";
            dependentLoads[2] = "  ldr w13, [x2, w25, uxtw #2]";
            dependentLoads[3] = "  ldr w12, [x2, w25, uxtw #2]";

            string[] dependentLoads1 = new string[4];
            dependentLoads1[0] = "  ldr w15, [x2, w26, uxtw #2]";
            dependentLoads1[1] = "  ldr w14, [x2, w26, uxtw #2]";
            dependentLoads1[2] = "  ldr w13, [x2, w26, uxtw #2]";
            dependentLoads1[3] = "  ldr w12, [x2, w26, uxtw #2]";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, false);
        }
    }
}
