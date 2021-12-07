using System.Text;

namespace AsmGen
{
    public class TakenJumpSchedTest : UarchTest
    {
        public TakenJumpSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "takenjmpsched";
            this.Description = "Taken Jump Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int listsize";
            this.GetFunctionCallParameters = "structIterations, A, list_size";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
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
                sb.AppendLine("  push %r15");
                sb.AppendLine("  mov $16, %r15");

                // arguments are in RDI, RSI, RDX, RCX, R8, and R9
                // move them into familiar windows argument regs (rcx, rdx, r8)
                sb.AppendLine("  mov %rdx, %r8"); // r8 <- rdx
                sb.AppendLine("  mov %rsi, %rdx"); // rdx <- rsi
                sb.AppendLine("  mov %rdi, %rcx"); // rcx <- rdi

                sb.AppendLine("  add %r8, %r15");

                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                for (int fillerIdx = 0; fillerIdx < this.Counts[i]; fillerIdx++)
                {
                    string labelName = funcName + "part" + fillerIdx;
                    sb.AppendLine("  cmp %rdi, %r15");   // r15 is well past list size and therefore should never equal the ptr chasing idx
                    sb.AppendLine("  jne " + labelName); 
                    sb.AppendLine("  inc %rax");
                    sb.AppendLine(".align 16");
                    sb.AppendLine(labelName + ":");
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                sb.AppendLine("lfence");

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            for (int i = 0; i < this.Counts.Length; i++)
            {
                string funcName = this.Prefix + this.Counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov r15, 16");
                sb.AppendLine("  add r15, r8");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                for (int fillerIdx = 0; fillerIdx < this.Counts[i]; fillerIdx++)
                {
                    string labelName = funcName + "part" + fillerIdx;
                    sb.AppendLine("  cmp rdi, r15");
                    sb.AppendLine("  jne " + labelName);
                    sb.AppendLine("  inc rax");
                    sb.AppendLine("align 16");
                    sb.AppendLine(labelName + ":");
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                sb.AppendLine("  lfence");
                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            // todo
            string[] unrolledJumps = new string[1];
            unrolledJumps[0] = "  cmp x25, x26\n  b.eq jumpsched_reallybadthing";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledJumps, unrolledJumps, false);

            sb.AppendLine("jumpsched_reallybadthing:");
            sb.AppendLine("  .word 0xf7f0a000");
        }
    }
}
