using System.IO;
using System.Text;

namespace AsmGen
{
    public class BranchHistoryTest : IUarchTest
    {
        public string Prefix { get; private set; }

        public string Description { get; private set; }

        public string FunctionDefinitionParameters { get; private set; }

        public string GetFunctionCallParameters { get; private set; }

        public bool DivideTimeByCount { get; private set; }

        private int[] branchCounts;
        private int[] historyCounts;

        public BranchHistoryTest()
        {
            Prefix = "branchhist";
            Description = "Branch predictor pattern recognition";
            FunctionDefinitionParameters = "uint64_t iterations, uint32_t **arr, uint32_t arrLen";
            GetFunctionCallParameters = "structIterations";
            DivideTimeByCount = true;
            branchCounts = new int[] { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 };
            historyCounts = new int[] { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536,
              2048, 3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536 };
        }

        public bool SupportsIsa(IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.amd64) return true;
            if (isa == IUarchTest.ISA.aarch64) return true;
            if (isa == IUarchTest.ISA.mips64) return true;
            return false;
        }

        public void GenerateAsm(StringBuilder sb, IUarchTest.ISA isa)
        {
            if (isa == IUarchTest.ISA.aarch64) GenerateArmAsm(sb);
            if (isa == IUarchTest.ISA.amd64) GenerateX86GccAsm(sb);
            if (isa == IUarchTest.ISA.mips64) GenerateMipsAsm(sb);
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
            {
                string functionLabel = Prefix + branchCounts[i];
                string loopLabel = functionLabel + "_loop";
                sb.AppendLine("\n" + functionLabel + ":");
                sb.AppendLine("  sub sp, sp, #0x40");
                sb.AppendLine("  stp x11, x12, [sp, #0x30]");
                sb.AppendLine("  stp x15, x16, [sp, #0x20]");
                sb.AppendLine("  stp x13, x14, [sp, #0x10]");
                sb.AppendLine("  eor x16, x16, x16");
                sb.AppendLine("  eor x15, x15, x15");
                sb.AppendLine("  eor x12, x12, x12");
                sb.AppendLine("  eor x11, x11, x11");

                // w14 = branch index, w16 = pattern array index
                sb.AppendLine(loopLabel + ":");
                sb.AppendLine("  eor w14, w14, w14");

                // generate branch blocks
                for (int branchCount = 0; branchCount < branchCounts[i]; branchCount++)
                {
                    string jumpTarget = functionLabel + branchCounts[i] + "_zero" + branchCount;
                    sb.AppendLine("  ldr x15, [x1, w14, uxtw #3]");
                    sb.AppendLine("  add w14, w14, 1");
                    sb.AppendLine("  ldr w13, [x15, w16, uxtw #2]");
                    sb.AppendLine($"  cbnz x13, {jumpTarget}");
                    sb.AppendLine("  add x12, x12, 1");
                    sb.AppendLine(jumpTarget + ":");
                }

                // increment w16, and basically cmov 0 -> w16 if w16 = list length
                sb.AppendLine("  add w16, w16, 1");
                sb.AppendLine("  cmp w16, w2");
                sb.AppendLine("  csel w16, w11, w16, EQ");
                sb.AppendLine("  sub x0, x0, 1");
                sb.AppendLine($"  cbnz x0, {loopLabel}");
                sb.AppendLine("  mov x0, x12");
                sb.AppendLine("  ldp x11, x12, [sp, #0x30]");
                sb.AppendLine("  ldp x15, x16, [sp, #0x20]");
                sb.AppendLine("  ldp x13, x14, [sp, #0x10]");
                sb.AppendLine("  add sp, sp, #0x40");
                sb.AppendLine("  ret");
            }
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
            {
                string functionLabel = Prefix + branchCounts[i];
                sb.AppendLine("\n" + functionLabel + ":");
                sb.AppendLine("  push %rbx");
                sb.AppendLine("  push %r8");
                sb.AppendLine("  push %r9");
                sb.AppendLine("  xor %rbx, %rbx");
                sb.AppendLine("  xor %r8, %r8");
                sb.AppendLine("  xor %r9, %r9");

                string loopLabel = functionLabel + "_loop";
                sb.AppendLine("\n" + loopLabel + ":");
                sb.AppendLine("  xor %r11, %r11"); // set index into arr of arrs to 0
                for (int branchCount = 0; branchCount < branchCounts[i]; branchCount++)
                {
                    sb.AppendLine("  mov (%rsi,%r11,8), %r10");  // load array base pointer into r10
                    sb.AppendLine("  inc %r11");
                    sb.AppendLine("  mov (%r10,%rbx,4), %eax "); // read element from branch history test array
                    sb.AppendLine("  test %eax, %eax");

                    // conditional branch on test array value
                    string zeroLabel = Prefix + branchCounts[i] + "_zero" + branchCount;
                    sb.AppendLine("  jz " + zeroLabel);
                    sb.AppendLine("  inc %r8"); // r8 is just a sink here
                    sb.AppendLine(zeroLabel + ":");
                }

                // loop around in pattern history test array if necessary
                // avoiding an extra branch to not pollute BPU history
                sb.AppendLine("  inc %rbx");
                sb.AppendLine("  cmp %rbx, %rdx");
                sb.AppendLine("  cmove %r9, %rbx");

                // end of main loop over iteration count
                sb.AppendLine("  dec %rdi");
                sb.AppendLine("  jnz " + loopLabel);

                // function epilogue
                sb.AppendLine("  mov %r8, %rax");
                sb.AppendLine("  pop %r9");
                sb.AppendLine("  pop %r8");
                sb.AppendLine("  pop %rbx");
                sb.AppendLine("  ret");
            }
        }

        public void GenerateMipsAsm(StringBuilder sb)
        {
            // Generate an array of branch history test functions, one for each branch count
            for (int i = 0; i < branchCounts.Length; i++)
            {
                // branchtestFunc(iterations, testArrToArr, historyLen)
                // r4 = iterations, r5 = array of pointers to pattern arrays for each branch, r6 = history length (length of each array)
                // temporary registers: r12-r20

                // write code here
                string functionLabel = Prefix + branchCounts[i];
                sb.AppendLine("\n" + functionLabel + ":");

                // r12 = branch index, r13 = index into pattern array
                sb.AppendLine("  move $r13, $r0");
                sb.AppendLine("  move $r18, $r0");
                sb.AppendLine("  move $r20, $r0");
                sb.AppendLine("  addi.d $r20, $r20, 1");

                string loopLabel = functionLabel + "_loop";
                sb.AppendLine("\n" + loopLabel + ":");
                sb.AppendLine("  move $r12, $r0"); // set branch index to zero

                // generate branch blocks
                for (int branchCount = 0; branchCount < branchCounts[i]; branchCount++)
                {
                    string jumpTarget = functionLabel + branchCounts[i] + "_zero" + branchCount;

                    // load the branch's pattern array
                    sb.AppendLine("  alsl.d $r14, $r12, $r0, 0x3");    // get offset into array in bytes, using r12 as array index.
                    sb.AppendLine("  add.d $r14, $r14, $r5");          // get address into r14
                    sb.AppendLine("  ld.d $r15, $r14, 0");             // r15 = base address of curent branch's target array
                    sb.AppendLine("  addi.d $r12, $r12, 1");            // next branch

                    // load element from pattern array indicating where we should branch
                    sb.AppendLine("  alsl.d $r16, $r13, $r0, 0x2");    // use r13 to index into pattern array
                    sb.AppendLine("  add.d $r16, $r16, $r15");         // r16 = address of element we want to load
                    sb.AppendLine("  ld.w $r17, $r16, 0");
                    sb.AppendLine($"  bnez $r17, {jumpTarget}");       // branch if 1
                    sb.AppendLine("  addi.d $r18, $r18, 1");
                    sb.AppendLine(jumpTarget + ":");
                }

                // increment w16, and basically cmov 0 -> w16 if w16 = list length
                // increment r13 (idx into pattern array)
                sb.AppendLine("  addi.d $r13, $r13, 1");
                sb.AppendLine("  sub.d $r19, $r6, $r13");    // r19 = history length - index
                sb.AppendLine("  maskeqz $r13, $r13, $r19"); // set index back to 0 to repeat pattern, if history length - index == 0
                sb.AppendLine("  sub.d $r4, $r4, $r20");            // decrement iteration count
                sb.AppendLine($"  bnez $r4, {loopLabel}");
                sb.AppendLine("  move $r4, $r18"); // return the count of NT branches for tracking RNG quality

                sb.AppendLine("  jr $r1");
            }
        }

        public void GenerateTestBlock(StringBuilder sb, IUarchTest.ISA isa)
        {
            sb.AppendLine("  if (argc > 1 && strncmp(test_name, \"" + Prefix + "\", " + Prefix.Length + ") == 0) {");
            sb.AppendLine("    printf(\"" + Description + ":\\n\");");
            GenerateCommonTestBlock(sb);
            sb.AppendLine("  }\n");
        }

        public void GenerateAsmGlobalLines(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
                sb.AppendLine(".global " + Prefix + branchCounts[i]);
        }

        // kinda hack this to put in initialization code we need
        public void GenerateExternLines(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + Prefix + branchCounts[i] + $"({FunctionDefinitionParameters}) __attribute((sysv_abi));");

            GenerateInitializationCode(sb, true);

            string gccFunction = File.ReadAllText($"{Program.DataFilesDir}\\GccBranchHistFunction.c");
            sb.AppendLine(gccFunction);
        }

        public void GenerateInitializationCode(StringBuilder sb, bool gcc)
        {
            sb.AppendLine($"uint32_t maxBranchCount = {branchCounts.Length};");
            sb.Append($"uint32_t branchCounts[{branchCounts.Length}] = ");
            sb.Append("{  " + branchCounts[0]);
            for (int i = 1; i < branchCounts.Length; i++) sb.Append(", " + branchCounts[i]);
            sb.AppendLine(" };");
            sb.Append($"uint32_t branchHistoryLengths[{historyCounts.Length}] = ");
            sb.Append("{  " + historyCounts[0]);
            for (int i = 1; i < historyCounts.Length; i++) sb.Append(", " + historyCounts[i]);
            sb.AppendLine(" };");

            if (gcc) sb.AppendLine($"uint64_t (__attribute((sysv_abi)) *branchtestFuncArr[{branchCounts.Length}])(uint64_t iterations, uint32_t **arr, uint32_t arrLen);");
            else sb.AppendLine($"uint64_t (*branchtestFuncArr[{branchCounts.Length}])(uint64_t iterations, uint32_t **arr, uint32_t arrLen);");

            sb.AppendLine("void initializeBranchHistFuncArr() {");
            for (int i = 0; i < branchCounts.Length; i++)
            {
                sb.AppendLine($"  branchtestFuncArr[{i}] = {Prefix + branchCounts[i]};");
            }

            sb.AppendLine("}");
        }

        public void GenerateCommonTestBlock(StringBuilder sb)
        {
            string branchhistMain = File.ReadAllText($"{Program.DataFilesDir}\\BranchhistTestBlock.c");
            sb.AppendLine(branchhistMain);
        }
    }
}
