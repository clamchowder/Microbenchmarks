﻿using System.Text;

namespace AsmGen
{
    public class FcvtSchedTest : UarchTest
    {
        public FcvtSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fcvtsched";
            this.Description = "fcvt Scheduler";
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
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  fcvt d17, s16";
                unrolledAdds[1] = "  fcvt d18, s16";
                unrolledAdds[2] = "  fcvt d19, s16";
                unrolledAdds[3] = "  fcvt d20, s16";
                UarchTestHelpers.GenerateArmAsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
            }
        }
    }
}
