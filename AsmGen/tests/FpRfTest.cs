using System.Text;

namespace AsmGen
{
    public class FpRfTest : UarchTest
    {
        public FpRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fprf";
            this.Description = "FP Register File";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return true;
            if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string initInstrs = "  movss (%r8), %xmm1\n" +
                    "  movss 4(%r8), %xmm2\n" +
                    "  movss 8(%r8), %xmm3\n" +
                    "  movss 12(%r8), %xmm4\n" +
                    "  movss 16(%r8), %xmm5\n";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  addss %xmm1, %xmm2";
                unrolledAdds[1] = "  addss %xmm1, %xmm3";
                unrolledAdds[2] = "  addss %xmm1, %xmm4";
                unrolledAdds[3] = "  addss %xmm1, %xmm5";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false, initInstrs);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string initInstrs = "  ldr s17, [x2]\n" +
                    "  ldr s18, [x2, 4]\n" +
                    "  ldr s19, [x2, 8]\n" +
                    "  ldr s20, [x2, 12]\n" +
                    "  ldr s21, [x2, 16]\n";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  fadd s18, s18, s17";
                unrolledAdds[1] = "  fadd s19, s19, s17";
                unrolledAdds[2] = "  fadd s20, s20, s17";
                unrolledAdds[3] = "  fadd s21, s21, s17";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false, initInstrs);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string initInstrs = "  fld.s $f8, $r6, 0\n" +
                    "  fld.s $f9, $r6, 4\n" +
                    "  fld.s $f10, $r6, 8\n" +
                    "  fld.s $f11, $r6, 12\n" +
                    "  fld.s $f12, $r6, 16\n";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  fadd.s $f9, $f9, $f8";
                unrolledAdds[1] = "  fadd.s $f10, $f10, $f8";
                unrolledAdds[2] = "  fadd.s $f11, $f11, $f8";
                unrolledAdds[3] = "  fadd.s $f12, $f12, $f8";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false, initInstrs);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string initInstrs = "  fld f0, (x12)\n" +
                    "  fld f1, 8(x12)\n" +
                    "  fld f2, 16(x12)\n" +
                    "  fld f3, 24(x12)\n" +
                    "  fld f4, 32(x12)\n";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  fadd.s f0, f0, f4";
                unrolledAdds[1] = "  fadd.s f1, f1, f4";
                unrolledAdds[2] = "  fadd.s f2, f2, f4";
                unrolledAdds[3] = "  fadd.s f3, f3, f4";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false, initInstrs);
            }
        }
    }
}
