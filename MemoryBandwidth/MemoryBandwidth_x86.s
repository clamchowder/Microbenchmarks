.text

.global asm_read
.global asm_write
.global asm_copy
.global asm_cflip
.global asm_add
.global sse_read
.global sse_write
.global sse_ntwrite
.global avx512_read
.global avx512_write
.global avx512_copy
.global avx512_add
.global readbankconflict
.global readbankconflict128

.global repstosd_write
.global repstosb_write
.global repmovsb_copy
.global repmovsd_copy

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

/* rcx = ptr to arr
   rdx = arr_length
   r8 = iterations */
asm_copy:
  push %rsi
  push %rdi
  push %rbx
  push %r15
  push %r14
  push %r13
  xor %rsi, %rsi
  mov %rdx, %r9
  shr $1, %r9    /* start destination at array + length / 2 */
  mov $256, %r15 /* load in blocks of 128 bytes */
  mov %r9, %r13
  sub $64, %r13 /* place loop limit 256B before end */
  lea (%rcx,%rsi,4), %rdi
  lea (%rcx,%r9,4), %r14
avx_asm_copy_pass_loop:

  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  vmovaps 128(%rdi), %ymm4
  vmovaps 160(%rdi), %ymm5
  vmovaps 192(%rdi), %ymm6
  vmovaps 224(%rdi), %ymm7
  vmovaps %ymm0, (%r14)
  vmovaps %ymm1, 32(%r14)
  vmovaps %ymm2, 64(%r14)
  vmovaps %ymm3, 96(%r14)
  vmovaps %ymm4, 128(%r14)
  vmovaps %ymm5, 160(%r14)
  vmovaps %ymm6, 192(%r14)
  vmovaps %ymm7, 224(%r14)
  add $64, %rsi
  add %r15, %rdi  /* increment src/dst pointers */
  add %r15, %r14
  cmp %rsi, %r13   /* end location is at half */
  jge avx_asm_copy_pass_loop
  xor %rsi, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
  lea (%rcx,%r9,4), %r14
  dec %r8                 /* decrement iteration counter */
  jnz avx_asm_copy_pass_loop
  pop %r13
  pop %r14
  pop %r15
  pop %rbx
  pop %rdi
  pop %rsi
  ret


asm_cflip:
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
avx_asm_cflip_pass_loop:

  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  vmovaps %ymm0, 96(%rdi)
  vmovaps %ymm1, 64(%rdi)
  vmovaps %ymm2, 32(%rdi)
  vmovaps %ymm3, (%rdi)
  vmovaps 128(%rdi), %ymm0
  vmovaps 160(%rdi), %ymm1
  vmovaps 192(%rdi), %ymm2
  vmovaps 224(%rdi), %ymm3
  vmovaps %ymm0, 224(%rdi)
  vmovaps %ymm1, 192(%rdi)
  vmovaps %ymm2, 160(%rdi)
  vmovaps %ymm3, 128(%rdi)
  add $64, %rsi
  add %r15, %rdi
  vmovaps (%rdi), %ymm0
  vmovaps 32(%rdi), %ymm1
  vmovaps 64(%rdi), %ymm2
  vmovaps 96(%rdi), %ymm3
  vmovaps %ymm0, 96(%rdi)
  vmovaps %ymm1, 64(%rdi)
  vmovaps %ymm2, 32(%rdi)
  vmovaps %ymm3, (%rdi)
  vmovaps 128(%rdi), %ymm0
  vmovaps 160(%rdi), %ymm1
  vmovaps 192(%rdi), %ymm2
  vmovaps 224(%rdi), %ymm3
  vmovaps %ymm0, 224(%rdi)
  vmovaps %ymm1, 192(%rdi)
  vmovaps %ymm2, 160(%rdi)
  vmovaps %ymm3, 128(%rdi)
  add $64, %rsi
  add %r15, %rdi
  cmp %rsi, %rdx
  jge asm_avx_cflip_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
asm_avx_cflip_iteration_count:
  cmp %rsi, %r9
  jnz avx_asm_cflip_pass_loop /* skip iteration decrement if we're not back to start */
  sub $2, %r8  /* each iteration counts as two (hitting each element twice) */
  jnz avx_asm_cflip_pass_loop
  pop %r14
  pop %r15
  pop %rbx
  pop %rdi
  pop %rsi
  ret

asm_add:
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
  vmovaps (%rdi), %ymm4
avx_asm_add_pass_loop:
  vaddps (%rdi), %ymm4, %ymm0
  vaddps 32(%rdi), %ymm4, %ymm1
  vaddps 64(%rdi), %ymm4, %ymm2
  vaddps 96(%rdi), %ymm4, %ymm3
  vmovaps %ymm0, (%rdi)
  vmovaps %ymm1, 32(%rdi)
  vmovaps %ymm2, 64(%rdi)
  vmovaps %ymm3, 96(%rdi)
  vaddps 128(%rdi), %ymm4, %ymm0
  vaddps 160(%rdi), %ymm4, %ymm1
  vaddps 192(%rdi), %ymm4, %ymm2
  vaddps 224(%rdi), %ymm4, %ymm3
  vmovaps %ymm0, 128(%rdi)
  vmovaps %ymm1, 160(%rdi)
  vmovaps %ymm2, 192(%rdi)
  vmovaps %ymm3, 224(%rdi)
  add $64, %rsi
  add %r15, %rdi
  vaddps (%rdi), %ymm4, %ymm0
  vaddps 32(%rdi), %ymm4, %ymm1
  vaddps 64(%rdi), %ymm4, %ymm2
  vaddps 96(%rdi), %ymm4, %ymm3
  vmovaps %ymm0, (%rdi)
  vmovaps %ymm1, 32(%rdi)
  vmovaps %ymm2, 64(%rdi)
  vmovaps %ymm3, 96(%rdi)
  vaddps 128(%rdi), %ymm4, %ymm0
  vaddps 160(%rdi), %ymm4, %ymm1
  vaddps 192(%rdi), %ymm4, %ymm2
  vaddps 224(%rdi), %ymm4, %ymm3
  vmovaps %ymm0, 128(%rdi)
  vmovaps %ymm1, 160(%rdi)
  vmovaps %ymm2, 192(%rdi)
  vmovaps %ymm3, 224(%rdi)
  add $64, %rsi
  add %r15, %rdi
  cmp %rsi, %rdx
  jge asm_avx_add_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
asm_avx_add_iteration_count:
  cmp %rsi, %r9
  jnz avx_asm_add_pass_loop /* skip iteration decrement if we're not back to start */
  sub $2, %r8
  jg avx_asm_add_pass_loop
  pop %r14
  pop %r15
  pop %rbx
  pop %rdi
  pop %rsi
  movss (%rdi), %xmm0
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

sse_write:
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
  movaps (%rdi), %xmm0
  movaps 16(%rdi), %xmm1
  movaps 32(%rdi), %xmm2
  movaps 48(%rdi), %xmm3
sse_write_pass_loop:

  movaps %xmm0, (%rdi)
  movaps %xmm1, 16(%rdi)
  movaps %xmm2, 32(%rdi)
  movaps %xmm3, 48(%rdi)
  movaps %xmm0, 64(%rdi)
  movaps %xmm1, 80(%rdi)
  movaps %xmm2, 96(%rdi)
  movaps %xmm3, 112(%rdi)
  movaps %xmm0, 128(%rdi)
  movaps %xmm1, 144(%rdi)
  movaps %xmm2, 160(%rdi)
  movaps %xmm3, 176(%rdi)
  movaps %xmm0, 192(%rdi)
  movaps %xmm1, 208(%rdi)
  movaps %xmm2, 224(%rdi)
  movaps %xmm3, 240(%rdi)
  add $64, %rsi
  add %r15, %rdi
  movaps %xmm0, (%rdi)
  movaps %xmm1, 16(%rdi)
  movaps %xmm2, 32(%rdi)
  movaps %xmm3, 48(%rdi)
  movaps %xmm0, 64(%rdi)
  movaps %xmm1, 80(%rdi)
  movaps %xmm2, 96(%rdi)
  movaps %xmm3, 112(%rdi)
  movaps %xmm0, 128(%rdi)
  movaps %xmm1, 144(%rdi)
  movaps %xmm2, 160(%rdi)
  movaps %xmm3, 176(%rdi)
  movaps %xmm0, 192(%rdi)
  movaps %xmm1, 208(%rdi)
  movaps %xmm2, 224(%rdi)
  movaps %xmm3, 240(%rdi)
  add $64, %rsi
  add %r15, %rdi
  cmp %rsi, %rdx
  jge sse_write_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
sse_write_iteration_count:

  cmp %rsi, %r9
  jnz sse_write_pass_loop /* skip iteration decrement if we're not back to start */
  dec %r8
  jnz sse_write_pass_loop
  movaps (%rcx), %xmm0
  pop %r14
  pop %r15
  pop %rbx
  pop %rdi
  pop %rsi
  ret

sse_ntwrite:
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
  movaps (%rdi), %xmm0
  movaps 16(%rdi), %xmm1
  movaps 32(%rdi), %xmm2
  movaps 48(%rdi), %xmm3
sse_ntwrite_pass_loop:
  movntps %xmm0, (%rdi)
  movntps %xmm1, 16(%rdi)
  movntps %xmm2, 32(%rdi)
  movntps %xmm3, 48(%rdi)
  movntps %xmm0, 64(%rdi)
  movntps %xmm1, 80(%rdi)
  movntps %xmm2, 96(%rdi)
  movntps %xmm3, 112(%rdi)
  movntps %xmm0, 128(%rdi)
  movntps %xmm1, 144(%rdi)
  movntps %xmm2, 160(%rdi)
  movntps %xmm3, 176(%rdi)
  movntps %xmm0, 192(%rdi)
  movntps %xmm1, 208(%rdi)
  movntps %xmm2, 224(%rdi)
  movntps %xmm3, 240(%rdi)
  add $64, %rsi
  add %r15, %rdi
  movntps %xmm0, (%rdi)
  movntps %xmm1, 16(%rdi)
  movntps %xmm2, 32(%rdi)
  movntps %xmm3, 48(%rdi)
  movntps %xmm0, 64(%rdi)
  movntps %xmm1, 80(%rdi)
  movntps %xmm2, 96(%rdi)
  movntps %xmm3, 112(%rdi)
  movntps %xmm0, 128(%rdi)
  movntps %xmm1, 144(%rdi)
  movntps %xmm2, 160(%rdi)
  movntps %xmm3, 176(%rdi)
  movntps %xmm0, 192(%rdi)
  movntps %xmm1, 208(%rdi)
  movntps %xmm2, 224(%rdi)
  movntps %xmm3, 240(%rdi)
  add $64, %rsi
  add %r15, %rdi
  cmp %rsi, %rdx
  jge sse_ntwrite_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
sse_ntwrite_iteration_count:

  cmp %rsi, %r9
  jnz sse_ntwrite_pass_loop /* skip iteration decrement if we're not back to start */
  dec %r8
  jnz sse_ntwrite_pass_loop
  movaps (%rcx), %xmm0
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

avx512_write:
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
  vmovaps (%rdi), %zmm0
avx512_write_pass_loop:
  vmovaps %zmm0, (%rdi)
  vmovaps %zmm1, 64(%rdi)
  vmovaps %zmm2, 128(%rdi)
  vmovaps %zmm3, 192(%rdi)
  add $64, %rsi
  add %r15, %rdi
  vmovaps %zmm0, (%rdi)
  vmovaps %zmm1, 64(%rdi)
  vmovaps %zmm2, 128(%rdi)
  vmovaps %zmm3, 192(%rdi)
  add $64, %rsi
  add %r15, %rdi
  cmp %rsi, %rdx
  jge avx512_write_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
avx512_write_iteration_count:

  cmp %rsi, %r9
  jnz avx512_write_pass_loop /* skip iteration decrement if we're not back to start */
  dec %r8
  jnz avx512_write_pass_loop
  pop %r14
  pop %r15
  pop %rbx
  pop %rdi
  pop %rsi
  ret

/* rcx = ptr to arr
   rdx = arr_length
   r8 = iterations */
avx512_copy:
  push %rsi
  push %rdi
  push %rbx
  push %r15
  push %r14
  push %r13
  xor %rsi, %rsi
  mov %rdx, %r9
  shr $1, %r9    /* start destination at array + length / 2 */
  mov $256, %r15 /* load in blocks of 128 bytes */
  mov %r9, %r13
  sub $128, %r13 /* place loop limit 512B before end */
  lea (%rcx,%rsi,4), %rdi
  lea (%rcx,%r9,4), %r14
avx512_copy_pass_loop:

  vmovaps (%rdi), %zmm0
  vmovaps 64(%rdi), %zmm1
  vmovaps 128(%rdi), %zmm2
  vmovaps 192(%rdi), %zmm3
  vmovaps 256(%rdi), %zmm4
  vmovaps 320(%rdi), %zmm5
  vmovaps 384(%rdi), %zmm6
  vmovaps 448(%rdi), %zmm7
  vmovaps %zmm0, (%r14)
  vmovaps %zmm1, 64(%r14)
  vmovaps %zmm2, 128(%r14)
  vmovaps %zmm3, 192(%r14)
  vmovaps %zmm4, 256(%r14)
  vmovaps %zmm5, 320(%r14)
  vmovaps %zmm6, 384(%r14)
  vmovaps %zmm7, 448(%r14)
  add $128, %rsi
  add %r15, %rdi  /* increment src/dst pointers */
  add %r15, %r14
  cmp %rsi, %r13   /* end location is at half */
  jge avx512_copy_pass_loop
  xor %rsi, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
  lea (%rcx,%r9,4), %r14
  dec %r8                 /* decrement iteration counter */
  jnz avx512_copy_pass_loop
  pop %r13
  pop %r14
  pop %r15
  pop %rbx
  pop %rdi
  pop %rsi
  ret

avx512_add:
  push %rsi
  push %rdi
  push %rbx
  push %r15
  push %r14
  mov $512, %r15 /* load in blocks of 512 bytes */
  sub $128, %rdx /* last iteration: rsi == rdx. rsi > rdx = break */
  mov %r9, %rsi  /* assume we're passed in an aligned start location O.o */
  xor %rbx, %rbx
  lea (%rcx,%rsi,4), %rdi
  mov %rdi, %r14
  vmovaps (%rcx), %zmm4
avx512_add_pass_loop:
  vaddps (%rdi), %zmm4, %zmm0
  vaddps 64(%rdi), %zmm4, %zmm1
  vaddps 128(%rdi), %zmm4, %zmm2
  vaddps 192(%rdi), %zmm4, %zmm3
  vmovaps %zmm0, (%rdi)
  vmovaps %zmm1, 64(%rdi)
  vmovaps %zmm2, 128(%rdi)
  vmovaps %zmm3, 192(%rdi)
  vaddps 256(%rdi), %zmm4, %zmm0
  vaddps 320(%rdi), %zmm4, %zmm1
  vaddps 384(%rdi), %zmm4, %zmm2
  vaddps 448(%rdi), %zmm4, %zmm3
  vmovaps %zmm0, 256(%rdi)
  vmovaps %zmm1, 320(%rdi)
  vmovaps %zmm2, 384(%rdi)
  vmovaps %zmm3, 448(%rdi)
  add $128, %rsi
  add %r15, %rdi
  cmp %rsi, %rdx
  jge avx512_add_iteration_count
  mov %rbx, %rsi
  lea (%rcx,%rsi,4), %rdi /* back to start */
avx512_add_iteration_count:

  cmp %rsi, %r9
  jnz avx512_add_pass_loop /* skip iteration decrement if we're not back to start */
  sub $2, %r8
  jg avx512_add_pass_loop
  pop %r14
  pop %r15
  pop %rbx
  pop %rdi
  pop %rsi
  movss (%rcx), %xmm0
  ret

/* rcx = ptr to arr, rdx = nr of fp32 elements in arr, r8 = iteration count */
repmovsb_copy:
  push %r15
  push %r14
  push %r13
  push %r12
  push %rsi
  push %rdi
  cld
  mov %rcx, %rsi  /* set source */
  shr $1, %rdx    /* point destination to second half of array, or rcx + (rdx / 2) */
  mov %rcx, %rdi
  add %rdx, %rdi
  mov %rdx, %rcx  /* rcx = count. set to (size / 2) * (4 bytes per FP32 element) */
  shl $2, %rcx
  mov %rsi, %r12
  mov %rdi, %r13
  mov %rcx, %r14
repmovsb_copy_pass_loop:
  mov %r12, %rsi
  mov %r13, %rdi
  mov %r14, %rcx
  rep movsb
  dec %r8
  jnz repmovsb_copy_pass_loop
  movss (%r12), %xmm0
  pop %rdi
  pop %rsi
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  ret


repmovsd_copy:
  push %r15
  push %r14
  push %r13
  push %r12
  push %rsi
  push %rdi
  cld
  mov %rcx, %rsi  /* set source */
  shr $1, %rdx    /* point destination to second half of array, or rcx + (rdx / 2) */
  mov %rcx, %rdi
  add %rdx, %rdi
  mov %rdx, %rcx  /* rcx = count. set to (size / 2) */
  mov %rsi, %r12
  mov %rdi, %r13
  mov %rcx, %r14
repmovsd_copy_pass_loop:
  mov %r12, %rsi
  mov %r13, %rdi
  mov %r14, %rcx
  rep movsd
  dec %r8
  jnz repmovsd_copy_pass_loop
  movss (%r12), %xmm0
  pop %rdi
  pop %rsi
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  ret 

repstosb_write:
  push %r15
  push %r14
  push %r13
  push %r12
  push %rsi
  push %rdi
  cld
  mov $1, %al     /* set source (1) */
  mov %rcx, %r13  /* save destination into r13 */
  mov %rdx, %r14  /* save count into r14 */
  shl $2, %r14    /* multiply count by 4 because count is in FP32 elements and stosb works with bytes */
repstosb_copy_pass_loop:
  mov %r13, %rdi
  mov %r14, %rcx
  rep stosb
  dec %r8
  jnz repstosb_copy_pass_loop
  movss (%r12), %xmm0
  pop %rdi
  pop %rsi
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  ret  

repstosd_write:
  push %r15
  push %r14
  push %r13
  push %r12
  push %rsi
  push %rdi
  cld
  mov $1, %al     /* set source (1) */
  mov %rcx, %r13  /* save destination into r13 */
  mov %rdx, %r14  /* save count into r14 */
repstosd_copy_pass_loop:
  mov %r13, %rdi
  mov %r14, %rcx
  rep stosl
  dec %r8
  jnz repstosd_copy_pass_loop
  movss (%r12), %xmm0
  pop %rdi
  pop %rsi
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  ret   


/* Tests for cache bank conflicts by reading from two locations, spaced by some
   number of bytes
   rcx = ptr to array. first 32-bit int = increment step, because I'm too lazy to mess with the stack
   rdx = array length, in bytes
   r8 = load spacing, in bytes
   r9 = iter count (number of loads to execute) */
readbankconflict:
   push %rbx
   push %rdi
   push %rsi
   push %r10
   push %r11
   push %r12
   mov $1, %rax
   cmp %r8, %rdx  /* basic check - subtract load spacing from array len */
   jle readbankconflict_end /* exit immediately if we don't have enough space to iterate */
   xor %rax, %rax
   mov %rcx, %rdi
   mov %rcx, %rsi
   mov %rcx, %r12
   add %rdx, %r12  /* set end location */
   sub $10, %r12   /* we're reading 10B ahead */
   add %r8, %rsi   /* rdi = first load location, rsi = second load location */
   mov (%rcx), %rbx  /* rbx = increment */
readbankconflict_loop:
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   mov (%rdi), %r10
   mov (%rsi), %r11
   sub $20, %r9
   jl readbankconflict_end
   cmp %rsi, %r12  /* subtract leading location from end location */
   jg readbankconflict_loop /* if positive or equal, continue loop */
   mov %rcx, %rdi  /* reset to start */
   mov %rcx, %rsi
   add %r8, %rsi
   jmp readbankconflict_loop
readbankconflict_end:
   pop %r12
   pop %r11
   pop %r10
   pop %rsi
   pop %rdi
   pop %rbx
   ret

readbankconflict128:
   push %rbx
   push %rdi
   push %rsi
   push %r10
   push %r11
   push %r12
   mov $1, %rax
   cmp %r8, %rdx  /* basic check - subtract load spacing from array len */
   jle readbankconflict128_end /* exit immediately if we don't have enough space to iterate */
   xor %rax, %rax
   mov %rcx, %rdi
   mov %rcx, %rsi
   mov %rcx, %r12
   add %rdx, %r12  /* set end location */
   sub $10, %r12   /* we're reading 10B ahead */
   add %r8, %rsi   /* rdi = first load location, rsi = second load location */
   mov (%rcx), %rbx  /* rbx = increment */
readbankconflict128_loop:
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   movups (%rdi), %xmm0
   movups (%rsi), %xmm1
   sub $20, %r9
   jl readbankconflict128_end
   cmp %rsi, %r12  /* subtract leading location from end location */
   jg readbankconflict128_loop /* if positive or equal, continue loop */
   mov %rcx, %rdi  /* reset to start */
   mov %rcx, %rsi
   add %r8, %rsi
   jmp readbankconflict128_loop
readbankconflict128_end:
   pop %r12
   pop %r11
   pop %r10
   pop %rsi
   pop %rdi
   pop %rbx
   ret 
