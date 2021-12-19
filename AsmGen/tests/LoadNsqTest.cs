using System.Text;

namespace AsmGen
{
    public class LoadNsqTest : UarchTest
    {
        int high;

        public LoadNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "loadnsq";
            this.Description = "Load scheduler capacity test, excluding NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr2";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
            this.high = high;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] dependentLoads = new string[4];
            dependentLoads[0] = "  mov (%r8, %rdi, 4), %r15";
            dependentLoads[1] = "  mov (%r8, %rdi, 4), %r14";
            dependentLoads[2] = "  mov (%r8, %rdi, 4), %r13";
            dependentLoads[3] = "  mov (%r8, %rdi, 4), %r12";

            string[] indepLoads = new string[4];
            indepLoads[0] = "  mov (%r8), %r15";
            indepLoads[1] = "  mov (%r8), %r14";
            indepLoads[2] = "  mov (%r8), %r13";
            indepLoads[3] = "  mov (%r8), %r12";

            for (int i = 0; i < this.Counts.Length; i++)
            {
                string funcName = this.Prefix + this.Counts[i];
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
                int sqInstrs = this.Counts[i] - 2;
                for (int fillerIdx = 0; fillerIdx < this.high; fillerIdx++)
                {
                    if (fillerIdx < sqInstrs)
                    {
                        sb.AppendLine($"  mov {fillerIdx + 1}(%r8, %rdi), %r15");
                    }
                    else
                    {
                        sb.AppendLine($"  mov {fillerIdx - sqInstrs + 1}(%r8), %r15");
                    }
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("  lfence");
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

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string[] dependentLoads = new string[4];
            dependentLoads[0] = "  mov r15, [r8 + rdi * 4]";
            dependentLoads[1] = "  mov r14, [r8 + rdi * 4]";
            dependentLoads[2] = "  mov r13, [r8 + rdi * 4]";
            dependentLoads[3] = "  mov r12, [r8 + rdi * 4]";

            string[] indepLoads = new string[4];
            indepLoads[0] = "  mov r15, [r8]";
            indepLoads[1] = "  mov r14, [r8]";
            indepLoads[2] = "  mov r13, [r8]";
            indepLoads[3] = "  mov r12, [r8]";
            UarchTestHelpers.GenerateX86NasmNsqTestFuncs(sb, this.high, this.Counts, this.Prefix, dependentLoads, indepLoads, true);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            // todo
            string[] dependentLoads = new string[4];
            dependentLoads[0] = "  ldr w15, [x2, w25, uxtw #2]";
            dependentLoads[1] = "  ldr w14, [x2, w25, uxtw #2]";
            dependentLoads[2] = "  ldr w13, [x2, w25, uxtw #2]";
            dependentLoads[3] = "  ldr w12, [x2, w25, uxtw #2]";

            string[] dependentLoads1 = new string[4];
            dependentLoads1[0] = "  ldr w15, [x2, w26, uxtw #2]";
            dependentLoads1[1] = "  ldr w14, [x2, w26, uxtw #2]";
            dependentLoads1[2] = "  ldr w13, [x2, w26, uxtw #2]";
            dependentLoads1[3] = "  ldr w12, [x2, w26, uxtw #2]";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentLoads, dependentLoads1, false);
        }
    }
}
