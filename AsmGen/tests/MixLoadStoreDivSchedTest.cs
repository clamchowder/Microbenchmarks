using System.Text;

namespace AsmGen
{
    public class MixLoadStoreDivSchedTest : UarchTest
    {
        public MixLoadStoreDivSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixloadstoredivsched";
            this.Description = "Load/Store Scheduler Capacity Test, using divs to block retirement";
            this.FunctionDefinitionParameters = "uint64_t iterations, int count, int *arr2, int *arr3";
            this.GetFunctionCallParameters = "structIterations, list_size, B, A";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                GenerateX86Asm(sb);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                GenerateArmAsm(sb);
            }
        }

        public void GenerateX86Asm(StringBuilder sb)
        {
            string[] dependentLoads = new string[2];
            dependentLoads[0] = "  mov (%r9, %rdx, 4), %r15";
            dependentLoads[1] = "  mov %r14, (%r8, %rdx, 4)";

            UarchTestHelpers.GenerateX86AsmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads, false);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] dependentLoads = new string[2];
            dependentLoads[0] = "  ldr w15, [x3, w25, uxtw #2]";
            dependentLoads[1] = "  str w14, [x2, w25, uxtw #2]";

            string[] dependentLoads1 = new string[2];
            dependentLoads1[0] = "  ldr w15, [x3, w26, uxtw #2]";
            dependentLoads1[1] = "  str w14, [x2, w26, uxtw #2]";

            UarchTestHelpers.GenerateArmAsmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, false);
        }
    }
}
