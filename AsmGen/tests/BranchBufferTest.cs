using System.Text;

namespace AsmGen
{
    public class BranchBufferTest : UarchTest
    {
        private bool mixNops;
        public BranchBufferTest(int low, int high, int step, bool mixNops = false)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "bob";
            this.Description = "Branch Order Buffer Test (not-taken branches pending retire)";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
            this.mixNops = mixNops;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                GenerateX86GccAsm(sb);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                GenerateArmAsm(sb);
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                GenerateMipsAsm(sb);
            }
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
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

                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_edi_target{fillerIdx}";
                    sb.AppendLine($"  cmp %r14, %r11");
                    sb.AppendLine($"  je {jumpLabel}");
                    // try to space the jumps out a bit
                    if (this.mixNops) sb.AppendLine($"  nop");
                    sb.AppendLine($"{jumpLabel}:");
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_esi_target{fillerIdx}";
                    sb.AppendLine($"  cmp %r14, %r11");
                    sb.AppendLine($"  je {jumpLabel}");
                    if (this.mixNops) sb.AppendLine($"  nop");
                    // try to space the jumps out a bit
                    sb.AppendLine($"{jumpLabel}:");
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
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

        public void GenerateArmAsm(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = Prefix + Counts[i];

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

                sb.AppendLine("  mov w25, 0x0");
                sb.AppendLine("  mov w26, 0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w25, [x1, w25, uxtw #2]"); // current = A[current]

                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_w25_target{fillerIdx}";
                    sb.AppendLine($"  cmp x15, x10");
                    sb.AppendLine($"  b.eq {jumpLabel}");
                    sb.AppendLine($"{jumpLabel}:");
                }

                sb.AppendLine("  ldr w26, [x1, w26, uxtw #2]");
                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_w26_target{fillerIdx}";
                    sb.AppendLine($"  cmp x15, x10");
                    sb.AppendLine($"  b.eq {jumpLabel}");
                    sb.AppendLine($"{jumpLabel}:");
                }

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

        public void GenerateMipsAsm(StringBuilder sb)
        {
            StringBuilder ntJumpTargets = new StringBuilder();
            for (int i = 0; i < Counts.Length; i++)
            {
                string initInstrs = "  move $r15, $r0\n  addi.d $r15, $r15, 15";
                string funcName = this.Prefix + Counts[i];

                // args in r4 = iterations, r5 = list, r6 = list (sink)
                // use r12 and r13 for ptr chasing loads, r14 as decrement for iteration count
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  ld.d $r12, $r5, 0");
                sb.AppendLine("  ld.d $r13, $r5, 64");
                sb.AppendLine("  xor $r14, $r14, $r14");
                sb.AppendLine("  addi.d $r14, $r14, 1");
                sb.AppendLine(initInstrs);
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ld.d $r12, $r12, 0");
                int fillerInstrCount = Counts[i];
                for (int instrIdx = 0; instrIdx < fillerInstrCount; instrIdx++)
                {
                    string jumpLabel = "dontenduphere_r12_" + this.Prefix + "_" + Counts[i] + "_" + instrIdx;
                    sb.AppendLine($"  beqz $r15, {jumpLabel}");
                    ntJumpTargets.AppendLine(jumpLabel + ":");
                    ntJumpTargets.AppendLine("  jr $r1");
                }
                sb.AppendLine("  ld.d $r13, $r13, 0");
                for (int instrIdx = 0; instrIdx < fillerInstrCount; instrIdx++)
                {
                    string jumpLabel = "dontenduphere_r13_" + this.Prefix + "_" + Counts[i] + "_" + instrIdx;
                    sb.AppendLine($"  beqz $r15, {jumpLabel}");
                    ntJumpTargets.AppendLine(jumpLabel + ":");
                    ntJumpTargets.AppendLine("  jr $r1");
                }
                sb.AppendLine("  sub.d $r4, $r4, $r14");
                sb.AppendLine("  bnez $r4, " + funcName + "start");
                sb.AppendLine(" jr $r1");
            }

            sb.AppendLine(ntJumpTargets.ToString());
        }
    }
}
