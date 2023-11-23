using System;
using System.Text;

namespace AsmGen
{
    public class BtbTest : UarchTest
    {
        private int spacing;
        private BranchType branchType;
        private bool varyspacing;

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return true;
            if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public enum BranchType
        {
            /// <summary>
            /// Conditional branches that are always taken
            /// </summary>
            Conditional,

            /// <summary>
            /// Unconditional jmps
            /// </summary>
            Unconditional,

            /// <summary>
            /// A mix of both to max out Zen 2's BTB capacity
            /// Optimization guide says one entry can track two branches if they're in the same 64B line
            /// and the first is conditional
            /// </summary>
            ZenMix
        }

        /// <summary>
        /// Constructor for BTB test
        /// </summary>
        /// <param name="spacing">How far apart branches should be. Valid values are 4, 8, 16</param>
        /// <param name="conditional">If true, use conditional branches (still always taken)</param>
        public BtbTest(int spacing, BranchType branchType, bool varyspacing = false)
        {
            this.Counts = new int[] { 1, 2, 4, 8, 16, 32, 48, 56, 64, 128, 256, 512, 768, 1024, 1536, 2048,
                3072, 4096, 4608, 5120, 6144, 7168, 8192, 10240, 12288, 14336, 16384, 32768 };
            this.Prefix = "btb" + spacing + (varyspacing ? "v" : "") + branchType;
            this.Description = $"Branch Target Buffer, " + branchType + $" branch every {spacing} bytes " + (varyspacing ? " (varied spacing)" : "");
            this.FunctionDefinitionParameters = "uint64_t iterations";
            this.GetFunctionCallParameters = "structIterations";
            this.DivideTimeByCount = true;
            this.spacing = spacing;
            this.branchType = branchType;
            this.varyspacing = varyspacing;
        }

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
            string paddingAlign = "  .align " + spacing;
            int spacingNops = 0;
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = GetBranchFuncName(Counts[i]);
                //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                sb.AppendLine(funcName + ":\n");
                sb.AppendLine("  xor %rax, %rax");

                if (branchType == BranchType.ZenMix) sb.AppendLine("  .align 64");
                for (int branchIdx = 1; branchIdx < Counts[i]; branchIdx++)
                {
                    string labelName = GetLabelName(funcName, branchIdx);

                    if (branchType == BranchType.Conditional)
                    {
                        sb.AppendLine("  test %rax, %rax");
                        sb.AppendLine("  jz " + labelName); // should always be set
                    }
                    else if (branchType == BranchType.Unconditional)
                    {
                        sb.AppendLine("  jmp " + labelName);
                    }
                    else if (branchType == BranchType.ZenMix)
                    {
                        if ((branchIdx & 0x1) == 0)
                        {
                            sb.AppendLine("  jmp " + labelName);
                        }
                        else
                        {
                            sb.AppendLine("  test %rax, %rax");
                            sb.AppendLine("  jz " + labelName);
                        }
                    }

                    sb.AppendLine(paddingAlign);

                    if (varyspacing)
                    {
                        for (int nopIdx = 0; nopIdx < spacingNops; nopIdx++)
                        {
                            sb.AppendLine("  nop");
                        }
                        spacingNops++;
                        if (spacingNops > 6) spacingNops = 0;
                    }

                    sb.AppendLine(labelName + ":");
                }

                sb.AppendLine("  dec %rdi");
                sb.AppendLine("  jne " + funcName);
                sb.AppendLine("  ret\n\n");

                // don't let it get too close to the next branch
                sb.AppendLine(paddingAlign);
            }
        }

        private string Get4BNopAlign()
        {
            string paddingAlign = "";
            if (spacing == 8)
            {
                paddingAlign = "  nop";
            }
            else if (spacing == 16)
            {
                paddingAlign = "  nop\n  nop\n  nop";
            }
            else if (spacing == 32)
            {
                paddingAlign = "  nop\n  nop\n  nop\n  nop\n  nop\n  nop\n  nop";
            }
            else if (spacing == 64)
            {
                paddingAlign = "  nop\n  nop\n  nop\n  nop\n  nop\n  nop\n  nop\n";
                paddingAlign += "  nop\n  nop\n  nop\n  nop\n  nop\n  nop\n  nop\n  nop";
            }
            else if (spacing != 4)
            {
                Console.WriteLine($"Unsupported padding value {spacing}");
                throw new NotImplementedException("Unsupported padding value");
            }

            return paddingAlign;
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            // things are 4 bytes on aarch64
            string paddingAlign = Get4BNopAlign();

            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = GetBranchFuncName(Counts[i]);
                string funcTargetName = GetBranchFuncName(Counts[i]) + "_itarget";
                sb.AppendLine(funcName + ":");
                sb.AppendLine($"  adrp x2, {funcName}");
                sb.AppendLine($"  add x2, x2, :lo12:{funcName}");
                sb.AppendLine("  mov x1, 1");
                sb.AppendLine(".align 16");
                sb.AppendLine(funcTargetName + ":");
                for (int branchIdx = 1; branchIdx < Counts[i]; branchIdx++)
                {
                    string labelName = GetLabelName(funcName, branchIdx);
                    if (branchType == BranchType.Unconditional)
                        sb.AppendLine("  b " + labelName);
                    else if (branchType == BranchType.Conditional)
                        sb.AppendLine("  cbnz x1, " + labelName); // x1 = 1 from earlier, should never be zero
                    else if (branchType == BranchType.ZenMix)
                    {
                        if ((branchIdx & 0x1) == 0) sb.AppendLine("  b " + labelName);
                        else sb.AppendLine("  cbnz x1, " + labelName);
                    }

                    sb.AppendLine(paddingAlign);
                    sb.AppendLine(labelName + ":");
                }

                sb.AppendLine(paddingAlign);
                sb.AppendLine("  sub x0, x0, 1");

                // aarch64 is a mess. try to avoid 'relocation truncated to fit' issues with an indirect branch
                if (spacing * Counts[i] >= (1024 * 1024 - 20))
                {
                    string workaroundTarget = funcName + "_aarch64_indirect_workaround";

                    // jump over indirect branch to return, on zero
                    // this branch should be not taken for all except the last iteration, and should have minimal
                    // impact on results because a predicted NT branch is sort of 'free' on most architectures
                    sb.AppendLine("  cbz x0, " + workaroundTarget);
                    sb.AppendLine("  br x2");
                    sb.AppendLine(workaroundTarget + ":");
                }
                else
                {
                    sb.AppendLine("  cbnz x0, " + funcTargetName);
                }

                sb.AppendLine("  ret\n\n");

                // don't let it get too close to the next branch
                sb.AppendLine(paddingAlign);
            }
        }

        public void GenerateMipsAsm(StringBuilder sb)
        {
            string paddingAlign = Get4BNopAlign();
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = GetBranchFuncName(Counts[i]);
                string funcTargetName = GetBranchFuncName(Counts[i]) + "_itarget";

                sb.AppendLine(funcName + ":");
                sb.AppendLine("  xor $r12, $r12, $r12");
                sb.AppendLine("  addi.d $r12, $r12, 1");
                sb.AppendLine("  xor $r13, $r13, $r13");
                sb.AppendLine("  la $r14, " + funcTargetName);
                sb.AppendLine(funcTargetName + ":");
                for (int branchIdx = 1; branchIdx < Counts[i]; branchIdx++)
                {
                    string labelName = GetLabelName(funcName, branchIdx);
                    sb.AppendLine("  beqz $r13, " + labelName);
                    sb.AppendLine(paddingAlign);
                    sb.AppendLine(labelName + ":");
                }

                sb.AppendLine("  sub.d $r4, $r4, $r12"); // decrement iteration count

                int distance = spacing * Counts[i];
                if (distance < 1024)
                {
                    sb.AppendLine("  bnez $r4, " + funcTargetName); // short branch if we're not too far away
                }
                else
                {
                    string workaroundTarget = funcName + "_mips_indirect_workaround";
                    sb.AppendLine("  beqz $r4, " + workaroundTarget); // jump over indirect branch if iteration count is reached
                    sb.AppendLine("  jr $r14"); // jump back to target (start of loop)
                    sb.AppendLine(workaroundTarget + ":");
                }

                sb.AppendLine("  jr $r1");
            }
        }

        private string GetRiscvNopAlign()
        {
            // branch takes 16 bits (2 bytes)
            int paddingNeeded = spacing - 2;

            // each NOP is 2 bytes
            StringBuilder nopSb = new StringBuilder();
            for (int i = 0; i < paddingNeeded; i += 2)
            {
                nopSb.AppendLine("  nop");
            }

            return nopSb.ToString();
        }

        public void GenerateRiscvAsm(StringBuilder sb)
        {
            string paddingAlign = GetRiscvNopAlign();
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = GetBranchFuncName(Counts[i]);
                string funcTargetName = GetBranchFuncName(Counts[i]) + "_itarget";

                sb.AppendLine(funcName + ":");
                sb.AppendLine("  la x5, " + funcTargetName);
                sb.AppendLine(funcTargetName + ":");
                for (int branchIdx = 1; branchIdx < Counts[i]; branchIdx++)
                {
                    string labelName = GetLabelName(funcName, branchIdx);
                    sb.AppendLine("  j " + labelName);
                    sb.AppendLine(paddingAlign);
                    sb.AppendLine(labelName + ":");
                }

                sb.AppendLine("  addi x10, x10, -1"); // decrement iteration count

                int distance = spacing * Counts[i];
                if (distance < 1024)
                {
                    sb.AppendLine("  bne x10, x0, " + funcTargetName); // short branch if we're not too far away
                }
                else
                {
                    string workaroundTarget = funcName + "_riscv_indirect_workaround";
                    sb.AppendLine("  beq x10, x0, " + workaroundTarget); // jump over indirect branch if iteration count is reached
                    sb.AppendLine("  jalr x0, x5"); // jump back to target (start of loop)
                    sb.AppendLine(workaroundTarget + ":");
                }

                sb.AppendLine("  ret");
            }
        }
    }
}
