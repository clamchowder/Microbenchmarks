using System.Text;

namespace AsmGen
{
    public class Mul16SchedTest : UarchTest
    {
        public Mul16SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mul16sched";
            this.Description = "Integer (16-bit mul) Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            // trying to unsuccessfully counter some weird behavior on zhaoxin
            string resetMulsInstr = "mov $11, %r15\n  mov $13, %r14\n  mov $15, %r13\n  mov $17, %r12\n";
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  imul %di, %r15w";
            unrolledMuls[1] = "  imul %di, %r14w";
            unrolledMuls[2] = "  imul %di, %r13w";
            unrolledMuls[3] = "  imul %di, %r12w";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  imul %si, %r15w";
            unrolledMuls1[1] = "  imul %si, %r14w";
            unrolledMuls1[2] = "  imul %si, %r13w";
            unrolledMuls1[3] = "  imul %si, %r12w";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls1, false, postLoadInstrs1: resetMulsInstr, postLoadInstrs2: resetMulsInstr);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  imul r15w, di";
            unrolledMuls[1] = "  imul r14w, di";
            unrolledMuls[2] = "  imul r13w, di";
            unrolledMuls[3] = "  imul r12w, di";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  imul r15w, si";
            unrolledMuls1[1] = "  imul r14w, si";
            unrolledMuls1[2] = "  imul r13w, si";
            unrolledMuls1[3] = "  imul r12w, si";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls, false);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  mul w15, w15, w25";
            unrolledMuls[1] = "  mul w14, w14, w25";
            unrolledMuls[2] = "  mul w13, w13, w25";
            unrolledMuls[3] = "  mul w12, w12, w25";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  mul w15, w15, w26";
            unrolledMuls1[1] = "  mul w14, w14, w26";
            unrolledMuls1[2] = "  mul w13, w13, w26";
            unrolledMuls1[3] = "  mul w12, w12, w26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledMuls, unrolledMuls1, false);
        }
    }
}
