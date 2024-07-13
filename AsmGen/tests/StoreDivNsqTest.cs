using System.Text;

namespace AsmGen
{
    public class StoreDivNsqTest : UarchTest
    {
        public StoreDivNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "storedivnsq";
            this.Description = "Store Scheduler, using DIVs to block retirement, excluding NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
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
                // idiv puts remainder in RDX
                string[] dependentStores = new string[4];
                dependentStores[0] = "  mov %r15w, (%r8, %rdx, 2)";
                dependentStores[1] = "  mov %r15w, 2(%r8, %rdx, 2)";
                dependentStores[2] = "  mov %r15w, 4(%r8, %rdx, 2)";
                dependentStores[3] = "  mov %r15w, 6(%r8, %rdx, 2)";

                string[] indepStores = new string[4];
                indepStores[0] = "  mov %r11w, (%r8)";
                indepStores[1] = "  mov %r11w, 2(%r8)";
                indepStores[2] = "  mov %r11w, 4(%r8)";
                indepStores[3] = "  mov %r11w, 6(%r8)";
                UarchTestHelpers.GenerateX86AsmDivNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, indepStores);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string[] dependentStores = new string[1];
                dependentStores[0] = "  str w15, [x2, w25, uxtw #2]";

                string[] independentStores = new string[1];
                independentStores[0] = "  str w15, [x2, w15, uxtw #2]";

                UarchTestHelpers.GenerateArmAsmDivNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, independentStores);
            }
        }
    }
}
