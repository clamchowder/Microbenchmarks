using System.Text;

namespace AsmGen
{
    public class StoreDivSchedTest : UarchTest
    {
        public StoreDivSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "storedivsched";
            this.Description = "Store Address Scheduler Capacity Test, using divs to block retirement";
            this.FunctionDefinitionParameters = "uint64_t iterations, int count, int *arr2";
            this.GetFunctionCallParameters = "structIterations, list_size, B";
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
            string[] dependentStores = new string[4];
            dependentStores[0] = "  mov %r15, (%r8, %rdx, 4)";
            dependentStores[1] = "  mov %r15, (%r8, %rdx, 4)";
            dependentStores[2] = "  mov %r15, (%r8, %rdx, 4)";
            dependentStores[3] = "  mov %r15, (%r8, %rdx, 4)";

            string[] dependentStores1 = new string[4];
            dependentStores1[0] = "  mov %r11, (%r8, %rdx, 4)";
            dependentStores1[1] = "  mov %r11, (%r8, %rdx, 4)";
            dependentStores1[2] = "  mov %r11, (%r8, %rdx, 4)";
            dependentStores1[3] = "  mov %r11, (%r8, %rdx, 4)";

            // instead of using pointer chasing loads, use a nasty block of chained integer divisions to block retirement
            // some older/less capable architectures will not reorder loads ahead of stores with unknown addresses,
            // which breaks the usual technique
            UarchTestHelpers.GenerateX86AsmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores1, false);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] dependentStores = new string[4];
            dependentStores[0] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[1] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[2] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[3] = "  str w15, [x2, w25, uxtw #2]";

            string[] dependentStores1 = new string[4];
            dependentStores1[0] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[1] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[2] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[3] = "  str w15, [x2, w26, uxtw #2]";
            UarchTestHelpers.GenerateArmAsmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores1, false);
        }
    }
}