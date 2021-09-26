.text

.global clktest
.global addtest
.global addmultest
.global jmpmultest
.global noptest
.global noptest1b
.global add256int
.global mixadd256int
.global mixadd256int11
.global mixadd256fpint
.global mix256fp
.global latadd256int
.global latadd128int
.global latmul256int
.global latmul128int
.global latadd256int
.global latmul256fp
.global latadd256fp
.global latmul128fp
.global latadd128fp
.global fma256
.global mul256fp
.global add256fp
.global latmul64
.global latmul16
.global mul16
.global mul64
.global load128
.global spacedload128
.global load256
.global store128
.global store256
.global mixaddmul128int
.global mixmul16mul64
.global mixmul16mul64_21

.global pdeptest
.global pexttest

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

noptest1b:
  push %rbx
  push %r9
  mov $20, %r9 
noptest1b_loop:
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  sub %r9, %rdi
  jnz noptest1b_loop
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

jmpmultest:
  push %rsi
  push %rbx
  push %rcx
  push %rdx
  push %r8
  push %r9
  push %r10
  push %r11
  push %r12
  push %r13
  push %r14
  push %r15
  mov $1, %r8
  mov $40, %r9
  xor %rbx, %rbx 
  xor %rcx, %rcx
  xor %r10, %r10
  xor %r11, %r11
  xor %r12, %r12
  xor %r13, %r13
  xor %r14, %r14
  xor %r15, %r15
  xor %rsi, %rsi
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %rsi
  mov %r8, %rax
  mov %r8, %rdx
jmpmultest_loop:
  cmp %r8, %r9
  je jmpmultest_jellydonut
  imul %r8d, %r10d

  cmp %r8, %r9
  je jmpmultest_jellydonut  
  imul %r8d, %esi

  cmp %r8, %r9
  je jmpmultest_jellydonut    
  imul %r8d, %ebx

  cmp %r8, %r9
  je jmpmultest_jellydonut      
  imul %r8d, %edx 
  
  cmp %r8, %r9
  je jmpmultest_jellydonut       
  imul %r8d, %r10d
  
  cmp %r8, %r9
  je jmpmultest_jellydonut        
  imul %r8d, %esi
  
  cmp %r8, %r9
  je jmpmultest_jellydonut         
  imul %r8d, %ebx

  cmp %r8, %r9
  je jmpmultest_jellydonut           
  imul %r8d, %edx  

  cmp %r8, %r9
  je jmpmultest_jellydonut            
  imul %r8d, %r15d  

  cmp %r8, %r9
  je jmpmultest_jellydonut             
  imul %r8d, %r14d  
  
  sub %r9, %rdi
  jnz addmultest_loop
jmpmultest_jellydonut:
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8 
  pop %rdx
  pop %rcx
  pop %rbx
  pop %rsi
  ret 

addmultest:
  push %rsi
  push %rbx
  push %rcx
  push %rdx
  push %r8
  push %r9
  push %r10
  push %r11
  push %r12
  push %r13
  push %r14
  push %r15
  mov $1, %r8
  mov $40, %r9
  xor %rbx, %rbx 
  xor %rcx, %rcx
  xor %r10, %r10
  xor %r11, %r11
  xor %r12, %r12
  xor %r13, %r13
  xor %r14, %r14
  xor %r15, %r15
  xor %rsi, %rsi
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %rsi
  mov %r8, %rax
  mov %r8, %rdx
addmultest_loop:
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  imul %r8, %r10
  
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  imul %r8, %rsi
  
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  imul %r8, %rbx
  
  add %r8, %r15
  add %r8, %r15
  add %r8, %r13
  add %r8, %r12
  imul %r8, %rdx 
  
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  imul %r8, %r10
  
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  imul %r8, %rsi
  
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  imul %r8, %rbx
  
  add %r8, %r15
  add %r8, %r13
  add %r8, %r12
  imul %r8, %rdx  
  
  sub %r9, %rdi
  jnz addmultest_loop
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8 
  pop %rdx
  pop %rcx
  pop %rbx
  pop %rsi
  ret

add256int:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %ymm0
  vmovdqu %ymm0, %ymm1
  vmovdqu %ymm0, %ymm2
  vmovdqu %ymm0, %ymm3
  vmovdqu %ymm0, %ymm4
  vmovdqu %ymm0, %ymm5
add256int_loop:
  vpaddq %ymm0, %ymm1, %ymm1
  vpaddq %ymm0, %ymm2, %ymm2
  vpaddq %ymm0, %ymm3, %ymm3
  vpaddq %ymm0, %ymm4, %ymm4
  vpaddq %ymm0, %ymm5, %ymm5
  vpaddq %ymm0, %ymm1, %ymm1
  vpaddq %ymm0, %ymm2, %ymm2
  vpaddq %ymm0, %ymm3, %ymm3
  vpaddq %ymm0, %ymm4, %ymm4
  vpaddq %ymm0, %ymm5, %ymm5
  vpaddq %ymm0, %ymm1, %ymm1
  vpaddq %ymm0, %ymm2, %ymm2
  vpaddq %ymm0, %ymm3, %ymm3
  vpaddq %ymm0, %ymm4, %ymm4
  vpaddq %ymm0, %ymm5, %ymm5 
  vpaddq %ymm0, %ymm1, %ymm1
  vpaddq %ymm0, %ymm2, %ymm2
  vpaddq %ymm0, %ymm3, %ymm3
  vpaddq %ymm0, %ymm4, %ymm4
  vpaddq %ymm0, %ymm5, %ymm5 
  sub %r9, %rdi
  jnz add256int_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mixadd256fpint:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %ymm0
  vmovdqu %ymm0, %ymm1
  vmovdqu %ymm0, %ymm2
  vmovdqu %ymm0, %ymm3
  vmovdqu %ymm0, %ymm4
  vmovdqu %ymm0, %ymm5
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %ymm6
  vmovups %ymm6, %ymm7
  vmovups %ymm6, %ymm8
  vmovups %ymm6, %ymm9
  vmovups %ymm6, %ymm10
  vmovups %ymm6, %ymm11
mixadd256fpint_loop:
  vpaddq %ymm0, %ymm1, %ymm1
  vaddps %ymm6, %ymm7, %ymm7
  vpaddq %ymm0, %ymm2, %ymm2
  vaddps %ymm6, %ymm8, %ymm8
  vpaddq %ymm0, %ymm3, %ymm3
  vaddps %ymm6, %ymm9, %ymm9
  vpaddq %ymm0, %ymm4, %ymm4
  vaddps %ymm6, %ymm10, %ymm10
  vpaddq %ymm0, %ymm5, %ymm5
  vaddps %ymm6, %ymm11, %ymm11
  vpaddq %ymm0, %ymm1, %ymm1
  vaddps %ymm6, %ymm7, %ymm7
  vpaddq %ymm0, %ymm2, %ymm2
  vaddps %ymm6, %ymm8, %ymm8
  vpaddq %ymm0, %ymm3, %ymm3
  vaddps %ymm6, %ymm9, %ymm9
  vpaddq %ymm0, %ymm4, %ymm4
  vaddps %ymm6, %ymm10, %ymm10
  vpaddq %ymm0, %ymm5, %ymm5
  vaddps %ymm6, %ymm11, %ymm11
  sub %r9, %rdi
  jnz mixadd256fpint_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret 

mix256fp:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %ymm6
  vmovups %ymm6, %ymm5
  vmovups %ymm6, %ymm7
  vmovups %ymm6, %ymm8
  vmovups %ymm6, %ymm9
  vmovups %ymm6, %ymm10
  vmovups %ymm6, %ymm11
  vmovups %ymm6, %ymm12
  vmovups %ymm6, %ymm13
  vmovups %ymm6, %ymm14
  vmovups %ymm6, %ymm15
mix256fp_loop:
  vaddps %ymm6, %ymm7, %ymm7
  vmulps %ymm6, %ymm8, %ymm8
  vaddps %ymm6, %ymm9, %ymm9
  vmulps %ymm6, %ymm10, %ymm10
  vaddps %ymm6, %ymm11, %ymm11
  vmulps %ymm6, %ymm12, %ymm12
  vaddps %ymm6, %ymm13, %ymm13
  vmulps %ymm6, %ymm14, %ymm14
  vaddps %ymm6, %ymm15, %ymm15
  vmulps %ymm6, %ymm5, %ymm5
  vaddps %ymm6, %ymm7, %ymm7
  vmulps %ymm6, %ymm8, %ymm8
  vaddps %ymm6, %ymm9, %ymm9
  vmulps %ymm6, %ymm10, %ymm10
  vaddps %ymm6, %ymm11, %ymm11
  vmulps %ymm6, %ymm12, %ymm12
  vaddps %ymm6, %ymm13, %ymm13
  vmulps %ymm6, %ymm14, %ymm14
  vaddps %ymm6, %ymm15, %ymm15
  vmulps %ymm6, %ymm5, %ymm5
  sub %r9, %rdi
  jnz mix256fp_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret  

mixadd256int:
  push %r9
  push %r8
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  mov $30, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %ymm0
  vmovdqu %ymm0, %ymm1
  vmovdqu %ymm0, %ymm2
  vmovdqu %ymm0, %ymm3
  vmovdqu %ymm0, %ymm4
  vmovdqu %ymm0, %ymm5
  mov %r9, %r15
  mov %r9, %r14
  mov %r9, %r13
  mov %r9, %r12
  mov %r9, %r11
  mov %r9, %r8
mixadd256int_loop:
  add %r8, %r11
  add %r8, %r12
  add %r8, %r13
  add %r8, %r14
  add %r8, %r15 
  vpaddq %ymm0, %ymm1, %ymm1
  vpaddq %ymm0, %ymm2, %ymm2
  vpaddq %ymm0, %ymm3, %ymm3
  vpaddq %ymm0, %ymm4, %ymm4
  vpaddq %ymm0, %ymm5, %ymm5
  add %r8, %r11
  add %r8, %r12
  add %r8, %r13
  add %r8, %r14
  add %r8, %r15
  add %r8, %r11
  add %r8, %r12
  add %r8, %r13
  add %r8, %r14
  add %r8, %r15 
  vpaddq %ymm0, %ymm1, %ymm1
  vpaddq %ymm0, %ymm2, %ymm2
  vpaddq %ymm0, %ymm3, %ymm3
  vpaddq %ymm0, %ymm4, %ymm4
  vpaddq %ymm0, %ymm5, %ymm5 
  add %r8, %r11
  add %r8, %r12
  add %r8, %r13
  add %r8, %r14
  add %r8, %r15 
  sub %r9, %rdi
  jnz mixadd256int_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r8
  pop %r9
  ret 

mixadd256int11:
  push %r9
  push %r8
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %ymm0
  vmovdqu %ymm0, %ymm1
  vmovdqu %ymm0, %ymm2
  vmovdqu %ymm0, %ymm3
  vmovdqu %ymm0, %ymm4
  vmovdqu %ymm0, %ymm5
  mov %r9, %r15
  mov %r9, %r14
  mov %r9, %r13
  mov %r9, %r12
  mov %r9, %r11
  mov %r9, %r8
mixadd256int11_loop:
  add %r8, %r11
  add %r8, %r12
  add %r8, %r13
  add %r8, %r14
  add %r8, %r15 
  vpaddq %ymm0, %ymm1, %ymm1
  vpaddq %ymm0, %ymm2, %ymm2
  vpaddq %ymm0, %ymm3, %ymm3
  vpaddq %ymm0, %ymm4, %ymm4
  vpaddq %ymm0, %ymm5, %ymm5
  add %r8, %r11
  add %r8, %r12
  add %r8, %r13
  add %r8, %r14
  add %r8, %r15 
  vpaddq %ymm0, %ymm1, %ymm1
  vpaddq %ymm0, %ymm2, %ymm2
  vpaddq %ymm0, %ymm3, %ymm3
  vpaddq %ymm0, %ymm4, %ymm4
  vpaddq %ymm0, %ymm5, %ymm5 
  sub %r9, %rdi
  jnz mixadd256int11_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r8
  pop %r9
  ret  

latadd256int:
  push %r9
  push %r8
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %ymm0
  vmovdqu %ymm0, %ymm1
  vmovdqu %ymm0, %ymm2
  vmovdqu %ymm0, %ymm3
  vmovdqu %ymm0, %ymm4
  vmovdqu %ymm0, %ymm5
latadd256int_loop:
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  vpaddq %ymm0, %ymm0, %ymm0
  sub %r9, %rdi
  jnz latadd256int_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r8
  pop %r9
  ret 

latmul256int:
  push %r9
  push %r8
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastd %xmm1, %ymm0
  vmovdqu %ymm0, %ymm1
  vmovdqu %ymm0, %ymm2
  vmovdqu %ymm0, %ymm3
  vmovdqu %ymm0, %ymm4
  vmovdqu %ymm0, %ymm5
latmul256int_loop:
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  vpmulld %ymm0, %ymm0, %ymm0
  sub %r9, %rdi
  jnz latmul256int_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r8
  pop %r9
  ret  

latadd128int:
  push %r9
  vzeroupper
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %xmm0
latadd128int_loop:
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  paddq %xmm0, %xmm0
  sub %r9, %rdi
  jnz latadd128int_loop
  movq %xmm1, %rax
  pop %r9
  ret

latmul128int:
  push %r9
  vzeroupper
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastd %xmm1, %xmm0
latmul128int_loop:
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  pmulld %xmm0, %xmm0
  sub %r9, %rdi
  jnz latmul128int_loop
  movq %xmm1, %rax
  pop %r9
  ret 

mixaddmul128int:
  push %r9
  vzeroupper
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastd %xmm1, %xmm0
  movdqa %xmm0, %xmm1
  movdqa %xmm0, %xmm2
  movdqa %xmm0, %xmm3
  movdqa %xmm0, %xmm4
  movdqa %xmm0, %xmm5
  movdqa %xmm0, %xmm6
  movdqa %xmm0, %xmm7
  movdqa %xmm0, %xmm8
  movdqa %xmm0, %xmm9
  movdqa %xmm0, %xmm10
mixaddmul128int_loop:
  pmulld %xmm0, %xmm1
  paddd %xmm0, %xmm2
  pmulld %xmm0, %xmm3
  paddd %xmm0, %xmm4
  pmulld %xmm0, %xmm5
  paddd %xmm0, %xmm6
  pmulld %xmm0, %xmm7
  paddd %xmm0, %xmm8
  pmulld %xmm0, %xmm9
  paddd %xmm0, %xmm10
  pmulld %xmm0, %xmm1
  paddd %xmm0, %xmm2
  pmulld %xmm0, %xmm3
  paddd %xmm0, %xmm4
  pmulld %xmm0, %xmm5
  paddd %xmm0, %xmm6
  pmulld %xmm0, %xmm7
  paddd %xmm0, %xmm8
  pmulld %xmm0, %xmm9
  paddd %xmm0, %xmm10 
  sub %r9, %rdi
  jnz mixaddmul128int_loop
  movq %xmm1, %rax
  pop %r9
  ret  

latadd256fp:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %ymm6
latadd256fp_loop:
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  vaddps %ymm6, %ymm6, %ymm6
  sub %r9, %rdi
  jnz latadd256fp_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret 

mul256fp:
  push %r9
  push %r8
  mov $20, %r9
  cvtsi2ss %r9, %xmm0
  vbroadcastss %xmm0, %ymm6
  vmovdqa %ymm0, %ymm1
  vmovdqa %ymm0, %ymm2
  vmovdqa %ymm0, %ymm3
  vmovdqa %ymm0, %ymm4
  vmovdqa %ymm0, %ymm5
  vmovdqa %ymm0, %ymm6
  vmovdqa %ymm0, %ymm7
  vmovdqa %ymm0, %ymm8
  vmovdqa %ymm0, %ymm9
  vmovdqa %ymm0, %ymm10
mul256fp_loop:
  vmulps %ymm0, %ymm1, %ymm1
  vmulps %ymm0, %ymm2, %ymm2
  vmulps %ymm0, %ymm3, %ymm3
  vmulps %ymm0, %ymm4, %ymm4
  vmulps %ymm0, %ymm5, %ymm5
  vmulps %ymm0, %ymm6, %ymm6
  vmulps %ymm0, %ymm7, %ymm7
  vmulps %ymm0, %ymm8, %ymm8
  vmulps %ymm0, %ymm9, %ymm9
  vmulps %ymm0, %ymm10, %ymm10
  vmulps %ymm0, %ymm1, %ymm1
  vmulps %ymm0, %ymm2, %ymm2
  vmulps %ymm0, %ymm3, %ymm3
  vmulps %ymm0, %ymm4, %ymm4
  vmulps %ymm0, %ymm5, %ymm5
  vmulps %ymm0, %ymm6, %ymm6
  vmulps %ymm0, %ymm7, %ymm7
  vmulps %ymm0, %ymm8, %ymm8
  vmulps %ymm0, %ymm9, %ymm9
  vmulps %ymm0, %ymm10, %ymm10
  sub %r9, %rdi
  jnz mul256fp_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

add256fp:
  push %r9
  push %r8
  mov $20, %r9
  cvtsi2ss %r9, %xmm0
  vbroadcastss %xmm0, %ymm6
  vmovdqa %ymm0, %ymm1
  vmovdqa %ymm0, %ymm2
  vmovdqa %ymm0, %ymm3
  vmovdqa %ymm0, %ymm4
  vmovdqa %ymm0, %ymm5
  vmovdqa %ymm0, %ymm6
  vmovdqa %ymm0, %ymm7
  vmovdqa %ymm0, %ymm8
  vmovdqa %ymm0, %ymm9
  vmovdqa %ymm0, %ymm10
add256fp_loop:
  vaddps %ymm0, %ymm1, %ymm1
  vaddps %ymm0, %ymm2, %ymm2
  vaddps %ymm0, %ymm3, %ymm3
  vaddps %ymm0, %ymm4, %ymm4
  vaddps %ymm0, %ymm5, %ymm5
  vaddps %ymm0, %ymm6, %ymm6
  vaddps %ymm0, %ymm7, %ymm7
  vaddps %ymm0, %ymm8, %ymm8
  vaddps %ymm0, %ymm9, %ymm9
  vaddps %ymm0, %ymm10, %ymm10
  vaddps %ymm0, %ymm1, %ymm1
  vaddps %ymm0, %ymm2, %ymm2
  vaddps %ymm0, %ymm3, %ymm3
  vaddps %ymm0, %ymm4, %ymm4
  vaddps %ymm0, %ymm5, %ymm5
  vaddps %ymm0, %ymm6, %ymm6
  vaddps %ymm0, %ymm7, %ymm7
  vaddps %ymm0, %ymm8, %ymm8
  vaddps %ymm0, %ymm9, %ymm9
  vaddps %ymm0, %ymm10, %ymm10
  sub %r9, %rdi
  jnz add256fp_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret


latmul256fp:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %ymm6
latmul256fp_loop:
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  vmulps %ymm6, %ymm6, %ymm6
  sub %r9, %rdi
  jnz latmul256fp_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret


fma256:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %ymm6
  vmovups %ymm6, %ymm5
  vmovups %ymm6, %ymm7
  vmovups %ymm6, %ymm8
  vmovups %ymm6, %ymm9
  vmovups %ymm6, %ymm10
  vmovups %ymm6, %ymm11
  vmovups %ymm6, %ymm12
  vmovups %ymm6, %ymm13
  vmovups %ymm6, %ymm14
  vmovups %ymm6, %ymm15
fma256_loop:
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %ymm6, %ymm7, %ymm7
  vfmadd132ps %ymm6, %ymm8, %ymm8
  vfmadd132ps %ymm6, %ymm9, %ymm9
  vfmadd132ps %ymm6, %ymm10, %ymm10
  vfmadd132ps %ymm6, %ymm11, %ymm11
  vfmadd132ps %ymm6, %ymm12, %ymm12
  vfmadd132ps %ymm6, %ymm13, %ymm13
  vfmadd132ps %ymm6, %ymm14, %ymm14
  vfmadd132ps %ymm6, %ymm15, %ymm15
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %ymm6, %ymm7, %ymm7
  vfmadd132ps %ymm6, %ymm8, %ymm8
  vfmadd132ps %ymm6, %ymm9, %ymm9
  vfmadd132ps %ymm6, %ymm10, %ymm10
  vfmadd132ps %ymm6, %ymm11, %ymm11
  vfmadd132ps %ymm6, %ymm12, %ymm12
  vfmadd132ps %ymm6, %ymm13, %ymm13
  vfmadd132ps %ymm6, %ymm14, %ymm14
  vfmadd132ps %ymm6, %ymm15, %ymm15 
  sub %r9, %rdi
  jnz fma256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret   

latadd128fp:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %xmm6
latadd128fp_loop:
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  addps %xmm6, %xmm6
  sub %r9, %rdi
  jnz latadd128fp_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret 

latmul128fp:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %xmm6
latmul128fp_loop:
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  mulps %xmm6, %xmm6
  sub %r9, %rdi
  jnz latmul128fp_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret 

latmul64:
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
  mov %r8, %rbx 
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r9, %r15
latmul64_loop:
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  imul %r9, %r15
  sub %r9, %rdi
  jnz latmul64_loop
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

latmul16:
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
  mov %r8, %rbx 
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r9, %r15
latmul16_loop:
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  imul %r9w, %r15w
  sub %r9, %rdi
  jnz latmul16_loop
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

mul16:
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
  mov %r8, %rbx 
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r9, %r15
mul16_loop:
  imul %r9w, %r15w
  imul %r9w, %r14w
  imul %r9w, %r13w
  imul %r9w, %r12w
  imul %r9w, %r11w
  imul %r9w, %r15w
  imul %r9w, %r14w
  imul %r9w, %r13w
  imul %r9w, %r12w
  imul %r9w, %r11w 
  imul %r9w, %r15w
  imul %r9w, %r14w
  imul %r9w, %r13w
  imul %r9w, %r12w
  imul %r9w, %r11w  
  imul %r9w, %r15w
  imul %r9w, %r14w
  imul %r9w, %r13w
  imul %r9w, %r12w
  imul %r9w, %r11w  
  sub %r9, %rdi
  jnz mul16_loop
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

mul64:
  push %rbx
  push %rcx
  push %rsi
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
  mov %r8, %rbx 
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r9, %r15
mul64_loop:
  imul %r9, %r15
  imul %r9, %r14
  imul %r9, %r13
  imul %r9, %r12
  imul %r9, %r11
  imul %r9, %r10
  imul %r9, %r8
  imul %r9, %rbx
  imul %r9, %rcx
  imul %r9, %rsi
  imul %r9, %r15
  imul %r9, %r14
  imul %r9, %r13
  imul %r9, %r12
  imul %r9, %r11
  imul %r9, %r10
  imul %r9, %r8
  imul %r9, %rbx
  imul %r9, %rcx
  imul %r9, %rsi 
  sub %r9, %rdi
  jnz mul64_loop
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8 
  pop %rsi
  pop %rcx
  pop %rbx
  ret  

mixmul16mul64:
  push %rbx
  push %rcx
  push %rsi
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
  mov %r8, %rbx 
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r9, %r15
mixmul16mul64_loop:
  imul %r9, %r15
  imul %r9w, %r14w
  imul %r9, %r13
  imul %r9w, %r12w
  imul %r9, %r11
  imul %r9w, %r10w
  imul %r9, %r8
  imul %r9w, %bx
  imul %r9, %rcx
  imul %r9w, %si
  imul %r9, %r15
  imul %r9w, %r14w
  imul %r9, %r13
  imul %r9w, %r12w
  imul %r9, %r11
  imul %r9w, %r10w
  imul %r9, %r8
  imul %r9w, %bx
  imul %r9, %rcx
  imul %r9w, %si 
  sub %r9, %rdi
  jnz mixmul16mul64_loop
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8 
  pop %rsi
  pop %rcx
  pop %rbx
  ret   

mixmul16mul64_21:
  push %rbx
  push %rcx
  push %rdx
  push %rsi
  push %r8
  push %r9
  push %r10
  push %r11
  push %r12
  push %r13
  push %r14
  push %r15
  mov $1, %r8
  mov $24, %r9
  mov %r8, %rbx 
  mov %r8, %rcx
  mov %r8, %rsi
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r9, %r15
mixmul16mul64_21_loop:
  imul %r9, %r15
  imul %r9w, %r14w
  imul %r9w, %r13w
  imul %r9, %r12
  imul %r9w, %r11w
  imul %r9w, %r10w

  imul %r9, %r8
  imul %r9w, %r14w
  imul %r9w, %r13w
  imul %r9, %rcx
  imul %r9w, %r11w
  imul %r9w, %r10w 

  imul %r9, %rbx
  imul %r9w, %r14w
  imul %r9w, %r13w
  imul %r9, %rax
  imul %r9w, %r11w
  imul %r9w, %r10w 

  imul %r9, %rsi
  imul %r9w, %r14w
  imul %r9w, %r13w
  imul %r9, %rdx
  imul %r9w, %r11w
  imul %r9w, %r10w  

  sub %r9, %rdi
  jge mixmul16mul64_21_loop
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8 
  pop %rsi
  pop %rdx
  pop %rcx
  pop %rbx
  ret    

spacedload128:
  push %rbx
  push %rcx
  push %r8
  push %r9
  vzeroupper
  mov $20, %r9
spacedload128_loop:
  movdqa (%rsi), %xmm10
  movdqa 64(%rsi), %xmm11
  movdqa 128(%rsi), %xmm12
  movdqa 192(%rsi), %xmm13
  movdqa 256(%rsi), %xmm14
  movdqa 320(%rsi), %xmm10
  movdqa 384(%rsi), %xmm11
  movdqa 448(%rsi), %xmm12
  movdqa 512(%rsi), %xmm13
  movdqa 576(%rsi), %xmm14 
  movdqa 640(%rsi), %xmm10
  movdqa 704(%rsi), %xmm11
  movdqa 768(%rsi), %xmm12
  movdqa 832(%rsi), %xmm13
  movdqa 896(%rsi), %xmm14    
  movdqa 960(%rsi), %xmm10
  movdqa 1024(%rsi), %xmm11
  movdqa 1088(%rsi), %xmm12
  movdqa 1152(%rsi), %xmm13
  movdqa 1216(%rsi), %xmm14  
  sub %r9, %rdi
  jnz spacedload128_loop
  pop %r9
  pop %r8 
  pop %rcx
  pop %rbx
  ret

load128:
  push %rbx
  push %rcx
  push %r8
  push %r9
  vzeroupper
  mov $20, %r9
load128_loop:
  movdqa (%rsi), %xmm10
  movdqa (%rsi), %xmm11
  movdqa (%rsi), %xmm12
  movdqa (%rsi), %xmm13
  movdqa (%rsi), %xmm14
  movdqa (%rsi), %xmm10
  movdqa (%rsi), %xmm11
  movdqa (%rsi), %xmm12
  movdqa (%rsi), %xmm13
  movdqa (%rsi), %xmm14 
  movdqa (%rsi), %xmm10
  movdqa (%rsi), %xmm11
  movdqa (%rsi), %xmm12
  movdqa (%rsi), %xmm13
  movdqa (%rsi), %xmm14    
  movdqa (%rsi), %xmm10
  movdqa (%rsi), %xmm11
  movdqa (%rsi), %xmm12
  movdqa (%rsi), %xmm13
  movdqa (%rsi), %xmm14  
  sub %r9, %rdi
  jnz load128_loop
  pop %r9
  pop %r8 
  pop %rcx
  pop %rbx
  ret 

load256:
  push %rbx
  push %rcx
  push %r8
  push %r9
  mov $20, %r9
load256_loop:
  vmovaps (%rsi), %ymm10
  vmovaps (%rsi), %ymm11
  vmovaps (%rsi), %ymm12
  vmovaps (%rsi), %ymm13
  vmovaps (%rsi), %ymm14
  vmovaps (%rsi), %ymm10
  vmovaps (%rsi), %ymm11
  vmovaps (%rsi), %ymm12
  vmovaps (%rsi), %ymm13
  vmovaps (%rsi), %ymm14 
  vmovaps (%rsi), %ymm10
  vmovaps (%rsi), %ymm11
  vmovaps (%rsi), %ymm12
  vmovaps (%rsi), %ymm13
  vmovaps (%rsi), %ymm14    
  vmovaps (%rsi), %ymm10
  vmovaps (%rsi), %ymm11
  vmovaps (%rsi), %ymm12
  vmovaps (%rsi), %ymm13
  vmovaps (%rsi), %ymm14  
  sub %r9, %rdi
  jnz load256_loop
  pop %r9
  pop %r8 
  pop %rcx
  pop %rbx
  ret 

store128:
  push %rbx
  push %rcx
  push %r8
  push %r9
  vzeroupper
  movdqa (%rsi), %xmm10
  movdqa %xmm10, %xmm11
  movdqa %xmm10, %xmm12
  movdqa %xmm10, %xmm13
  movdqa %xmm10, %xmm14
  mov $20, %r9
store128_loop:
  movdqa %xmm10, (%rdx)
  movdqa %xmm11, (%rdx)
  movdqa %xmm12, (%rdx)
  movdqa %xmm13, (%rdx)
  movdqa %xmm14, (%rdx)
  movdqa %xmm10, (%rdx)
  movdqa %xmm11, (%rdx)
  movdqa %xmm12, (%rdx)
  movdqa %xmm13, (%rdx)
  movdqa %xmm14, (%rdx) 
  movdqa %xmm10, (%rdx)
  movdqa %xmm11, (%rdx)
  movdqa %xmm12, (%rdx)
  movdqa %xmm13, (%rdx)
  movdqa %xmm14, (%rdx) 
  movdqa %xmm10, (%rdx)
  movdqa %xmm11, (%rdx)
  movdqa %xmm12, (%rdx)
  movdqa %xmm13, (%rdx)
  movdqa %xmm14, (%rdx) 
  sub %r9, %rdi
  jnz store128_loop
  pop %r9
  pop %r8 
  pop %rcx
  pop %rbx
  ret 

store256:
  push %rbx
  push %rcx
  push %r8
  push %r9
  vmovaps (%rsi), %ymm10
  vmovaps %ymm10, %ymm11
  vmovaps %ymm10, %ymm12
  vmovaps %ymm10, %ymm13
  vmovaps %ymm10, %ymm14
  mov $20, %r9
store256_loop:
  vmovaps %ymm10, (%rdx)
  vmovaps %ymm11, (%rdx)
  vmovaps %ymm12, (%rdx)
  vmovaps %ymm13, (%rdx)
  vmovaps %ymm14, (%rdx)
  vmovaps %ymm10, (%rdx)
  vmovaps %ymm11, (%rdx)
  vmovaps %ymm12, (%rdx)
  vmovaps %ymm13, (%rdx)
  vmovaps %ymm14, (%rdx) 
  vmovaps %ymm10, (%rdx)
  vmovaps %ymm11, (%rdx)
  vmovaps %ymm12, (%rdx)
  vmovaps %ymm13, (%rdx)
  vmovaps %ymm14, (%rdx) 
  vmovaps %ymm10, (%rdx)
  vmovaps %ymm11, (%rdx)
  vmovaps %ymm12, (%rdx)
  vmovaps %ymm13, (%rdx)
  vmovaps %ymm14, (%rdx) 
  sub %r9, %rdi
  jnz store256_loop
  pop %r9
  pop %r8 
  pop %rcx
  pop %rbx
  ret  

pdeptest:
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
pdeptest_loop:
  pdep %r8, %r15, %r15
  pdep %r8, %r14, %r14
  pdep %r8, %r13, %r13
  pdep %r8, %r12, %r12
  pdep %r8, %r11, %r11
  pdep %r8, %r10, %r10
  pdep %r8, %rcx, %rcx
  pdep %r8, %rbx, %rbx
  pdep %r8, %r15, %r15
  pdep %r8, %r14, %r14
  pdep %r8, %r13, %r13
  pdep %r8, %r12, %r12
  pdep %r8, %r11, %r11
  pdep %r8, %r10, %r10
  pdep %r8, %rcx, %rcx
  pdep %r8, %rbx, %rbx 
  pdep %r8, %r15, %r15
  pdep %r8, %r14, %r14
  pdep %r8, %r13, %r13
  pdep %r8, %r12, %r12
  sub %r9, %rdi
  jnz pdeptest_loop
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


pexttest:
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
pexttest_loop:
  pext %r8, %r15, %r15
  pext %r8, %r14, %r14
  pext %r8, %r13, %r13
  pext %r8, %r12, %r12
  pext %r8, %r11, %r11
  pext %r8, %r10, %r10
  pext %r8, %rcx, %rcx
  pext %r8, %rbx, %rbx
  pext %r8, %r15, %r15
  pext %r8, %r14, %r14
  pext %r8, %r13, %r13
  pext %r8, %r12, %r12
  pext %r8, %r11, %r11
  pext %r8, %r10, %r10
  pext %r8, %rcx, %rcx
  pext %r8, %rbx, %rbx 
  pext %r8, %r15, %r15
  pext %r8, %r14, %r14
  pext %r8, %r13, %r13
  pext %r8, %r12, %r12
  sub %r9, %rdi
  jnz pexttest_loop
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
