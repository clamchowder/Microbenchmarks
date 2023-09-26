using System.Text;

namespace AsmGen
{
    public class AddLoopTest : UarchTest
    {
        /// <summary>
        ///
        /// </summary>
        /// <param name="low">must be greater than 2</param>
        /// <param name="high"></param>
        /// <param name="step"></param>
        public AddLoopTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "addloop";
            this.Description = $"ADD throughput for various loop sizes. Avoids NOP fusing";
            this.FunctionDefinitionParameters = "uint64_t iterations";
            this.GetFunctionCallParameters = "structIterations";
            this.DivideTimeByCount = true;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return false;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) GenerateX86GccAsm(sb);
            if (isa == IUarchTest.ISA.aarch64) GenerateArmAsm(sb);
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add %r11, %r15";
            unrolledAdds[1] = "  add %r11, %r14";
            unrolledAdds[2] = "  add %r11, %r13";
            unrolledAdds[3] = "  add %r11, %r12";

            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = this.Prefix + this.Counts[i];
                sb.AppendLine(funcName + ":");

                // count dec, jnz as instructions in the loop
                for (int nopIdx = 0; nopIdx < this.Counts[i] - 2; nopIdx++) sb.AppendLine(unrolledAdds[nopIdx & 3]);
                sb.AppendLine("  dec %rdi");
                sb.AppendLine("  jnz " + funcName);
                sb.AppendLine("  ret");
            }
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string[] unrolledAdds = new string[4];
            unrolledAdds[0] = "  add x15, x15, x11";
            unrolledAdds[1] = "  add x14, x14, x11";
            unrolledAdds[2] = "  add x13, x13, x11";
            unrolledAdds[3] = "  add x12, x12, x11";

            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = this.Prefix + this.Counts[i];
                sb.AppendLine(funcName + ":");

                for (int nopIdx = 0; nopIdx < this.Counts[i] - 2; nopIdx++) sb.AppendLine(unrolledAdds[nopIdx & 3]);
                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName);
                sb.AppendLine("  ret");
            }
        }
    }
}