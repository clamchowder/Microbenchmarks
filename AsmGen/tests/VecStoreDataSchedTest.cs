using System.Text;

namespace AsmGen
{
    public class VecStoreDataSchedTest : UarchTest
    {
        public VecStoreDataSchedTest(int low, int high, int step)
        {
            this.Counts = UarchTestHelpers.GenerateCountArray(low, high, step);
            this.Prefix = "vecstoredatasched";
            this.Description = "Store 128-bit Data Scheduler Capacity Test";
            this.FunctionDefinitionParameters = "uint64_t iterations, int *arr, int *arr1";
            this.GetFunctionCallParameters = "structIterations, A, B";
            this.DivideTimeByCount = false;
        }

        public override void GenerateX86GccAsm(StringBuilder sb)
        {
            string postLoadInstr1 = "  movups (%rdx, %rdi, 2), %xmm1";
            string postLoadInstr2 = "  movups (%rdx, %rsi, 2), %xmm1";
            string[] dependentStores = new string[4];
            dependentStores[0] = "  movups %xmm1, (%r8)";
            dependentStores[1] = "  movups %xmm1, (%r8, %r14, 8)";
            dependentStores[2] = "  movups %xmm1, (%r8, %r13, 8)";
            dependentStores[3] = "  movups %xmm1, (%r8, %r12, 8)";

            UarchTestHelpers.GenerateX86AsmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores, false, postLoadInstrs1: postLoadInstr1, postLoadInstrs2: postLoadInstr2);
        }

        public override void GenerateX86NasmAsm(StringBuilder sb)
        {
            string initInstrs = "  vpcmpeqd xmm1, xmm1, xmm1\n  vpxor xmm0, xmm0, xmm1";
            string postLoadInstr1 = "  cvtsi2ss xmm0, rdi";
            string postLoadInstr2 = "  cvtsi2ss xmm0, rsi";
            string[] dependentStores = new string[4];
            dependentStores[0] = "  movups [r8], xmm0";
            dependentStores[1] = "  movups [r8 + r14 * 8], xmm0";
            dependentStores[2] = "  movups [r8 + r13 * 8], xmm0";
            dependentStores[3] = "  movups [r8 + r12 * 8], xmm0";

            UarchTestHelpers.GenerateX86NasmStructureTestFuncs(sb, this.Counts, this.Prefix, dependentStores, dependentStores, false, initInstrs, postLoadInstr1, postLoadInstr2);
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
