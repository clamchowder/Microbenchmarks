.text

.global latencytest
.global preplatencyarr
.global stlftest
.global stlftest32

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

/* rcx = iterations
   rdx = ptr to arr 
   do pointer chasing for specified iteration count
*/
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
