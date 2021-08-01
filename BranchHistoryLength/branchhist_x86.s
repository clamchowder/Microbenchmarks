.text

.global branchtest

/*
  System-V calling convention:
  %rdi = arg0 = iteration count
  %rsi = arg1 = ptr to array
  %rdx = arg2 = array length
*/
branchtest:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9
branchtest_loop:
  mov (%rsi,%rbx,4), %eax
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  test %eax, %eax
  jz branchtest_zero
  inc %r8
branchtest_zero:
  dec %rdi
  jnz branchtest_loop
  mov %r8, %rax
  pop %r9
  pop %r8
  pop %rbx
  ret
