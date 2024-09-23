using System.Collections.Generic;
using System.Text;

namespace AsmGen
{
    public class StqTest : UarchTest
    {
        private bool initialDependentBranch;
        private bool spaced;

        public StqTest(int low, int high, int step, bool initialDependentBranch, bool spaced)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "stq" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "Store Queue" + (initialDependentBranch ? ", preceded by independent branch" : string.Empty);
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.initialDependentBranch = initialDependentBranch;
            this.spaced = spaced;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (this.initialDependentBranch && isa != IUarchTest.ISA.aarch64) return false;
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return true;
            if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string[] unrolledStores;
                string postLoadInstrs = "";
                if (spaced)
                {
                    postLoadInstrs = "mov %r8, %r11";
                    List<string> storeInstrs = new List<string>();
                    for (int i = 0; i < this.Counts[Counts.Length - 1]; i++)
                    {
                        // Send to different cache lines
                        storeInstrs.Add("  mov %r15, (%r11)\n  add $64, %r11");
                    }

                    unrolledStores = storeInstrs.ToArray();
                }
                else
                {
                    unrolledStores = new string[4];
                    unrolledStores[0] = "  mov %r15, (%r8)";
                    unrolledStores[1] = "  mov %r14, (%r8)";
                    unrolledStores[2] = "  mov %r13, (%r8)";
                    unrolledStores[3] = "  mov %r12, (%r8)";
                }

                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(
                    sb, 
                    this.Counts, 
                    this.Prefix, 
                    unrolledStores, 
                    unrolledStores, 
                    postLoadInstrs1: postLoadInstrs, 
                    postLoadInstrs2: postLoadInstrs, 
                    includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetArmDependentBranch(this.Prefix) : null;
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  str x15, [x2]";
                unrolledStores[1] = "  str x14, [x2]";
                unrolledStores[2] = "  str x13, [x2]";
                unrolledStores[3] = "  str x12, [x2]";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, includePtrChasingLoads: false, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
            }
            else if (isa == IUarchTest.ISA.mips64)
            {
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  st.d $r15, $r6, 0";
                unrolledStores[1] = "  st.d $r16, $r6, 0";
                unrolledStores[2] = "  st.d $r17, $r6, 0";
                unrolledStores[3] = "  st.d $r18, $r6, 0";
                UarchTestHelpers.GenerateMipsAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  sd x28, (x12)";
                unrolledStores[1] = "  sd x29, 8(x12)";
                unrolledStores[2] = "  sd x30, 16(x12)";
                unrolledStores[3] = "  sd x31, 24(x12)";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, false);
            }
        }
    }
}
