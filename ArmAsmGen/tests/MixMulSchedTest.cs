using System.Text;

namespace AsmGen
{
    // only applicable to Zhaoxin Lujiazui
    public class MixMulSchedTest : UarchTest
    {
        public MixMulSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixmulschedtest";
            this.Description = "Mixed Integer (64/16-bit mul) Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string resetMulsInstr = "mov $1, %r15\n  mov $1, %r13";
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  imul %di, %r15w";
            unrolledMuls[1] = "  imul %rdi, %r14";
            unrolledMuls[2] = "  imul %di, %r13w";
            unrolledMuls[3] = "  imul %rdi, %r12";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  imul %si, %r15w";
            unrolledMuls1[1] = "  imul %rsi, %r14";
            unrolledMuls1[2] = "  imul %si, %r13w";
            unrolledMuls1[3] = "  imul %rsi, %r12";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls1, false, postLoadInstrs1: resetMulsInstr, postLoadInstrs2: resetMulsInstr);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  imul r15w, di";
            unrolledMuls[1] = "  imul r14, rdi";
            unrolledMuls[2] = "  imul r13w, di";
            unrolledMuls[3] = "  imul r12, rdi";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  imul r15w, si";
            unrolledMuls1[1] = "  imul r14, rsi";
            unrolledMuls1[2] = "  imul r13w, si";
            unrolledMuls1[3] = "  imul r12, rsi";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  mul w15, w15, w25";
            unrolledMuls[1] = "  mul x14, x14, x25";
            unrolledMuls[2] = "  mul w13, w13, w25";
            unrolledMuls[3] = "  mul x12, x12, x25";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  mul w15, w15, w26";
            unrolledMuls1[1] = "  mul x14, x14, x26";
            unrolledMuls1[2] = "  mul w13, w13, w26";
            unrolledMuls1[3] = "  mul x12, x12, x26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls1, false);
        }
    }
}
