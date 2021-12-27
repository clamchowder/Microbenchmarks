using System.Text;

namespace AsmGen
{
    public class NopLoopTest : UarchTest
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="low">must be greater than 2</param>
        /// <param name="high"></param>
        /// <param name="step"></param>
        public NopLoopTest(int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(3, high, step);
            this.Prefix = "noploop";
            this.Description = $"NOP throughput for various loop sizes";
            this.FunctionDefinitionParameters = "uint64_t iterations";
            this.GetFunctionCallParameters = "structIterations";
            this.DivideTimeByCount = true;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = this.Prefix + this.Counts[i];
                sb.AppendLine(funcName + ":");

                // count dec, jnz as instructions in the loop
                for (int nopIdx = 0; nopIdx < this.Counts[i] - 2; nopIdx++) sb.AppendLine("  nop");
                sb.AppendLine("  dec %rdi");
                sb.AppendLine("  jnz " + funcName);
                sb.AppendLine("  ret");
            }
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = this.Prefix + this.Counts[i];
                sb.AppendLine(funcName + ":");

                // count dec, jnz as instructions in the loop
                for (int nopIdx = 0; nopIdx < this.Counts[i] - 2; nopIdx++) sb.AppendLine("  nop");
                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jnz " + funcName);
                sb.AppendLine("  ret");
            }
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = this.Prefix + this.Counts[i];
                sb.AppendLine(funcName + ":");

                // count dec, jnz as instructions in the loop
                for (int nopIdx = 0; nopIdx < this.Counts[i] - 2; nopIdx++) sb.AppendLine("  nop");
                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine("  cbnz x0, " + funcName);
                sb.AppendLine("  ret");
            }
        }
    }
}
