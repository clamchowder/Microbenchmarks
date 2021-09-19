using System.Text;

namespace AsmGen
{
    public class RorSchedTest : UarchTest
    {
        public RorSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "rorsched";
            this.Description = "Rotate Scheduler Capacity Test - x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] rors = new string[1];
            rors[0] = "  ror $1, %r15";
            UarchTestHelpers.GenerateX86AsmIntSchedTestFuncs(sb, this.Counts, this.Prefix, rors, rors, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] rors = new string[1];
            rors[0] = "  ror r15, 1";
            UarchTestHelpers.GenerateX86NasmIntSchedTestFuncs(sb, this.Counts, this.Prefix, rors, rors, false);
        }

        // todo: arm
        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x25";
            unrolledAdds[1] = "  add x14, x14, x25";
            unrolledAdds[2] = "  add x13, x13, x25";
            unrolledAdds[3] = "  add x12, x12, x25";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add x15, x15, x26";
            unrolledAdds1[1] = "  add x14, x14, x26";
            unrolledAdds1[2] = "  add x13, x13, x26";
            unrolledAdds1[3] = "  add x12, x12, x26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
        }
    }
}
