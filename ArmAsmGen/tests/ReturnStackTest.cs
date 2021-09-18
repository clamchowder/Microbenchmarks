using System.Text;

namespace AsmGen
{
    public class ReturnStackTest : UarchTest
    {
        public ReturnStackTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "returnstack";
            this.Description = "Return Stack Depth Test";
            this.FunctionDefinitionParameters = "uint64_t iterations";
            this.GetFunctionCallParameters = "structIterations";
            this.DivideTimeByCount = true;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            for (int countIdx = 0; countIdx < this.Counts.Length; countIdx++)
            {
                int callDepth = this.Counts[countIdx];
                string topLevelFunctionLabel = this.Prefix + callDepth;
                sb.AppendLine($"{topLevelFunctionLabel}:");
                sb.AppendLine("  xor %rax, %rax");
                sb.AppendLine($"{topLevelFunctionLabel}_loop:");
                sb.AppendLine($"  call " + GetFunctionName(callDepth, 0));
                sb.AppendLine($"  dec %rdi");
                sb.AppendLine($"  jne {topLevelFunctionLabel}_loop");
                sb.AppendLine("  ret");

                // generate a batch of functions so we aren't returning to the same address
                // otherwise a simple predictor will suffice
                for (int callIdx = 0; callIdx < callDepth; callIdx++)
                {
                    string funcName = GetFunctionName(callDepth, callIdx);
                    sb.AppendLine($".global {funcName}");
                    sb.AppendLine($"{funcName}:");
                    if (callIdx < callDepth - 1)
                    {
                        sb.AppendLine($"  add %rdi, %rax");
                        sb.AppendLine("  call " + GetFunctionName(callDepth, callIdx + 1));
                    }

                    sb.AppendLine("  ret");
                }
            }
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            for (int countIdx = 0; countIdx < this.Counts.Length; countIdx++)
            {
                int callDepth = this.Counts[countIdx];
                string topLevelFunctionLabel = this.Prefix + callDepth;
                sb.AppendLine($"{topLevelFunctionLabel}:");
                sb.AppendLine("  xor rax, rax");
                sb.AppendLine($"{topLevelFunctionLabel}_loop:");
                sb.AppendLine($"  call " + GetFunctionName(callDepth, 0));
                sb.AppendLine($"  dec rcx");
                sb.AppendLine($"  jne {topLevelFunctionLabel}_loop");
                sb.AppendLine("  ret");

                for (int callIdx = 0; callIdx < callDepth; callIdx++)
                {
                    string funcName = GetFunctionName(callDepth, callIdx);
                    sb.AppendLine($"global {funcName}");
                    sb.AppendLine($"{funcName}:");
                    if (callIdx < callDepth - 1)
                    {
                        sb.AppendLine($"  add rax, rcx");
                        sb.AppendLine("  call " + GetFunctionName(callDepth, callIdx + 1));
                    }

                    sb.AppendLine("  ret");
                }
            }
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            for (int countIdx = 0; countIdx < this.Counts.Length; countIdx++)
            {
                int callDepth = this.Counts[countIdx];
                string topLevelFunctionLabel = this.Prefix + callDepth;
                sb.AppendLine($"{topLevelFunctionLabel}:");
                sb.AppendLine("  sub sp, sp, #0x20");
                sb.AppendLine("  stp x29, x30, [sp, #0x10]");
                sb.AppendLine("  eor x3, x3, x3");
                sb.AppendLine($"{topLevelFunctionLabel}_loop:");
                sb.AppendLine($"  bl " + GetFunctionName(callDepth, 0));
                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine($"  cbnz x0, {topLevelFunctionLabel}_loop");
                sb.AppendLine("  ldp x29, x30, [sp, #0x10]");
                sb.AppendLine("  add sp, sp, #0x20");
                sb.AppendLine("  ret");

                for (int callIdx = 0; callIdx < callDepth; callIdx++)
                {
                    string funcName = GetFunctionName(callDepth, callIdx);
                    sb.AppendLine($".global {funcName}");
                    sb.AppendLine($"{funcName}:");
                    sb.AppendLine($"  add x3, x3, x0");
                    if (callIdx < callDepth - 1)
                    {
                        // 'bl' is like x86 'call', except it's like the kid that falls asleep in the middle of class
                        // it doesn't push the return address, so you have to do that yourself
                        sb.AppendLine("  sub sp, sp, #0x20");
                        sb.AppendLine("  stp x29, x30, [sp, #0x10]");
                        sb.AppendLine("  bl " + GetFunctionName(callDepth, callIdx + 1));
                        sb.AppendLine("  ldp x29, x30, [sp, #0x10]");
                        sb.AppendLine("  add sp, sp, #0x20");
                    }

                    sb.AppendLine("  ret");
                }
            }
        }

        private string GetFunctionName(int count, int depth) { return $"returnstack{count}_{depth}"; }
    }
}
