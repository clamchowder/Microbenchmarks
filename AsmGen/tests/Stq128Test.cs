using System.Text;

namespace AsmGen
{
    public class Stq128Test : UarchTest
    {
        private bool initialDependentBranch;
        public Stq128Test(int low, int high, int step, bool initialDependentBranch)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "stq128" + (initialDependentBranch ? "db" : string.Empty);
            this.Description = "Store Queue with 128-bit stores" + (initialDependentBranch ? ", preceded by independent branch" : string.Empty);
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, float *floatArr";
            this.GetFunctionCallParameters = "structIterations, A, fpArr";
            this.DivideTimeByCount = false;
            this.initialDependentBranch = initialDependentBranch;
        }

        public override bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (this.initialDependentBranch)
            {
                if (isa == IUarchTest.ISA.aarch64) return true;
                if (isa == IUarchTest.ISA.riscv) return true;
                return false;
            }

            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.riscv) return true;
            return false;
        }

        public override void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64)
            {
                string initInstrs = "  movups (%rdx), %xmm1";
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  movaps %xmm1, (%r8)";
                unrolledStores[1] = "  movaps %xmm1, (%r8)";
                unrolledStores[2] = "  movaps %xmm1, (%r8)";
                unrolledStores[3] = "  movaps %xmm1, (%r8)";
                UarchTestHelpers.GenerateX86AsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, initInstrs: initInstrs, includePtrChasingLoads: false);
            }
            else if (isa == IUarchTest.ISA.aarch64)
            {
                string initInstrs = "  ldr q0, [x1]";
                string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetArmDependentBranch(this.Prefix) : null;
                string[] unrolledStores = new string[4];
                unrolledStores[0] = "  str q0, [x2]";
                unrolledStores[1] = "  str q0, [x2]";
                unrolledStores[2] = "  str q0, [x2]";
                unrolledStores[3] = "  str q0, [x2]";
                UarchTestHelpers.GenerateArmAsmStructureTestFuncs(
                    sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, includePtrChasingLoads: false, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetArmDependentBranchTarget(this.Prefix));
            }
            else if (isa == IUarchTest.ISA.riscv)
            {
                string initInstrs = "  mv t6, x0\n  addi t6, t6, 16\n  vsetvli t5, t6, e32\n  vlw.v v0, (a1)";
                string postLoadInstrs = this.initialDependentBranch ? UarchTestHelpers.GetRiscvDependentBranch(this.Prefix) : string.Empty;
                postLoadInstrs += "\n  mv t6, a2";
                string[] unrolledStores = new string[1];
                unrolledStores[0] = "  vsw.v v0, (t6)\n  addi t6, t6, 64";
                UarchTestHelpers.GenerateRiscvAsmStructureTestFuncs(sb, this.Counts, this.Prefix, unrolledStores, unrolledStores, false,
                    initInstrs: initInstrs, postLoadInstrs1: postLoadInstrs, postLoadInstrs2: postLoadInstrs);
                if (this.initialDependentBranch) sb.AppendLine(UarchTestHelpers.GetRiscvDependentBranchTarget(this.Prefix));
            }
        }
    }
}
