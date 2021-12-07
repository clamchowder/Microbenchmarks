using System.Text;

namespace AsmGen
{
    public class MxcsrTest : UarchTest
    {
        public MxcsrTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mxcsrrename";
            this.Description = "MXCSR renamed registers";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] setMxcsrInstrs = new string[2];
            setMxcsrInstrs[0] = "  mov $0x1f80, %r15\n  mov %r15, (%r8)\n  ldmxcsr (%r8)\n  addss %xmm0, %xmm1"; // default
            setMxcsrInstrs[1] = "  mov $0x9fc0, %r15\n  mov %r15, (%r8)\n  ldmxcsr (%r8)\n  addss %xmm0, %xmm1"; // set denormals are zero, flush to zero
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, setMxcsrInstrs, setMxcsrInstrs, false);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] setMxcsrInstrs = new string[2];
            setMxcsrInstrs[0] = "  mov r15, 0x1f80\n  mov [r8], r15\n  ldmxcsr [r8]\n  addss xmm0, xmm1"; // default
            setMxcsrInstrs[1] = "  mov r15, 0x9fc0\n  mov [r8], r15\n  ldmxcsr [r8]\n  addss xmm0, xmm1"; // set denormals are zero, flush to zero
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, setMxcsrInstrs, setMxcsrInstrs, false);
        }

        // todo
        public override void GenerateArmAsm(StringBuilder sb)
        {
            // read FPCR into x15, set x14 = flush denormals to zero enabled, x15 = flush denormals to zero disabled
            // x12 = mask with all bits set except bit 24 (flush to zero) - bitwise AND to unset bit 24
            // x13 = just bit 24 set with all other bits zero - bitwise OR to set bit 24
            string initInstrs = "  mrs x15, fpcr\n  mov x13, 1\n  lsl x13, x13, 24\n  neg x12, x13\n  orr x14, x15, x13\n  and x15, x15, x12";
            string[] setFpcrInstrs = new string[2];
            setFpcrInstrs[0] = "  msr fpcr, x15\n  fadd s2, s2, s3\n";
            setFpcrInstrs[1] = "  msr fpcr, x14\n  fadd s4, s4, s5\n";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, setFpcrInstrs, setFpcrInstrs, false, initInstrs: initInstrs);
        }
    }
}
