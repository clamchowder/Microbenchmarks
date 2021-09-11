using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AsmGen
{
    class ARM
    {
        public static void GenerateArmAsmStructureTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2, bool includePtrChasingLoads = false)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];

                // args in x0, x1
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  sub sp, sp, #0x50");
                sb.AppendLine("  stp x14, x15, [sp, #0x10]");
                sb.AppendLine("  stp x12, x13, [sp, #0x20]");
                sb.AppendLine("  stp x10, x11, [sp, #0x30]");
                sb.AppendLine("  stp x25, x26, [sp, #0x40]");
                sb.AppendLine("  mov x15, 1");
                sb.AppendLine("  mov x14, 2");
                sb.AppendLine("  mov x13, 3");
                sb.AppendLine("  mov x12, 4");
                sb.AppendLine("  mov x11, 5");
                sb.AppendLine("  mov x10, 6");
                sb.AppendLine("  mov w25, 0x0");
                sb.AppendLine("  mov w26, 0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w25, [x1, w25, uxtw #2]"); // current = A[current]

                int fillerInstrCount = includePtrChasingLoads ? counts[i] - 2 : counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  ldr w26, [x1, w26, uxtw #2]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x25, x26, [sp, #0x40]");
                sb.AppendLine("  ldp x10, x11, [sp, #0x30]");
                sb.AppendLine("  ldp x12, x13, [sp, #0x20]");
                sb.AppendLine("  ldp x14, x15, [sp, #0x10]");
                sb.AppendLine("  add sp, sp, #0x50");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateArmAsmFpSchedTestFuncs(StringBuilder sb, int[] counts, string funcNamePrefix, string[] fillerInstrs1, string[] fillerInstrs2)
        {
            for (int i = 0; i < counts.Length; i++)
            {
                string funcName = funcNamePrefix + counts[i];

                // x0 = iteration count, x1 = ptr chasing arr, x2 = fp array
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  sub sp, sp, #0x50");
                sb.AppendLine("  stp x14, x15, [sp, #0x10]");
                sb.AppendLine("  stp x12, x13, [sp, #0x20]");
                sb.AppendLine("  stp x10, x11, [sp, #0x30]");
                sb.AppendLine("  stp x25, x26, [sp, #0x40]");;
                sb.AppendLine("  ldr s17, [x2]");
                sb.AppendLine("  ldr s18, [x2, 4]");
                sb.AppendLine("  ldr s19, [x2, 8]");
                sb.AppendLine("  ldr s20, [x2, 12]");
                sb.AppendLine("  ldr s21, [x2, 16]");
                sb.AppendLine("  mov w25, 0x0");
                sb.AppendLine("  mov w26, 0x40");
                sb.AppendLine("\n" + funcName + "start:");
                sb.AppendLine("  ldr w25, [x1, w25, uxtw #2]"); // current = A[current]
                // x2 = ptr to FP array. do a FP load dependent on that
                sb.AppendLine("  ldr s16, [x2, w25, uxtw #2]");

                int fillerInstrCount = counts[i];
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs1[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs1.Length;
                }

                sb.AppendLine("  ldr w26, [x1, w26, uxtw #2]");
                sb.AppendLine("  ldr s16, [x2, w26, uxtw #2]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < fillerInstrCount; nopIdx++)
                {
                    sb.AppendLine(fillerInstrs2[addIdx]);
                    addIdx = (addIdx + 1) % fillerInstrs2.Length;
                }

                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName + "start");
                sb.AppendLine("  ldp x25, x26, [sp, #0x40]");
                sb.AppendLine("  ldp x10, x11, [sp, #0x30]");
                sb.AppendLine("  ldp x12, x13, [sp, #0x20]");
                sb.AppendLine("  ldp x14, x15, [sp, #0x10]");
                sb.AppendLine("  add sp, sp, #0x50");
                sb.AppendLine("  ret\n\n");
            }
        }

        public static void GenerateArmAsmMulSchedFuncs(StringBuilder sb, int[] counts)
        {
            string[] unrolledMuls = new string[4];
            unrolledMuls[0] = "  mul w15, w15, w25";
            unrolledMuls[1] = "  mul w14, w14, w25";
            unrolledMuls[2] = "  mul w13, w13, w25";
            unrolledMuls[3] = "  mul w12, w12, w25";

            string[] unrolledMuls1 = new string[4];
            unrolledMuls1[0] = "  mul w15, w15, w26";
            unrolledMuls1[1] = "  mul w14, w14, w26";
            unrolledMuls1[2] = "  mul w13, w13, w26";
            unrolledMuls1[3] = "  mul w12, w12, w26";

            GenerateArmAsmStructureTestFuncs(sb, counts, Program.mulSchedPrefix, unrolledMuls, unrolledMuls);
        }

        public static void GenerateArmAsmFAddSchedFuncs(StringBuilder sb, int[] counts)
        {
            // x0 = iteration count, x1 = ptr chasing arr, x2 = fp arr
            string[] unrolledFadds = new string[4];
            unrolledFadds[0] = "  fadd s17, s17, s16";
            unrolledFadds[1] = "  fadd s18, s18, s16";
            unrolledFadds[2] = "  fadd s19, s19, s16";
            unrolledFadds[3] = "  fadd s20, s20, s16";

            GenerateArmAsmFpSchedTestFuncs(sb, counts, Program.faddSchedPrefix, unrolledFadds, unrolledFadds);
        }

        public static void GenerateArmAsmLdmFuncs(StringBuilder sb, int[] ldmcounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x10";
            unrolledAdds[1] = "  add x14, x14, x10";
            unrolledAdds[2] = "  add x13, x13, x10";
            unrolledAdds[3] = "  add x12, x12, x10";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add x15, x15, x11";
            unrolledAdds1[1] = "  add x14, x14, x11";
            unrolledAdds1[2] = "  add x13, x13, x11";
            unrolledAdds1[3] = "  add x12, x12, x11";

            GenerateArmAsmStructureTestFuncs(sb, ldmcounts, Program.ldmPrefix, unrolledAdds, unrolledAdds1, includePtrChasingLoads: true);
        }

        public static void GenerateArmAsmLdqFuncs(StringBuilder sb, int[] ldqCounts)
        {
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  ldr x15, [x1]";
            unrolledLoads[1] = "  ldr x14, [x1]";
            unrolledLoads[2] = "  ldr x13, [x1]";
            unrolledLoads[3] = "  ldr x12, [x1]";

            GenerateArmAsmStructureTestFuncs(sb, ldqCounts, Program.ldqPrefix, unrolledLoads, unrolledLoads, includePtrChasingLoads: true);
        }

        public static void GenerateArmAsmLdqStqFuncs(StringBuilder sb, int[] ldqCounts)
        {
            // x1 = load arr, x2 = sink
            string[] unrolledLoads = new string[4];
            unrolledLoads[0] = "  ldr x15, [x1]";
            unrolledLoads[1] = "  str x14, [x2]";
            unrolledLoads[2] = "  ldr x13, [x1]";
            unrolledLoads[3] = "  str x12, [x2]";

            GenerateArmAsmStructureTestFuncs(sb, ldqCounts, Program.ldqStqPrefix, unrolledLoads, unrolledLoads, includePtrChasingLoads: true);
        }

        public static void GenerateArmAsmMemSchedFuncs(StringBuilder sb, int[] memSchedCounts)
        {
            // ldr w26, [x1, w26, uxtw #2]
            string[] loads = new string[4];
            loads[0] = "  ldr w15, [x2, w25, uxtw #2]";
            loads[1] = "  ldr w14, [x2, w25, uxtw #2]";
            loads[2] = "  ldr w13, [x2, w25, uxtw #2]";
            loads[3] = "  ldr w12, [x2, w25, uxtw #2]";

            string[] loads1 = new string[4];
            loads1[0] = "  ldr w15, [x2, w26, uxtw #2]";
            loads1[1] = "  ldr w14, [x2, w26, uxtw #2]";
            loads1[2] = "  ldr w13, [x2, w26, uxtw #2]";
            loads1[3] = "  ldr w12, [x2, w26, uxtw #2]";

            GenerateArmAsmStructureTestFuncs(sb, memSchedCounts, Program.memSchedPrefix, loads, loads1, includePtrChasingLoads: true);
        }

        public static void GenerateArmAsmStoreSchedFuncs(StringBuilder sb, int[] memSchedCounts)
        {
            // ldr w26, [x1, w26, uxtw #2]
            string[] loads = new string[4];
            loads[0] = "  str w15, [x2, w25, uxtw #2]";
            loads[1] = "  str w14, [x2, w25, uxtw #2]";
            loads[2] = "  str w13, [x2, w25, uxtw #2]";
            loads[3] = "  str w12, [x2, w25, uxtw #2]";

            string[] loads1 = new string[4];
            loads1[0] = "  str w15, [x2, w26, uxtw #2]";
            loads1[1] = "  str w14, [x2, w26, uxtw #2]";
            loads1[2] = "  str w13, [x2, w26, uxtw #2]";
            loads1[3] = "  str w12, [x2, w26, uxtw #2]";

            GenerateArmAsmStructureTestFuncs(sb, memSchedCounts, Program.storeSchedPrefix, loads, loads1, includePtrChasingLoads: false);
        }

        public static void GenerateArmAsmStqFuncs(StringBuilder sb, int[] stqCounts)
        {
            // program will pass &tmpsink as a third argument, which goes in x2
            string[] unrolledStores = new string[4];
            unrolledStores[0] = "  str x15, [x2]";
            unrolledStores[1] = "  str x14, [x2]";
            unrolledStores[2] = "  str x13, [x2]";
            unrolledStores[3] = "  str x12, [x2]";

            GenerateArmAsmStructureTestFuncs(sb, stqCounts, Program.stqPrefix, unrolledStores, unrolledStores);
        }

        public static void GenerateArmAsmPrfFuncs(StringBuilder sb, int[] rfCounts)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, 1";
            unrolledAdds[1] = "  add x14, x14, 2";
            unrolledAdds[2] = "  add x13, x13, 3";
            unrolledAdds[3] = "  add x12, x12, 4";

            GenerateArmAsmStructureTestFuncs(sb, rfCounts, Program.prfPrefix, unrolledAdds, unrolledAdds);
        }

        public static void GenerateArmAsmRobFuncs(StringBuilder sb, int[] robCounts)
        {
            string[] nops = new string[] { "nop" };
            GenerateArmAsmStructureTestFuncs(sb, robCounts, Program.robPrefix, nops, nops);
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
                string funcName = Program.frfPrefix + rfCounts[i];

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
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i]; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
                }

                sb.AppendLine("  ldr w3, [x1, w3, uxtw #2]");
                for (int nopIdx = 0, addIdx = 0; nopIdx < rfCounts[i]; nopIdx++)
                {
                    sb.AppendLine(unrolledAdds[addIdx]);
                    addIdx = (addIdx + 1) % 4;
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
