.global clktsctest

/* rcx = iterations, return elapsed TSC in rax */ 
clktsctest:
  push %rdx
  push %rbx
  push %r8
  push %r9
  push %r10
  mov %rcx, %rdi
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
  rdtsc            /* high 32 bits in EDX, low 32 bits in EAX */
  shl $32, %rdx    /* shift high 32 bits into upper half of EDX */
  add %rax, %rdx   /* place full 64-bit value in rdx */
  mov %rdx, %r10
clktsctest_loop:
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  sub %r9, %rdi
  jnz clktsctest_loop
  rdtsc
  shl $32, %rdx
  add %rdx, %rax /* now rax has the new value */
  sub %r10, %rax /* subtract old TSC value from the new one, which should be larger */
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  pop %rdx
  ret  
