using System.Text;

namespace AsmGen
{
    public class Add256RfTest : UarchTest
    {
        public Add256RfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "add256rf";
            this.Description = "256-bit Integer Add RF Capacity Test - 128-bit fadd on ARM";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovdqu (%r8), %ymm0\n" +
                "  vmovdqa %ymm0, %ymm1\n" +
                "  vmovdqa %ymm0, %ymm2\n" +
                "  vmovdqa %ymm0, %ymm3\n" +
                "  vmovdqa %ymm0, %ymm4\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vpaddd %ymm0, %ymm1, %ymm1";
            unrolledAdds[1] = "  vpaddd %ymm0, %ymm2, %ymm2";
            unrolledAdds[2] = "  vpaddd %ymm0, %ymm3, %ymm3";
            unrolledAdds[3] = "  vpaddd %ymm0, %ymm4, %ymm3";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovdqu ymm0, [r8]\n" +
                "  vmovdqa ymm1, ymm0\n" +
                "  vmovdqa ymm2, ymm0\n" +
                "  vmovdqa ymm3, ymm0\n" +
                "  vmovdqa ymm4, ymm0\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vpaddd ymm1, ymm1, ymm0";
            unrolledAdds[1] = "  vpaddd ymm2, ymm2, ymm0";
            unrolledAdds[2] = "  vpaddd ymm3, ymm3, ymm0";
            unrolledAdds[3] = "  vpaddd ymm4, ymm4, ymm0";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fadd v15.4s, v15.4s, v19.4s";
            unrolledAdds[1] = "  fadd v16.4s, v16.4s, v19.4s";
            unrolledAdds[2] = "  fadd v17.4s, v17.4s, v19.4s";
            unrolledAdds[3] = "  fadd v18.4s, v18.4s, v19.4s";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }
    }
}
