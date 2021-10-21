.text

.global asm_read
.global avx512_read

asm_read:
  push %rsi
  push %rdi
  push %rbx
  push %r15
  push %r14
  mov $256, %r15 /* load in blocks of 256 bytes */
  sub $128, %rdx /* last iteration: rsi == rdx. rsi > rdx = break */
  mov %r9, %rsi  /* assume we're passed in an aligned start location O.o */
  xor %rbx, %rbx
  lea (%rcx,%rsi,4), %rdi
  mov %rdi, %r14
avx_asm_read_pass_loop:
  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  vmovaps 128(%rdi), %ymm0
  vmovaps 160(%rdi), %ymm1
  vmovaps 192(%rdi), %ymm2
  vmovaps 224(%rdi), %ymm3
  add $64, %rsi
  add %r15, %rdi
  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  vmovaps 128(%rdi), %ymm0
  vmovaps 160(%rdi), %ymm1
  vmovaps 192(%rdi), %ymm2
  vmovaps 224(%rdi), %ymm3
  add $64, %rsi
  add %r15, %rdi 
  cmp %rsi, %rdx
  jge asm_avx_test_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
asm_avx_test_iteration_count:
  cmp %rsi, %r9
  jnz avx_asm_read_pass_loop /* skip iteration decrement if we're not back to start */
  dec %r8
  jnz avx_asm_read_pass_loop
  pop %r14 
  pop %r15 
  pop %rbx 
  pop %rdi 
  pop %rsi 
  ret 

avx512_read:
  push %rsi
  push %rdi
  push %rbx
  push %r15
  push %r14
  mov $256, %r15 /* load in blocks of 256 bytes */
  sub $128, %rdx /* last iteration: rsi == rdx. rsi > rdx = break */
  mov %r9, %rsi  /* assume we're passed in an aligned start location O.o */
  xor %rbx, %rbx
  lea (%rcx,%rsi,4), %rdi
  mov %rdi, %r14
avx512_read_pass_loop:
  vmovaps (%rdi), %zmm0
  vmovaps 64(%rdi), %zmm1
  vmovaps 128(%rdi), %zmm2
  vmovaps 192(%rdi), %zmm3
  add $64, %rsi
  add %r15, %rdi
  vmovaps (%rdi), %zmm0
  vmovaps 64(%rdi), %zmm1
  vmovaps 128(%rdi), %zmm2
  vmovaps 192(%rdi), %zmm3
  add $64, %rsi
  add %r15, %rdi 
  cmp %rsi, %rdx
  jge avx512_test_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
avx512_test_iteration_count:
  cmp %rsi, %r9
  jnz avx512_read_pass_loop /* skip iteration decrement if we're not back to start */
  dec %r8
  jnz avx512_read_pass_loop
  pop %r14 
  pop %r15 
  pop %rbx 
  pop %rdi 
  pop %rsi 
  ret  
