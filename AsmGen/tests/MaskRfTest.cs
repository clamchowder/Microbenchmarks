using System.Text;

namespace AsmGen
{
    public class MaskRfTest : UarchTest
    {
        public MaskRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "maskrf";
            this.Description = "Mask (K regs) RF Test - AVX-512 x86 CPUs only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  kandw %k0, %k1, %k1";
            unrolledAdds[1] = "  kandw %k0, %k2, %k2";
            unrolledAdds[2] = "  kandw %k0, %k3, %k3";
            unrolledAdds[3] = "  kandw %k0, %k4, %k4";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  kandw k1, k1, k0";
            unrolledAdds[1] = "  kandw k2, k2, k0";
            unrolledAdds[2] = "  kandw k3, k3, k0";
            unrolledAdds[3] = "  kandw k4, k4, k0";
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
