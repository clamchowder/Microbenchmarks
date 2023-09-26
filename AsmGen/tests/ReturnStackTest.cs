using System;
using System.Text;

namespace AsmGen
{
    public class ReturnStackTest : UarchTest
    {
        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return true;
            if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public ReturnStackTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "returnstack";
            this.Description = "Return Stack Depth Test";
            this.FunctionDefinitionParameters = "uint64_t iterations";
            this.GetFunctionCallParameters = "structIterations";
            this.DivideTimeByCount = true;
        }

        private string GetFunctionName(int count, int depth) { return $"returnstack{count}_{depth}"; }

        private string GetBranchFuncName(int branchCount) { return Prefix + branchCount; }
        public string GetLabelName(string funcName, int part) { return funcName + "part" + part; }

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
            else if (isa == IUarchTest.ISA.riscv)
            {
                GenerateRiscvAsm(sb);
            }
        }

        public void GenerateX86GccAsm(StringBuilder sb)
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

        public void GenerateArmAsm(StringBuilder sb)
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

        public void GenerateMipsAsm(StringBuilder sb)
        {
            for (int countIdx = 0; countIdx < this.Counts.Length; countIdx++)
            {
                int callDepth = this.Counts[countIdx];
                string topLevelFunctionLabel = this.Prefix + callDepth;
                sb.AppendLine($"{topLevelFunctionLabel}:");
                // top level function runs for specified number of iterations
                sb.AppendLine("  xor $r12, $r12, $r12");
                sb.AppendLine("  xor $r13, $r13, $r13");
                sb.AppendLine("  addi.d $r12, $r12, 1");
                sb.AppendLine("  addi.d $r13, $r13, 8");
                sb.AppendLine("  sub.d $sp, $sp, $r13");
                sb.AppendLine("  st.d $r1, $sp, 0");
                sb.AppendLine($"{topLevelFunctionLabel}_loop:");

                // mips stack grows down
                sb.AppendLine($"  bl " + GetFunctionName(callDepth, 0));
                sb.AppendLine("  sub.d $r4, $r4, $r12");
                sb.AppendLine($"  bnez $r4, {topLevelFunctionLabel}_loop");
                sb.AppendLine("  ld.d $r1, $sp, 0");
                sb.AppendLine("  add.d $sp, $sp, $r13");
                sb.AppendLine("  jr $r1");

                // generate the dummy functions
                for (int callIdx = 0; callIdx < callDepth; callIdx++)
                {
                    string funcName = GetFunctionName(callDepth, callIdx);
                    sb.AppendLine($".global {funcName}");
                    sb.AppendLine($"{funcName}:");
                    if (callIdx < callDepth - 1)
                    {
                        sb.AppendLine("  sub.d $sp, $sp, $r13");
                        sb.AppendLine("  st.d $r1, $sp, 0"); // save return address
                        sb.AppendLine("  bl " + GetFunctionName(callDepth, callIdx + 1));
                        sb.AppendLine("  ld.d $r1, $sp, 0"); // load return address
                        sb.AppendLine("  add.d $sp, $sp, $r13");
                    }

                    sb.AppendLine("  jr $r1");
                }
            }
        }

        public void GenerateRiscvAsm(StringBuilder sb)
        {
            for (int countIdx = 0; countIdx < this.Counts.Length; countIdx++)
            {
                int callDepth = this.Counts[countIdx];
                string topLevelFunctionLabel = this.Prefix + callDepth;
                sb.AppendLine($"{topLevelFunctionLabel}:");
                // top level function runs for specified number of iterations
                // iteration count in x10
                sb.AppendLine("  addi sp, sp, -16");
                sb.AppendLine("  sd ra, (sp)");
                sb.AppendLine($"{topLevelFunctionLabel}_loop:");
                sb.AppendLine($"  jal " + GetFunctionName(callDepth, 0));
                sb.AppendLine("  addi x10, x10, -1");
                sb.AppendLine($"  bge x10, x0, {topLevelFunctionLabel}_loop");
                sb.AppendLine("  ld ra, (sp)");
                sb.AppendLine("  addi sp, sp, 16");
                sb.AppendLine("  ret");

                // generate the dummy functions
                for (int callIdx = 0; callIdx < callDepth; callIdx++)
                {
                    string funcName = GetFunctionName(callDepth, callIdx);
                    sb.AppendLine($".global {funcName}");
                    sb.AppendLine($"{funcName}:");
                    if (callIdx < callDepth - 1)
                    {
                        sb.AppendLine("  addi sp, sp, -16"); // keep stack pointer 16B aligned even though we only save a 8B reg
                        sb.AppendLine("  sd ra, (sp)"); // save return address
                        sb.AppendLine("  jal " + GetFunctionName(callDepth, callIdx + 1));
                        sb.AppendLine("  ld ra, (sp)"); // load return address
                        sb.AppendLine("  addi sp, sp, 16");
                    }

                    sb.AppendLine("  ret");
                }
            }
        }
    }
}
