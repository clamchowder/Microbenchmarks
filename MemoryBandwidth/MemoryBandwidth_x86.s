.text

.global asm_read

/* rdi = ptr to array (was rcx)
 * rsi = arr length (was rdx)
 * rdx = iterations (was r8)
 * rcx = start (was r9)
 */
asm_read:
  push %rbx
  push %r8
  push %r9
  mov %rcx, %r9
  mov %rdx, %r8
  mov %rdi, %rcx
  mov %rsi, %rdx
  sub $128, %rdx /* last iteration: rsi == rdx. rsi > rdx = break */
  mov %r9, %rsi  /* assume we're passed in an aligned start location O.o */
  xor %rbx, %rbx
avx_asm_read_pass_loop:
  lea (%rcx,%rsi,4), %rdi
  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  add $32, %rsi
  lea (%rcx,%rsi,4), %rdi
  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  add $32, %rsi
  lea (%rcx,%rsi,4), %rdi
  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  add $32, %rsi
  lea (%rcx,%rsi,4), %rdi
  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  add $32, %rsi
  cmp %rsi, %rdx
  cmovl %rbx, %rsi /* if rdx - 128 < rsi, loop back around */
  cmp %rsi, %r9
  jnz avx_asm_read_pass_loop /* skip iteration decrement if we're not back to start */
  dec %r8
  jnz avx_asm_read_pass_loop
  pop %r9
  pop %r8
  pop %rbx
  ret
