using System.Text;

namespace AsmGen
{
    public class MixMmxSseRf : UarchTest
    {
        public MixMmxSseRf(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixmmxsserf";
            this.Description = "Mixed 64-bit MMX and 128-bit SSE RF Capacity Test. x86 only";
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

            initInstrs += "  movdqu (%rdx), %xmm1\n" +
                "  movdqu 16(%rdx), %xmm2\n" +
                "  movdqu 32(%rdx), %xmm3\n" +
                "  movdqu 48(%rdx), %xmm4\n" +
                "  movdqu 64(%rdx), %xmm5\n";

            string[] unrolledAdds = new string[8];
            unrolledAdds[0] = "  paddw %mm0, %mm1";
            unrolledAdds[1] = "  paddq %xmm1, %xmm2";
            unrolledAdds[2] = "  paddw %mm0, %mm2";
            unrolledAdds[3] = "  paddq %xmm1, %xmm3";
            unrolledAdds[4] = "  paddw %mm0, %mm3";
            unrolledAdds[5] = "  paddq %xmm1, %xmm4";
            unrolledAdds[6] = "  paddw %mm0, %mm4";
            unrolledAdds[7] = "  paddq %xmm1, %xmm5";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movq mm0, [rdx]\n" +
                "  movq mm1, [rdx + 8]\n" +
                "  movq mm2, [rdx + 16]\n" +
                "  movq mm3, [rdx + 24]\n" +
                "  movq mm4, [rdx + 32]\n";

            initInstrs += "  movdqu xmm1, [rdx]\n" +
                "  movdqu xmm2, [rdx + 16]\n" +
                "  movdqu xmm3, [rdx + 32]\n" +
                "  movdqu xmm4, [rdx + 48]\n" +
                "  movdqu xmm5, [rdx + 64]\n";

            string[] unrolledAdds = new string[8];
            unrolledAdds[0] = "  paddw mm1, mm0";
            unrolledAdds[1] = "  paddq xmm2, xmm1";
            unrolledAdds[2] = "  paddw mm2, mm0";
            unrolledAdds[3] = "  paddq xmm3, xmm1";
            unrolledAdds[4] = "  paddw mm3, mm0";
            unrolledAdds[5] = "  paddq xmm4, xmm1";
            unrolledAdds[6] = "  paddw mm4, mm0";
            unrolledAdds[7] = "  paddq xmm5, xmm1";
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
