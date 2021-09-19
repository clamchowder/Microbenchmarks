using System.Text;

namespace AsmGen
{
    public class BranchBufferTest : UarchTest
    {
        public BranchBufferTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "bob";
            this.Description = "Branch Order Buffer Test (not-taken branches pending retire) - x86 only";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
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
                for (int fillerIdx = 0 ; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_edi_target{fillerIdx}";
                    sb.AppendLine($"  cmp %r14, %r11");
                    sb.AppendLine($"  je {jumpLabel}");
                    // try to space the jumps out a bit
                    // sb.AppendLine($"  nopw %cs:0x0(%rax,%rax,1)");
                    sb.AppendLine($"{jumpLabel}:");
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_esi_target{fillerIdx}";
                    sb.AppendLine($"  cmp %r14, %r11");
                    sb.AppendLine($"  je {jumpLabel}");
                    // sb.AppendLine($"  nopw %cs:0x0(%rax,%rax,1)");
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

        // todo: nasm
        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = Prefix + Counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  push r11");
                sb.AppendLine("  xor r15, r15");
                sb.AppendLine("  mov r14, 1");
                sb.AppendLine("  mov r13, 2");
                sb.AppendLine("  mov r12, 3");
                sb.AppendLine("  mov r11, 4");
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_edi_target{fillerIdx}";
                    sb.AppendLine($"  cmp r14, r11");
                    sb.AppendLine($"  je {jumpLabel}");
                    sb.AppendLine($"{jumpLabel}:");
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_esi_target{fillerIdx}";
                    sb.AppendLine($"  cmp r14, r11");
                    sb.AppendLine($"  je {jumpLabel}");
                    sb.AppendLine($"{jumpLabel}:");
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r11");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        // todo: arm
        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  ldr x15, [x2]";
            unrolledLoads[1] = "  ldr x14, [x2]";
            unrolledLoads[2] = "  ldr x13, [x2]";
            unrolledLoads[3] = "  ldr x12, [x2]";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledLoads, unrolledLoads, true);
        }
    }
}
