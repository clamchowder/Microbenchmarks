using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class MshrsTest : UarchTest
    {
        private string[] linuxRegsArr, linuxRegsArr32, winRegsArr, winRegsArr32;

        public MshrsTest(int low, int high, int step)
        {
            this.Prefix = "mshrs";
            this.Description = "Miss Status Handling Registers Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr";
            this.GetFunctionCallParameters = "structIterations, A";
            this.DivideTimeByCount = false;
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            List<string> regs = new List<string>();
            regs.Add("rax");
            regs.Add("rbx");
            regs.Add("rcx");
            regs.Add("rdx");
            regs.Add("r8");
            regs.Add("r9");
            regs.Add("r10");
            regs.Add("r11");
            regs.Add("r12");
            regs.Add("r13");
            regs.Add("r14");
            regs.Add("r15");
            linuxRegsArr = regs.ToArray();

            List<string> regs32 = new List<string>();
            regs32.Add("eax");
            regs32.Add("ebx");
            regs32.Add("ecx");
            regs32.Add("edx");
            regs32.Add("r8d");
            regs32.Add("r9d");
            regs32.Add("r10d");
            regs32.Add("r11d");
            regs32.Add("r12d");
            regs32.Add("r13d");
            regs32.Add("r14d");
            regs32.Add("r15d");
            linuxRegsArr32 = regs32.ToArray();

            List<string> winregs = new List<string>();
            winregs.Add("rax");
            winregs.Add("rbx");
            winregs.Add("rsi");
            winregs.Add("rdi");
            winregs.Add("r8");
            winregs.Add("r9");
            winregs.Add("r10");
            winregs.Add("r11");
            winregs.Add("r12");
            winregs.Add("r13");
            winregs.Add("r14");
            winregs.Add("r15");
            winRegsArr = winregs.ToArray();

            List<string> winregs32 = new List<string>();
            winregs32.Add("eax");
            winregs32.Add("ebx");
            winregs32.Add("esi");
            winregs32.Add("edi");
            winregs32.Add("r8d");
            winregs32.Add("r9d");
            winregs32.Add("r10d");
            winregs32.Add("r11d");
            winregs32.Add("r12d");
            winregs32.Add("r13d");
            winregs32.Add("r14d");
            winregs32.Add("r15d");
            winRegsArr32 = winregs32.ToArray();

            if (high > regs.Count) throw new System.Exception("No");
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
            {
                // rdi = iterations, rsi = array
                string funcName = Prefix + Counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push %r15");
                sb.AppendLine("  push %r14");
                sb.AppendLine("  push %r13");
                sb.AppendLine("  push %r12");
                sb.AppendLine("  push %r11");
                sb.AppendLine("  push %r8");
                sb.AppendLine("  push %rcx");
                sb.AppendLine("  push %rdx");
                sb.AppendLine("  push %rbx");

                for (int chaseIdx = 0; chaseIdx < Counts[i]; chaseIdx++)
                {
                    sb.AppendLine($"  mov ${chaseIdx * 4}, %{linuxRegsArr[chaseIdx]}");
                }

                sb.AppendLine("\n" + funcName + "start:");
                for (int chaseIdx = 0; chaseIdx < Counts[i]; chaseIdx++)
                {
                    sb.AppendLine($"  mov (%rsi,%{linuxRegsArr[chaseIdx]},4), %{linuxRegsArr32[chaseIdx]}");
                }

                sb.AppendLine("  dec %rdi");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop %rbx");
                sb.AppendLine("  pop %rdx");
                sb.AppendLine("  pop %rcx");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %r11");
                sb.AppendLine("  pop %r12");
                sb.AppendLine("  pop %r13");
                sb.AppendLine("  pop %r14");
                sb.AppendLine("  pop %r15");
                sb.AppendLine("  ret\n\n");
            }
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
            {
                // rdi = iterations, rsi = array
                string funcName = Prefix + Counts[i];
                sb.AppendLine("\n" + funcName + ":");
                sb.AppendLine("  push r15");
                sb.AppendLine("  push r14");
                sb.AppendLine("  push r13");
                sb.AppendLine("  push r12");
                sb.AppendLine("  push r11");
                sb.AppendLine("  push r8");
                sb.AppendLine("  push rdx");
                sb.AppendLine("  push rbx");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push rdi");

                for (int chaseIdx = 0; chaseIdx < Counts[i]; chaseIdx++)
                {
                    sb.AppendLine($"  mov {winRegsArr[chaseIdx]}, {chaseIdx * 4}");
                }

                sb.AppendLine("\n" + funcName + "start:");
                for (int chaseIdx = 0; chaseIdx < Counts[i]; chaseIdx++)
                {
                    sb.AppendLine($"  mov {winRegsArr32[chaseIdx]}, [rdx + {winRegsArr[chaseIdx]} * 4]");
                }

                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jne " + funcName + "start");
                sb.AppendLine("  pop rdi");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  pop rbx");
                sb.AppendLine("  pop rdx");
                sb.AppendLine("  pop r8");
                sb.AppendLine("  pop r11");
                sb.AppendLine("  pop r12");
                sb.AppendLine("  pop r13");
                sb.AppendLine("  pop r14");
                sb.AppendLine("  pop r15");
                sb.AppendLine("  ret\n\n");
            }
        }

        // not implemented for ARM
        public override void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x25";
            unrolledAdds[1] = "  add x14, x14, x25";
            unrolledAdds[2] = "  add x13, x13, x25";
            unrolledAdds[3] = "  add x12, x12, x25";

            string[] unrolledAdds1 = new string[4];
            unrolledAdds1[0] = "  add x15, x15, x26";
            unrolledAdds1[1] = "  add x14, x14, x26";
            unrolledAdds1[2] = "  add x13, x13, x26";
            unrolledAdds1[3] = "  add x12, x12, x26";
            UarchTestHelpers.GenerateArmAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledAdds, unrolledAdds1, false);
        }
    }
}