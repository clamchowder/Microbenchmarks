using System.Text;

namespace AsmGen
{
    /// <summary>
    /// Determines whether there is a non-scheduling queue, overflow buffer, dispatch buffer, or whatever you choose to call it
    /// is placed before the store address scheduler. Trying to see if Gracemont has a memory overflow buffer like Tremont does,
    /// according to Wikichip. 
    /// </summary>
    public class StoreNsqTest : UarchTest
    {
        public StoreNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "storensq";
            this.Description = "Store Address Scheduler Capacity Test, Excluding NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            this.GenerateX86GccAsmDivVersion(sb);
        }

        private void GenerateX86GccAsmDivVersion(StringBuilder sb)
        {
            string[] dependentStores = new string[4];
            dependentStores[0] = "  mov %r15w, (%r8, %rdx, 2)";
            dependentStores[1] = "  mov %r15w, 2(%r8, %rdx, 2)";
            dependentStores[2] = "  mov %r15w, 4(%r8, %rdx, 2)";
            dependentStores[3] = "  mov %r15w, 6(%r8, %rdx, 2)";

            string[] indepStores = new string[4];
            indepStores[0] = "  mov %r11w, (%r8)";
            indepStores[1] = "  mov %r11w, 2(%r8)";
            indepStores[2] = "  mov %r11w, 4(%r8)";
            indepStores[3] = "  mov %r11w, 6(%r8)";

            UarchTestHelpers.GenerateX86AsmDivNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, indepStores, false);
        }

        private void GenerateX86GccAsmLoadHoistVersion(StringBuilder sb)
        {
            string[] dependentStores = new string[4];
            dependentStores[0] = "  mov %r15w, (%r8, %rdi, 2)";
            dependentStores[1] = "  mov %r15w, 2(%r8, %rdi, 2)";
            dependentStores[2] = "  mov %r15w, 4(%r8, %rdi, 2)";
            dependentStores[3] = "  mov %r15w, 6(%r8, %rdi, 2)";

            string[] indepStores = new string[4];
            indepStores[0] = "  mov %r11w, (%r8)";
            indepStores[1] = "  mov %r11w, 2(%r8)";
            indepStores[2] = "  mov %r11w, 4(%r8)";
            indepStores[3] = "  mov %r11w, 6(%r8)";

            UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, indepStores, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] dependentStores = new string[4];
            dependentStores[0] = "  mov [r8 + rdi * 4], r15d";
            dependentStores[1] = "  mov [r8 + rdi * 4], r15d";
            dependentStores[2] = "  mov [r8 + rdi * 4], r15d";
            dependentStores[3] = "  mov [r8 + rdi * 4], r15d";

            string[] indepStores = new string[4];
            indepStores[0] = "  mov [r8], r11";
            indepStores[1] = "  mov [r8 + 8], r11";
            indepStores[2] = "  mov [r8 + 16], r11";
            indepStores[3] = "  mov [r8 + 24], r11";
            UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, indepStores, false);
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
