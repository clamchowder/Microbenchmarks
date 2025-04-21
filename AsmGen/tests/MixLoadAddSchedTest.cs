using System.Text;

namespace AsmGen
{
    public class MixLoadAddSchedTest : UarchTest
    {
        public MixLoadAddSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixloadaddsched";
            this.Description = "Load,Add Scheduler";
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
                string[] dependentLoads = new string[4];
                dependentLoads[0] = "  mov (%r8, %rdi, 4), %r15";
                dependentLoads[1] = "  add %rdi, %r14";
                dependentLoads[2] = "  mov (%r8, %rdi, 4), %r13";
                dependentLoads[3] = "  add %rdi, %r12";

                string[] dependentLoads1 = new string[4];
                dependentLoads1[0] = "  mov (%r8, %rsi, 4), %r15";
                dependentLoads1[1] = "  add %rsi, %r14";
                dependentLoads1[2] = "  mov (%r8, %rsi, 4), %r13";
                dependentLoads1[3] = "  add %rsi, %r12";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, includePtrChasingLoads: true);
            }
        }
    }
}
