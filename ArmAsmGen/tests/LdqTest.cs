using System.Text;

namespace AsmGen
{
    public class LdqTest : UarchTest
    {
        public string Prefix { get => "ldq"; }
        public string Description { get => "Load Queue Test (loads pending retire)"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr, int *arr1"; }
        public string GetFunctionCallParameters { get => "structIterations, A, B"; }

        public int[] Counts { get; private set; }
        public bool DivideTimeByCount => false;

        public LdqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  mov (%r8), %r15";
            unrolledLoads[1] = "  mov (%r8), %r14";
            unrolledLoads[2] = "  mov (%r8), %r13";
            unrolledLoads[3] = "  mov (%r8), %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, true);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  mov r15, [r8]";
            unrolledLoads[1] = "  mov r14, [r8]";
            unrolledLoads[2] = "  mov r13, [r8]";
            unrolledLoads[3] = "  mov r12, [r8]";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, true);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  ldr x15, [x2]";
            unrolledLoads[1] = "  ldr x14, [x2]";
            unrolledLoads[2] = "  ldr x13, [x2]";
            unrolledLoads[3] = "  ldr x12, [x2]";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, true);
        }
    }
}
