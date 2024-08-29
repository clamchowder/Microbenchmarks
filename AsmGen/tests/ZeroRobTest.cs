using System.Text;

namespace AsmGen
{
    public class ZeroRobTest : UarchTest
    {
        private bool initialDependentBranch;
        public ZeroRobTest(int low, int high, int step, bool initialDependentBranch)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "zerorob" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "Reorder Buffer Test with Zeroing Idioms" + (initialDependentBranch ? ", preceded by dependent branch" : string.Empty);
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
            this.initialDependentBranch = initialDependentBranch;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (this.initialDependentBranch && isa != IUarchTest.ISA.aarch64) return false;
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] nops = new string[] { "  xor %r11, %r11" };
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetArmDependentBranch(this.Prefix) : null;
                string[] nops = new string[] { "  mov x10, 0" };
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string[] nops = new string[] { "  move $r14, $r0" };
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string[] nops = new string[] { "  mov $r14, $r0" };
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, includePtrChasingLoads: true);
            }
        }
    }
}
