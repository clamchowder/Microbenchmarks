using System.Text;

namespace AsmGen
{
    public class MixLdqVecLdqTest : UarchTest
    {
        bool initialDependentBranch;
        public MixLdqVecLdqTest(int low, int high, int step, bool initialDependentBranch)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixldqvecldq" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "Load Queue mixed" + (initialDependentBranch ? ", preceded by dependent branch"  : string.Empty);
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.initialDependentBranch = initialDependentBranch;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (this.initialDependentBranch && isa != IUarchTest.ISA.aarch64) return false;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64)
            {
                string postLoadInstr = this.initialDependentBranch ? UarchTestHelpers.GetArmDependentBranch(this.Prefix) : null;
                string[] unrolledLoads = new string[4];
                unrolledLoads[0] = "  ldr x15, [x2]";
                unrolledLoads[1] = "  ldr q0, [x2]";
                unrolledLoads[2] = "  ldr x13, [x2]";
                unrolledLoads[3] = "  ldr q1, [x2]";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, includePtrChasingLoads: true, postLoadInstrs1: postLoadInstr, postLoadInstrs2: postLoadInstr);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
            }
        }
    }
}
