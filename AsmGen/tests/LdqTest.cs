using System.Text;

namespace AsmGen
{
    public class LdqTest : UarchTest
    {
        public LdqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "ldq";
            this.Description = "Load Queue";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
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
                string[] unrolledLoads = new string[4];
                unrolledLoads[0] = "  mov (%r8), %r15";
                unrolledLoads[1] = "  mov (%r8), %r14";
                unrolledLoads[2] = "  mov (%r8), %r13";
                unrolledLoads[3] = "  mov (%r8), %r12";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] unrolledLoads = new string[4];
                unrolledLoads[0] = "  ldr x15, [x2]";
                unrolledLoads[1] = "  ldr x14, [x2]";
                unrolledLoads[2] = "  ldr x13, [x2]";
                unrolledLoads[3] = "  ldr x12, [x2]";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string[] unrolledLoads = new string[4];
                unrolledLoads[0] = "  ld.d $r15, $r6, 0";
                unrolledLoads[1] = "  ld.d $r16, $r6, 8";
                unrolledLoads[2] = "  ld.d $r17, $r6, 16";
                unrolledLoads[3] = "  ld.d $r18, $r6, 24";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string[] unrolledLoads = new string[4];
                unrolledLoads[0] = "  ld x28, (x11)";
                unrolledLoads[1] = "  ld x29, 8(x11)";
                unrolledLoads[2] = "  ld x30, 16(x11)";
                unrolledLoads[3] = "  ld x31, 24(x11)";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, includePtrChasingLoads: true);
            }
        }
    }
}
