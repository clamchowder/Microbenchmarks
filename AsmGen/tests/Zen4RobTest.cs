using System.Diagnostics.Metrics;
using System.Security.Cryptography;
using System.Text;

namespace AsmGen
{
    public class Zen4RobTest : UarchTest
    {
        public Zen4RobTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "zen4rob";
            this.Description = "Custom ROB size test for Zen 4, x86/GCC only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  movss (%r8), %xmm1\n" +
                "  movss 4(%r8), %xmm2\n" +
                "  movss 8(%r8), %xmm3\n" +
                "  movss 12(%r8), %xmm4\n" +
                "  movss 16(%r8), %xmm5\n";

            string[] intRfInstrs = new string[4];
            intRfInstrs[0] = "add %r15, %r14";
            intRfInstrs[1] = "add %r15, %r13";
            intRfInstrs[2] = "add %r15, %r12";
            intRfInstrs[3] = "add %r15, %r11";

            string[] vecRfInstrs = new string[4];
            vecRfInstrs[0] = "addss %xmm1, %xmm2";
            vecRfInstrs[1] = "addss %xmm1, %xmm3";
            vecRfInstrs[2] = "addss %xmm1, %xmm4";
            vecRfInstrs[3] = "addss %xmm1, %xmm5";

            string[] storeInstrs = new string[4];
            storeInstrs[0] = "movss %xmm0, (%r8)";
            storeInstrs[1] = "movss %xmm0, (%r8)";
            storeInstrs[2] = "movss %xmm0, (%r8)";
            storeInstrs[3] = "movss %xmm0, (%r8)";

            string[] ntBranches = new string[1];
            ntBranches[0] = "cmp %edi, %esi\n  je " + Prefix + "10"; // should never be taken

            int nIntRf = 128;
            int nVecRf = 128;
            int nStore = 40;
            int ntBranchCount = 55;

            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = Prefix + Counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %r11");
                sb.AppendLine("  push %r10");
                sb.AppendLine("  push %r8");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");

                // arguments are in RDI, RSI, RDX, RCX, R8, and R9
                // move them into familiar windows argument regs (rcx, rdx, r8)
                sb.AppendLine("  mov %rdx, %r8"); // r8 <- rdx
                sb.AppendLine("  mov %rsi, %rdx"); // rdx <- rsi
                sb.AppendLine("  mov %rdi, %rcx"); // rcx <- rdi

                sb.AppendLine("  xor %r15, %r15");
                sb.AppendLine("  mov $0x1, %r14");
                sb.AppendLine("  mov $0x2, %r13");
                sb.AppendLine("  mov $0x3, %r12");
                sb.AppendLine("  mov $0x4, %r11");

                if (initInstrs != null) sb.AppendLine(initInstrs);

                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                int fillerInstrCount = Counts[i] - 2;
                int fillerIdx = 0;
                for (int instrIdx = 0, intRfCount = 0; fillerIdx < fillerInstrCount && intRfCount < nIntRf; fillerIdx++, intRfCount++)
                {
                    sb.AppendLine(intRfInstrs[instrIdx]);
                    instrIdx = (instrIdx + 1) % intRfInstrs.Length;
                }

                for (int instrIdx = 0, vecRfCount = 0; fillerIdx < fillerInstrCount && vecRfCount < nVecRf; fillerIdx++, vecRfCount++)
                {
                    sb.AppendLine(vecRfInstrs[instrIdx]);
                    instrIdx = (instrIdx + 1) % vecRfInstrs.Length;
                }

                for (int instrIdx = 0, storeCount = 0; fillerIdx < fillerInstrCount && storeCount < nStore; fillerIdx++, storeCount++)
                {
                    sb.AppendLine(storeInstrs[instrIdx]);
                    instrIdx = (instrIdx + 1) % storeInstrs.Length;
                }

                for (int instrIdx = 0, storeCount = 0; fillerIdx < fillerInstrCount && storeCount < ntBranchCount; fillerIdx++, storeCount++)
                {
                    sb.AppendLine(ntBranches[instrIdx]);
                    instrIdx = (instrIdx + 1) % ntBranches.Length;
                }


                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("lfence");

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %r10");
                sb.AppendLine("  pop %r11");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  movss xmm1, [r8]\n" +
                "  movss xmm2, [r8 + 4]\n" +
                "  movss xmm3, [r8 + 8]\n" +
                "  movss xmm4, [r8 + 12]\n" +
                "  movss xmm5, [r8 + 16]\n";

            string[] instrs = new string[8];
            instrs[0] = "add r14, r15";
            instrs[1] = "addss xmm2, xmm1";
            instrs[2] = "add r13, r15";
            instrs[3] = "addss xmm3, xmm1";
            instrs[4] = "add r12, r15";
            instrs[5] = "addss xmm4, xmm1";
            instrs[6] = "add r11, r15";
            instrs[7] = "addss xmm5, xmm1";
            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, instrs, instrs, true, initInstrs);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            const uint nopCount = 30;
            const uint intrfCount = 90;
            const uint fprfCount = 100;
            string initInstrs = "  ldr s17, [x2]\n" +
                "  ldr s18, [x2, 4]\n" +
                "  ldr s19, [x2, 8]\n" +
                "  ldr s20, [x2, 12]\n" +
                "  ldr s21, [x2, 16]\n";

            string[] unrolledFpInstrs = new string[4];
            unrolledFpInstrs[0] = "  fadd s18, s18, s17";
            unrolledFpInstrs[1] = "  fadd s19, s19, s17";
            unrolledFpInstrs[2] = "  fadd s20, s20, s17";
            unrolledFpInstrs[3] = "  fadd s21, s21, s17";

            string[] unrolledIntInstrs = new string[4];
            unrolledIntInstrs[0] = "  add x15, x15, x11";
            unrolledIntInstrs[1] = "  add x14, x14, x11";
            unrolledIntInstrs[2] = "  add x13, x13, x11";
            unrolledIntInstrs[3] = "  add x12, x12, x11";

            for (int i = 0; i < this.Counts.Length; i++)
            {
                string funcName = this.Prefix + this.Counts[i];

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  sub sp, sp, #0x50");
                sb.AppendLine("  stp x14, x15, [sp, #0x10]");
                sb.AppendLine("  stp x12, x13, [sp, #0x20]");
                sb.AppendLine("  stp x10, x11, [sp, #0x30]");
                sb.AppendLine("  stp x25, x26, [sp, #0x40]");
                sb.AppendLine("  mov x15, 1");
                sb.AppendLine("  mov x14, 2");
                sb.AppendLine("  mov x13, 3");
                sb.AppendLine("  mov x12, 4");
                sb.AppendLine("  mov x11, 5");
                sb.AppendLine("  mov x10, 6");
                sb.AppendLine(initInstrs);
                sb.AppendLine("  mov w25, 0x0");
                sb.AppendLine("  mov w26, 0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w25, [x1, w25, uxtw #2]"); // current = A[current]
                int fillerInstrCount = this.Counts[i] - 2;
                uint totalFillerInstrCount = 0;
                for (int addIdx = 0, fillIdx = 0; addIdx < intrfCount && totalFillerInstrCount < fillerInstrCount; addIdx++, totalFillerInstrCount++)
                {
                    sb.AppendLine(unrolledIntInstrs[fillIdx]);
                    fillIdx = (fillIdx + 1) % unrolledIntInstrs.Length;
                }

                for (int fpIdx = 0, fillIdx = 0; fpIdx < fprfCount && totalFillerInstrCount < fillerInstrCount; fpIdx++, totalFillerInstrCount++)
                {
                    sb.AppendLine(unrolledFpInstrs[fillIdx]);
                    fillIdx = (fillIdx + 1) % unrolledFpInstrs.Length;
                }

                for (int nopIdx = 0; nopIdx < nopCount && totalFillerInstrCount < fillerInstrCount; nopIdx++, totalFillerInstrCount++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  ldr w26, [x1, w26, uxtw #2]");
                sb.AppendLine("  dsb sy");
                sb.AppendLine("  isb sy");

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x25, x26, [sp, #0x40]");
                sb.AppendLine("  ldp x10, x11, [sp, #0x30]");
                sb.AppendLine("  ldp x12, x13, [sp, #0x20]");
                sb.AppendLine("  ldp x14, x15, [sp, #0x10]");
                sb.AppendLine("  add sp, sp, #0x50");
                sb.AppendLine("  ret\n\n");
            }
        }
    }
}
