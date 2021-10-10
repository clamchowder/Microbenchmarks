using System;
using System.Text;

namespace AsmGen
{
    public class BtbTest : UarchTest
    {
        private int spacing;
        /// <summary>
        /// Constructor for BTB test
        /// </summary>
        /// <param name="spacing">How far apart branches should be. Valid values are 4, 8, 16</param>
        public BtbTest(int spacing)
        {
            this.Counts = new int[] { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 1536, 2048,
                3072, 4096, 5120, 6144, 7168, 8192, 10240, 16384, 32768 };
            this.Prefix = "btb" + spacing + "n";
            this.Description = $"Branch Target Buffer, branch every {spacing} bytes";
            this.FunctionDefinitionParameters = "uint64_t iterations";
            this.GetFunctionCallParameters = "structIterations";
            this.DivideTimeByCount = true;
            this.spacing = spacing;
        }

        private string GetBranchFuncName(int branchCount) { return Prefix + branchCount; }
        public string GetLabelName(string funcName, int part) { return funcName + "part" + part; }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string paddingAlign = "";
            if (spacing == 8) paddingAlign = "  .align 8";
            else if (spacing == 16) paddingAlign = "  .align 16";
            else if (spacing != 4)
            {
                // in theory we could have more cases/denser branches for x86, but that wouldn't work on ARM
                // where all instructions are 4 bytes
                Console.WriteLine($"Unsupported padding value {spacing}");
                throw new NotImplementedException("Padding/alignment value for branches must 4, 8, or 16");
            }

            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = GetBranchFuncName(Counts[i]);
                //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                sb.AppendLine(funcName + ":\n");
                for (int branchIdx = 1; branchIdx < Counts[i]; branchIdx++)
                {
                    string labelName = GetLabelName(funcName, branchIdx);
                    sb.AppendLine("  jmp " + labelName);
                    sb.AppendLine(paddingAlign);
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

            string paddingAlign = "";

            // jmp takes two bytes
            // need 2 bytes, then a 4 byte nop to make 8 bytes total
            if (spacing == 8)
            {
                paddingAlign = "  nop2\n  nop4\n";
            }
            // need 2 bytes, then 12 bytes of nops to make 16 bytes total
            else if (spacing == 16)
            {
                paddingAlign = "  nop2\n  nop12\n";
            }
            else if (spacing != 4)
            {
                Console.WriteLine($"Unsupported padding value {spacing}");
                throw new NotImplementedException("Unsupported padding value");
            }

            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = GetBranchFuncName(Counts[i]);
                //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                sb.AppendLine(funcName + ":\n");
                for (int branchIdx = 1; branchIdx < Counts[i]; branchIdx++)
                {
                    string labelName = GetLabelName(funcName, branchIdx);
                    sb.AppendLine("  jmp " + labelName);
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
                paddingAlign = "  nop\n";
            }
            else if (spacing == 16)
            {
                paddingAlign = "  nop\n  nop\n";
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
                for (int branchIdx = 1; branchIdx < Counts[i]; branchIdx++)
                {
                    string labelName = GetLabelName(funcName, branchIdx);
                    sb.AppendLine("  b " + labelName);
                    sb.AppendLine(paddingAlign);
                    sb.AppendLine(labelName + ":");
                }

                sb.AppendLine(paddingAlign);
                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName);
                sb.AppendLine("  ret\n\n");

                // don't let it get too close to the next branch
                sb.AppendLine(paddingAlign);
            }
        }
    }
}
