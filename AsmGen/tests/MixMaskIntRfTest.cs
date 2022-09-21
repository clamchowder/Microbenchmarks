using System.Text;

namespace AsmGen
{
    public class MixMaskIntRfTest : UarchTest
    {
        public MixMaskIntRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixmaskintrf";
            this.Description = "Mixed Integer and Mask (K regs) RF Test - AVX-512 x86 CPUs only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  kaddb %k0, %k1, %k1";
            unrolledAdds[1] = "  add %r14, %r13";
            unrolledAdds[2] = "  kaddb %k0, %k3, %k3";
            unrolledAdds[3] = "  add %r11, %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  kaddb k1, k1, k0";
            unrolledAdds[1] = "  add r13, r14";
            unrolledAdds[2] = "  kaddb k3, k3, k0";
            unrolledAdds[3] = "  add r12, r11";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x11";
            unrolledAdds[1] = "  add x14, x14, x11";
            unrolledAdds[2] = "  add x13, x13, x11";
            unrolledAdds[3] = "  add x12, x12, x11";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }
    }
}
