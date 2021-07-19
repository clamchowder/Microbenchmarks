using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AsmGen
{
    class x86Nasm
    {
        public static void GenerateX86NasmRobFuncs(StringBuilder sb, int[] robCounts)
        {
            for (int i = 0; i < robCounts.Length; i++)
            {
                string funcName = Program.GetRobFuncName(robCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86NasmPrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add r15, 1";
            unrolledAdds[1] = "  add r14, 2";
            unrolledAdds[2] = "  add r13, 3";
            unrolledAdds[3] = "  add r12, 4";

            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = Program.GetPrfFuncName(rfCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  xor r15, r15");
                sb.AppendLine("  mov r14, 1");
                sb.AppendLine("  mov r13, 2");
                sb.AppendLine("  mov r12, 3");
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86NasmFrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddd xmm1, xmm1";
            unrolledAdds[1] = "  paddd xmm2, xmm2";
            unrolledAdds[2] = "  paddd xmm3, xmm3";
            unrolledAdds[3] = "  paddd xmm4, xmm4";

            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = Program.GetFrfFuncName(rfCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");
                sb.AppendLine("  xor rdi, rdi");
                sb.AppendLine("  mov esi, 64");
                sb.AppendLine("  movdqu xmm1, [rdx]");
                sb.AppendLine("  movdqu xmm2, [rdx]");
                sb.AppendLine("  movdqu xmm3, [rdx + rsi * 4]");
                sb.AppendLine("  movdqu xmm4, [rdx + rsi * 8]");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov edi, [rdx + rdi * 4]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86NasmBranchFuncs(StringBuilder sb, int[] branchCounts, int[] paddings)
        {
            string paddingAlign = "";
            for (int p = 0; p < paddings.Length; p++)
            {
                // need 2 bytes, then a 4 byte nop
                if (paddings[p] == 1)
                {
                    paddingAlign = "  nop2\n  nop4\n";
                }
                // need 2 bytes, then 12 bytes of nops
                else if (paddings[p] == 3)
                {
                    paddingAlign = "  nop2\n  nop12\n";
                }
                else if (paddings[p] != 0)
                {
                    Console.WriteLine($"Unsupported padding value {paddings[p]}");
                    continue;
                }

                for (int i = 0; i < branchCounts.Length; i++)
                {
                    string funcName = Program.GetFuncName(branchCounts[i], paddings[p]);
                    //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                    sb.AppendLine(funcName + ":\n");
                    for (int branchIdx = 1; branchIdx < branchCounts[i]; branchIdx++)
                    {
                        string labelName = Program.GetLabelName(funcName, branchIdx);
                        sb.AppendLine("  jmp " + labelName);
                        sb.AppendLine(paddingAlign);
                        sb.AppendLine(labelName + ":");
                    }

                    sb.AppendLine("  dec rcx");
                    sb.AppendLine("  jne " + funcName);
                    sb.AppendLine("  ret\n\n");
                }
            }
        }
    }
}
