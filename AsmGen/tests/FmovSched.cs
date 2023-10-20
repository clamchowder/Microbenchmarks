using System.Text;

namespace AsmGen
{
    public class FmovSched : UarchTest
    {
        public FmovSched(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fmovsched";
            this.Description = "FMOV vec to gpr Scheduler";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64)
            {
                string postLoadInstrs1 = "  ldr d16, [x2, w25, sxtw #0]";
                string postLoadInstrs2 = "  ldr d16, [x2, w25, sxtw #0]";
                string[] unrolledInstrs = new string[4];
                unrolledInstrs[0] = "  fmov x15, d16";
                unrolledInstrs[1] = "  fmov x14, d16";
                unrolledInstrs[2] = "  fmov x13, d16";
                unrolledInstrs[3] = "  fmov x12, d16";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs, false, null,
                    postLoadInstrs1: postLoadInstrs1, postLoadInstrs2: postLoadInstrs2);
            }
        }
    }
}
