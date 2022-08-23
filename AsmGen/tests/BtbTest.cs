using System;
using System.Text;

namespace AsmGen
{
    public class BtbTest : UarchTest
    {
        private int spacing;
        private BranchType branchType;
        private bool varyspacing;

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
            this.Counts = new int[] { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 1536, 2048,
                3072, 4096, 4608, 5120, 6144, 7168, 8192, 10240, 16384, 32768 };
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

        public override void GenerateX86GccAsm(StringBuilder sb)
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

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            sb.AppendLine("%define nop2 db 0x66, 0x90\n");
            sb.AppendLine("%define nop4 db 0x0F, 0x1F, 0x40, 0x00\n");
            sb.AppendLine("%define nop12 db 0x66, 0x66, 0x66, 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n\n");

            string paddingAlign = "align " + spacing;
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = GetBranchFuncName(Counts[i]);
                //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                sb.AppendLine(funcName + ":\n");
                for (int branchIdx = 1; branchIdx < Counts[i]; branchIdx++)
                {
                    string labelName = GetLabelName(funcName, branchIdx);
                    
                    if(branchType == BranchType.Conditional)
                    {
                        sb.AppendLine("  test rax, rax");
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
                            sb.AppendLine("  test rax, rax");
                            sb.AppendLine("  jz " + labelName);
                        }
                    }

                    sb.AppendLine(paddingAlign);
                    sb.AppendLine(labelName + ":");
                }

                sb.AppendLine(paddingAlign);
                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName);
                sb.AppendLine("  ret\n\n");

                // don't let it get too close to the next branch
                sb.AppendLine(paddingAlign);
            }
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            // things are 4 bytes on aarch64
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
            else if (spacing != 4)
            {
                Console.WriteLine($"Unsupported padding value {spacing}");
                throw new NotImplementedException("Unsupported padding value");
            }

            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = GetBranchFuncName(Counts[i]);
                sb.AppendLine(funcName + ":");
                /*sb.AppendLine($"  adrp x2, {funcName}");
                sb.AppendLine($"  add x2, x2, :lo12:{funcName}");*/
                sb.AppendLine("  mov x1, 1");
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
                    sb.AppendLine("  cbz x0, " + workaroundTarget);  // jump over indirect branch to return, on zero
                    sb.AppendLine("  br x2");
                    sb.AppendLine(workaroundTarget + ":");
                }
                else
                {
                    sb.AppendLine("  cbnz x0, " + funcName);
                }

                sb.AppendLine("  ret\n\n");

                // don't let it get too close to the next branch
                sb.AppendLine(paddingAlign);
            }
        }
    }
}
