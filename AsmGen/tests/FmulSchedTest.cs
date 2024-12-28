using System.Text;

namespace AsmGen
{
    public class FmulSchedTest : UarchTest
    {
        public FmulSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fmulsched";
            this.Description = "FP (32-bit multiply) Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                GenerateX86Asm(sb);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                GenerateArmAsm(sb);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                GenerateRiscvAsm(sb);
            }
        }

        public void GenerateX86Asm(StringBuilder sb)
        {
            // xmm0 is dependent on ptr chasing load
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  mulss %xmm0, %xmm1";
            unrolledAdds[1] = "  mulss %xmm0, %xmm2";
            unrolledAdds[2] = "  mulss %xmm0, %xmm3";
            unrolledAdds[3] = "  mulss %xmm0, %xmm4";

            UarchTestHelpers.GenerateX86AsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fmul s17, s17, s16";
            unrolledAdds[1] = "  fmul s18, s18, s16";
            unrolledAdds[2] = "  fmul s19, s19, s16";
            unrolledAdds[3] = "  fmul s20, s20, s16";
            UarchTestHelpers.GenerateArmAsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public void GenerateRiscvAsm(StringBuilder sb)
        {
            string initInstrs = "  fld f0, (x12)\n" +
                "  fld f1, 8(x12)\n" +
                "  fld f2, 16(x12)\n" +
                "  fld f3, 24(x12)\n" +
                "  fld f4, 32(x12)\n";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fmul.s f0, f0, f4";
            unrolledAdds[1] = "  fmul.s f1, f1, f4";
            unrolledAdds[2] = "  fmul.s f2, f2, f4";
            unrolledAdds[3] = "  fmul.s f3, f3, f4";

            string postLoadInstrs1 = "  andi x7, x5, 0xF\n  add x7, x7, x12\n  fld f4, (x7)";
            string postLoadInstrs2 = "  andi x7, x6, 0xF\n  add x7, x7, x12\n  fld f4, (x7)";
            UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false,
                initInstrs, postLoadInstrs1, postLoadInstrs2);
        }
    }
}