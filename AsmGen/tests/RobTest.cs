using System.Text;

namespace AsmGen
{
    public class RobTest : UarchTest
    {
        private string[] nops;
        private bool initialDependentBranch;
        public RobTest(int low, int high, int step, bool initialDependentBranch)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "rob" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "Reorder Buffer Test" + (initialDependentBranch ? " preceded by dependent branch" : string.Empty);
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
            this.nops = new string[] { "nop" };
            this.initialDependentBranch = initialDependentBranch;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (this.initialDependentBranch)
            {
                if (isa == IUarchTest.ISA.aarch64) return true;
                if (isa == IUarchTest.ISA.riscv) return true;
                return false;
            }

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
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetArmDependentBranch(this.Prefix) : null;
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetRiscvDependentBranch(this.Prefix) : null;
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, includePtrChasingLoads: true, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetRiscvDependentBranchTarget(this.Prefix));
            }
        }
    }
}
