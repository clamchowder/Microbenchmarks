.text
.global branchhist1
.global branchhist2
.global branchhist4
.global branchhist8
.global branchhist16
.global branchhist32
.global branchhist64
.global branchhist128
.global branchhist256
.global branchhist512


branchhist1:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist1_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist1_zero0
  inc %r8
branchhist1_zero0:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist1_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist2:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist2_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist2_zero0
  inc %r8
branchhist2_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist2_zero1
  inc %r8
branchhist2_zero1:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist2_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist4:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist4_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist4_zero0
  inc %r8
branchhist4_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist4_zero1
  inc %r8
branchhist4_zero1:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist4_zero2
  inc %r8
branchhist4_zero2:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist4_zero3
  inc %r8
branchhist4_zero3:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist4_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist8:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist8_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist8_zero0
  inc %r8
branchhist8_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist8_zero1
  inc %r8
branchhist8_zero1:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist8_zero2
  inc %r8
branchhist8_zero2:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist8_zero3
  inc %r8
branchhist8_zero3:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist8_zero4
  inc %r8
branchhist8_zero4:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist8_zero5
  inc %r8
branchhist8_zero5:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist8_zero6
  inc %r8
branchhist8_zero6:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist8_zero7
  inc %r8
branchhist8_zero7:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist8_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist16:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist16_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero0
  inc %r8
branchhist16_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero1
  inc %r8
branchhist16_zero1:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero2
  inc %r8
branchhist16_zero2:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero3
  inc %r8
branchhist16_zero3:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero4
  inc %r8
branchhist16_zero4:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero5
  inc %r8
branchhist16_zero5:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero6
  inc %r8
branchhist16_zero6:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero7
  inc %r8
branchhist16_zero7:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero8
  inc %r8
branchhist16_zero8:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero9
  inc %r8
branchhist16_zero9:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero10
  inc %r8
branchhist16_zero10:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero11
  inc %r8
branchhist16_zero11:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero12
  inc %r8
branchhist16_zero12:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero13
  inc %r8
branchhist16_zero13:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero14
  inc %r8
branchhist16_zero14:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist16_zero15
  inc %r8
branchhist16_zero15:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist16_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist32:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist32_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero0
  inc %r8
branchhist32_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero1
  inc %r8
branchhist32_zero1:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero2
  inc %r8
branchhist32_zero2:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero3
  inc %r8
branchhist32_zero3:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero4
  inc %r8
branchhist32_zero4:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero5
  inc %r8
branchhist32_zero5:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero6
  inc %r8
branchhist32_zero6:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero7
  inc %r8
branchhist32_zero7:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero8
  inc %r8
branchhist32_zero8:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero9
  inc %r8
branchhist32_zero9:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero10
  inc %r8
branchhist32_zero10:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero11
  inc %r8
branchhist32_zero11:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero12
  inc %r8
branchhist32_zero12:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero13
  inc %r8
branchhist32_zero13:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero14
  inc %r8
branchhist32_zero14:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero15
  inc %r8
branchhist32_zero15:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero16
  inc %r8
branchhist32_zero16:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero17
  inc %r8
branchhist32_zero17:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero18
  inc %r8
branchhist32_zero18:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero19
  inc %r8
branchhist32_zero19:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero20
  inc %r8
branchhist32_zero20:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero21
  inc %r8
branchhist32_zero21:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero22
  inc %r8
branchhist32_zero22:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero23
  inc %r8
branchhist32_zero23:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero24
  inc %r8
branchhist32_zero24:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero25
  inc %r8
branchhist32_zero25:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero26
  inc %r8
branchhist32_zero26:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero27
  inc %r8
branchhist32_zero27:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero28
  inc %r8
branchhist32_zero28:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero29
  inc %r8
branchhist32_zero29:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero30
  inc %r8
branchhist32_zero30:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist32_zero31
  inc %r8
branchhist32_zero31:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist32_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist64:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist64_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero0
  inc %r8
branchhist64_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero1
  inc %r8
branchhist64_zero1:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero2
  inc %r8
branchhist64_zero2:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero3
  inc %r8
branchhist64_zero3:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero4
  inc %r8
branchhist64_zero4:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero5
  inc %r8
branchhist64_zero5:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero6
  inc %r8
branchhist64_zero6:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero7
  inc %r8
branchhist64_zero7:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero8
  inc %r8
branchhist64_zero8:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero9
  inc %r8
branchhist64_zero9:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero10
  inc %r8
branchhist64_zero10:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero11
  inc %r8
branchhist64_zero11:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero12
  inc %r8
branchhist64_zero12:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero13
  inc %r8
branchhist64_zero13:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero14
  inc %r8
branchhist64_zero14:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero15
  inc %r8
branchhist64_zero15:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero16
  inc %r8
branchhist64_zero16:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero17
  inc %r8
branchhist64_zero17:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero18
  inc %r8
branchhist64_zero18:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero19
  inc %r8
branchhist64_zero19:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero20
  inc %r8
branchhist64_zero20:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero21
  inc %r8
branchhist64_zero21:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero22
  inc %r8
branchhist64_zero22:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero23
  inc %r8
branchhist64_zero23:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero24
  inc %r8
branchhist64_zero24:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero25
  inc %r8
branchhist64_zero25:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero26
  inc %r8
branchhist64_zero26:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero27
  inc %r8
branchhist64_zero27:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero28
  inc %r8
branchhist64_zero28:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero29
  inc %r8
branchhist64_zero29:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero30
  inc %r8
branchhist64_zero30:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero31
  inc %r8
branchhist64_zero31:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero32
  inc %r8
branchhist64_zero32:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero33
  inc %r8
branchhist64_zero33:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero34
  inc %r8
branchhist64_zero34:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero35
  inc %r8
branchhist64_zero35:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero36
  inc %r8
branchhist64_zero36:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero37
  inc %r8
branchhist64_zero37:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero38
  inc %r8
branchhist64_zero38:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero39
  inc %r8
branchhist64_zero39:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero40
  inc %r8
branchhist64_zero40:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero41
  inc %r8
branchhist64_zero41:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero42
  inc %r8
branchhist64_zero42:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero43
  inc %r8
branchhist64_zero43:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero44
  inc %r8
branchhist64_zero44:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero45
  inc %r8
branchhist64_zero45:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero46
  inc %r8
branchhist64_zero46:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero47
  inc %r8
branchhist64_zero47:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero48
  inc %r8
branchhist64_zero48:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero49
  inc %r8
branchhist64_zero49:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero50
  inc %r8
branchhist64_zero50:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero51
  inc %r8
branchhist64_zero51:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero52
  inc %r8
branchhist64_zero52:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero53
  inc %r8
branchhist64_zero53:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero54
  inc %r8
branchhist64_zero54:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero55
  inc %r8
branchhist64_zero55:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero56
  inc %r8
branchhist64_zero56:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero57
  inc %r8
branchhist64_zero57:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero58
  inc %r8
branchhist64_zero58:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero59
  inc %r8
branchhist64_zero59:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero60
  inc %r8
branchhist64_zero60:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero61
  inc %r8
branchhist64_zero61:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero62
  inc %r8
branchhist64_zero62:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist64_zero63
  inc %r8
branchhist64_zero63:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist64_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist128:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist128_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero0
  inc %r8
branchhist128_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero1
  inc %r8
branchhist128_zero1:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero2
  inc %r8
branchhist128_zero2:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero3
  inc %r8
branchhist128_zero3:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero4
  inc %r8
branchhist128_zero4:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero5
  inc %r8
branchhist128_zero5:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero6
  inc %r8
branchhist128_zero6:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero7
  inc %r8
branchhist128_zero7:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero8
  inc %r8
branchhist128_zero8:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero9
  inc %r8
branchhist128_zero9:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero10
  inc %r8
branchhist128_zero10:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero11
  inc %r8
branchhist128_zero11:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero12
  inc %r8
branchhist128_zero12:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero13
  inc %r8
branchhist128_zero13:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero14
  inc %r8
branchhist128_zero14:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero15
  inc %r8
branchhist128_zero15:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero16
  inc %r8
branchhist128_zero16:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero17
  inc %r8
branchhist128_zero17:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero18
  inc %r8
branchhist128_zero18:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero19
  inc %r8
branchhist128_zero19:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero20
  inc %r8
branchhist128_zero20:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero21
  inc %r8
branchhist128_zero21:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero22
  inc %r8
branchhist128_zero22:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero23
  inc %r8
branchhist128_zero23:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero24
  inc %r8
branchhist128_zero24:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero25
  inc %r8
branchhist128_zero25:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero26
  inc %r8
branchhist128_zero26:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero27
  inc %r8
branchhist128_zero27:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero28
  inc %r8
branchhist128_zero28:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero29
  inc %r8
branchhist128_zero29:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero30
  inc %r8
branchhist128_zero30:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero31
  inc %r8
branchhist128_zero31:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero32
  inc %r8
branchhist128_zero32:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero33
  inc %r8
branchhist128_zero33:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero34
  inc %r8
branchhist128_zero34:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero35
  inc %r8
branchhist128_zero35:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero36
  inc %r8
branchhist128_zero36:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero37
  inc %r8
branchhist128_zero37:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero38
  inc %r8
branchhist128_zero38:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero39
  inc %r8
branchhist128_zero39:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero40
  inc %r8
branchhist128_zero40:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero41
  inc %r8
branchhist128_zero41:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero42
  inc %r8
branchhist128_zero42:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero43
  inc %r8
branchhist128_zero43:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero44
  inc %r8
branchhist128_zero44:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero45
  inc %r8
branchhist128_zero45:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero46
  inc %r8
branchhist128_zero46:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero47
  inc %r8
branchhist128_zero47:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero48
  inc %r8
branchhist128_zero48:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero49
  inc %r8
branchhist128_zero49:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero50
  inc %r8
branchhist128_zero50:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero51
  inc %r8
branchhist128_zero51:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero52
  inc %r8
branchhist128_zero52:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero53
  inc %r8
branchhist128_zero53:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero54
  inc %r8
branchhist128_zero54:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero55
  inc %r8
branchhist128_zero55:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero56
  inc %r8
branchhist128_zero56:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero57
  inc %r8
branchhist128_zero57:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero58
  inc %r8
branchhist128_zero58:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero59
  inc %r8
branchhist128_zero59:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero60
  inc %r8
branchhist128_zero60:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero61
  inc %r8
branchhist128_zero61:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero62
  inc %r8
branchhist128_zero62:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero63
  inc %r8
branchhist128_zero63:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero64
  inc %r8
branchhist128_zero64:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero65
  inc %r8
branchhist128_zero65:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero66
  inc %r8
branchhist128_zero66:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero67
  inc %r8
branchhist128_zero67:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero68
  inc %r8
branchhist128_zero68:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero69
  inc %r8
branchhist128_zero69:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero70
  inc %r8
branchhist128_zero70:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero71
  inc %r8
branchhist128_zero71:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero72
  inc %r8
branchhist128_zero72:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero73
  inc %r8
branchhist128_zero73:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero74
  inc %r8
branchhist128_zero74:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero75
  inc %r8
branchhist128_zero75:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero76
  inc %r8
branchhist128_zero76:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero77
  inc %r8
branchhist128_zero77:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero78
  inc %r8
branchhist128_zero78:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero79
  inc %r8
branchhist128_zero79:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero80
  inc %r8
branchhist128_zero80:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero81
  inc %r8
branchhist128_zero81:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero82
  inc %r8
branchhist128_zero82:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero83
  inc %r8
branchhist128_zero83:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero84
  inc %r8
branchhist128_zero84:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero85
  inc %r8
branchhist128_zero85:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero86
  inc %r8
branchhist128_zero86:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero87
  inc %r8
branchhist128_zero87:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero88
  inc %r8
branchhist128_zero88:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero89
  inc %r8
branchhist128_zero89:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero90
  inc %r8
branchhist128_zero90:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero91
  inc %r8
branchhist128_zero91:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero92
  inc %r8
branchhist128_zero92:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero93
  inc %r8
branchhist128_zero93:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero94
  inc %r8
branchhist128_zero94:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero95
  inc %r8
branchhist128_zero95:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero96
  inc %r8
branchhist128_zero96:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero97
  inc %r8
branchhist128_zero97:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero98
  inc %r8
branchhist128_zero98:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero99
  inc %r8
branchhist128_zero99:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero100
  inc %r8
branchhist128_zero100:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero101
  inc %r8
branchhist128_zero101:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero102
  inc %r8
branchhist128_zero102:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero103
  inc %r8
branchhist128_zero103:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero104
  inc %r8
branchhist128_zero104:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero105
  inc %r8
branchhist128_zero105:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero106
  inc %r8
branchhist128_zero106:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero107
  inc %r8
branchhist128_zero107:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero108
  inc %r8
branchhist128_zero108:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero109
  inc %r8
branchhist128_zero109:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero110
  inc %r8
branchhist128_zero110:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero111
  inc %r8
branchhist128_zero111:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero112
  inc %r8
branchhist128_zero112:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero113
  inc %r8
branchhist128_zero113:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero114
  inc %r8
branchhist128_zero114:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero115
  inc %r8
branchhist128_zero115:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero116
  inc %r8
branchhist128_zero116:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero117
  inc %r8
branchhist128_zero117:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero118
  inc %r8
branchhist128_zero118:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero119
  inc %r8
branchhist128_zero119:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero120
  inc %r8
branchhist128_zero120:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero121
  inc %r8
branchhist128_zero121:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero122
  inc %r8
branchhist128_zero122:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero123
  inc %r8
branchhist128_zero123:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero124
  inc %r8
branchhist128_zero124:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero125
  inc %r8
branchhist128_zero125:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero126
  inc %r8
branchhist128_zero126:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist128_zero127
  inc %r8
branchhist128_zero127:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist128_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist256:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist256_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero0
  inc %r8
branchhist256_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero1
  inc %r8
branchhist256_zero1:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero2
  inc %r8
branchhist256_zero2:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero3
  inc %r8
branchhist256_zero3:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero4
  inc %r8
branchhist256_zero4:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero5
  inc %r8
branchhist256_zero5:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero6
  inc %r8
branchhist256_zero6:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero7
  inc %r8
branchhist256_zero7:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero8
  inc %r8
branchhist256_zero8:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero9
  inc %r8
branchhist256_zero9:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero10
  inc %r8
branchhist256_zero10:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero11
  inc %r8
branchhist256_zero11:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero12
  inc %r8
branchhist256_zero12:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero13
  inc %r8
branchhist256_zero13:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero14
  inc %r8
branchhist256_zero14:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero15
  inc %r8
branchhist256_zero15:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero16
  inc %r8
branchhist256_zero16:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero17
  inc %r8
branchhist256_zero17:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero18
  inc %r8
branchhist256_zero18:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero19
  inc %r8
branchhist256_zero19:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero20
  inc %r8
branchhist256_zero20:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero21
  inc %r8
branchhist256_zero21:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero22
  inc %r8
branchhist256_zero22:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero23
  inc %r8
branchhist256_zero23:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero24
  inc %r8
branchhist256_zero24:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero25
  inc %r8
branchhist256_zero25:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero26
  inc %r8
branchhist256_zero26:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero27
  inc %r8
branchhist256_zero27:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero28
  inc %r8
branchhist256_zero28:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero29
  inc %r8
branchhist256_zero29:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero30
  inc %r8
branchhist256_zero30:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero31
  inc %r8
branchhist256_zero31:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero32
  inc %r8
branchhist256_zero32:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero33
  inc %r8
branchhist256_zero33:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero34
  inc %r8
branchhist256_zero34:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero35
  inc %r8
branchhist256_zero35:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero36
  inc %r8
branchhist256_zero36:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero37
  inc %r8
branchhist256_zero37:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero38
  inc %r8
branchhist256_zero38:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero39
  inc %r8
branchhist256_zero39:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero40
  inc %r8
branchhist256_zero40:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero41
  inc %r8
branchhist256_zero41:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero42
  inc %r8
branchhist256_zero42:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero43
  inc %r8
branchhist256_zero43:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero44
  inc %r8
branchhist256_zero44:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero45
  inc %r8
branchhist256_zero45:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero46
  inc %r8
branchhist256_zero46:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero47
  inc %r8
branchhist256_zero47:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero48
  inc %r8
branchhist256_zero48:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero49
  inc %r8
branchhist256_zero49:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero50
  inc %r8
branchhist256_zero50:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero51
  inc %r8
branchhist256_zero51:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero52
  inc %r8
branchhist256_zero52:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero53
  inc %r8
branchhist256_zero53:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero54
  inc %r8
branchhist256_zero54:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero55
  inc %r8
branchhist256_zero55:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero56
  inc %r8
branchhist256_zero56:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero57
  inc %r8
branchhist256_zero57:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero58
  inc %r8
branchhist256_zero58:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero59
  inc %r8
branchhist256_zero59:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero60
  inc %r8
branchhist256_zero60:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero61
  inc %r8
branchhist256_zero61:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero62
  inc %r8
branchhist256_zero62:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero63
  inc %r8
branchhist256_zero63:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero64
  inc %r8
branchhist256_zero64:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero65
  inc %r8
branchhist256_zero65:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero66
  inc %r8
branchhist256_zero66:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero67
  inc %r8
branchhist256_zero67:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero68
  inc %r8
branchhist256_zero68:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero69
  inc %r8
branchhist256_zero69:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero70
  inc %r8
branchhist256_zero70:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero71
  inc %r8
branchhist256_zero71:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero72
  inc %r8
branchhist256_zero72:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero73
  inc %r8
branchhist256_zero73:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero74
  inc %r8
branchhist256_zero74:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero75
  inc %r8
branchhist256_zero75:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero76
  inc %r8
branchhist256_zero76:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero77
  inc %r8
branchhist256_zero77:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero78
  inc %r8
branchhist256_zero78:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero79
  inc %r8
branchhist256_zero79:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero80
  inc %r8
branchhist256_zero80:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero81
  inc %r8
branchhist256_zero81:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero82
  inc %r8
branchhist256_zero82:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero83
  inc %r8
branchhist256_zero83:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero84
  inc %r8
branchhist256_zero84:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero85
  inc %r8
branchhist256_zero85:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero86
  inc %r8
branchhist256_zero86:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero87
  inc %r8
branchhist256_zero87:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero88
  inc %r8
branchhist256_zero88:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero89
  inc %r8
branchhist256_zero89:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero90
  inc %r8
branchhist256_zero90:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero91
  inc %r8
branchhist256_zero91:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero92
  inc %r8
branchhist256_zero92:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero93
  inc %r8
branchhist256_zero93:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero94
  inc %r8
branchhist256_zero94:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero95
  inc %r8
branchhist256_zero95:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero96
  inc %r8
branchhist256_zero96:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero97
  inc %r8
branchhist256_zero97:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero98
  inc %r8
branchhist256_zero98:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero99
  inc %r8
branchhist256_zero99:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero100
  inc %r8
branchhist256_zero100:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero101
  inc %r8
branchhist256_zero101:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero102
  inc %r8
branchhist256_zero102:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero103
  inc %r8
branchhist256_zero103:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero104
  inc %r8
branchhist256_zero104:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero105
  inc %r8
branchhist256_zero105:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero106
  inc %r8
branchhist256_zero106:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero107
  inc %r8
branchhist256_zero107:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero108
  inc %r8
branchhist256_zero108:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero109
  inc %r8
branchhist256_zero109:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero110
  inc %r8
branchhist256_zero110:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero111
  inc %r8
branchhist256_zero111:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero112
  inc %r8
branchhist256_zero112:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero113
  inc %r8
branchhist256_zero113:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero114
  inc %r8
branchhist256_zero114:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero115
  inc %r8
branchhist256_zero115:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero116
  inc %r8
branchhist256_zero116:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero117
  inc %r8
branchhist256_zero117:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero118
  inc %r8
branchhist256_zero118:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero119
  inc %r8
branchhist256_zero119:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero120
  inc %r8
branchhist256_zero120:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero121
  inc %r8
branchhist256_zero121:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero122
  inc %r8
branchhist256_zero122:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero123
  inc %r8
branchhist256_zero123:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero124
  inc %r8
branchhist256_zero124:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero125
  inc %r8
branchhist256_zero125:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero126
  inc %r8
branchhist256_zero126:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero127
  inc %r8
branchhist256_zero127:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero128
  inc %r8
branchhist256_zero128:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero129
  inc %r8
branchhist256_zero129:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero130
  inc %r8
branchhist256_zero130:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero131
  inc %r8
branchhist256_zero131:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero132
  inc %r8
branchhist256_zero132:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero133
  inc %r8
branchhist256_zero133:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero134
  inc %r8
branchhist256_zero134:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero135
  inc %r8
branchhist256_zero135:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero136
  inc %r8
branchhist256_zero136:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero137
  inc %r8
branchhist256_zero137:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero138
  inc %r8
branchhist256_zero138:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero139
  inc %r8
branchhist256_zero139:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero140
  inc %r8
branchhist256_zero140:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero141
  inc %r8
branchhist256_zero141:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero142
  inc %r8
branchhist256_zero142:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero143
  inc %r8
branchhist256_zero143:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero144
  inc %r8
branchhist256_zero144:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero145
  inc %r8
branchhist256_zero145:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero146
  inc %r8
branchhist256_zero146:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero147
  inc %r8
branchhist256_zero147:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero148
  inc %r8
branchhist256_zero148:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero149
  inc %r8
branchhist256_zero149:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero150
  inc %r8
branchhist256_zero150:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero151
  inc %r8
branchhist256_zero151:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero152
  inc %r8
branchhist256_zero152:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero153
  inc %r8
branchhist256_zero153:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero154
  inc %r8
branchhist256_zero154:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero155
  inc %r8
branchhist256_zero155:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero156
  inc %r8
branchhist256_zero156:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero157
  inc %r8
branchhist256_zero157:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero158
  inc %r8
branchhist256_zero158:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero159
  inc %r8
branchhist256_zero159:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero160
  inc %r8
branchhist256_zero160:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero161
  inc %r8
branchhist256_zero161:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero162
  inc %r8
branchhist256_zero162:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero163
  inc %r8
branchhist256_zero163:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero164
  inc %r8
branchhist256_zero164:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero165
  inc %r8
branchhist256_zero165:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero166
  inc %r8
branchhist256_zero166:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero167
  inc %r8
branchhist256_zero167:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero168
  inc %r8
branchhist256_zero168:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero169
  inc %r8
branchhist256_zero169:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero170
  inc %r8
branchhist256_zero170:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero171
  inc %r8
branchhist256_zero171:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero172
  inc %r8
branchhist256_zero172:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero173
  inc %r8
branchhist256_zero173:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero174
  inc %r8
branchhist256_zero174:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero175
  inc %r8
branchhist256_zero175:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero176
  inc %r8
branchhist256_zero176:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero177
  inc %r8
branchhist256_zero177:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero178
  inc %r8
branchhist256_zero178:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero179
  inc %r8
branchhist256_zero179:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero180
  inc %r8
branchhist256_zero180:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero181
  inc %r8
branchhist256_zero181:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero182
  inc %r8
branchhist256_zero182:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero183
  inc %r8
branchhist256_zero183:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero184
  inc %r8
branchhist256_zero184:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero185
  inc %r8
branchhist256_zero185:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero186
  inc %r8
branchhist256_zero186:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero187
  inc %r8
branchhist256_zero187:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero188
  inc %r8
branchhist256_zero188:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero189
  inc %r8
branchhist256_zero189:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero190
  inc %r8
branchhist256_zero190:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero191
  inc %r8
branchhist256_zero191:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero192
  inc %r8
branchhist256_zero192:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero193
  inc %r8
branchhist256_zero193:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero194
  inc %r8
branchhist256_zero194:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero195
  inc %r8
branchhist256_zero195:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero196
  inc %r8
branchhist256_zero196:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero197
  inc %r8
branchhist256_zero197:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero198
  inc %r8
branchhist256_zero198:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero199
  inc %r8
branchhist256_zero199:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero200
  inc %r8
branchhist256_zero200:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero201
  inc %r8
branchhist256_zero201:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero202
  inc %r8
branchhist256_zero202:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero203
  inc %r8
branchhist256_zero203:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero204
  inc %r8
branchhist256_zero204:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero205
  inc %r8
branchhist256_zero205:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero206
  inc %r8
branchhist256_zero206:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero207
  inc %r8
branchhist256_zero207:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero208
  inc %r8
branchhist256_zero208:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero209
  inc %r8
branchhist256_zero209:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero210
  inc %r8
branchhist256_zero210:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero211
  inc %r8
branchhist256_zero211:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero212
  inc %r8
branchhist256_zero212:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero213
  inc %r8
branchhist256_zero213:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero214
  inc %r8
branchhist256_zero214:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero215
  inc %r8
branchhist256_zero215:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero216
  inc %r8
branchhist256_zero216:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero217
  inc %r8
branchhist256_zero217:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero218
  inc %r8
branchhist256_zero218:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero219
  inc %r8
branchhist256_zero219:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero220
  inc %r8
branchhist256_zero220:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero221
  inc %r8
branchhist256_zero221:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero222
  inc %r8
branchhist256_zero222:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero223
  inc %r8
branchhist256_zero223:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero224
  inc %r8
branchhist256_zero224:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero225
  inc %r8
branchhist256_zero225:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero226
  inc %r8
branchhist256_zero226:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero227
  inc %r8
branchhist256_zero227:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero228
  inc %r8
branchhist256_zero228:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero229
  inc %r8
branchhist256_zero229:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero230
  inc %r8
branchhist256_zero230:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero231
  inc %r8
branchhist256_zero231:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero232
  inc %r8
branchhist256_zero232:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero233
  inc %r8
branchhist256_zero233:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero234
  inc %r8
branchhist256_zero234:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero235
  inc %r8
branchhist256_zero235:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero236
  inc %r8
branchhist256_zero236:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero237
  inc %r8
branchhist256_zero237:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero238
  inc %r8
branchhist256_zero238:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero239
  inc %r8
branchhist256_zero239:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero240
  inc %r8
branchhist256_zero240:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero241
  inc %r8
branchhist256_zero241:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero242
  inc %r8
branchhist256_zero242:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero243
  inc %r8
branchhist256_zero243:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero244
  inc %r8
branchhist256_zero244:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero245
  inc %r8
branchhist256_zero245:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero246
  inc %r8
branchhist256_zero246:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero247
  inc %r8
branchhist256_zero247:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero248
  inc %r8
branchhist256_zero248:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero249
  inc %r8
branchhist256_zero249:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero250
  inc %r8
branchhist256_zero250:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero251
  inc %r8
branchhist256_zero251:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero252
  inc %r8
branchhist256_zero252:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero253
  inc %r8
branchhist256_zero253:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero254
  inc %r8
branchhist256_zero254:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist256_zero255
  inc %r8
branchhist256_zero255:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist256_loop
  pop %r9
  pop %r8
  pop %rbx
  ret

branchhist512:
  push %rbx
  push %r8
  push %r9
  xor %rbx, %rbx
  xor %r8, %r8
  xor %r9, %r9

branchhist512_loop:
  xor %r11, %r11
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero0
  inc %r8
branchhist512_zero0:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero1
  inc %r8
branchhist512_zero1:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero2
  inc %r8
branchhist512_zero2:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero3
  inc %r8
branchhist512_zero3:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero4
  inc %r8
branchhist512_zero4:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero5
  inc %r8
branchhist512_zero5:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero6
  inc %r8
branchhist512_zero6:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero7
  inc %r8
branchhist512_zero7:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero8
  inc %r8
branchhist512_zero8:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero9
  inc %r8
branchhist512_zero9:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero10
  inc %r8
branchhist512_zero10:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero11
  inc %r8
branchhist512_zero11:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero12
  inc %r8
branchhist512_zero12:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero13
  inc %r8
branchhist512_zero13:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero14
  inc %r8
branchhist512_zero14:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero15
  inc %r8
branchhist512_zero15:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero16
  inc %r8
branchhist512_zero16:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero17
  inc %r8
branchhist512_zero17:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero18
  inc %r8
branchhist512_zero18:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero19
  inc %r8
branchhist512_zero19:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero20
  inc %r8
branchhist512_zero20:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero21
  inc %r8
branchhist512_zero21:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero22
  inc %r8
branchhist512_zero22:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero23
  inc %r8
branchhist512_zero23:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero24
  inc %r8
branchhist512_zero24:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero25
  inc %r8
branchhist512_zero25:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero26
  inc %r8
branchhist512_zero26:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero27
  inc %r8
branchhist512_zero27:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero28
  inc %r8
branchhist512_zero28:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero29
  inc %r8
branchhist512_zero29:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero30
  inc %r8
branchhist512_zero30:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero31
  inc %r8
branchhist512_zero31:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero32
  inc %r8
branchhist512_zero32:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero33
  inc %r8
branchhist512_zero33:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero34
  inc %r8
branchhist512_zero34:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero35
  inc %r8
branchhist512_zero35:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero36
  inc %r8
branchhist512_zero36:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero37
  inc %r8
branchhist512_zero37:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero38
  inc %r8
branchhist512_zero38:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero39
  inc %r8
branchhist512_zero39:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero40
  inc %r8
branchhist512_zero40:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero41
  inc %r8
branchhist512_zero41:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero42
  inc %r8
branchhist512_zero42:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero43
  inc %r8
branchhist512_zero43:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero44
  inc %r8
branchhist512_zero44:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero45
  inc %r8
branchhist512_zero45:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero46
  inc %r8
branchhist512_zero46:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero47
  inc %r8
branchhist512_zero47:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero48
  inc %r8
branchhist512_zero48:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero49
  inc %r8
branchhist512_zero49:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero50
  inc %r8
branchhist512_zero50:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero51
  inc %r8
branchhist512_zero51:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero52
  inc %r8
branchhist512_zero52:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero53
  inc %r8
branchhist512_zero53:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero54
  inc %r8
branchhist512_zero54:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero55
  inc %r8
branchhist512_zero55:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero56
  inc %r8
branchhist512_zero56:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero57
  inc %r8
branchhist512_zero57:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero58
  inc %r8
branchhist512_zero58:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero59
  inc %r8
branchhist512_zero59:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero60
  inc %r8
branchhist512_zero60:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero61
  inc %r8
branchhist512_zero61:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero62
  inc %r8
branchhist512_zero62:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero63
  inc %r8
branchhist512_zero63:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero64
  inc %r8
branchhist512_zero64:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero65
  inc %r8
branchhist512_zero65:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero66
  inc %r8
branchhist512_zero66:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero67
  inc %r8
branchhist512_zero67:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero68
  inc %r8
branchhist512_zero68:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero69
  inc %r8
branchhist512_zero69:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero70
  inc %r8
branchhist512_zero70:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero71
  inc %r8
branchhist512_zero71:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero72
  inc %r8
branchhist512_zero72:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero73
  inc %r8
branchhist512_zero73:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero74
  inc %r8
branchhist512_zero74:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero75
  inc %r8
branchhist512_zero75:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero76
  inc %r8
branchhist512_zero76:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero77
  inc %r8
branchhist512_zero77:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero78
  inc %r8
branchhist512_zero78:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero79
  inc %r8
branchhist512_zero79:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero80
  inc %r8
branchhist512_zero80:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero81
  inc %r8
branchhist512_zero81:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero82
  inc %r8
branchhist512_zero82:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero83
  inc %r8
branchhist512_zero83:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero84
  inc %r8
branchhist512_zero84:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero85
  inc %r8
branchhist512_zero85:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero86
  inc %r8
branchhist512_zero86:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero87
  inc %r8
branchhist512_zero87:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero88
  inc %r8
branchhist512_zero88:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero89
  inc %r8
branchhist512_zero89:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero90
  inc %r8
branchhist512_zero90:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero91
  inc %r8
branchhist512_zero91:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero92
  inc %r8
branchhist512_zero92:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero93
  inc %r8
branchhist512_zero93:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero94
  inc %r8
branchhist512_zero94:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero95
  inc %r8
branchhist512_zero95:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero96
  inc %r8
branchhist512_zero96:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero97
  inc %r8
branchhist512_zero97:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero98
  inc %r8
branchhist512_zero98:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero99
  inc %r8
branchhist512_zero99:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero100
  inc %r8
branchhist512_zero100:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero101
  inc %r8
branchhist512_zero101:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero102
  inc %r8
branchhist512_zero102:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero103
  inc %r8
branchhist512_zero103:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero104
  inc %r8
branchhist512_zero104:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero105
  inc %r8
branchhist512_zero105:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero106
  inc %r8
branchhist512_zero106:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero107
  inc %r8
branchhist512_zero107:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero108
  inc %r8
branchhist512_zero108:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero109
  inc %r8
branchhist512_zero109:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero110
  inc %r8
branchhist512_zero110:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero111
  inc %r8
branchhist512_zero111:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero112
  inc %r8
branchhist512_zero112:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero113
  inc %r8
branchhist512_zero113:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero114
  inc %r8
branchhist512_zero114:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero115
  inc %r8
branchhist512_zero115:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero116
  inc %r8
branchhist512_zero116:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero117
  inc %r8
branchhist512_zero117:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero118
  inc %r8
branchhist512_zero118:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero119
  inc %r8
branchhist512_zero119:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero120
  inc %r8
branchhist512_zero120:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero121
  inc %r8
branchhist512_zero121:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero122
  inc %r8
branchhist512_zero122:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero123
  inc %r8
branchhist512_zero123:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero124
  inc %r8
branchhist512_zero124:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero125
  inc %r8
branchhist512_zero125:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero126
  inc %r8
branchhist512_zero126:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero127
  inc %r8
branchhist512_zero127:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero128
  inc %r8
branchhist512_zero128:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero129
  inc %r8
branchhist512_zero129:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero130
  inc %r8
branchhist512_zero130:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero131
  inc %r8
branchhist512_zero131:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero132
  inc %r8
branchhist512_zero132:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero133
  inc %r8
branchhist512_zero133:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero134
  inc %r8
branchhist512_zero134:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero135
  inc %r8
branchhist512_zero135:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero136
  inc %r8
branchhist512_zero136:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero137
  inc %r8
branchhist512_zero137:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero138
  inc %r8
branchhist512_zero138:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero139
  inc %r8
branchhist512_zero139:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero140
  inc %r8
branchhist512_zero140:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero141
  inc %r8
branchhist512_zero141:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero142
  inc %r8
branchhist512_zero142:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero143
  inc %r8
branchhist512_zero143:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero144
  inc %r8
branchhist512_zero144:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero145
  inc %r8
branchhist512_zero145:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero146
  inc %r8
branchhist512_zero146:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero147
  inc %r8
branchhist512_zero147:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero148
  inc %r8
branchhist512_zero148:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero149
  inc %r8
branchhist512_zero149:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero150
  inc %r8
branchhist512_zero150:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero151
  inc %r8
branchhist512_zero151:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero152
  inc %r8
branchhist512_zero152:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero153
  inc %r8
branchhist512_zero153:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero154
  inc %r8
branchhist512_zero154:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero155
  inc %r8
branchhist512_zero155:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero156
  inc %r8
branchhist512_zero156:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero157
  inc %r8
branchhist512_zero157:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero158
  inc %r8
branchhist512_zero158:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero159
  inc %r8
branchhist512_zero159:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero160
  inc %r8
branchhist512_zero160:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero161
  inc %r8
branchhist512_zero161:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero162
  inc %r8
branchhist512_zero162:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero163
  inc %r8
branchhist512_zero163:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero164
  inc %r8
branchhist512_zero164:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero165
  inc %r8
branchhist512_zero165:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero166
  inc %r8
branchhist512_zero166:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero167
  inc %r8
branchhist512_zero167:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero168
  inc %r8
branchhist512_zero168:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero169
  inc %r8
branchhist512_zero169:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero170
  inc %r8
branchhist512_zero170:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero171
  inc %r8
branchhist512_zero171:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero172
  inc %r8
branchhist512_zero172:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero173
  inc %r8
branchhist512_zero173:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero174
  inc %r8
branchhist512_zero174:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero175
  inc %r8
branchhist512_zero175:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero176
  inc %r8
branchhist512_zero176:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero177
  inc %r8
branchhist512_zero177:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero178
  inc %r8
branchhist512_zero178:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero179
  inc %r8
branchhist512_zero179:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero180
  inc %r8
branchhist512_zero180:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero181
  inc %r8
branchhist512_zero181:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero182
  inc %r8
branchhist512_zero182:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero183
  inc %r8
branchhist512_zero183:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero184
  inc %r8
branchhist512_zero184:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero185
  inc %r8
branchhist512_zero185:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero186
  inc %r8
branchhist512_zero186:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero187
  inc %r8
branchhist512_zero187:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero188
  inc %r8
branchhist512_zero188:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero189
  inc %r8
branchhist512_zero189:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero190
  inc %r8
branchhist512_zero190:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero191
  inc %r8
branchhist512_zero191:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero192
  inc %r8
branchhist512_zero192:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero193
  inc %r8
branchhist512_zero193:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero194
  inc %r8
branchhist512_zero194:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero195
  inc %r8
branchhist512_zero195:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero196
  inc %r8
branchhist512_zero196:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero197
  inc %r8
branchhist512_zero197:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero198
  inc %r8
branchhist512_zero198:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero199
  inc %r8
branchhist512_zero199:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero200
  inc %r8
branchhist512_zero200:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero201
  inc %r8
branchhist512_zero201:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero202
  inc %r8
branchhist512_zero202:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero203
  inc %r8
branchhist512_zero203:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero204
  inc %r8
branchhist512_zero204:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero205
  inc %r8
branchhist512_zero205:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero206
  inc %r8
branchhist512_zero206:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero207
  inc %r8
branchhist512_zero207:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero208
  inc %r8
branchhist512_zero208:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero209
  inc %r8
branchhist512_zero209:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero210
  inc %r8
branchhist512_zero210:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero211
  inc %r8
branchhist512_zero211:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero212
  inc %r8
branchhist512_zero212:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero213
  inc %r8
branchhist512_zero213:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero214
  inc %r8
branchhist512_zero214:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero215
  inc %r8
branchhist512_zero215:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero216
  inc %r8
branchhist512_zero216:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero217
  inc %r8
branchhist512_zero217:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero218
  inc %r8
branchhist512_zero218:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero219
  inc %r8
branchhist512_zero219:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero220
  inc %r8
branchhist512_zero220:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero221
  inc %r8
branchhist512_zero221:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero222
  inc %r8
branchhist512_zero222:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero223
  inc %r8
branchhist512_zero223:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero224
  inc %r8
branchhist512_zero224:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero225
  inc %r8
branchhist512_zero225:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero226
  inc %r8
branchhist512_zero226:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero227
  inc %r8
branchhist512_zero227:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero228
  inc %r8
branchhist512_zero228:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero229
  inc %r8
branchhist512_zero229:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero230
  inc %r8
branchhist512_zero230:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero231
  inc %r8
branchhist512_zero231:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero232
  inc %r8
branchhist512_zero232:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero233
  inc %r8
branchhist512_zero233:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero234
  inc %r8
branchhist512_zero234:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero235
  inc %r8
branchhist512_zero235:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero236
  inc %r8
branchhist512_zero236:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero237
  inc %r8
branchhist512_zero237:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero238
  inc %r8
branchhist512_zero238:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero239
  inc %r8
branchhist512_zero239:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero240
  inc %r8
branchhist512_zero240:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero241
  inc %r8
branchhist512_zero241:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero242
  inc %r8
branchhist512_zero242:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero243
  inc %r8
branchhist512_zero243:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero244
  inc %r8
branchhist512_zero244:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero245
  inc %r8
branchhist512_zero245:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero246
  inc %r8
branchhist512_zero246:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero247
  inc %r8
branchhist512_zero247:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero248
  inc %r8
branchhist512_zero248:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero249
  inc %r8
branchhist512_zero249:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero250
  inc %r8
branchhist512_zero250:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero251
  inc %r8
branchhist512_zero251:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero252
  inc %r8
branchhist512_zero252:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero253
  inc %r8
branchhist512_zero253:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero254
  inc %r8
branchhist512_zero254:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero255
  inc %r8
branchhist512_zero255:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero256
  inc %r8
branchhist512_zero256:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero257
  inc %r8
branchhist512_zero257:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero258
  inc %r8
branchhist512_zero258:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero259
  inc %r8
branchhist512_zero259:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero260
  inc %r8
branchhist512_zero260:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero261
  inc %r8
branchhist512_zero261:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero262
  inc %r8
branchhist512_zero262:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero263
  inc %r8
branchhist512_zero263:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero264
  inc %r8
branchhist512_zero264:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero265
  inc %r8
branchhist512_zero265:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero266
  inc %r8
branchhist512_zero266:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero267
  inc %r8
branchhist512_zero267:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero268
  inc %r8
branchhist512_zero268:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero269
  inc %r8
branchhist512_zero269:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero270
  inc %r8
branchhist512_zero270:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero271
  inc %r8
branchhist512_zero271:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero272
  inc %r8
branchhist512_zero272:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero273
  inc %r8
branchhist512_zero273:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero274
  inc %r8
branchhist512_zero274:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero275
  inc %r8
branchhist512_zero275:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero276
  inc %r8
branchhist512_zero276:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero277
  inc %r8
branchhist512_zero277:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero278
  inc %r8
branchhist512_zero278:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero279
  inc %r8
branchhist512_zero279:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero280
  inc %r8
branchhist512_zero280:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero281
  inc %r8
branchhist512_zero281:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero282
  inc %r8
branchhist512_zero282:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero283
  inc %r8
branchhist512_zero283:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero284
  inc %r8
branchhist512_zero284:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero285
  inc %r8
branchhist512_zero285:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero286
  inc %r8
branchhist512_zero286:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero287
  inc %r8
branchhist512_zero287:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero288
  inc %r8
branchhist512_zero288:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero289
  inc %r8
branchhist512_zero289:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero290
  inc %r8
branchhist512_zero290:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero291
  inc %r8
branchhist512_zero291:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero292
  inc %r8
branchhist512_zero292:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero293
  inc %r8
branchhist512_zero293:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero294
  inc %r8
branchhist512_zero294:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero295
  inc %r8
branchhist512_zero295:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero296
  inc %r8
branchhist512_zero296:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero297
  inc %r8
branchhist512_zero297:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero298
  inc %r8
branchhist512_zero298:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero299
  inc %r8
branchhist512_zero299:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero300
  inc %r8
branchhist512_zero300:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero301
  inc %r8
branchhist512_zero301:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero302
  inc %r8
branchhist512_zero302:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero303
  inc %r8
branchhist512_zero303:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero304
  inc %r8
branchhist512_zero304:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero305
  inc %r8
branchhist512_zero305:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero306
  inc %r8
branchhist512_zero306:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero307
  inc %r8
branchhist512_zero307:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero308
  inc %r8
branchhist512_zero308:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero309
  inc %r8
branchhist512_zero309:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero310
  inc %r8
branchhist512_zero310:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero311
  inc %r8
branchhist512_zero311:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero312
  inc %r8
branchhist512_zero312:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero313
  inc %r8
branchhist512_zero313:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero314
  inc %r8
branchhist512_zero314:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero315
  inc %r8
branchhist512_zero315:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero316
  inc %r8
branchhist512_zero316:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero317
  inc %r8
branchhist512_zero317:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero318
  inc %r8
branchhist512_zero318:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero319
  inc %r8
branchhist512_zero319:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero320
  inc %r8
branchhist512_zero320:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero321
  inc %r8
branchhist512_zero321:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero322
  inc %r8
branchhist512_zero322:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero323
  inc %r8
branchhist512_zero323:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero324
  inc %r8
branchhist512_zero324:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero325
  inc %r8
branchhist512_zero325:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero326
  inc %r8
branchhist512_zero326:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero327
  inc %r8
branchhist512_zero327:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero328
  inc %r8
branchhist512_zero328:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero329
  inc %r8
branchhist512_zero329:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero330
  inc %r8
branchhist512_zero330:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero331
  inc %r8
branchhist512_zero331:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero332
  inc %r8
branchhist512_zero332:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero333
  inc %r8
branchhist512_zero333:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero334
  inc %r8
branchhist512_zero334:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero335
  inc %r8
branchhist512_zero335:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero336
  inc %r8
branchhist512_zero336:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero337
  inc %r8
branchhist512_zero337:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero338
  inc %r8
branchhist512_zero338:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero339
  inc %r8
branchhist512_zero339:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero340
  inc %r8
branchhist512_zero340:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero341
  inc %r8
branchhist512_zero341:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero342
  inc %r8
branchhist512_zero342:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero343
  inc %r8
branchhist512_zero343:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero344
  inc %r8
branchhist512_zero344:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero345
  inc %r8
branchhist512_zero345:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero346
  inc %r8
branchhist512_zero346:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero347
  inc %r8
branchhist512_zero347:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero348
  inc %r8
branchhist512_zero348:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero349
  inc %r8
branchhist512_zero349:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero350
  inc %r8
branchhist512_zero350:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero351
  inc %r8
branchhist512_zero351:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero352
  inc %r8
branchhist512_zero352:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero353
  inc %r8
branchhist512_zero353:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero354
  inc %r8
branchhist512_zero354:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero355
  inc %r8
branchhist512_zero355:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero356
  inc %r8
branchhist512_zero356:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero357
  inc %r8
branchhist512_zero357:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero358
  inc %r8
branchhist512_zero358:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero359
  inc %r8
branchhist512_zero359:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero360
  inc %r8
branchhist512_zero360:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero361
  inc %r8
branchhist512_zero361:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero362
  inc %r8
branchhist512_zero362:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero363
  inc %r8
branchhist512_zero363:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero364
  inc %r8
branchhist512_zero364:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero365
  inc %r8
branchhist512_zero365:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero366
  inc %r8
branchhist512_zero366:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero367
  inc %r8
branchhist512_zero367:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero368
  inc %r8
branchhist512_zero368:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero369
  inc %r8
branchhist512_zero369:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero370
  inc %r8
branchhist512_zero370:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero371
  inc %r8
branchhist512_zero371:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero372
  inc %r8
branchhist512_zero372:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero373
  inc %r8
branchhist512_zero373:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero374
  inc %r8
branchhist512_zero374:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero375
  inc %r8
branchhist512_zero375:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero376
  inc %r8
branchhist512_zero376:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero377
  inc %r8
branchhist512_zero377:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero378
  inc %r8
branchhist512_zero378:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero379
  inc %r8
branchhist512_zero379:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero380
  inc %r8
branchhist512_zero380:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero381
  inc %r8
branchhist512_zero381:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero382
  inc %r8
branchhist512_zero382:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero383
  inc %r8
branchhist512_zero383:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero384
  inc %r8
branchhist512_zero384:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero385
  inc %r8
branchhist512_zero385:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero386
  inc %r8
branchhist512_zero386:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero387
  inc %r8
branchhist512_zero387:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero388
  inc %r8
branchhist512_zero388:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero389
  inc %r8
branchhist512_zero389:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero390
  inc %r8
branchhist512_zero390:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero391
  inc %r8
branchhist512_zero391:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero392
  inc %r8
branchhist512_zero392:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero393
  inc %r8
branchhist512_zero393:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero394
  inc %r8
branchhist512_zero394:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero395
  inc %r8
branchhist512_zero395:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero396
  inc %r8
branchhist512_zero396:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero397
  inc %r8
branchhist512_zero397:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero398
  inc %r8
branchhist512_zero398:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero399
  inc %r8
branchhist512_zero399:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero400
  inc %r8
branchhist512_zero400:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero401
  inc %r8
branchhist512_zero401:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero402
  inc %r8
branchhist512_zero402:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero403
  inc %r8
branchhist512_zero403:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero404
  inc %r8
branchhist512_zero404:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero405
  inc %r8
branchhist512_zero405:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero406
  inc %r8
branchhist512_zero406:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero407
  inc %r8
branchhist512_zero407:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero408
  inc %r8
branchhist512_zero408:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero409
  inc %r8
branchhist512_zero409:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero410
  inc %r8
branchhist512_zero410:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero411
  inc %r8
branchhist512_zero411:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero412
  inc %r8
branchhist512_zero412:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero413
  inc %r8
branchhist512_zero413:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero414
  inc %r8
branchhist512_zero414:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero415
  inc %r8
branchhist512_zero415:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero416
  inc %r8
branchhist512_zero416:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero417
  inc %r8
branchhist512_zero417:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero418
  inc %r8
branchhist512_zero418:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero419
  inc %r8
branchhist512_zero419:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero420
  inc %r8
branchhist512_zero420:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero421
  inc %r8
branchhist512_zero421:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero422
  inc %r8
branchhist512_zero422:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero423
  inc %r8
branchhist512_zero423:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero424
  inc %r8
branchhist512_zero424:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero425
  inc %r8
branchhist512_zero425:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero426
  inc %r8
branchhist512_zero426:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero427
  inc %r8
branchhist512_zero427:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero428
  inc %r8
branchhist512_zero428:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero429
  inc %r8
branchhist512_zero429:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero430
  inc %r8
branchhist512_zero430:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero431
  inc %r8
branchhist512_zero431:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero432
  inc %r8
branchhist512_zero432:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero433
  inc %r8
branchhist512_zero433:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero434
  inc %r8
branchhist512_zero434:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero435
  inc %r8
branchhist512_zero435:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero436
  inc %r8
branchhist512_zero436:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero437
  inc %r8
branchhist512_zero437:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero438
  inc %r8
branchhist512_zero438:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero439
  inc %r8
branchhist512_zero439:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero440
  inc %r8
branchhist512_zero440:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero441
  inc %r8
branchhist512_zero441:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero442
  inc %r8
branchhist512_zero442:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero443
  inc %r8
branchhist512_zero443:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero444
  inc %r8
branchhist512_zero444:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero445
  inc %r8
branchhist512_zero445:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero446
  inc %r8
branchhist512_zero446:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero447
  inc %r8
branchhist512_zero447:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero448
  inc %r8
branchhist512_zero448:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero449
  inc %r8
branchhist512_zero449:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero450
  inc %r8
branchhist512_zero450:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero451
  inc %r8
branchhist512_zero451:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero452
  inc %r8
branchhist512_zero452:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero453
  inc %r8
branchhist512_zero453:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero454
  inc %r8
branchhist512_zero454:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero455
  inc %r8
branchhist512_zero455:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero456
  inc %r8
branchhist512_zero456:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero457
  inc %r8
branchhist512_zero457:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero458
  inc %r8
branchhist512_zero458:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero459
  inc %r8
branchhist512_zero459:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero460
  inc %r8
branchhist512_zero460:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero461
  inc %r8
branchhist512_zero461:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero462
  inc %r8
branchhist512_zero462:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero463
  inc %r8
branchhist512_zero463:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero464
  inc %r8
branchhist512_zero464:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero465
  inc %r8
branchhist512_zero465:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero466
  inc %r8
branchhist512_zero466:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero467
  inc %r8
branchhist512_zero467:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero468
  inc %r8
branchhist512_zero468:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero469
  inc %r8
branchhist512_zero469:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero470
  inc %r8
branchhist512_zero470:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero471
  inc %r8
branchhist512_zero471:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero472
  inc %r8
branchhist512_zero472:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero473
  inc %r8
branchhist512_zero473:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero474
  inc %r8
branchhist512_zero474:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero475
  inc %r8
branchhist512_zero475:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero476
  inc %r8
branchhist512_zero476:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero477
  inc %r8
branchhist512_zero477:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero478
  inc %r8
branchhist512_zero478:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero479
  inc %r8
branchhist512_zero479:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero480
  inc %r8
branchhist512_zero480:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero481
  inc %r8
branchhist512_zero481:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero482
  inc %r8
branchhist512_zero482:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero483
  inc %r8
branchhist512_zero483:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero484
  inc %r8
branchhist512_zero484:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero485
  inc %r8
branchhist512_zero485:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero486
  inc %r8
branchhist512_zero486:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero487
  inc %r8
branchhist512_zero487:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero488
  inc %r8
branchhist512_zero488:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero489
  inc %r8
branchhist512_zero489:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero490
  inc %r8
branchhist512_zero490:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero491
  inc %r8
branchhist512_zero491:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero492
  inc %r8
branchhist512_zero492:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero493
  inc %r8
branchhist512_zero493:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero494
  inc %r8
branchhist512_zero494:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero495
  inc %r8
branchhist512_zero495:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero496
  inc %r8
branchhist512_zero496:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero497
  inc %r8
branchhist512_zero497:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero498
  inc %r8
branchhist512_zero498:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero499
  inc %r8
branchhist512_zero499:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero500
  inc %r8
branchhist512_zero500:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero501
  inc %r8
branchhist512_zero501:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero502
  inc %r8
branchhist512_zero502:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero503
  inc %r8
branchhist512_zero503:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero504
  inc %r8
branchhist512_zero504:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero505
  inc %r8
branchhist512_zero505:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero506
  inc %r8
branchhist512_zero506:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero507
  inc %r8
branchhist512_zero507:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero508
  inc %r8
branchhist512_zero508:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero509
  inc %r8
branchhist512_zero509:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero510
  inc %r8
branchhist512_zero510:
  mov (%rsi,%r11,8), %r10
  inc %r11
  mov (%r10,%rbx,4), %eax 
  test %eax, %eax
  jz branchhist512_zero511
  inc %r8
branchhist512_zero511:
  inc %rbx
  cmp %rbx, %rdx
  cmove %r9, %rbx
  dec %rdi
  jnz branchhist512_loop
  pop %r9
  pop %r8
  pop %rbx
  ret
