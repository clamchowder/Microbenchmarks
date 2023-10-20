using System.Text;

namespace AsmGen
{
    public class StoreNsq : UarchTest
    {
        public StoreNsq(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "storensq";
            this.Description = "Store Address Scheduler, Excluding any NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64)
            {
                string[] depStores = new string[4];
                depStores[0] = "  str w15, [x2, w25, uxtw #2]";
                depStores[1] = "  str w14, [x2, w25, uxtw #2]";
                depStores[2] = "  str w13, [x2, w25, uxtw #2]";
                depStores[3] = "  str w12, [x2, w25, uxtw #2]";

                string[] indepStores = new string[4];
                indepStores[0] = "  str w15, [x2, w26, uxtw #2]";
                indepStores[1] = "  str w14, [x2, w26, uxtw #2]";
                indepStores[2] = "  str w13, [x2, w26, uxtw #2]";
                indepStores[3] = "  str w12, [x2, w26, uxtw #2]";
                UarchTestHelpers.GenerateArmAsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, depStores, indepStores);
            }
        }
    }
}
