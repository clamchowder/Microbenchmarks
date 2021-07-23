using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AsmGen
{
    class ARM
    {
        public static void GenerateArmAsmLdmFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x30, x30, x2";
            unrolledAdds[1] = "  add x29, x29, x2";
            unrolledAdds[2] = "  add x28, x28, x2";
            unrolledAdds[3] = "  add x27, x27, x2";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add x30, x30, x3";
            unrolledAdds1[1] = "  add x29, x29, x3";
            unrolledAdds1[2] = "  add x28, x28, x3";
            unrolledAdds1[3] = "  add x27, x27, x3";

            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = Program.GetLdmFuncName(rfCounts[i]);

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  stp x29, x30, [sp, #0x10]");
                sb.AppendLine("  stp x27, x28, [sp, #0x20]");
                sb.AppendLine("  mov w2, #0x0");
                sb.AppendLine("  mov w3, #0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w2, [x1, w2, uxtw #2]"); // current = A[current]
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  ldr w3, [x1, w3, uxtw #2]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds1[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x27, x28, [sp, #0x20]");
                sb.AppendLine("  ldp x29, x30, [sp, #0x10]");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateArmAsmPrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x30, x30, 1";
            unrolledAdds[1] = "  add x29, x29, 2";
            unrolledAdds[2] = "  add x28, x28, 3";
            unrolledAdds[3] = "  add x27, x27, 4";

            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = Program.GetPrfFuncName(rfCounts[i]);

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  stp x29, x30, [sp, #0x10]");
                sb.AppendLine("  stp x27, x28, [sp, #0x20]");
                sb.AppendLine("  mov w2, #0x0");
                sb.AppendLine("  mov w3, #0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w2, [x1, w2, uxtw #2]"); // current = A[current]
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  ldr w3, [x1, w3, uxtw #2]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x27, x28, [sp, #0x20]");
                sb.AppendLine("  ldp x29, x30, [sp, #0x10]");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateArmAsmFrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add v0.4s, v0.4s, v0.4s";
            unrolledAdds[1] = "  add v1.4s, v1.4s, v1.4s";
            unrolledAdds[2] = "  add v2.4s, v2.4s, v2.4s";
            unrolledAdds[3] = "  add v3.4s, v3.4s, v3.4s";

            for (int i = 0; i < rfCounts.Length; i++)
            {
                string funcName = Program.GetFrfFuncName(rfCounts[i]);

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  mov w2, #0x0");
                sb.AppendLine("  mov w3, #0x40");
                sb.AppendLine("  ldr q0, [x1]"); // get clobbered?
                sb.AppendLine("  ldr q1, [x1, #0x10]");
                sb.AppendLine("  ldr q2, [x1, #0x20]");
                sb.AppendLine("  ldr q3, [x1, #0x30]");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w2, [x1, w2, uxtw #2]"); // current = A[current]
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  ldr w3, [x1, w3, uxtw #2]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateArmAsmRobFuncs(StringBuilder sb, int[] robCounts)
        {
            for (int i = 0; i < robCounts.Length; i++)
            {
                string funcName = Program.GetRobFuncName(robCounts[i]);

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  mov w2, #0x0");
                sb.AppendLine("  mov w3, #0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w2, [x1, w2, uxtw #2]"); // current = A[current]
                // followed by nops
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  ldr w3, [x1, w3, uxtw #2]");
                for (int nopIdx = 0; nopIdx < robCounts[i] - 2; nopIdx++)
                {
                    sb.AppendLine("  nop");
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateArmAsmBranchFuncs(StringBuilder sb, int[] branchCounts, int[] paddings)
        {
            for (int p = 0; p < paddings.Length; p++)
                for (int i = 0; i < branchCounts.Length; i++)
                {
                    string funcName = Program.GetBranchFuncName(branchCounts[i], paddings[p]);
                    //sb.AppendLine("; Start of function for branch count " + branchCounts[i] + " padding " + paddings[p]);
                    sb.AppendLine(funcName + ":");
                    for (int branchIdx = 1; branchIdx < branchCounts[i]; branchIdx++)
                    {
                        string labelName = Program.GetLabelName(funcName, branchIdx);
                        sb.AppendLine("  b " + labelName);
                        for (int paddingIdx = 0; paddingIdx < paddings[p]; paddingIdx++)
                            sb.AppendLine("  nop");
                        sb.AppendLine(labelName + ":");
                    }

                    sb.AppendLine("  sub x0, x0, 1");
                    sb.AppendLine("  cbnz x0, " + funcName);
                    sb.AppendLine("  ret\n\n");
                }
        }
    }
}
