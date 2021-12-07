using System.Text;

namespace AsmGen
{
    public class StoreHoistSchedTest : UarchTest
    {
        public StoreHoistSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "storehoistsched";
            this.Description = "Store Address Scheduler (assuming load hoisting) Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr1, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] dependentStores = new string[4];
            dependentStores[0] = "  mov %r15, (%r8, %rdi, 4)";
            dependentStores[1] = "  mov %r15, (%r8, %rdi, 4)";
            dependentStores[2] = "  mov %r15, (%r8, %rdi, 4)";
            dependentStores[3] = "  mov %r15, (%r8, %rdi, 4)";

            string[] dependentStores1 = new string[4];
            dependentStores1[0] = "  mov %r11, (%r8, %rsi, 4)";
            dependentStores1[1] = "  mov %r11, (%r8, %rsi, 4)";
            dependentStores1[2] = "  mov %r11, (%r8, %rsi, 4)";
            dependentStores1[3] = "  mov %r11, (%r8, %rsi, 4)";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores1, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] dependentStores = new string[4];
            dependentStores[0] = "  mov [r8 + rdi * 4], r15";
            dependentStores[1] = "  mov [r8 + rdi * 4], r15";
            dependentStores[2] = "  mov [r8 + rdi * 4], r15";
            dependentStores[3] = "  mov [r8 + rdi * 4], r15";

            string[] dependentStores1 = new string[4];
            dependentStores1[0] = "  mov [r8 + rsi * 4], r11";
            dependentStores1[1] = "  mov [r8 + rsi * 4], r11";
            dependentStores1[2] = "  mov [r8 + rsi * 4], r11";
            dependentStores1[3] = "  mov [r8 + rsi * 4], r11";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores1, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] dependentStores = new string[4];
            dependentStores[0] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[1] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[2] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[3] = "  str w15, [x2, w25, uxtw #2]";

            string[] dependentStores1 = new string[4];
            dependentStores1[0] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[1] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[2] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[3] = "  str w15, [x2, w26, uxtw #2]";
            UarchTestHelpers.GenerateArmAsmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores1, false);
        }
    }
}
