.text

.global asm_read
.global asm_write
.global sse_read
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

asm_write:
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
  vmovaps (%rcx), %ymm0
avx_asm_write_pass_loop:
  vmovaps %ymm0, (%rdi)
  vmovaps %ymm0, 32(%rdi)
  vmovaps %ymm0, 64(%rdi)
  vmovaps %ymm0, 96(%rdi)
  vmovaps %ymm0, 128(%rdi)
  vmovaps %ymm0, 160(%rdi)
  vmovaps %ymm0, 192(%rdi)
  vmovaps %ymm0, 224(%rdi)
  add $64, %rsi
  add %r15, %rdi
  vmovaps %ymm0, (%rdi)
  vmovaps %ymm0, 32(%rdi)
  vmovaps %ymm0, 64(%rdi)
  vmovaps %ymm0, 96(%rdi)
  vmovaps %ymm0, 128(%rdi)
  vmovaps %ymm0, 160(%rdi)
  vmovaps %ymm0, 192(%rdi)
  vmovaps %ymm0, 224(%rdi) 
  add $64, %rsi
  add %r15, %rdi 
  cmp %rsi, %rdx
  jge asm_avx_write_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
asm_avx_write_iteration_count:
  cmp %rsi, %r9
  jnz avx_asm_write_pass_loop /* skip iteration decrement if we're not back to start */
  dec %r8
  jnz avx_asm_write_pass_loop
  pop %r14 
  pop %r15 
  pop %rbx 
  pop %rdi 
  pop %rsi 
  ret  

sse_read:
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
sse_read_pass_loop:
  movaps (%rdi), %xmm0
  movaps 16(%rdi), %xmm1
  movaps 32(%rdi), %xmm2
  movaps 48(%rdi), %xmm3
  movaps 64(%rdi), %xmm0
  movaps 80(%rdi), %xmm1
  movaps 96(%rdi), %xmm2
  movaps 112(%rdi), %xmm3
  movaps 128(%rdi), %xmm0
  movaps 144(%rdi), %xmm1
  movaps 160(%rdi), %xmm2
  movaps 176(%rdi), %xmm3
  movaps 192(%rdi), %xmm0
  movaps 208(%rdi), %xmm1
  movaps 224(%rdi), %xmm2
  movaps 240(%rdi), %xmm3
  add $64, %rsi
  add %r15, %rdi
  movaps (%rdi), %xmm0
  movaps 16(%rdi), %xmm1
  movaps 32(%rdi), %xmm2
  movaps 48(%rdi), %xmm3
  movaps 64(%rdi), %xmm0
  movaps 80(%rdi), %xmm1
  movaps 96(%rdi), %xmm2
  movaps 112(%rdi), %xmm3
  movaps 128(%rdi), %xmm0
  movaps 144(%rdi), %xmm1
  movaps 160(%rdi), %xmm2
  movaps 176(%rdi), %xmm3
  movaps 192(%rdi), %xmm0
  movaps 208(%rdi), %xmm1
  movaps 224(%rdi), %xmm2
  movaps 240(%rdi), %xmm3
  add $64, %rsi
  add %r15, %rdi  
  cmp %rsi, %rdx
  jge sse_test_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
sse_test_iteration_count:
  cmp %rsi, %r9
  jnz sse_read_pass_loop /* skip iteration decrement if we're not back to start */
  dec %r8
  jnz sse_read_pass_loop
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
