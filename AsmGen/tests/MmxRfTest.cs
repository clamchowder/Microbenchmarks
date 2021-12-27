using System.Text;

namespace AsmGen
{
    public class MmxRfTest : UarchTest
    {
        public MmxRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mmxrf";
            this.Description = "64-bit MMX RF Capacity Test. x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  movq (%rdx), %mm0\n" +
                "  movq 8(%rdx), %mm1\n" +
                "  movq 16(%rdx), %mm2\n" +
                "  movq 24(%rdx), %mm3\n" +
                "  movq 32(%rdx), %mm4\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddw %mm0, %mm1";
            unrolledAdds[1] = "  paddw %mm0, %mm2";
            unrolledAdds[2] = "  paddw %mm0, %mm3";
            unrolledAdds[3] = "  paddw %mm0, %mm4";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movq mm0, [rdx]\n" +
                "  movq mm1, [rdx + 8]\n" +
                "  movq mm2, [rdx + 16]\n" +
                "  movq mm3, [rdx + 24]\n" +
                "  movq mm4, [rdx + 32]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddw mm1, mm0";
            unrolledAdds[1] = "  paddw mm2, mm0";
            unrolledAdds[2] = "  paddw mm3, mm0";
            unrolledAdds[3] = "  paddw mm4, mm0";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add v15.2s, v15.2s, v19.2s";
            unrolledAdds[1] = "  add v16.2s, v16.2s, v19.2s";
            unrolledAdds[2] = "  add v17.2s, v17.2s, v19.2s";
            unrolledAdds[3] = "  add v18.2s, v18.2s, v19.2s";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }
    }
}
