using System.Text;

namespace AsmGen
{
    public class RorSchedTest : UarchTest
    {
        public RorSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "rorsched";
            this.Description = "Scheduler, Integer Rotate by Immediate (1)";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
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
                string postLoadInstrs = "  mov %rdi, %r15";
                string postLoadInstrs2 = "  mov %rsi, %r15";
                string[] unrolledInstrs = new string[1];
                unrolledInstrs[0] = "  ror $1, %r15";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(
                    sb, 
                    this.Counts, 
                    this.Prefix, 
                    unrolledInstrs, 
                    unrolledInstrs, 
                    postLoadInstrs1: postLoadInstrs, 
                    postLoadInstrs2: postLoadInstrs2, 
                    includePtrChasingLoads: false);
            }
        }
    }
}
