using System.Text;

namespace AsmGen
{
    public class Fadd128SchedTest : UarchTest
    {
        public Fadd128SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fadd128sched";
            this.Description = "128-bit Vector FP Add Scheduler";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  addps %xmm0, %xmm1";
                unrolledAdds[1] = "  addps %xmm0, %xmm2";
                unrolledAdds[2] = "  addps %xmm0, %xmm3";
                unrolledAdds[3] = "  addps %xmm0, %xmm4";

                UarchTestHelpers.GenerateX86AsmFpSchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string postLoadInstrs1 = "  ldr q0, [x2, w25, uxtw#0]";
                string postLoadInstrs2 = "  ldr q0, [x2, w26, uxtw#0]";
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  add v1.4s, v1.4s, v0.4s";
                unrolledAdds[1] = "  add v2.4s, v2.4s, v0.4s";
                unrolledAdds[2] = "  add v3.4s, v3.4s, v0.4s";
                unrolledAdds[3] = "  add v4.4s, v4.4s, v0.4s";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, null, postLoadInstrs1, postLoadInstrs2);
            }
        }
    }
}
