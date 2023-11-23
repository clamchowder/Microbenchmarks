using System.Text;

namespace AsmGen
{
    public class AddSchedTest : UarchTest
    {
        public AddSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "addsched";
            this.Description = "Scheduler, Integer Adds";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
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
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  add %rdi, %r15";
                unrolledAdds[1] = "  add %rdi, %r14";
                unrolledAdds[2] = "  add %rdi, %r13";
                unrolledAdds[3] = "  add %rdi, %r12";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  add x15, x15, x25";
                unrolledAdds[1] = "  add x14, x14, x25";
                unrolledAdds[2] = "  add x13, x13, x25";
                unrolledAdds[3] = "  add x12, x12, x25";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  add.d $r15, $r15, $r12";
                unrolledAdds[1] = "  add.d $r16, $r16, $r12";
                unrolledAdds[2] = "  add.d $r17, $r17, $r12";
                unrolledAdds[3] = "  add.d $r18, $r18, $r12";

                string[] unrolledAdds1 = new string[4];
                unrolledAdds1[0] = "  add.d $r15, $r15, $r13";
                unrolledAdds1[1] = "  add.d $r16, $r16, $r13";
                unrolledAdds1[2] = "  add.d $r17, $r17, $r13";
                unrolledAdds1[3] = "  add.d $r18, $r18, $r13";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  add x30, x30, x5";
                unrolledAdds[1] = "  add x29, x29, x5";
                unrolledAdds[2] = "  add x28, x28, x5";
                unrolledAdds[3] = "  add x31, x31, x5";

                string[] unrolledAdds1 = new string[4];
                unrolledAdds1[0] = "  add x30, x30, x6";
                unrolledAdds1[1] = "  add x31, x31, x6";
                unrolledAdds1[2] = "  add x28, x28, x6";
                unrolledAdds1[3] = "  add x29, x29, x6";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
            }
        }
    }
}
