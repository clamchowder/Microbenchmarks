using System.Text;

namespace AsmGen
{
    public class ZeroRobTest : UarchTest
    {
        public ZeroRobTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "zerorob";
            this.Description = "Reorder Buffer Test with Zeroing Idioms";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
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
                string[] nops = new string[] { "  mov x10, 0" };
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, nops, nops, true);
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
