using System.Text;

namespace AsmGen
{
    public class Fadd128RfTest : UarchTest
    {
        private bool initialDependentBranch;
        public Fadd128RfTest(int low, int high, int step, bool initialDependentBranch)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fadd128rf" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "128-bit FP/vector RF capacity" + (initialDependentBranch ? ", preceded by dependent branch" : string.Empty);
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.initialDependentBranch = initialDependentBranch;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (this.initialDependentBranch && isa != IUarchTest.ISA.aarch64) return false;
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return false;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string initInstrs = "  vmovups (%r8), %ymm0\n" +
                 "  vmovups %ymm0, %ymm1\n" +
                 "  vmovups %ymm0, %ymm2\n" +
                 "  vmovups %ymm0, %ymm3\n" +
                 "  vmovups %ymm0, %ymm4\n";

                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  vaddps %ymm0, %ymm1, %ymm1";
                unrolledAdds[1] = "  vaddps %ymm0, %ymm2, %ymm2";
                unrolledAdds[2] = "  vaddps %ymm0, %ymm3, %ymm3";
                unrolledAdds[3] = "  vaddps %ymm0, %ymm4, %ymm3";

                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, initInstrs: initInstrs);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetArmDependentBranch(this.Prefix) : null;
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
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
            }
        }
    }
}
