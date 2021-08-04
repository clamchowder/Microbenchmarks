using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AsmGen
{
    class x86Nasm
    {
        public static void GenerateGlobalLines(StringBuilder sb, int[] branchCounts, int[] paddings, int[] robCounts, int[] prfCounts, int[] ldmCounts, int[] ldqCounts)
        {
            for (int i = 0; i < prfCounts.Length; i++)
                sb.AppendLine("global " + Program.prfPrefix + prfCounts[i]);

            for (int i = 0; i < prfCounts.Length; i++)
                sb.AppendLine("global " + Program.frfPrefix + prfCounts[i]);

            for (int i = 0; i < robCounts.Length; i++)
                sb.AppendLine("global " + Program.robPrefix + robCounts[i]);

            for (int i = 0;i < ldmCounts.Length; i++)
                sb.AppendLine("global " + Program.ldmPrefix + ldmCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("global " + Program.intSchedPrefix + ldmCounts[i]);

            for (int i = 0; i < ldmCounts.Length; i++)
                sb.AppendLine("global " + Program.memSchedPrefix + ldmCounts[i]);

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine("global " + Program.ldqPrefix + ldqCounts[i]);

            for (int i = 0; i < ldqCounts.Length; i++)
                sb.AppendLine("global " + Program.stqPrefix + ldqCounts[i]);

            for (int i = 0; i < branchCounts.Length; i++)
                for (int p = 0; p < paddings.Length; p++)
                    sb.AppendLine("global " + Program.GetBranchFuncName(branchCounts[i], paddings[p]));
        }

        /// <summary>
        /// Basic template for generating a load of structure test funcs
        /// regs r12, r13, r14, and r15 are usable for filler funcs
        /// </summary>
        /// <param name="sb">stringbuilder to append to</param>
        /// <param name="counts">structure sizes to test</param>
        /// <param name="funcNamePrefix">function name prefix</param>
        /// <param name="fillerInstrs1">instructions after first pointer chasing load (rdi = [rdi])</param>
        /// <param name="fillerInstrs2">instructions after second pointer chasing load (rsi = [rsi])</param>
        public static void GenerateX86NasmStructureTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];
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
                for (int nopIdx = 0, addIdx = 0; nopIdx < counts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < counts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
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

        public static void GenerateX86NasmRobFuncs(StringBuilder sb, int[] robCounts)
        {
            string[] nop = new string[] { "nop" };
            GenerateX86NasmStructureTestFuncs(sb, robCounts, Program.robPrefix, nop, nop);
        }

        public static void GenerateX86NasmPrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add r15, 1";
            unrolledAdds[1] = "  add r14, 2";
            unrolledAdds[2] = "  add r13, 3";
            unrolledAdds[3] = "  add r12, 4";
            GenerateX86NasmStructureTestFuncs(sb, rfCounts, Program.prfPrefix, unrolledAdds, unrolledAdds);
        }

        /// <summary>
        /// Tries to test load dependency matrix capacity with instructions
        /// that depend on an outstanding load
        /// </summary>
        /// <param name="sb">StringBuilder to append ASM to</param>
        /// <param name="ldmCounts">Array of counts</param>
        public static void GenerateX86NasmLdmFuncs(StringBuilder sb, int[] ldmCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add r15, rdi";
            unrolledAdds[1] = "  add r14, rdi";
            unrolledAdds[2] = "  add r13, rdi";
            unrolledAdds[3] = "  add r12, rdi";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add r15, rsi";
            unrolledAdds1[1] = "  add r14, rsi";
            unrolledAdds1[2] = "  add r13, rsi";
            unrolledAdds1[3] = "  add r12, rsi";
            GenerateX86NasmStructureTestFuncs(sb, ldmCounts, Program.ldmPrefix, unrolledAdds, unrolledAdds1);
        }

        public static void GenerateX86NasmIntSchedFuncs(StringBuilder sb, int[] schedCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add r15, rdi";
            unrolledAdds[1] = "  add r14, r15";
            unrolledAdds[2] = "  add r13, r15";
            unrolledAdds[3] = "  add r12, r15";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add r15, rsi";
            unrolledAdds1[1] = "  add r14, r15";
            unrolledAdds1[2] = "  add r13, r15";
            unrolledAdds1[3] = "  add r12, r15";
            GenerateX86NasmStructureTestFuncs(sb, schedCounts, Program.intSchedPrefix, unrolledAdds, unrolledAdds1);
        }

        public static void GenerateX86NasmLdqFuncs(StringBuilder sb, int[] ldqCounts)
        {
            string[] unrolledMovs = new string[4];
            unrolledMovs[0] = "  mov r15, [rdx]";
            unrolledMovs[1] = "  mov r14, [rdx]";
            unrolledMovs[2] = "  mov r13, [rdx]";
            unrolledMovs[3] = "  mov r12, [rdx]";
            GenerateX86NasmStructureTestFuncs(sb, ldqCounts, Program.ldqPrefix, unrolledMovs, unrolledMovs);
        }

        public static void GenerateX86NasmMemSchedFuncs(StringBuilder sb, int[] ldqCounts)
        {
            string[] unrolledMovs = new string[4];
            unrolledMovs[0] = "  mov r15, [r8 + rdi * 4]";
            unrolledMovs[1] = "  mov r14, [r8 + rdi * 4]";
            unrolledMovs[2] = "  mov r13, [r8 + rdi * 4]";
            unrolledMovs[3] = "  mov r12, [r8 + rdi * 4]";

            string[] unrolledMovs1 = new string[4];
            unrolledMovs1[0] = "  mov r15, [r8 + rsi * 4]";
            unrolledMovs1[1] = "  mov r14, [r8 + rsi * 4]";
            unrolledMovs1[2] = "  mov r13, [r8 + rsi * 4]";
            unrolledMovs1[3] = "  mov r12, [r8 + rsi * 4]";
            GenerateX86NasmStructureTestFuncs(sb, ldqCounts, Program.memSchedPrefix, unrolledMovs, unrolledMovs1);
        }

        // Version of LDQ test that makes every filler load hit a different cacheline
        // to see if Zen 2 is doing load coalescing. Results are identical to previous LDQ test
        // indicating there's no load coalescing
        /*public static void GenerateX86NasmLdqFuncs(StringBuilder sb, int[] counts)
        {

            string[] unrolledMovs = new string[4];
            unrolledMovs[0] = "  mov r15, [rdx + 0x40]";
            unrolledMovs[1] = "  mov r14, [rdx + 0x80]";
            unrolledMovs[2] = "  mov r13, [rdx + 0xC0]";
            unrolledMovs[3] = "  mov r12, [rdx + 0x100]";
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = Program.ldqPrefix + counts[i];
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
                for (int nopIdx = 0, addIdx = 0; nopIdx < counts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  mov r15, [rdx + " + (64 * nopIdx) +"]");
                }

                sb.AppendLine("  mov esi, [rdx + rsi * 4]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < counts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  mov r14, [rdx + " + (64 * nopIdx) + "]");
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
        }*/

        public static void GenerateX86NasmStqFuncs(StringBuilder sb, int[] stqCounts)
        {
            string[] unrolledMovs = new string[4];
            unrolledMovs[0] = "  mov [r8], r15";
            unrolledMovs[1] = "  mov [r8], r14";
            unrolledMovs[2] = "  mov [r8], r13";
            unrolledMovs[3] = "  mov [r8], r12";
            GenerateX86NasmStructureTestFuncs(sb, stqCounts, "stq", unrolledMovs, unrolledMovs);
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
                string funcName = Program.frfPrefix + rfCounts[i];
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
                    string funcName = Program.GetBranchFuncName(branchCounts[i], paddings[p]);
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
