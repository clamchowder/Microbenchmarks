using System.Text;

namespace AsmGen
{
    public class LoadSchedTest : UarchTest
    {
        public string Prefix { get => "loadsched"; }
        public string Description { get => "Load Scheduler Capacity Test"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr, int *arr2"; }
        public string GetFunctionCallParameters { get => "structIterations, A, B"; }

        public int[] Counts { get; private set; }
        public bool DivideTimeByCount => false;

        public LoadSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] dependentLoads = new string[4];
            dependentLoads[0] = "  mov (%r8, %rdi, 4), %r15";
            dependentLoads[1] = "  mov (%r8, %rdi, 4), %r14";
            dependentLoads[2] = "  mov (%r8, %rdi, 4), %r13";
            dependentLoads[3] = "  mov (%r8, %rdi, 4), %r12";

            string[] dependentLoads1 = new string[4];
            dependentLoads1[0] = "  mov (%r8, %rsi, 4), %r15";
            dependentLoads1[1] = "  mov (%r8, %rsi, 4), %r14";
            dependentLoads1[2] = "  mov (%r8, %rsi, 4), %r13";
            dependentLoads1[3] = "  mov (%r8, %rsi, 4), %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, false);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
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

        public void GenerateArmAsm(StringBuilder sb)
        {
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
