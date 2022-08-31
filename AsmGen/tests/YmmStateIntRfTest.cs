using System.Text;

namespace AsmGen
{
    public class YmmStateIntRfTest : UarchTest
    {
        public YmmStateIntRfTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "ymmstateintrf";
            this.Description = "10:1 Integer/FP RF Test with YMM (AVX) state - x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovups (%r8), %ymm1\n" +
                "  vmovaps %ymm1, %ymm0\n" +
                "  vmovaps %ymm1, %ymm2\n" +
                "  vaddps %ymm1, %ymm2, %ymm3\n" +
                "  vaddps %ymm1, %ymm3, %ymm4\n" +
                "  vaddps %ymm1, %ymm4, %ymm5\n" +
                "  vaddps %ymm1, %ymm5, %ymm6\n" +
                "  vaddps %ymm1, %ymm1, %ymm7\n" +
                "  vaddps %ymm1, %ymm2, %ymm8\n" +
                "  vaddps %ymm1, %ymm3, %ymm9\n" +
                "  vaddps %ymm2, %ymm4, %ymm10\n" +
                "  vaddps %ymm2, %ymm5, %ymm11\n" +
                "  vaddps %ymm2, %ymm1, %ymm12\n" +
                "  vaddps %ymm2, %ymm2, %ymm13\n" +
                "  vaddps %ymm2, %ymm3, %ymm14\n" +
                "  vaddps %ymm2, %ymm4, %ymm15\n";

            string postLoadInstr = "  vaddps %ymm1, %ymm2, %ymm3";

            string[] unrolledAdds = new string[11];
            unrolledAdds[0] = "  add %r11, %r8";
            unrolledAdds[1] = "  add %r11, %r14";
            unrolledAdds[2] = "  add %r11, %r13";
            unrolledAdds[3] = "  add %r11, %r12";
            unrolledAdds[4] = "  add %r11, %r15";
            unrolledAdds[5] = "  add %r11, %r8";
            unrolledAdds[6] = "  add %r11, %r14";
            unrolledAdds[7] = "  add %r11, %r13";
            unrolledAdds[8] = "  add %r11, %r15";
            unrolledAdds[9] = "  add %r11, %r12";
            unrolledAdds[10] = "  add %r11, %r8";
            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true, initInstrs: initInstrs, postLoadInstrs1: postLoadInstr, postLoadInstrs2: postLoadInstr);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vmovups ymm1, [r8]\n" +
                "  vmovaps ymm0, ymm1\n" +
                "  vmovaps ymm0, ymm2\n" +
                "  vaddps ymm3, ymm1, ymm2\n" +
                "  vaddps ymm4, ymm1, ymm3\n" +
                "  vaddps ymm5, ymm1, ymm4\n" +
                "  vaddps ymm6, ymm1, ymm5\n" +
                "  vaddps ymm7, ymm1, ymm1\n" +
                "  vaddps ymm8, ymm1, ymm2\n" +
                "  vaddps ymm9, ymm1, ymm3\n" +
                "  vaddps ymm10, ymm2, ymm4\n" +
                "  vaddps ymm11, ymm2, ymm5\n" +
                "  vaddps ymm12, ymm2, ymm1\n" +
                "  vaddps ymm13, ymm2, ymm2\n" +
                "  vaddps ymm14, ymm2, ymm3\n" +
                "  vaddps ymm15, ymm2, ymm4\n";

            string postLoadInstr = "  vaddps ymm3, ymm1, ymm2";

            string[] unrolledAdds = new string[11];
            unrolledAdds[0] = "  add r8, r11";
            unrolledAdds[1] = "  add r14, r11";
            unrolledAdds[2] = "  add r13, r11";
            unrolledAdds[3] = "  add r12, r11";
            unrolledAdds[4] = "  add r11, r11";
            unrolledAdds[5] = "  add r8, r11";
            unrolledAdds[6] = "  add r15, r11";
            unrolledAdds[7] = "  add r14, r11";
            unrolledAdds[8] = "  add r13, r11";
            unrolledAdds[9] = "  add r12, r11";
            unrolledAdds[10] = "  add r8, r11";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true, initInstrs: initInstrs, postLoadInstrs1: postLoadInstr, postLoadInstrs2: postLoadInstr);
        }

        // n/a for ARM
        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x11";
            unrolledAdds[1] = "  add x14, x14, x11";
            unrolledAdds[2] = "  add x13, x13, x11";
            unrolledAdds[3] = "  add x12, x12, x11";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds, true);
        }
    }
}
