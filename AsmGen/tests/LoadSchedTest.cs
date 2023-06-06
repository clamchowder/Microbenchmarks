using System.Text;

namespace AsmGen
{
    public class LoadSchedTest : UarchTest
    {
        public LoadSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "loadsched";
            this.Description = "Load Scheduler";
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
                string[] dependentLoads = new string[4];
                dependentLoads[0] = "  mov (%r8, %rdi, 4), %r15";
                dependentLoads[1] = "  mov (%r8, %rdi, 4), %r14";
                dependentLoads[2] = "  mov (%r8, %rdi, 4), %r13";
                dependentLoads[3] = "  mov (%r8, %rdi, 4), %r12";

                string[] dependentLoads1 = new string[4];
                dependentLoads1[0] = "  mov (%r8, %rsi, 4), %r15";
                dependentLoads1[1] = "  mov (%r8, %rsi, 4), %r14";
                dependentLoads1[2] = "  mov (%r8, %rsi, 4), %r13";
                dependentLoads1[3] = "  mov (%r8, %rsi, 4), %r12";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] dependentLoads = new string[4];
                dependentLoads[0] = "  ldr w15, [x2, w25, uxtw #2]";
                dependentLoads[1] = "  ldr w14, [x2, w25, uxtw #2]";
                dependentLoads[2] = "  ldr w13, [x2, w25, uxtw #2]";
                dependentLoads[3] = "  ldr w12, [x2, w25, uxtw #2]";

                string[] dependentLoads1 = new string[4];
                dependentLoads1[0] = "  ldr w15, [x2, w26, uxtw #2]";
                dependentLoads1[1] = "  ldr w14, [x2, w26, uxtw #2]";
                dependentLoads1[2] = "  ldr w13, [x2, w26, uxtw #2]";
                dependentLoads1[3] = "  ldr w12, [x2, w26, uxtw #2]";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string postLoadInstrs1 = "  andi $r19, $r12, 0xF\n  add.d $r19, $r19, $r6";
                string[] dependentLoads = new string[4];
                dependentLoads[0] = "  ld.d $r15, $r19, 0";
                dependentLoads[1] = "  ld.d $r16, $r19, 8";
                dependentLoads[2] = "  ld.d $r17, $r19, 12";
                dependentLoads[3] = "  ld.d $r18, $r19, 16";

                string postLoadInstrs2 = "  andi $r19, $r13, 0xF\n  add.d $r19, $r19, $r6";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, dependentLoads, dependentLoads, includePtrChasingLoads: true, null, 
                    postLoadInstrs1: postLoadInstrs1, postLoadInstrs2: postLoadInstrs2);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                // x5 and x6 are pointer chasing loads
                string postLoadInstrs1 = "  andi x7, x5, 0xF\n  add x7, x7, x12";
                string postLoadInstrs2 = "  andi x7, x6, 0xF\n  add x7, x7, x12";
                string[] dependentLoads = new string[4];
                dependentLoads[0] = "  ld x28, (x7)";
                dependentLoads[1] = "  ld x29, 8(x7)";
                dependentLoads[2] = "  ld x30, 16(x7)";
                dependentLoads[3] = "  ld x31, 24(x7)";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads, includePtrChasingLoads: true,
                    postLoadInstrs1: postLoadInstrs1, postLoadInstrs2: postLoadInstrs2);
            }
        }
    }
}
