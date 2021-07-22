using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AsmGen
{
    class x86
    {
        public static void GenerateX86AsmRobFuncs(StringBuilder sb, int[] robCounts)
        {
            for (int i = 0; i < robCounts.Length; i++)
            {
                // args in rdi, rsi, rdx, rcx
                string funcName = Program.GetRobFuncName(robCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rdx");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  mov %rsi, %rdx");
                sb.AppendLine("  mov %rdi, %rcx");
                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86AsmLdmFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add %rdi, %r15";
            unrolledAdds[1] = "  add %rdi, %r14";
            unrolledAdds[2] = "  add %rdi, %r13";
            unrolledAdds[3] = "  add %rdi, %r12";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add %rsi, %r15";
            unrolledAdds1[1] = "  add %rsi, %r14";
            unrolledAdds1[2] = "  add %rsi, %r13";
            unrolledAdds1[3] = "  add %rsi, %r12";

            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = Program.GetLdmFuncName(rfCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");
                sb.AppendLine("  mov %rsi, %rdx");
                sb.AppendLine("  mov %rdi, %rcx");
                sb.AppendLine("  xor %r15, %r15");
                sb.AppendLine("  mov $0x1, %r14");
                sb.AppendLine("  mov $0x1, %r13");
                sb.AppendLine("  mov $0x3, %r12");
                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds1[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86AsmPrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add $0x1, %r15";
            unrolledAdds[1] = "  add $0x2, %r14";
            unrolledAdds[2] = "  add $0x3, %r13";
            unrolledAdds[3] = "  add $0x4, %r12";

            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = Program.GetPrfFuncName(rfCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");
                sb.AppendLine("  mov %rsi, %rdx");
                sb.AppendLine("  mov %rdi, %rcx");
                sb.AppendLine("  xor %r15, %r15");
                sb.AppendLine("  mov $0x1, %r14");
                sb.AppendLine("  mov $0x1, %r13");
                sb.AppendLine("  mov $0x3, %r12");
                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86AsmFrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  paddd %xmm1, %xmm1";
            unrolledAdds[1] = "  paddd %xmm2, %xmm2";
            unrolledAdds[2] = "  paddd %xmm3, %xmm3";
            unrolledAdds[3] = "  paddd %xmm4, %xmm4";

            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = Program.GetFrfFuncName(rfCounts[i]);
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %rsi");
                sb.AppendLine("  push %rdi");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");
                sb.AppendLine("  mov %rsi, %rdx");
                sb.AppendLine("  mov %rdi, %rcx");
                sb.AppendLine("  xor %rdi, %rdi");
                sb.AppendLine("  mov $0x40, %esi");
                sb.AppendLine("  movdqu (%rdx,%rdi,4), %xmm1");
                sb.AppendLine("  movdqu (%rdx,%rsi,4), %xmm1");
                sb.AppendLine("  movdqu (%rdx,%rdi,8), %xmm1");
                sb.AppendLine("  movdqu (%rdx,%rsi,8), %xmm1");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  mov (%rdx,%rdi,4), %edi");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  mov (%rdx,%rsi,4), %esi");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  dec %rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %rdi");
                sb.AppendLine("  pop %rsi");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateX86AsmBranchFuncs(StringBuilder sb, int[] branchCounts, int[] paddings)
        {
            string paddingAlign = "";
            for (int p = 0; p < paddings.Length; p++)
            {
                if (paddings[p] == 1) paddingAlign = "  .align 8";
                else if (paddings[p] == 3) paddingAlign = "  .align 16";
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

                    sb.AppendLine("  dec %rdi");
                    sb.AppendLine("  jne " + funcName);
                    sb.AppendLine("  ret\n\n");
                }
            }
        }
    }
}
