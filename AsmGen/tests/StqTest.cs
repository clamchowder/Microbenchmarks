using System.Text;

namespace AsmGen
{
    public class StqTest : UarchTest
    {
        public StqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "stq";
            this.Description = "Store Queue";
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
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  mov %r15, (%r8)";
                unrolledStores[1] = "  mov %r14, (%r8)";
                unrolledStores[2] = "  mov %r13, (%r8)";
                unrolledStores[3] = "  mov %r12, (%r8)";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  str x15, [x2]";
                unrolledStores[1] = "  str x14, [x2]";
                unrolledStores[2] = "  str x13, [x2]";
                unrolledStores[3] = "  str x12, [x2]";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  st.d $r15, $r6, 0";
                unrolledStores[1] = "  st.d $r16, $r6, 0";
                unrolledStores[2] = "  st.d $r17, $r6, 0";
                unrolledStores[3] = "  st.d $r18, $r6, 0";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  sd x28, (x12)";
                unrolledStores[1] = "  sd x29, 8(x12)";
                unrolledStores[2] = "  sd x30, 16(x12)";
                unrolledStores[3] = "  sd x31, 24(x12)";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, false);
            }
        }
    }
}
