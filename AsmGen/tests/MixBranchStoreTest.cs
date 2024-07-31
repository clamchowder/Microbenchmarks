using System.Text;

namespace AsmGen
{
    public class MixBranchStoreTest : UarchTest
    {
        private bool mixNops;
        private bool initialDependentBranch;
        public MixBranchStoreTest(int low, int high, int step, bool mixNops = false, bool initialDependentBranch = false)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "mixstqbob" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "Mixed NT branches and stores" + (initialDependentBranch ? ", preceded by dependent branch" : string.Empty); ;
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.mixNops = mixNops;
            this.initialDependentBranch = initialDependentBranch;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (this.initialDependentBranch && isa != IUarchTest.ISA.aarch64) return false;
            if (isa == IUarchTest.ISA.aarch64) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64)
            {
                GenerateArmAsm(sb);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
            }
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            string dependentBranch = this.initialDependentBranch ? UarchTestHelpers.GetArmDependentBranch(this.Prefix) : null;
            for (int i = 0; i < Counts.Length; i++)
            {
                string funcName = Prefix + Counts[i];

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
                if (this.initialDependentBranch) sb.AppendLine(dependentBranch);
                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_w25_target{fillerIdx}";
                    sb.AppendLine($"  cmp x15, x10");
                    sb.AppendLine($"  b.eq {jumpLabel}");
                    sb.AppendLine($"{jumpLabel}:");
                }

                sb.AppendLine("  ldr w26, [x1, w26, uxtw #2]");
                if (this.initialDependentBranch) sb.AppendLine(dependentBranch);
                for (int fillerIdx = 0; fillerIdx < Counts[i]; fillerIdx++)
                {
                    string jumpLabel = $"{funcName}_w26_target{fillerIdx}";
                    sb.AppendLine($"  cmp x15, x10");
                    sb.AppendLine($"  b.eq {jumpLabel}");
                    sb.AppendLine($"{jumpLabel}:");
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
    }
}
