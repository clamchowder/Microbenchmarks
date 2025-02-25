using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class MixFpVecRfTest : UarchTest
    {
        private bool initialDependentBranch;
        public MixFpVecRfTest(int low, int high, int step, bool initialDependentBranch)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixfpvecrf" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "Mixed FP/128-bit FP vec rf" + (initialDependentBranch ? ", preceded by dependent branch" : string.Empty);
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.initialDependentBranch = initialDependentBranch;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (this.initialDependentBranch)
            {
                if (isa == IUarchTest.ISA.riscv) return true;
                return false;
            }

            if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.riscv)
            {
                string initInstrs = "  vsetvli t5, t6, e32\n  vlw.v v0, (a1)\n    fld f0, (a1)";
                string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetRiscvDependentBranch(this.Prefix) : string.Empty;
                postLoadInstrs += "\n  mv t6, a2";
                string[] unrolledInstrs = new string[2];
                unrolledInstrs[0] = "  vfadd.vv v0, v0, v0";
                unrolledInstrs[1] = "  fadd.s f0, f0, f0";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledInstrs, unrolledInstrs, false,
                    initInstrs: initInstrs, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetRiscvDependentBranchTarget(this.Prefix));
            }
        }
    }
}
