using System.Text;

namespace AsmGen
{
    public class VecStoreDataNsqTest : UarchTest
    {
        public VecStoreDataNsqTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "vecstoredatansq";
            this.Description = "Store 128-bit Data Scheduler Capacity Test, Excluding NSQ";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string initInstrs = "  cvtsi2ss %r11, %xmm3\n movss %xmm3, %xmm4\n  movss %xmm3, %xmm5\n  movss %xmm3, %xmm6";
            string postLoadInstr = "  movups (%rdx, %rdi, 2), %xmm1";
            string[] dependentStores = new string[4];
            dependentStores[0] = "  movups %xmm1, (%r8)";
            dependentStores[1] = "  movups %xmm1, (%r8, %r14, 8)";
            dependentStores[2] = "  movups %xmm1, (%r8, %r13, 8)";
            dependentStores[3] = "  movups %xmm1, (%r8, %r12, 8)";

            string[] indepFpInstrs = new string[4];
            indepFpInstrs[0] = "  addss %xmm2, %xmm3";
            indepFpInstrs[1] = "  addss %xmm2, %xmm4";
            indepFpInstrs[2] = "  addss %xmm2, %xmm5";
            indepFpInstrs[3] = "  addss %xmm2, %xmm6";

            UarchTestHelpers.GenerateX86AsmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, indepFpInstrs, false, initInstrs, postLoadInstr);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vpcmpeqd xmm1, xmm1, xmm1\n  vpxor xmm0, xmm0, xmm1";
            string postLoadInstr = "  cvtsi2ss xmm0, rdi";
            string[] dependentStores = new string[4];
            dependentStores[0] = "  movups [r8], xmm0";
            dependentStores[1] = "  movups [r8 + r14 * 8], xmm0";
            dependentStores[2] = "  movups [r8 + r13 * 8], xmm0";
            dependentStores[3] = "  movups [r8 + r12 * 8], xmm0";

            string[] indepStores = new string[4];
            indepStores[0] = "  movups [r8], xmm1";
            indepStores[1] = "  movups [r8 + 16], xmm1";
            indepStores[2] = "  movups [r8 + 32], xmm1";
            indepStores[3] = "  movups [r8 + 48], xmm1";

            UarchTestHelpers.GenerateX86NasmNsqTestFuncs(sb, this.Counts[this.Counts.Length - 1], this.Counts, this.Prefix, dependentStores, indepStores, false, initInstrs, postLoadInstr);
        }

        public override void GenerateArmAsm(StringBuilder sb)
        {
            // todo
            string[] dependentStores = new string[4];
            dependentStores[0] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[1] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[2] = "  str w15, [x2, w25, uxtw #2]";
            dependentStores[3] = "  str w15, [x2, w25, uxtw #2]";

            string[] dependentStores1 = new string[4];
            dependentStores1[0] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[1] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[2] = "  str w15, [x2, w26, uxtw #2]";
            dependentStores1[3] = "  str w15, [x2, w26, uxtw #2]";
            UarchTestHelpers.GenerateArmAsmDivStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores1, false);
        }
    }
}
