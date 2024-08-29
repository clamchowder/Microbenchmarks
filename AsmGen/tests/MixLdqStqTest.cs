using System.Text;

namespace AsmGen
{
    public class MixLdqStqTest : UarchTest
    {
        private bool initialDependentBranch;
        public MixLdqStqTest(int low, int high, int step, bool initialDependentBranch)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixldqstq" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "Mixed Load/Store Queue Test (mem ops pending retire)" + (initialDependentBranch ? ", preceded by dependent branch" : string.Empty);
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.initialDependentBranch = initialDependentBranch;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                GenerateX86GccAsm(sb);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                GenerateArmAsm(sb);
            }
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] instrs = new string[4];
            instrs[0] = "  mov %r15, (%r8)";
            instrs[1] = "  mov (%rdx), %r14";
            instrs[2] = "  mov %r13, (%r8)";
            instrs[3] = "  mov (%rdx), %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetArmDependentBranch(this.Prefix) : null;
            string[] instrs = new string[4];
            instrs[0] = "  str x15, [x2]";
            instrs[1] = "  ldr x14, [x1]";
            instrs[2] = "  str x13, [x2]";
            instrs[3] = "  ldr x12, [x1]";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(
                sb, this.Counts, this.Prefix, instrs, instrs, true, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
            if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
        }
    }
}