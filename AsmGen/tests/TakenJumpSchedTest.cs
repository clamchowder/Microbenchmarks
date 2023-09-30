using System.Text;

namespace AsmGen
{
    public class TakenJumpSchedTest : UarchTest
    {
        public TakenJumpSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "takenjumpsched";
            this.Description = "Scheduler, Taken Jumps";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            // if (isa == IUarchTest.ISA.mips64) return true;
            // if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                for (int i = 0; i < this.Counts.Length; i++)
                {
                    string funcName = this.Prefix + this.Counts[i];
                    sb.AppendLine("\n" + funcName + ":");
                    sb.AppendLine("  push %rsi");
                    sb.AppendLine("  push %rdi");
                    sb.AppendLine("  push %r8");
                    sb.AppendLine("  push %rcx");
                    sb.AppendLine("  push %rdx");

                    // arguments are in RDI, RSI, RDX, RCX, R8, and R9
                    // move them into familiar windows argument regs (rcx, rdx, r8)
                    sb.AppendLine("  mov %rdx, %r8"); // r8 <- rdx
                    sb.AppendLine("  mov %rsi, %rdx"); // rdx <- rsi
                    sb.AppendLine("  mov %rdi, %rcx"); // rcx <- rdi

                    sb.AppendLine("  xor %rdi, %rdi");
                    sb.AppendLine("  mov $0x40, %esi");
                    sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                    sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                    sb.AppendLine("\n" + funcName + "start:");
                    sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                    for (int fillerIdx = 0;fillerIdx < this.Counts[i]; fillerIdx++)
                    {
                        string labelName = funcName + "part" + fillerIdx;
                        sb.AppendLine("  cmp %rdi, %rsi");
                        sb.AppendLine("  jne " + labelName);
                        sb.AppendLine("  inc %rax");
                        sb.AppendLine(".align 16");
                        sb.AppendLine(labelName + ":");

                    }

                    sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                    sb.AppendLine("lfence");

                    sb.AppendLine("  dec %rcx");
                    sb.AppendLine("  jne " + funcName + "start");
                    sb.AppendLine("  pop %rdx");
                    sb.AppendLine("  pop %rcx");
                    sb.AppendLine("  pop %r8");
                    sb.AppendLine("  pop %rdi");
                    sb.AppendLine("  pop %rsi");
                    sb.AppendLine("  ret\n\n");
                }
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
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
                    sb.AppendLine("  mov w25, 0x0");
                    sb.AppendLine("  mov w26, 0x40");
                    sb.AppendLine("\n" + funcName + "start:");
                    sb.AppendLine("  ldr w25, [x1, w25, uxtw #2]"); // current = A[current]
                    for (int nopIdx = 0; nopIdx < this.Counts[i]; nopIdx++)
                    {
                        string labelName = funcName + "part" + nopIdx;
                        sb.AppendLine("  cmp w25, w26");
                        sb.AppendLine("  b.ne " + labelName);
                        sb.AppendLine("  add x15, x15, 1");
                        sb.AppendLine("  nop\n  nop\n  nop");
                        sb.AppendLine(labelName + ":");
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
            else if (isa == IUarchTest.ISA.riscv)
            {
                // todo
                string[] unrolledAdds = new string[4];
                unrolledAdds[0] = "  mul x30, x30, x5";
                unrolledAdds[1] = "  mul x29, x29, x5";
                unrolledAdds[2] = "  mul x28, x28, x5";
                unrolledAdds[3] = "  mul x31, x31, x5";

                string[] unrolledAdds1 = new string[4];
                unrolledAdds1[0] = "  mul x30, x30, x6";
                unrolledAdds1[1] = "  mul x31, x31, x6";
                unrolledAdds1[2] = "  mul x28, x28, x6";
                unrolledAdds1[3] = "  mul x29, x29, x6";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
            }
        }
    }
}
