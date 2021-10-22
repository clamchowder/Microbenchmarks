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
                    sb.AppendLine("  inc %r8");
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

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
            {
                string functionLabel = Prefix + branchCounts[i];
                sb.AppendLine("\n" + functionLabel + ":");
                sb.AppendLine("  push rbx");
                sb.AppendLine("  push rsi");
                sb.AppendLine("  push r11");
                sb.AppendLine("  push r10");
                sb.AppendLine("  push r9");
                sb.AppendLine("  xor rbx, rbx");
                sb.AppendLine("  xor r10, r10");
                sb.AppendLine("  xor r9, r9");

                string loopLabel = Prefix + branchCounts[i] + "_loop";
                sb.AppendLine("\n" + loopLabel + ":");
                sb.AppendLine("  xor r11, r11"); // set index into arr of arrs to 0 (branch index)
                for (int branchCount = 0; branchCount < branchCounts[i]; branchCount++)
                {
                    sb.AppendLine("  mov r10, [rdx + r11 * 8]");  // load array base pointer into r10
                    sb.AppendLine("  inc r11");
                    sb.AppendLine("  mov eax, [r10 + rbx * 4]"); // read element from branch history test array
                    sb.AppendLine("  test eax, eax");

                    // conditional branch on test array value
                    string zeroLabel = Prefix + branchCounts[i] + "_zero" + branchCount;
                    sb.AppendLine("  jz " + zeroLabel);
                    sb.AppendLine("  inc rsi");
                    sb.AppendLine(zeroLabel + ":");
                }

                // loop around in pattern history test array if necessary
                // avoiding an extra branch to not pollute BPU history
                sb.AppendLine("  inc rbx");
                sb.AppendLine("  cmp rbx, r8"); // rdx = array length
                sb.AppendLine("  cmove rbx, r9"); // set rbx (array index) to r9 = 0 if equal

                // end of main loop over iteration count
                sb.AppendLine("  dec rcx");
                sb.AppendLine("  jnz " + loopLabel);

                // function epilogue
                sb.AppendLine("  mov rax, rsi");
                sb.AppendLine("  pop r9");
                sb.AppendLine("  pop r10");
                sb.AppendLine("  pop r11");
                sb.AppendLine("  pop rsi");
                sb.AppendLine("  pop rbx");
                sb.AppendLine("  ret");
            }
        }

        public void GenerateTestBlock(StringBuilder sb)
        {
            sb.AppendLine("  if (argc > 1 && strncmp(argv[1], \"" + Prefix + "\", " + Prefix.Length + ") == 0) {");
            sb.AppendLine("    printf(\"" + Description + ":\\n\");");
            GenerateCommonTestBlock(sb);
            sb.AppendLine("  }\n");
        }

        public void GenerateVsTestBlock(StringBuilder sb)
        {
            sb.AppendLine("  if (argc > 1 && _strnicmp(argv[1], \"" + Prefix + "\", " + Prefix.Length + ") == 0) {");
            sb.AppendLine("  printf(\"" + Description + ":\\n\");");
            GenerateCommonTestBlock(sb);
            sb.AppendLine("  }\n");
        }

        public void GenerateAsmGlobalLines(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
                sb.AppendLine(".global " + Prefix + branchCounts[i]);
        }

        public void GenerateNasmGlobalLines(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
                sb.AppendLine("global " + Prefix + branchCounts[i]);
        }

        // kinda hack this to put in initialization code we need
        public void GenerateExternLines(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
                sb.AppendLine("extern uint64_t " + Prefix + branchCounts[i] + $"({FunctionDefinitionParameters}) __attribute((sysv_abi));");

            GenerateInitializationCode(sb);

            string gccFunction = File.ReadAllText($"{Program.DataFilesDir}\\GccBranchHistFunction.c");
            sb.AppendLine(gccFunction);
        }

        public void GenerateVsExternLines(StringBuilder sb)
        {
            for (int i = 0; i < branchCounts.Length; i++)
                sb.AppendLine("extern \"C\" uint64_t " + Prefix + branchCounts[i] + $"({FunctionDefinitionParameters});");

            GenerateInitializationCode(sb);

            string vsFunction = File.ReadAllText($"{Program.DataFilesDir}\\VsBranchHistFunction.c");
            sb.AppendLine(vsFunction);
        }

        public void GenerateInitializationCode(StringBuilder sb)
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

            sb.AppendLine($"uint64_t (__attribute((sysv_abi)) *branchtestFuncArr[{branchCounts.Length}])(uint64_t iterations, uint32_t **arr, uint32_t arrLen);");

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
