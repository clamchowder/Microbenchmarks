.global clktest

/*
  %rdi = arg0 = iteration count
*/
clktest:
  push %rbx
  push %r8
  push %r9
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
clktest_loop:
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
  jnz clktest_loop
  pop %r9
  pop %r8
  pop %rbx
  ret
