using System.Text;

namespace AsmGen
{
    public class FaddSchedTest : UarchTest
    {
        public FaddSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "faddsched";
            this.Description = "FP Add Scheduler";
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
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  addss %xmm0, %xmm1";
                unrolledAdds[1] = "  addss %xmm0, %xmm2";
                unrolledAdds[2] = "  addss %xmm0, %xmm3";
                unrolledAdds[3] = "  addss %xmm0, %xmm4";

                UarchTestHelpers.GenerateX86AsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  fadd s17, s17, s16";
                unrolledAdds[1] = "  fadd s18, s18, s16";
                unrolledAdds[2] = "  fadd s19, s19, s16";
                unrolledAdds[3] = "  fadd s20, s20, s16";
                UarchTestHelpers.GenerateArmAsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string initInstrs = "  fld.s $f8, $r6, 0\n" +
                    "  fld.s $f9, $r6, 4\n" +
                    "  fld.s $f10, $r6, 8\n" +
                    "  fld.s $f11, $r6, 12\n" +
                    "  fld.s $f12, $r6, 16\n";

                string postLoadInstrs1 = "  andi $r19, $r12, 0xF\n  add.d $r19, $r19, $r6\n fld.s $f8, $r19, 0";
                string[] dependentAdds = new string[4];
                dependentAdds[0] = "  fadd.s $f9, $f9, $f8";
                dependentAdds[1] = "  fadd.s $f10, $f10, $f8";
                dependentAdds[2] = "  fadd.s $f11, $f11, $f8";
                dependentAdds[3] = "  fadd.s $f12, $f12, $f8";

                string postLoadInstrs2 = "  andi $r19, $r13, 0xF\n  add.d $r19, $r19, $r6\n fld.s $f8, $r19, 0";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, dependentAdds, dependentAdds, includePtrChasingLoads: false, initInstrs: initInstrs, 
                    postLoadInstrs1: postLoadInstrs1, postLoadInstrs2: postLoadInstrs2);
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

                string postLoadInstrs1 = "  andi x7, x5, 0xF\n  add x7, x7, x12\n  fld f4, (x7)";
                string postLoadInstrs2 = "  andi x7, x6, 0xF\n  add x7, x7, x12\n  fld f4, (x7)";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false,
                    initInstrs, postLoadInstrs1, postLoadInstrs2);
            }
        }
    }
}
