.text

.global latencytest
.global longpatternlatencytest
.global preplatencyarr
.global stlftest
.global stlftest32
.global stlftest128
.global matchedstlftest

/* ms_abi specified in source file, so
   rcx = ptr to arr
   rdx = arr len
   convert values in array from array indexes to pointers
   there has to be a way to make C do this but high level
   programming languages suck and make simple things harder than they should be
*/
preplatencyarr:
  push %r15
  push %r14
  xor %r15, %r15    /* r15 = array index */
preplatencyarr_loop:
  mov (%rcx,%r15,8), %r14
  lea (%rcx,%r14,8), %r14
  mov %r14, (%rcx,%r15,8)
  inc %r15
  cmp %r15, %rdx
  jne preplatencyarr_loop
  pop %r14
  pop %r15
  ret

latencytest:
  push %r15
  mov (%rdx), %r15
  xor %rax, %rax
latencytest_loop:
  mov (%r15), %r15
  add %r15, %rax
  dec %rcx
  jnz latencytest_loop
  pop %r15
  ret

/* rcx = iterations
   rdx = ptr to arr
   do pointer chasing for specified iteration count
*/
longpatternlatencytest:
  push %r15
  push %r14
  push %r13
  push %r12
  push %rbx
  mov (%rdx), %r15
  xor %rax, %rax   /* rax = index into cacheline */

  /* r14 = 64B aligned start address */
  mov %rdx, %r14
  mov $63, %r13
  not %r13         /* r13 = mask for 64B cacheline addr */
  and %r13, %r14
longpatternlatencytest_loop:
  mov (%r15), %r15

  /* if we're back at the first cacheline */
  mov %r15, %r12
  and %r13, %r12
  cmp %r12, %r14
  jnz longpatternlatencytest_loop_inc
  add $8, %rax
  and $63, %rax
  and %r13, %r15
  add %rax, %r15
longpatternlatencytest_loop_inc:
  dec %rcx
  jnz longpatternlatencytest_loop
  pop %rbx
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  ret

/* rcx = iterations
   rdx = ptr to array. first two 32-bit ints in array are store and load offsets respectively */
stlftest:
  push %rsi
  push %rdi
  mov (%rdx), %rax   /* just get some value into rax (store value */
  mov (%rdx), %esi
  mov 4(%rdx), %edi
  add %rdx, %rsi     /* rsi = store ptr */
  add %rdx, %rdi     /* rdi = load ptr */
stlftest_loop:
  mov %rax, (%rsi)   /* store */
  mov (%rdi), %eax   /* load that possibly gets forwarded result */
  mov %rax, (%rsi)
  mov (%rdi), %eax
  mov %rax, (%rsi)
  mov (%rdi), %eax
  mov %rax, (%rsi)
  mov (%rdi), %eax
  mov %rax, (%rsi)
  mov (%rdi), %eax
  sub $5, %rcx
  jg stlftest_loop
  pop %rdi
  pop %rsi
  ret

stlftest128:
  push %rsi
  push %rdi
  mov (%rdx), %rax   /* just get some value into rax (store value */
  mov (%rdx), %esi
  mov 4(%rdx), %edi
  add %rdx, %rsi     /* rsi = store ptr */
  add %rdx, %rdi     /* rdi = load ptr */
stlftest128_loop:
  movups %xmm0, (%rsi)   /* store */
  movsd (%rdi), %xmm0   /* load that possibly gets forwarded result */
  movups %xmm0, (%rsi)
  movsd (%rdi), %xmm0
  movups %xmm0, (%rsi)
  movsd (%rdi), %xmm0
  movups %xmm0, (%rsi)
  movsd (%rdi), %xmm0
  movups %xmm0, (%rsi)
  movsd (%rdi), %xmm0
  sub $5, %rcx
  jg stlftest128_loop
  pop %rdi
  pop %rsi
  ret

stlftest32:
  push %rsi
  push %rdi
  mov (%rdx), %rax   /* just get some value into rax (store value */
  mov (%rdx), %esi
  mov 4(%rdx), %edi
  add %rdx, %rsi     /* rsi = store ptr */
  add %rdx, %rdi     /* rdi = load ptr */
stlftest32_loop:
  mov %eax, (%rsi)   /* store */
  mov (%rdi), %ax    /* load that possibly gets forwarded result */
  mov %eax, (%rsi)
  mov (%rdi), %ax
  mov %eax, (%rsi)
  mov (%rdi), %ax
  mov %eax, (%rsi)
  mov (%rdi), %ax
  mov %eax, (%rsi)
  mov (%rdi), %ax
  sub $5, %rcx
  jg stlftest32_loop
  pop %rdi
  pop %rsi
  ret

matchedstlftest:
  push %rsi
  push %rdi
  mov (%rdx), %rax   /* just get some value into rax (store value */
  mov (%rdx), %esi
  mov 4(%rdx), %edi
  add %rdx, %rsi     /* rsi = store ptr */
  add %rdx, %rdi     /* rdi = load ptr */
matchedstlftest_loop:
  mov %rax, (%rsi)   /* store */
  mov (%rdi), %rax   /* load that possibly gets forwarded result */
  mov %rax, (%rsi)
  mov (%rdi), %rax
  mov %rax, (%rsi)
  mov (%rdi), %rax
  mov %rax, (%rsi)
  mov (%rdi), %rax
  mov %rax, (%rsi)
  mov (%rdi), %rax
  sub $5, %rcx
  jg matchedstlftest_loop
  pop %rdi
  pop %rsi
  ret
