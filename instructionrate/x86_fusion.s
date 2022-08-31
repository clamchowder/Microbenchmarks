.text

.global clktest
.global addtest
.global noptest
.global testfusion
.global cmpfusion
.global subfusion
.global nopfusion

testfusion:
  push %rbx
  push %r8
  push %r9
  push %r10
  xor %rax, %rax
  not %rax
testfusion_loop:
  xor %r8, %r8
  xor %r9, %r9
  sub $5, %rdi
  test %rdi, %rax
  jnz testfusion_loop
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  ret

cmpfusion:
  push %rbx
  push %r8
  push %r9
  push %r10
  xor %rax, %rax
cmpfusion_loop:
  xor %r8, %r8
  xor %r9, %r9
  sub $5, %rdi
  cmp %rdi, %rax
  jnz cmpfusion_loop
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  ret

subfusion:
  push %rbx
  push %r8
  push %r9
  push %r10
  xor %rax, %rax
subfusion_loop:
  xor %r8, %r8
  xor %r9, %r9
  xor %r10, %r10
  sub $5, %rdi
  jnz subfusion_loop
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  ret

nopfusion:
  push %rbx
  push %r8
  push %r9
  push %r10
  xor %rax, %rax
nopfusion_loop:
  sub $5, %rdi
  nop
  nop
  nop
  jnz nopfusion_loop
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  ret

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

noptest:
  push %rbx
  push %r9
  mov $20, %r9
noptest_loop:
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  xchg %ax,%ax
  sub %r9, %rdi
  jnz noptest_loop
  pop %r9
  pop %rbx
  ret

addtest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r10
  push %r11
  push %r12
  push %r13
  push %r14
  push %r15
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
  xor %rcx, %rcx
  xor %r10, %r10
  xor %r11, %r11
  xor %r12, %r12
  xor %r13, %r13
  xor %r14, %r14
  xor %r15, %r15
addtest_loop:
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  add %r8, %r11
  add %r8, %r10
  add %r8, %rcx
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  add %r8, %r11
  add %r8, %r10
  add %r8, %rcx
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  add %r8, %r11
  add %r8, %r10
  sub %r9, %rdi
  jnz addtest_loop
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret
