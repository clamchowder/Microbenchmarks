using System.Text;

namespace AsmGen
{
    public class Fadd256SchedTest : UarchTest
    {
        public Fadd256SchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "fadd256sched";
            this.Description = "256-bit FADD Scheduler Capacity Test, SVE something on ARM";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            // ymm0 is dependent on ptr chasing load
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vaddps %ymm0, %ymm1, %ymm1";
            unrolledAdds[1] = "  vaddps %ymm0, %ymm2, %ymm2";
            unrolledAdds[2] = "  vaddps %ymm0, %ymm3, %ymm3";
            unrolledAdds[3] = "  vaddps %ymm0, %ymm4, %ymm3";

            UarchTestHelpers.GenerateX86AsmFp256SchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  vaddps ymm1, ymm1, ymm0";
            unrolledAdds[1] = "  vaddps ymm2, ymm2, ymm0";
            unrolledAdds[2] = "  vaddps ymm3, ymm3, ymm0";
            unrolledAdds[3] = "  vaddps ymm4, ymm4, ymm0";
            UarchTestHelpers.GenerateX86NasmFp256SchedTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            string initInstrs = "  ldr z0, [x1, 0, MUL VL]\n" +
                "  ldr z1, [x1, 1, MUL VL]\n" +
                "  ldr z2, [x1, 2, MUL VL]\n" +
                "  ldr z3, [x1, 3, MUL VL]\n" +
                "  ldr z4, [x1, 4, MUL VL]\n";

            string postLoadInstr1 = "  lsl x3, x25, #2\n  add x3, x2, x3\n  ld1rw z0.s, p0/z, [x3]";
            string postLoadInstr2 = "  lsl x3, x26, #2\n  add x3, x2, x3\n  ld1rw z0.s, p0/z, [x3]";

            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  fadd z1.s, z1.s, z0.s";
            unrolledAdds[1] = "  fadd z2.s, z2.s, z0.s";
            unrolledAdds[2] = "  fadd z3.s, z3.s, z0.s";
            unrolledAdds[3] = "  fadd z4.s, z4.s, z0.s";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, false, initInstrs, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }
    }
}
