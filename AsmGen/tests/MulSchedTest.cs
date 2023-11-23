using System.Text;

namespace AsmGen
{
    public class MulSchedTest : UarchTest
    {
        public MulSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mulsched";
            this.Description = "Scheduler, Integer Multiplies";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return true;
            // if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] unrolledMuls = new string[4];
                unrolledMuls[0] = "  imul %rdi, %r15";
                unrolledMuls[1] = "  imul %rdi, %r14";
                unrolledMuls[2] = "  imul %rdi, %r13";
                unrolledMuls[3] = "  imul %rdi, %r12";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] unrolledMuls = new string[4];
                unrolledMuls[0] = "  mul x15, x15, x25";
                unrolledMuls[1] = "  mul x14, x14, x25";
                unrolledMuls[2] = "  mul x13, x13, x25";
                unrolledMuls[3] = "  mul x12, x12, x25";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  mul.d $r15, $r15, $r12";
                unrolledAdds[1] = "  mul.d $r16, $r16, $r12";
                unrolledAdds[2] = "  mul.d $r17, $r17, $r12";
                unrolledAdds[3] = "  mul.d $r18, $r18, $r12";

                string[] unrolledAdds1 = new string[4];
                unrolledAdds1[0] = "  mul.d $r15, $r15, $r13";
                unrolledAdds1[1] = "  mul.d $r16, $r16, $r13";
                unrolledAdds1[2] = "  mul.d $r17, $r17, $r13";
                unrolledAdds1[3] = "  mul.d $r18, $r18, $r13";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, includePtrChasingLoads: true);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  mul x30, x30, x5";
                unrolledAdds[1] = "  mul x29, x29, x5";
                unrolledAdds[2] = "  mul x28, x28, x5";
                unrolledAdds[3] = "  mul x31, x31, x5";

                string[] unrolledAdds1 = new string[4];
                unrolledAdds1[0] = "  mul x30, x30, x6";
                unrolledAdds1[1] = "  mul x31, x31, x6";
                unrolledAdds1[2] = "  mul x28, x28, x6";
                unrolledAdds1[3] = "  mul x29, x29, x6";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
            }
        }
    }
}
