using System.Text;

namespace AsmGen
{
    public class VecRfTest : UarchTest
    {
        public string Prefix { get => "vec128rf"; }
        public string Description { get => "Vector (128-bit packed int) RF Test"; }
        public string FunctionDefinitionParameters { get => "uint64_t iterations, int *arr"; }
        public string GetFunctionCallParameters { get => "structIterations, A"; }

        public int[] Counts { get; private set; }

        public VecRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            // it's ok, the ptr chasing arr should be way bigger than this
            string initInstrs = "  movdqu (%rdx), %xmm1\n" +
                "  movdqu 16(%rdx), %xmm2\n" +
                "  movdqu 32(%rdx), %xmm3\n" +
                "  movdqu 48(%rdx), %xmm4\n" +
                "  movdqu 64(%rdx), %xmm5\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddq %xmm1, %xmm2";
            unrolledAdds[1] = "  paddq %xmm1, %xmm3";
            unrolledAdds[2] = "  paddq %xmm1, %xmm4";
            unrolledAdds[3] = "  paddq %xmm1, %xmm5";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movdqu xmm1, [rdx]\n" +
                "  movdqu xmm2, [rdx + 16]\n" +
                "  movdqu xmm3, [rdx + 32]\n" +
                "  movdqu xmm4, [rdx + 48]\n" +
                "  movdqu xmm5, [rdx + 64]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddq xmm2, xmm1";
            unrolledAdds[1] = "  paddq xmm3, xmm1";
            unrolledAdds[2] = "  paddq xmm4, xmm1";
            unrolledAdds[3] = "  paddq xmm5, xmm1";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string initInstrs = "  ldr q0, [x1]\n" +
                "  ldr q1, [x1, #0x10]\n" +
                "  ldr q2, [x1, #0x20]\n" +
                "  ldr q3, [x1, #0x30]\n" +
                "  ldr q4, [x1, #0x40]\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add v1.4s, v1.4s, v0.4s";
            unrolledAdds[1] = "  add v2.4s, v2.4s, v0.4s";
            unrolledAdds[2] = "  add v3.4s, v3.4s, v0.4s";
            unrolledAdds[3] = "  add v4.4s, v4.4s, v0.4s";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs);
        }
    }
}
