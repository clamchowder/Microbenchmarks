using System.Text;

namespace AsmGen
{
    public class StoreDataDivNsqTest : UarchTest
    {
        public StoreDataDivNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "storedatadivnsq";
            this.Description = "Store Data Scheduler, using DIVs to block retirement";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                // idiv puts remainder in RDX
                string[] dependentStores = new string[4];
                dependentStores[0] = "  mov %rdx, (%r8, %r15, 4)";
                dependentStores[1] = "  mov %rdx, (%r8, %r15, 4)";
                dependentStores[2] = "  mov %rdx, (%r8, %r15, 4)";
                dependentStores[3] = "  mov %rdx, (%r8, %r15, 4)";

                string[] independentStores = new string[4];
                independentStores[0] = "  mov %r14, (%r8, %r11, 4)";
                independentStores[1] = "  mov %r14, (%r8, %r11, 4)";
                independentStores[2] = "  mov %r14, (%r8, %r11, 4)";
                independentStores[3] = "  mov %r14, (%r8, %r11, 4)";
                UarchTestHelpers.GenerateX86AsmDivNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, independentStores);
            }
        }
    }
}
