.text

.global clktest
.global clkmovtest
.global addtest
.global addnoptest
.global addmovtest
.global rortest
.global shltest
.global mixrorshltest
.global mixrormultest
.global btstest
.global leatest
.global leamultest
.global rorbtstest
.global btsmultest
.global depmovtest
.global indepmovtest
.global vecindepmovtest
.global vecdepmovtest
.global xorzerotest
.global vecxorzerotest
.global movzerotest
.global subzerotest
.global vecsubzerotest
.global depinctest
.global depdectest
.global depaddimmtest
.global addmultest
.global jmpmultest
.global jmptest
.global ntjmptest
.global noptest
.global noptest1b
.global add256int
.global add512int
.global mul512int
.global muldq512int
.global mixadd256int
.global mixadd256int11
.global mixadd256fpint
.global mix256fp
.global latadd256int
.global latadd128int
.global latmul256int
.global latmul512int
.global latmulq512int
.global latmuldq512int
.global latmul128int
.global latadd256int
.global latmul256fp
.global latadd256fp
.global latmul128fp
.global latadd128fp
.global fma512
.global mixfma256fma512
.global mix21fma256fma512
.global fma256
.global fma128
.global mixfmafadd256
.global mixfmaadd256
.global mixfmaadd512
.global mixfma512add256
.global mixfmaand256
.global nemesfpumix21
.global nemesfpu512mix21
.global mixfmaandmem256
.global mixfmaaddmem256
.global latfma512
.global latfma256
.global latfma128
.global mul256fp
.global add256fp
.global add128fp
.global mul128fp
.global latmul64
.global latmul16
.global mul16
.global mul64
.global load128
.global spacedload128
.global load256
.global load512
.global store128
.global store256
.global store512
.global loadscalar
.global spacedstorescalar
.global mixaddmul128int
.global mixmul16mul64
.global mixmul16mul64_21
.global add128int
.global mul128int
.global mix256faddintadd

.global pdeptest
.global pexttest
.global pdepmultest

.global aesenc128
.global aesdec128
.global aesencadd128
.global aesencfma128
.global aesencfadd128
.global aesencmul128

.global fma4_256
.global fma4_128

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

clkmovtest:
  push %rbx
  push %r8
  push %r9
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
clkmovtest_loop:
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  add %r8, %rbx
  mov %rbx, %r8
  sub %r9, %rdi
  jnz clkmovtest_loop
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

addnoptest:
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
addnoptest_loop:
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  nop
  add %r8, %r10
  add %r8, %rcx
  add %r8, %r15
  add %r8, %r14
  nop
  add %r8, %r12
  add %r8, %r11
  add %r8, %r10
  add %r8, %rcx
  nop
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  add %r8, %r11
  nop
  sub %r9, %rdi
  jnz addnoptest_loop
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

addmovtest:
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
addmovtest_loop:
  add %r8, %r15
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  mov %r15, %rdx
  add %r8, %r10
  add %r8, %rcx
  add %r8, %r15
  add %r8, %r14
  mov %r15, %rdx
  add %r8, %r12
  add %r8, %r11
  add %r8, %r10
  add %r8, %rcx
  mov %r15, %rdx
  add %r8, %r14
  add %r8, %r13
  add %r8, %r12
  add %r8, %r11
  mov %r15, %rdx
  sub %r9, %rdi
  jnz addmovtest_loop
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

rortest:
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
  mov %r8, %r15
rortest_loop:
  ror $1, %r15
  ror $1, %r14
  ror $1, %r13
  ror $1, %r12
  ror $1, %r11
  ror $1, %r15
  ror $1, %r14
  ror $1, %r13
  ror $1, %r12
  ror $1, %r11
  ror $1, %r15
  ror $1, %r14
  ror $1, %r13
  ror $1, %r12
  ror $1, %r11
  ror $1, %r15
  ror $1, %r14
  ror $1, %r13
  ror $1, %r12
  ror $1, %r11
  sub %r9, %rdi
  jnz rortest_loop
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

shltest:
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
  mov %r8, %r15
shltest_loop:
  shl $1, %r15
  shl $1, %r14
  shl $1, %r13
  shl $1, %r12
  shl $1, %r11
  shl $1, %r15
  shl $1, %r14
  shl $1, %r13
  shl $1, %r12
  shl $1, %r11
  shl $1, %r15
  shl $1, %r14
  shl $1, %r13
  shl $1, %r12
  shl $1, %r11
  shl $1, %r15
  shl $1, %r14
  shl $1, %r13
  shl $1, %r12
  shl $1, %r11
  sub %r9, %rdi
  jnz shltest_loop
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

mixrorshltest:
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
  mov %r8, %r15
mixrorshltest_loop:
  ror $1, %r15
  shl $1, %r14
  ror $1, %r13
  shl $1, %r12
  ror $1, %r11
  shl $1, %r15
  ror $1, %r14
  shl $1, %r13
  ror $1, %r12
  shl $1, %r11
  ror $1, %r15
  shl $1, %r14
  ror $1, %r13
  shl $1, %r12
  ror $1, %r11
  shl $1, %r15
  ror $1, %r14
  shl $1, %r13
  ror $1, %r12
  shl $1, %r11
  sub %r9, %rdi
  jnz mixrorshltest_loop
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

mixrormultest:
  push %rbx
  push %rcx
  push %rsi
  push %rdx
  push %r8
  push %r9
  push %r10
  push %r11
  push %r12
  push %r13
  push %r14
  push %r15
  mov $3, %r8
  mov $20, %r9
  mov %r8, %rbx
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r8, %r15
mixrormultest_loop:
  ror $1, %r15
  imul %r8, %r14
  mov %r9, %r14
  ror $1, %r13
  imul %r8, %r12
  mov %r9, %r12
  ror $1, %r11
  imul %r8, %r10
  mov %r9, %r10
  ror $1, %rbx
  imul %r8, %rcx
  mov %r9, %rcx
  ror $1, %rsi
  imul %r8, %rax
  mov %r9, %rax
  ror $1, %r15
  imul %r8, %r14
  mov %r9, %r14
  ror $1, %r13
  imul %r8, %r12
  mov %r9, %r12
  ror $1, %r11
  imul %r8, %r10
  mov %r9, %r10
  ror $1, %rbx
  imul %r8, %rcx
  mov %r9, %rcx
  ror $1, %rsi
  imul %r8, %rdx
  sub %r9, %rdi
  jnz mixrormultest_loop
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8
  pop %rdx
  pop %rsi
  pop %rcx
  pop %rbx
  ret

rorbtstest:
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
  mov $20, %r9
  mov %r8, %rbx
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r8, %r15
  inc %r8
rorbtstest_loop:
  bts %r8, %r15
  ror $1, %r14
  bts %r8, %r13
  ror $1, %r12
  bts %r8, %r11
  ror $1, %r10
  bts %r8, %rcx
  ror $1, %rbx
  bts %r8, %rdx
  ror $1, %rsi
  bts %r8, %r15
  ror $1, %r14
  bts %r8, %r13
  ror $1, %r12
  bts %r8, %r11
  ror $1, %r10
  bts %r8, %rcx
  ror $1, %rbx
  bts %r8, %rdx
  ror $1, %rsi
  sub %r9, %rdi
  jnz rorbtstest_loop
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

btstest:
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
  mov %r8, %r15
  inc %r8
btstest_loop:
  bts %r8, %r15
  bts %r8, %r14
  bts %r8, %r13
  bts %r8, %r12
  bts %r8, %r11
  bts %r8, %r15
  bts %r8, %r14
  bts %r8, %r13
  bts %r8, %r12
  bts %r8, %r11
  bts %r8, %r15
  bts %r8, %r14
  bts %r8, %r13
  bts %r8, %r12
  bts %r8, %r11
  bts %r8, %r15
  bts %r8, %r14
  bts %r8, %r13
  bts %r8, %r12
  bts %r8, %r11
  sub %r9, %rdi
  jnz btstest_loop
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

leatest:
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
  mov %r8, %r15
  inc %r8
leatest_loop:
  lea (%r9,%r10,8), %r10
  lea (%r9,%r11,8), %r11
  lea (%r9,%r12,8), %r12
  lea (%r9,%r13,8), %r13
  lea (%r9,%r14,8), %r14
  lea (%r9,%r15,8), %r15
  lea (%r9,%r10,8), %r10
  lea (%r9,%r11,8), %r11
  lea (%r9,%r12,8), %r12
  lea (%r9,%r13,8), %r13
  lea (%r9,%r14,8), %r14
  lea (%r9,%r15,8), %r15
  lea (%r9,%r10,8), %r10
  lea (%r9,%r11,8), %r11
  lea (%r9,%r12,8), %r12
  lea (%r9,%r13,8), %r13
  lea (%r9,%r14,8), %r14
  lea (%r9,%r15,8), %r15
  lea (%r9,%r10,8), %r10
  lea (%r9,%r11,8), %r11
  sub %r9, %rdi
  jnz leatest_loop
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

leamultest:
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
  mov $20, %r9
  mov %r8, %rbx
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r8, %r15
  inc %r8
leamultest_loop:
  lea (%r9,%r15,8), %r15
  imul %r8, %r14
  mov %r8, %r14
  lea (%r9,%r13,8), %r13
  imul %r8, %r12
  mov %r8, %r12
  lea (%r9,%r11,8), %r11
  imul %r8, %r10
  mov %r8, %r10
  lea (%r9,%rbx,8), %rbx
  imul %r8, %rcx
  mov %r8, %rcx
  lea (%r9,%rdx,8), %rdx
  imul %r8, %rax
  lea (%r9,%r15,8), %r15
  imul %r8, %r14
  lea (%r9,%r13,8), %r13
  imul %r8, %r12
  lea (%r9,%r11,8), %r11
  imul %r8, %r10
  lea (%r9,%rbx,8), %rbx
  imul %r8, %rcx
  lea (%r9,%rdx,8), %rdx
  imul %r8, %rax
  sub %r9, %rdi
  jnz leamultest_loop
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


btsmultest:
  push %rbx
  push %rcx
  push %rsi
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
  mov $20, %r9
  mov %r8, %rbx
  mov %r8, %rdx
  mov %r8, %rsi
  mov %r8, %rcx
  mov %r8, %r10
  mov %r8, %r11
  mov %r8, %r12
  mov %r8, %r13
  mov %r8, %r14
  mov %r8, %r15
  inc %r8
btsmultest_loop:
  imul %r8, %r14
  bts %r8, %r13
  mov %r8, %r13
  imul %r8, %r12
  bts %r8, %r11
  mov %r8, %r11
  imul %r8, %r10
  bts %r8, %rbx
  imul %r8, %rcx
  mov %r8, %rcx
  bts %r8, %rsi
  imul %r8, %rax
  mov %r8, %rax
  bts %r8, %r15
  imul %r8, %r14
  mov %r8, %r14
  bts %r8, %r13
  imul %r8, %r12
  mov %r8, %r12
  bts %r8, %r11
  imul %r8, %r10
  mov %r8, %r10
  bts %r8, %rbx
  imul %r8, %rcx
  mov %r8, %rcx
  bts %r8, %rsi
  imul %r8, %rdx
  mov %r8, %rdx
  bts %r8, %r11
  sub %r9, %rdi
  jnz btsmultest_loop
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8
  pop %rdx
  pop %rsi
  pop %rcx
  pop %rbx
  ret


jmptest:
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
  mov $20, %r9
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
jmptest_loop:
  jmp jmptest1
  add $1, %rax
jmptest1:
  jmp jmptest2
  add $2, %rax
jmptest2:
  jmp jmptest3
  add $3, %rax
jmptest3:
  jmp jmptest4
  add $4, %rax
jmptest4:
  jmp jmptest5
  add $5, %rax
jmptest5:
  jmp jmptest6
  add $6, %rax
jmptest6:
  jmp jmptest7
  add $7, %rax
jmptest7:
  jmp jmptest8
  add $8, %rax
jmptest8:
  jmp jmptest9
  add $9, %rax
jmptest9:
  jmp jmptest10
  add $10, %rax
jmptest10:
  jmp jmptest11
  add $11, %rax
jmptest11:
  jmp jmptest12
  add $12, %rax
jmptest12:
  jmp jmptest13
  add $13, %rax
jmptest13:
  jmp jmptest14
  add $14, %rax
jmptest14:
  jmp jmptest15
  add $15, %rax
jmptest15:
  jmp jmptest16
  add $16, %rax
jmptest16:
  jmp jmptest17
  add $17, %rax
jmptest17:
  jmp jmptest18
  add $18, %rax
jmptest18:
  jmp jmptest19
  add $19, %rax
jmptest19:      /* jump back counts as nr 20 */
  sub %r9, %rdi
  jnz jmptest_loop
jmptest_jellydonut:
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

ntjmptest:
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
  mov $20, %r9
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
ntjmptest_loop:
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  cmp %r8, %r9
  je jmpmultest_jellydonut
  sub %r9, %rdi
  jnz ntjmptest_loop
ntjmptest_jellydonut:
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
  mov $2, %r8
  mov $20, %r9
  xor %rbx, %rbx
  xor %rcx, %rcx
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
  jnz jmpmultest_loop
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
  //vpbroadcastq %xmm1, %ymm0
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

mul512int:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %zmm0
  vmovdqu64 %zmm0, %zmm1
  vmovdqu64 %zmm0, %zmm2
  vmovdqu64 %zmm0, %zmm3
  vmovdqu64 %zmm0, %zmm4
  vmovdqu64 %zmm0, %zmm5
mul512int_loop:
  vpmulld %zmm0, %zmm1, %zmm1
  vpmulld %zmm0, %zmm2, %zmm2
  vpmulld %zmm0, %zmm3, %zmm3
  vpmulld %zmm0, %zmm4, %zmm4
  vpmulld %zmm0, %zmm5, %zmm5
  vpmulld %zmm0, %zmm1, %zmm1
  vpmulld %zmm0, %zmm2, %zmm2
  vpmulld %zmm0, %zmm3, %zmm3
  vpmulld %zmm0, %zmm4, %zmm4
  vpmulld %zmm0, %zmm5, %zmm5
  vpmulld %zmm0, %zmm1, %zmm1
  vpmulld %zmm0, %zmm2, %zmm2
  vpmulld %zmm0, %zmm3, %zmm3
  vpmulld %zmm0, %zmm4, %zmm4
  vpmulld %zmm0, %zmm5, %zmm5
  vpmulld %zmm0, %zmm1, %zmm1
  vpmulld %zmm0, %zmm2, %zmm2
  vpmulld %zmm0, %zmm3, %zmm3
  vpmulld %zmm0, %zmm4, %zmm4
  vpmulld %zmm0, %zmm5, %zmm5
  sub %r9, %rdi
  jnz mul512int_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

muldq512int:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %zmm0
  vmovdqu64 %zmm0, %zmm1
  vmovdqu64 %zmm0, %zmm2
  vmovdqu64 %zmm0, %zmm3
  vmovdqu64 %zmm0, %zmm4
  vmovdqu64 %zmm0, %zmm5
muldq512int_loop:
  vpmuldq %zmm0, %zmm1, %zmm1
  vpmuldq %zmm0, %zmm2, %zmm2
  vpmuldq %zmm0, %zmm3, %zmm3
  vpmuldq %zmm0, %zmm4, %zmm4
  vpmuldq %zmm0, %zmm5, %zmm5
  vpmuldq %zmm0, %zmm1, %zmm1
  vpmuldq %zmm0, %zmm2, %zmm2
  vpmuldq %zmm0, %zmm3, %zmm3
  vpmuldq %zmm0, %zmm4, %zmm4
  vpmuldq %zmm0, %zmm5, %zmm5
  vpmuldq %zmm0, %zmm1, %zmm1
  vpmuldq %zmm0, %zmm2, %zmm2
  vpmuldq %zmm0, %zmm3, %zmm3
  vpmuldq %zmm0, %zmm4, %zmm4
  vpmuldq %zmm0, %zmm5, %zmm5
  vpmuldq %zmm0, %zmm1, %zmm1
  vpmuldq %zmm0, %zmm2, %zmm2
  vpmuldq %zmm0, %zmm3, %zmm3
  vpmuldq %zmm0, %zmm4, %zmm4
  vpmuldq %zmm0, %zmm5, %zmm5
  sub %r9, %rdi
  jnz muldq512int_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

add512int:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %zmm0
  vmovdqu64 %zmm0, %zmm1
  vmovdqu64 %zmm0, %zmm2
  vmovdqu64 %zmm0, %zmm3
  vmovdqu64 %zmm0, %zmm4
  vmovdqu64 %zmm0, %zmm5
add512int_loop:
  vpaddq %zmm0, %zmm1, %zmm1
  vpaddq %zmm0, %zmm2, %zmm2
  vpaddq %zmm0, %zmm3, %zmm3
  vpaddq %zmm0, %zmm4, %zmm4
  vpaddq %zmm0, %zmm5, %zmm5
  vpaddq %zmm0, %zmm1, %zmm1
  vpaddq %zmm0, %zmm2, %zmm2
  vpaddq %zmm0, %zmm3, %zmm3
  vpaddq %zmm0, %zmm4, %zmm4
  vpaddq %zmm0, %zmm5, %zmm5
  vpaddq %zmm0, %zmm1, %zmm1
  vpaddq %zmm0, %zmm2, %zmm2
  vpaddq %zmm0, %zmm3, %zmm3
  vpaddq %zmm0, %zmm4, %zmm4
  vpaddq %zmm0, %zmm5, %zmm5
  vpaddq %zmm0, %zmm1, %zmm1
  vpaddq %zmm0, %zmm2, %zmm2
  vpaddq %zmm0, %zmm3, %zmm3
  vpaddq %zmm0, %zmm4, %zmm4
  vpaddq %zmm0, %zmm5, %zmm5
  sub %r9, %rdi
  jnz add512int_loop
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

mix256faddintadd:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %ymm8
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %ymm6
  vmovups %ymm6, %ymm7
  vmovups %ymm6, %ymm9
  vmovups %ymm6, %ymm11
  vmovups %ymm6, %ymm13
  vmovups %ymm6, %ymm15
  vmovdqu %ymm8, %ymm10
  vmovdqu %ymm8, %ymm12
  vmovdqu %ymm8, %ymm14
mix256faddintadd_loop:
  vaddps %ymm6, %ymm7, %ymm7
  vpaddd %ymm8, %ymm8, %ymm8
  vaddps %ymm6, %ymm9, %ymm9
  vpaddd %ymm10, %ymm10, %ymm10
  vaddps %ymm6, %ymm11, %ymm11
  vpaddd %ymm12, %ymm12, %ymm12
  vaddps %ymm6, %ymm13, %ymm13
  vpaddd %ymm14, %ymm14, %ymm14
  vaddps %ymm6, %ymm15, %ymm15
  vpaddd %ymm5, %ymm5, %ymm5
  vaddps %ymm6, %ymm7, %ymm7
  vpaddd %ymm8, %ymm8, %ymm8
  vaddps %ymm6, %ymm9, %ymm9
  vpaddd %ymm10, %ymm10, %ymm10
  vaddps %ymm6, %ymm11, %ymm11
  vpaddd %ymm12, %ymm12, %ymm12
  vaddps %ymm6, %ymm13, %ymm13
  vpaddd %ymm14, %ymm14, %ymm14
  vaddps %ymm6, %ymm15, %ymm15
  vpaddd %ymm5, %ymm5, %ymm5
  sub %r9, %rdi
  jnz mix256faddintadd_loop
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
  movups %xmm6, -32(%rsp)
  vbroadcastss -32(%rsp), %ymm6
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

latadd512int:
  push %r9
  push %r8
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastq %xmm1, %zmm0
  vmovdqa64 %zmm0, %zmm1
  vmovdqa64 %zmm0, %zmm2
  vmovdqa64 %zmm0, %zmm3
  vmovdqa64 %zmm0, %zmm4
  vmovdqa64 %zmm0, %zmm5
latadd51a2int_loop:
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
  vpaddq %zmm0, %zmm0, %zmm0
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

latmul512int:
  push %r9
  push %r8
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastd %xmm1, %zmm0
  vmovdqu64 %zmm0, %zmm1
  vmovdqu64 %zmm0, %zmm2
  vmovdqu64 %zmm0, %zmm3
  vmovdqu64 %zmm0, %zmm4
  vmovdqu64 %zmm0, %zmm5
latmul512int_loop:
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  vpmulld %zmm0, %zmm0, %zmm0
  sub %r9, %rdi
  jnz latmul512int_loop
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

latmuldq512int:
  push %r9
  push %r8
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastd %xmm1, %zmm0
  vmovdqu64 %zmm0, %zmm1
  vmovdqu64 %zmm0, %zmm2
  vmovdqu64 %zmm0, %zmm3
  vmovdqu64 %zmm0, %zmm4
  vmovdqu64 %zmm0, %zmm5
latmuldq512int_loop:
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  vpmuldq %zmm0, %zmm0, %zmm0
  sub %r9, %rdi
  jnz latmuldq512int_loop
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

latmulq512int:
  push %r9
  push %r8
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  mov $20, %r9
  movq %r9, %xmm1
  vpbroadcastd %xmm1, %zmm0
  vmovdqu64 %zmm0, %zmm1
  vmovdqu64 %zmm0, %zmm2
  vmovdqu64 %zmm0, %zmm3
  vmovdqu64 %zmm0, %zmm4
  vmovdqu64 %zmm0, %zmm5
latmulq512int_loop:
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  vpmullq %zmm0, %zmm0, %zmm0
  sub %r9, %rdi
  jnz latmulq512int_loop
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
  //vpbroadcastd %xmm1, %ymm0
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
  mov $20, %r9
  movq %r9, %xmm1
  //vpbroadcastq %xmm1, %xmm0
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

add128int:
  push %r9
  mov $20, %r9
  movq %r9, %xmm1
  //vpbroadcastq %xmm1, %xmm0
add128int_loop:
  paddq %xmm0, %xmm0
  paddq %xmm1, %xmm1
  paddq %xmm2, %xmm2
  paddq %xmm3, %xmm3
  paddq %xmm4, %xmm4
  paddq %xmm0, %xmm0
  paddq %xmm1, %xmm1
  paddq %xmm2, %xmm2
  paddq %xmm3, %xmm3
  paddq %xmm4, %xmm4
  paddq %xmm0, %xmm0
  paddq %xmm1, %xmm1
  paddq %xmm2, %xmm2
  paddq %xmm3, %xmm3
  paddq %xmm4, %xmm4
  paddq %xmm0, %xmm0
  paddq %xmm1, %xmm1
  paddq %xmm2, %xmm2
  paddq %xmm3, %xmm3
  paddq %xmm4, %xmm4
  sub %r9, %rdi
  jnz add128int_loop
  movq %xmm1, %rax
  pop %r9
  ret

aesenc128:
  push %r9
  mov $20, %r9
  movq %r9, %xmm1
  vzeroall
  pxor %xmm0, %xmm0
  pxor %xmm1, %xmm1
  pxor %xmm2, %xmm2
  pxor %xmm3, %xmm3
  pxor %xmm4, %xmm4
  pxor %xmm5, %xmm5
aesenc128_loop:
  aesenc %xmm0, %xmm1
  aesenc %xmm0, %xmm2
  aesenc %xmm0, %xmm3
  aesenc %xmm0, %xmm4
  aesenc %xmm0, %xmm5
  aesenc %xmm0, %xmm1
  aesenc %xmm0, %xmm2
  aesenc %xmm0, %xmm3
  aesenc %xmm0, %xmm4
  aesenc %xmm0, %xmm5
  aesenc %xmm0, %xmm1
  aesenc %xmm0, %xmm2
  aesenc %xmm0, %xmm3
  aesenc %xmm0, %xmm4
  aesenc %xmm0, %xmm5
  aesenc %xmm0, %xmm1
  aesenc %xmm0, %xmm2
  aesenc %xmm0, %xmm3
  aesenc %xmm0, %xmm4
  aesenc %xmm0, %xmm5
  sub %r9, %rdi
  jnz aesenc128_loop
  movq %xmm1, %rax
  pop %r9
  ret

aesencadd128:
  push %r9
  mov $20, %r9
  movq %r9, %xmm1
  vzeroall
  pxor %xmm0, %xmm0
  pxor %xmm1, %xmm1
  pxor %xmm2, %xmm2
  pxor %xmm3, %xmm3
  pxor %xmm4, %xmm4
  pxor %xmm5, %xmm5
  pxor %xmm6, %xmm6
  pxor %xmm7, %xmm7
  pxor %xmm8, %xmm8
  pxor %xmm9, %xmm9
  pxor %xmm10, %xmm10
  pxor %xmm11, %xmm11
  pxor %xmm12, %xmm12
  pxor %xmm13, %xmm13
aesencadd128_loop:
  aesenc %xmm0, %xmm1
  paddd %xmm6, %xmm2
  paddd %xmm6, %xmm3
  paddd %xmm6, %xmm4
  aesenc %xmm0, %xmm5
  paddd %xmm6, %xmm7
  paddd %xmm6, %xmm8
  paddd %xmm6, %xmm9
  aesenc %xmm0, %xmm10
  paddd %xmm6, %xmm2
  paddd %xmm6, %xmm3
  paddd %xmm6, %xmm4
  aesenc %xmm0, %xmm1
  paddd %xmm6, %xmm7
  paddd %xmm6, %xmm8
  paddd %xmm6, %xmm9
  aesenc %xmm0, %xmm10
  paddd %xmm6, %xmm11
  paddd %xmm6, %xmm12
  paddd %xmm6, %xmm13
  sub %r9, %rdi
  jnz aesencadd128_loop
  movq %xmm1, %rax
  pop %r9
  ret

aesencfma128:
  push %r9
  mov $15, %r9
  movq %r9, %xmm1
  vzeroall
  pxor %xmm0, %xmm0
  pxor %xmm1, %xmm1
  xorps %xmm2, %xmm2
  xorps %xmm3, %xmm3
  xorps %xmm4, %xmm4
  pxor %xmm5, %xmm5
  xorps %xmm6, %xmm6
  xorps %xmm7, %xmm7
  xorps %xmm8, %xmm8
  xorps %xmm9, %xmm9
  pxor %xmm10, %xmm10
  xorps %xmm11, %xmm11
  xorps %xmm12, %xmm12
  xorps %xmm13, %xmm13
  xorps %xmm14, %xmm14
  xorps %xmm15, %xmm15
  vxorps %xmm16, %xmm16, %xmm16
  vxorps %xmm17, %xmm17, %xmm17
  vxorps %xmm18, %xmm18, %xmm18
  vxorps %xmm19, %xmm19, %xmm19
aesencfma128_loop:
  aesenc %xmm0, %xmm1
  vfmadd132ps %xmm6, %xmm2, %xmm2
  vfmadd132ps %xmm6, %xmm3, %xmm3
  aesenc %xmm0, %xmm5
  vfmadd132ps %xmm6, %xmm7, %xmm7
  vfmadd132ps %xmm6, %xmm8, %xmm8
  aesenc %xmm0, %xmm10
  vfmadd132ps %xmm6, %xmm11, %xmm11
  vfmadd132ps %xmm6, %xmm12, %xmm12
  aesenc %xmm0, %xmm1
  vfmadd132ps %xmm6, %xmm14, %xmm14
  vfmadd132ps %xmm6, %xmm15, %xmm15
  aesenc %xmm0, %xmm10
  vfmadd132ps %xmm6, %xmm17, %xmm17
  vfmadd132ps %xmm6, %xmm18, %xmm18
  sub %r9, %rdi
  jnz aesencfma128_loop
  movq %xmm1, %rax
  pop %r9
  ret

aesencfadd128:
  push %r9
  mov $15, %r9
  movq %r9, %xmm1
  vzeroall
  pxor %xmm0, %xmm0
  pxor %xmm1, %xmm1
  xorps %xmm2, %xmm2
  xorps %xmm3, %xmm3
  xorps %xmm4, %xmm4
  pxor %xmm5, %xmm5
  xorps %xmm6, %xmm6
  xorps %xmm7, %xmm7
  xorps %xmm8, %xmm8
  xorps %xmm9, %xmm9
  pxor %xmm10, %xmm10
  xorps %xmm11, %xmm11
  xorps %xmm12, %xmm12
  xorps %xmm13, %xmm13
  xorps %xmm14, %xmm14
  xorps %xmm15, %xmm15
  vxorps %xmm16, %xmm16, %xmm16
  vxorps %xmm17, %xmm17, %xmm17
  vxorps %xmm18, %xmm18, %xmm18
  vxorps %xmm19, %xmm19, %xmm19
aesencfadd128_loop:
  aesenc %xmm0, %xmm1
  vaddps %xmm6, %xmm2, %xmm2
  vaddps %xmm6, %xmm3, %xmm3
  aesenc %xmm0, %xmm5
  vaddps %xmm6, %xmm7, %xmm7
  vaddps %xmm6, %xmm8, %xmm8
  aesenc %xmm0, %xmm10
  vaddps %xmm6, %xmm11, %xmm11
  vaddps %xmm6, %xmm12, %xmm12
  aesenc %xmm0, %xmm1
  vaddps %xmm6, %xmm14, %xmm14
  vaddps %xmm6, %xmm15, %xmm15
  aesenc %xmm0, %xmm10
  vaddps %xmm6, %xmm17, %xmm17
  vaddps %xmm6, %xmm18, %xmm18
  sub %r9, %rdi
  jg aesencfadd128_loop
  movq %xmm1, %rax
  pop %r9
  ret

aesencmul128:
  push %r9
  mov $15, %r9
  vzeroall
  movq %r9, %xmm6
  pxor %xmm0, %xmm0
  pxor %xmm5, %xmm5
  pxor %xmm10, %xmm10
  xorps %xmm1, %xmm1
  xorps %xmm2, %xmm2
  xorps %xmm3, %xmm3
  xorps %xmm4, %xmm4
  xorps %xmm7, %xmm7
  xorps %xmm8, %xmm8
  xorps %xmm11, %xmm11
  xorps %xmm12, %xmm12
  xorps %xmm14, %xmm14
  xorps %xmm15, %xmm15
aesencmul128_loop:
  aesenc %xmm0, %xmm1
  pmullw %xmm6, %xmm2
  pmullw %xmm6, %xmm3
  aesenc %xmm0, %xmm5
  pmullw %xmm6, %xmm7
  pmullw %xmm6, %xmm8
  aesenc %xmm0, %xmm10
  pmullw %xmm6, %xmm11
  pmullw %xmm6, %xmm12
  aesenc %xmm0, %xmm1
  pmullw %xmm6, %xmm4
  pmullw %xmm6, %xmm6
  aesenc %xmm0, %xmm10
  pmullw %xmm6, %xmm13
  pmullw %xmm6, %xmm14
  sub %r9, %rdi
  jg aesencmul128_loop
  movq %xmm1, %rax
  pop %r9
  ret

aesdec128:
  push %r9
  mov $20, %r9
  movq %r9, %xmm1
  vzeroall
  pxor %xmm0, %xmm0
  pxor %xmm1, %xmm1
  pxor %xmm2, %xmm2
  pxor %xmm3, %xmm3
  pxor %xmm4, %xmm4
  pxor %xmm5, %xmm5
aesdec128_loop:
  aesdec %xmm0, %xmm1
  aesdec %xmm0, %xmm2
  aesdec %xmm0, %xmm3
  aesdec %xmm0, %xmm4
  aesdec %xmm0, %xmm5
  aesdec %xmm0, %xmm1
  aesdec %xmm0, %xmm2
  aesdec %xmm0, %xmm3
  aesdec %xmm0, %xmm4
  aesdec %xmm0, %xmm5
  aesdec %xmm0, %xmm1
  aesdec %xmm0, %xmm2
  aesdec %xmm0, %xmm3
  aesdec %xmm0, %xmm4
  aesdec %xmm0, %xmm5
  aesdec %xmm0, %xmm1
  aesdec %xmm0, %xmm2
  aesdec %xmm0, %xmm3
  aesdec %xmm0, %xmm4
  aesdec %xmm0, %xmm5
  sub %r9, %rdi
  jnz aesdec128_loop
  movq %xmm1, %rax
  pop %r9
  ret

mul128int:
  push %r9
  mov $20, %r9
  movq %r9, %xmm1
  //vpbroadcastd %xmm1, %xmm0
mul128int_loop:
  pmulld %xmm0, %xmm0
  pmulld %xmm1, %xmm1
  pmulld %xmm2, %xmm2
  pmulld %xmm3, %xmm3
  pmulld %xmm4, %xmm4
  pmulld %xmm0, %xmm0
  pmulld %xmm1, %xmm1
  pmulld %xmm2, %xmm2
  pmulld %xmm3, %xmm3
  pmulld %xmm4, %xmm4
  pmulld %xmm0, %xmm0
  pmulld %xmm1, %xmm1
  pmulld %xmm2, %xmm2
  pmulld %xmm3, %xmm3
  pmulld %xmm4, %xmm4
  pmulld %xmm0, %xmm0
  pmulld %xmm1, %xmm1
  pmulld %xmm2, %xmm2
  pmulld %xmm3, %xmm3
  pmulld %xmm4, %xmm4
  sub %r9, %rdi
  jnz mul128int_loop
  movq %xmm1, %rax
  pop %r9
  ret

latmul128int:
  push %r9
  mov $20, %r9
  movq %r9, %xmm1
  //vpbroadcastd %xmm1, %xmm0
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
  mov $20, %r9
  movq %r9, %xmm1
  //vpbroadcastd %xmm1, %xmm0
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
  movups %xmm6, -32(%rsp)
  vbroadcastss -32(%rsp), %ymm6
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
  movups %xmm0, -32(%rsp)
  vbroadcastss -32(%rsp), %ymm6
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
  movups %xmm0, -32(%rsp)
  vbroadcastss -32(%rsp), %ymm6
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
  movups %xmm6, -32(%rsp)
  vbroadcastss -32(%rsp), %ymm6
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

fma512:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %zmm6
  vmovups %zmm6, %zmm5
  vmovups %zmm6, %zmm7
  vmovups %zmm6, %zmm8
  vmovups %zmm6, %zmm9
  vmovups %zmm6, %zmm10
  vmovups %zmm6, %zmm11
  vmovups %zmm6, %zmm12
  vmovups %zmm6, %zmm13
  vmovups %zmm6, %zmm14
  vmovups %zmm6, %zmm15
fma512_loop:
  vfmadd132ps %zmm6, %zmm5, %zmm5
  vfmadd132ps %zmm6, %zmm7, %zmm7
  vfmadd132ps %zmm6, %zmm8, %zmm8
  vfmadd132ps %zmm6, %zmm9, %zmm9
  vfmadd132ps %zmm6, %zmm10, %zmm10
  vfmadd132ps %zmm6, %zmm11, %zmm11
  vfmadd132ps %zmm6, %zmm12, %zmm12
  vfmadd132ps %zmm6, %zmm13, %zmm13
  vfmadd132ps %zmm6, %zmm14, %zmm14
  vfmadd132ps %zmm6, %zmm15, %zmm15
  vfmadd132ps %zmm6, %zmm5, %zmm5
  vfmadd132ps %zmm6, %zmm7, %zmm7
  vfmadd132ps %zmm6, %zmm8, %zmm8
  vfmadd132ps %zmm6, %zmm9, %zmm9
  vfmadd132ps %zmm6, %zmm10, %zmm10
  vfmadd132ps %zmm6, %zmm11, %zmm11
  vfmadd132ps %zmm6, %zmm12, %zmm12
  vfmadd132ps %zmm6, %zmm13, %zmm13
  vfmadd132ps %zmm6, %zmm14, %zmm14
  vfmadd132ps %zmm6, %zmm15, %zmm15
  sub %r9, %rdi
  jnz fma512_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mix21fma256fma512:
  push %r9
  push %r8
  mov $18, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %zmm6
  vmovups %zmm6, %zmm5
  vmovups %zmm6, %zmm7
  vmovups %zmm6, %zmm8
  vmovups %zmm6, %zmm9
  vmovups %zmm6, %zmm10
  vmovups %zmm6, %zmm11
  vmovups %zmm6, %zmm12
  vmovups %zmm6, %zmm13
  vmovups %zmm6, %zmm14
  vmovups %zmm6, %zmm15
mix21fma256fma512_loop:
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %ymm6, %ymm7, %ymm7
  vfmadd132ps %zmm6, %zmm8, %zmm8
  vfmadd132ps %ymm6, %ymm9, %ymm9
  vfmadd132ps %ymm6, %ymm10, %ymm10
  vfmadd132ps %zmm6, %zmm11, %zmm11
  vfmadd132ps %ymm6, %ymm12, %ymm12
  vfmadd132ps %ymm6, %ymm13, %ymm13
  vfmadd132ps %zmm6, %zmm14, %zmm14
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %ymm6, %ymm7, %ymm7
  vfmadd132ps %zmm6, %zmm8, %zmm8
  vfmadd132ps %ymm6, %ymm9, %ymm9
  vfmadd132ps %ymm6, %ymm10, %ymm10
  vfmadd132ps %zmm6, %zmm11, %zmm11
  vfmadd132ps %ymm6, %ymm12, %ymm12
  vfmadd132ps %ymm6, %ymm13, %ymm13
  vfmadd132ps %zmm6, %zmm14, %zmm14 
  sub %r9, %rdi
  jg mix21fma256fma512_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret 

mixfma256fma512:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %zmm6
  vmovups %zmm6, %zmm5
  vmovups %zmm6, %zmm7
  vmovups %zmm6, %zmm8
  vmovups %zmm6, %zmm9
  vmovups %zmm6, %zmm10
  vmovups %zmm6, %zmm11
  vmovups %zmm6, %zmm12
  vmovups %zmm6, %zmm13
  vmovups %zmm6, %zmm14
  vmovups %zmm6, %zmm15
mixfma256fma512_loop:
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %zmm6, %zmm7, %zmm7
  vfmadd132ps %ymm6, %ymm8, %ymm8
  vfmadd132ps %zmm6, %zmm9, %zmm9
  vfmadd132ps %ymm6, %ymm10, %ymm10
  vfmadd132ps %zmm6, %zmm11, %zmm11
  vfmadd132ps %ymm6, %ymm12, %ymm12
  vfmadd132ps %zmm6, %zmm13, %zmm13
  vfmadd132ps %ymm6, %ymm14, %ymm14
  vfmadd132ps %zmm6, %zmm15, %zmm15
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %zmm6, %zmm7, %zmm7
  vfmadd132ps %ymm6, %ymm8, %ymm8
  vfmadd132ps %zmm6, %zmm9, %zmm9
  vfmadd132ps %ymm6, %ymm10, %ymm10
  vfmadd132ps %zmm6, %zmm11, %zmm11
  vfmadd132ps %ymm6, %ymm12, %ymm12
  vfmadd132ps %zmm6, %zmm13, %zmm13
  vfmadd132ps %ymm6, %ymm14, %ymm14
  vfmadd132ps %zmm6, %zmm15, %zmm15
  sub %r9, %rdi
  jnz mixfma256fma512_loop
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
  movups %xmm6, -32(%rsp)
  vbroadcastss -32(%rsp), %ymm6
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

fma128:
  push %r9
  push %r8
  vzeroupper
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  movups %xmm6, -16(%rsp)
  vbroadcastss -16(%rsp), %xmm6
  vmovups %xmm6, %xmm5
  vmovups %xmm6, %xmm7
  vmovups %xmm6, %xmm8
  vmovups %xmm6, %xmm9
  vmovups %xmm6, %xmm10
  vmovups %xmm6, %xmm11
  vmovups %xmm6, %xmm12
  vmovups %xmm6, %xmm13
  vmovups %xmm6, %xmm14
  vmovups %xmm6, %xmm15
fma128_loop:
  vfmadd132ps %xmm6, %xmm5, %xmm5
  vfmadd132ps %xmm6, %xmm7, %xmm7
  vfmadd132ps %xmm6, %xmm8, %xmm8
  vfmadd132ps %xmm6, %xmm9, %xmm9
  vfmadd132ps %xmm6, %xmm10, %xmm10
  vfmadd132ps %xmm6, %xmm11, %xmm11
  vfmadd132ps %xmm6, %xmm12, %xmm12
  vfmadd132ps %xmm6, %xmm13, %xmm13
  vfmadd132ps %xmm6, %xmm14, %xmm14
  vfmadd132ps %xmm6, %xmm15, %xmm15
  vfmadd132ps %xmm6, %xmm5, %xmm5
  vfmadd132ps %xmm6, %xmm7, %xmm7
  vfmadd132ps %xmm6, %xmm8, %xmm8
  vfmadd132ps %xmm6, %xmm9, %xmm9
  vfmadd132ps %xmm6, %xmm10, %xmm10
  vfmadd132ps %xmm6, %xmm11, %xmm11
  vfmadd132ps %xmm6, %xmm12, %xmm12
  vfmadd132ps %xmm6, %xmm13, %xmm13
  vfmadd132ps %xmm6, %xmm14, %xmm14
  vfmadd132ps %xmm6, %xmm15, %xmm15
  sub %r9, %rdi
  jnz fma128_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mixfmafadd256:
  push %r9
  push %r8
  mov $30, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %ymm6
  vmovups %ymm6, %ymm0
  vmovups %ymm6, %ymm1
  vmovups %ymm6, %ymm2
  vmovups %ymm6, %ymm3
  vmovups %ymm6, %ymm4
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
mixfmafadd256_loop:
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %ymm6, %ymm7, %ymm7
  vaddps %ymm10, %ymm5, %ymm11
  vfmadd132ps %ymm6, %ymm8, %ymm8
  vfmadd132ps %ymm6, %ymm9, %ymm9
  vaddps %ymm12, %ymm5, %ymm13
  vfmadd132ps %ymm6, %ymm14, %ymm14
  vfmadd132ps %ymm6, %ymm15, %ymm15
  vaddps %ymm12, %ymm6, %ymm13
  vfmadd132ps %ymm6, %ymm0, %ymm1
  vfmadd132ps %ymm6, %ymm2, %ymm3
  vaddps %ymm6, %ymm5, %ymm4
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %ymm6, %ymm7, %ymm7
  vaddps %ymm10, %ymm6, %ymm11
  vfmadd132ps %ymm6, %ymm8, %ymm8
  vfmadd132ps %ymm6, %ymm9, %ymm9
  vaddps %ymm12, %ymm7, %ymm13
  vfmadd132ps %ymm6, %ymm14, %ymm14
  vfmadd132ps %ymm6, %ymm15, %ymm15
  vaddps %ymm12, %ymm5, %ymm13
  vfmadd132ps %ymm6, %ymm0, %ymm1
  vfmadd132ps %ymm6, %ymm2, %ymm3
  vaddps %ymm6, %ymm5, %ymm4
  vfmadd132ps %ymm6, %ymm5, %ymm5
  vfmadd132ps %ymm6, %ymm7, %ymm7
  vaddps %ymm10, %ymm6, %ymm11
  vfmadd132ps %ymm6, %ymm8, %ymm8
  vfmadd132ps %ymm6, %ymm9, %ymm9
  vaddps %ymm12, %ymm5, %ymm13
  sub %r9, %rdi
  jnz mixfmafadd256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mixfmaadd512:
  push %r9
  push %r8
  mov $16, %r9
  movq %r9, %xmm0
  vpbroadcastq %xmm0, %zmm0
  cvtsi2ss %r9, %xmm1
  vbroadcastss %xmm1, %zmm1
  vmovdqa64 %zmm0, %zmm3
  vmovdqa64 %zmm0, %zmm6
  vmovdqa64 %zmm0, %zmm9
  vmovdqa64 %zmm0, %zmm12
  vmovdqa64 %zmm0, %zmm15
  vmovaps %zmm1, %zmm2
  vmovaps %zmm1, %zmm4
  vmovaps %zmm1, %zmm5
  vmovaps %zmm1, %zmm7
  vmovaps %zmm1, %zmm8
  vmovaps %zmm1, %zmm10
  vmovaps %zmm1, %zmm11
  vmovaps %zmm1, %zmm13
  vmovaps %zmm1, %zmm14
mixfmaadd512_loop:
  vpaddq %zmm0, %zmm15, %zmm0
  vfmadd132ps %zmm1, %zmm1, %zmm1
  vfmadd132ps %zmm2, %zmm2, %zmm2
  vpaddq %zmm3, %zmm15, %zmm3
  vfmadd132ps %zmm4, %zmm4, %zmm4
  vfmadd132ps %zmm5, %zmm5, %zmm5
  vpaddq %zmm6, %zmm15, %zmm6
  vfmadd132ps %zmm7, %zmm7, %zmm7
  vfmadd132ps %zmm8, %zmm8, %zmm8
  vpaddq %zmm9, %zmm15, %zmm9
  vfmadd132ps %zmm10, %zmm10, %zmm10
  vfmadd132ps %zmm11, %zmm11, %zmm11
  vpaddq %zmm12, %zmm15, %zmm12
  vfmadd132ps %zmm13, %zmm13, %zmm13
  vfmadd132ps %zmm14, %zmm14, %zmm14
  sub %r9, %rdi
  jg mixfmaadd512_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mixfma512add256:
  push %r9
  push %r8
  mov $16, %r9
  movq %r9, %xmm0
  vpbroadcastq %xmm0, %ymm0
  cvtsi2ss %r9, %xmm1
  vbroadcastss %xmm1, %zmm1
  vmovdqa %ymm0, %ymm3
  vmovdqa %ymm0, %ymm6
  vmovdqa %ymm0, %ymm9
  vmovdqa %ymm0, %ymm12
  vmovdqa %ymm0, %ymm15
  vmovaps %zmm1, %zmm2
  vmovaps %zmm1, %zmm4
  vmovaps %zmm1, %zmm5
  vmovaps %zmm1, %zmm7
  vmovaps %zmm1, %zmm8
  vmovaps %zmm1, %zmm10
  vmovaps %zmm1, %zmm11
  vmovaps %zmm1, %zmm13
  vmovaps %zmm1, %zmm14
mixfma512add256_loop:
  vpaddq %ymm0, %ymm15, %ymm0
  vfmadd132ps %zmm1, %zmm1, %zmm1
  vfmadd132ps %zmm2, %zmm2, %zmm2
  vpaddq %ymm3, %ymm15, %ymm3
  vfmadd132ps %zmm4, %zmm4, %zmm4
  vfmadd132ps %zmm5, %zmm5, %zmm5
  vpaddq %ymm6, %ymm15, %ymm6
  vfmadd132ps %zmm7, %zmm7, %zmm7
  vfmadd132ps %zmm8, %zmm8, %zmm8
  vpaddq %ymm9, %ymm15, %ymm9
  vfmadd132ps %zmm10, %zmm10, %zmm10
  vfmadd132ps %zmm11, %zmm11, %zmm11
  vpaddq %ymm12, %ymm15, %ymm12
  vfmadd132ps %zmm13, %zmm13, %zmm13
  vfmadd132ps %zmm14, %zmm14, %zmm14
  sub %r9, %rdi
  jg mixfma512add256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mixfmaadd256:
  push %r9
  push %r8
  mov $16, %r9
  movq %r9, %xmm0
  vpbroadcastq %xmm0, %ymm0
  cvtsi2ss %r9, %xmm1
  vbroadcastss %xmm1, %ymm1
  vmovdqa %ymm0, %ymm3
  vmovdqa %ymm0, %ymm6
  vmovdqa %ymm0, %ymm9
  vmovdqa %ymm0, %ymm12
  vmovdqa %ymm0, %ymm15
  vmovaps %ymm1, %ymm2
  vmovaps %ymm1, %ymm4
  vmovaps %ymm1, %ymm5
  vmovaps %ymm1, %ymm7
  vmovaps %ymm1, %ymm8
  vmovaps %ymm1, %ymm10
  vmovaps %ymm1, %ymm11
  vmovaps %ymm1, %ymm13
  vmovaps %ymm1, %ymm14
mixfmaadd256_loop:
  vpaddq %ymm0, %ymm15, %ymm0
  vfmadd132ps %ymm1, %ymm1, %ymm1
  vfmadd132ps %ymm2, %ymm2, %ymm2
  vpaddq %ymm3, %ymm15, %ymm3
  vfmadd132ps %ymm4, %ymm4, %ymm4
  vfmadd132ps %ymm5, %ymm5, %ymm5
  vpaddq %ymm6, %ymm15, %ymm6
  vfmadd132ps %ymm7, %ymm7, %ymm7
  vfmadd132ps %ymm8, %ymm8, %ymm8
  vpaddq %ymm9, %ymm15, %ymm9
  vfmadd132ps %ymm10, %ymm10, %ymm10
  vfmadd132ps %ymm11, %ymm11, %ymm11
  vpaddq %ymm12, %ymm15, %ymm12
  vfmadd132ps %ymm13, %ymm13, %ymm13
  vfmadd132ps %ymm14, %ymm14, %ymm14
  sub %r9, %rdi
  jg mixfmaadd256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mixfmaand256:
  push %r9
  push %r8
  mov $15, %r9
  movq %r9, %xmm0
  vpbroadcastq %xmm0, %ymm0
  cvtsi2ss %r9, %xmm1
  vbroadcastss %xmm1, %ymm1
  vmovdqa %ymm0, %ymm3
  vmovdqa %ymm0, %ymm6
  vmovdqa %ymm0, %ymm9
  vmovdqa %ymm0, %ymm12
  vmovdqa %ymm0, %ymm15
  vmovaps %ymm1, %ymm2
  vmovaps %ymm1, %ymm4
  vmovaps %ymm1, %ymm5
  vmovaps %ymm1, %ymm7
  vmovaps %ymm1, %ymm8
  vmovaps %ymm1, %ymm10
  vmovaps %ymm1, %ymm11
  vmovaps %ymm1, %ymm13
  vmovaps %ymm1, %ymm14
mixfmaand256_loop:
  vpand %ymm0, %ymm15, %ymm0
  vfmadd132ps %ymm1, %ymm1, %ymm1
  vfmadd132ps %ymm2, %ymm2, %ymm2
  vpand %ymm3, %ymm15, %ymm3
  vfmadd132ps %ymm4, %ymm4, %ymm4
  vfmadd132ps %ymm5, %ymm5, %ymm5
  vpand %ymm6, %ymm15, %ymm6
  vfmadd132ps %ymm7, %ymm7, %ymm7
  vfmadd132ps %ymm8, %ymm8, %ymm8
  vpand %ymm9, %ymm15, %ymm9
  vfmadd132ps %ymm10, %ymm10, %ymm10
  vfmadd132ps %ymm11, %ymm11, %ymm11
  vpand %ymm12, %ymm15, %ymm12
  vfmadd132ps %ymm13, %ymm13, %ymm13
  vfmadd132ps %ymm14, %ymm14, %ymm14
  sub %r9, %rdi
  jg mixfmaand256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mixfmaandmem256:
  push %r9
  push %r8
  mov $22, %r9
  movq %r9, %xmm0
  vpbroadcastq %xmm0, %ymm0
  cvtsi2ss %r9, %xmm1
  vbroadcastss %xmm1, %ymm1
  vmovdqa %ymm0, %ymm3
  vmovaps %ymm1, %ymm6
  vmovaps %ymm1, %ymm9
  vmovaps %ymm1, %ymm12
  vmovaps %ymm1, %ymm15
  vmovaps %ymm1, %ymm2
  vmovaps %ymm1, %ymm4
  vmovaps %ymm1, %ymm5
  vmovaps %ymm1, %ymm7
  vmovaps %ymm1, %ymm8
  vmovaps %ymm1, %ymm10
  vmovaps %ymm1, %ymm11
  vmovaps %ymm1, %ymm13
  vmovaps %ymm1, %ymm14
mixfmaandmem256_loop:
  vpand %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm1, %ymm1, %ymm1
  vfmadd132ps (%rsi), %ymm2, %ymm2
  vpand %ymm3, %ymm3, %ymm3
  vfmadd132ps %ymm4, %ymm4, %ymm4
  vfmadd132ps (%rsi), %ymm5, %ymm5
  vpand %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm7, %ymm7, %ymm7
  vfmadd132ps (%rsi), %ymm8, %ymm8
  vpand %ymm3, %ymm3, %ymm3
  vfmadd132ps %ymm10, %ymm10, %ymm10
  vfmadd132ps (%rsi), %ymm11, %ymm11
  vpand %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm13, %ymm13, %ymm13
  vfmadd132ps (%rsi), %ymm14, %ymm14

  vpand %ymm3, %ymm3, %ymm3
  vfmadd132ps %ymm6, %ymm6, %ymm6
  vfmadd132ps (%rsi), %ymm9, %ymm9
  vpand %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm12, %ymm12, %ymm12
  vfmadd132ps (%rsi), %ymm15, %ymm15
  sub %r9, %rdi
  jg mixfmaandmem256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

mixfmaaddmem256:
  push %r9
  push %r8
  mov $22, %r9
  movq %r9, %xmm0
  vpbroadcastq %xmm0, %ymm0
  cvtsi2ss %r9, %xmm1
  vbroadcastss %xmm1, %ymm1
  vmovdqa %ymm0, %ymm3
  vmovaps %ymm1, %ymm6
  vmovaps %ymm1, %ymm9
  vmovaps %ymm1, %ymm12
  vmovaps %ymm1, %ymm15
  vmovaps %ymm1, %ymm2
  vmovaps %ymm1, %ymm4
  vmovaps %ymm1, %ymm5
  vmovaps %ymm1, %ymm7
  vmovaps %ymm1, %ymm8
  vmovaps %ymm1, %ymm10
  vmovaps %ymm1, %ymm11
  vmovaps %ymm1, %ymm13
  vmovaps %ymm1, %ymm14
mixfmaaddmem256_loop:
  vpaddq %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm1, %ymm1, %ymm1
  vfmadd132ps (%rsi), %ymm2, %ymm2
  vpaddq %ymm3, %ymm3, %ymm3
  vfmadd132ps %ymm4, %ymm4, %ymm4
  vfmadd132ps (%rsi), %ymm5, %ymm5
  vpaddq %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm7, %ymm7, %ymm7
  vfmadd132ps (%rsi), %ymm8, %ymm8
  vpaddq %ymm3, %ymm3, %ymm3
  vfmadd132ps %ymm10, %ymm10, %ymm10
  vfmadd132ps (%rsi), %ymm11, %ymm11
  vpaddq %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm13, %ymm13, %ymm13
  vfmadd132ps (%rsi), %ymm14, %ymm14

  vpaddq %ymm3, %ymm3, %ymm3
  vfmadd132ps %ymm6, %ymm6, %ymm6
  vfmadd132ps (%rsi), %ymm9, %ymm9
  vpaddq %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm12, %ymm12, %ymm12
  vfmadd132ps (%rsi), %ymm15, %ymm15

  sub %r9, %rdi
  jg mixfmaaddmem256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

nemesfpu512mix21:
  push %r9
  mov $16, %r9
  cvtsi2ss %r9, %xmm0
  vbroadcastss %xmm0, %zmm1
  vmovdqa64 %zmm1, %zmm2
  vmovdqa64 %zmm1, %zmm3
  vmovdqa64 %zmm1, %zmm4
  vmovdqa64 %zmm1, %zmm5
  vmovdqa64 %zmm1, %zmm6
  vmovdqa64 %zmm1, %zmm7
  vmovdqa64 %zmm1, %zmm8
  vmovdqa64 %zmm1, %zmm9
  vmovdqa64 %zmm1, %zmm10
  vmovdqa64 %zmm1, %zmm11
  vmovdqa64 %zmm1, %zmm12
  vmovdqa64 %zmm1, %zmm13
  vmovdqa64 %zmm1, %zmm14
  vmovdqa64 %zmm1, %zmm15
nemesfpu512mix21_loop:
  vaddps %zmm0, %zmm0, %zmm0
  vfmadd132ps %zmm1, %zmm1, %zmm1
  vfmadd132ps %zmm2, %zmm2, %zmm2
  vaddps %zmm3, %zmm3, %zmm3
  vfmadd132ps %zmm4, %zmm4, %zmm4
  vfmadd132ps %zmm5, %zmm5, %zmm5
  vaddps %zmm6, %zmm6, %zmm6
  vfmadd132ps %zmm7, %zmm7, %zmm7
  vfmadd132ps %zmm8, %zmm8, %zmm8
  vaddps %zmm9, %zmm9, %zmm9
  vfmadd132ps %zmm10, %zmm10, %zmm10
  vfmadd132ps %zmm11, %zmm11, %zmm11
  vaddps %ymm12, %ymm12, %ymm12
  vfmadd132ps %zmm13, %zmm13, %zmm13
  vfmadd132ps %zmm14, %zmm14, %zmm14
  vaddps %zmm15, %zmm15, %zmm15
  sub %r9, %rdi
  jg nemesfpu512mix21_loop
  pop %r9
  ret

nemesfpumix21:
  push %r9
  mov $16, %r9
  cvtsi2ss %r9, %xmm0
  vbroadcastss %xmm0, %ymm1
  vmovdqa %ymm1, %ymm2
  vmovdqa %ymm1, %ymm3
  vmovdqa %ymm1, %ymm4
  vmovdqa %ymm1, %ymm5
  vmovdqa %ymm1, %ymm6
  vmovdqa %ymm1, %ymm7
  vmovdqa %ymm1, %ymm8
  vmovdqa %ymm1, %ymm9
  vmovdqa %ymm1, %ymm10
  vmovdqa %ymm1, %ymm11
  vmovdqa %ymm1, %ymm12
  vmovdqa %ymm1, %ymm13
  vmovdqa %ymm1, %ymm14
  vmovdqa %ymm1, %ymm15
nemesfpumix21_loop:
  vaddps %ymm0, %ymm0, %ymm0
  vfmadd132ps %ymm1, %ymm1, %ymm1
  vfmadd132ps %ymm2, %ymm2, %ymm2
  vaddps %ymm3, %ymm3, %ymm3
  vfmadd132ps %ymm4, %ymm4, %ymm4
  vfmadd132ps %ymm5, %ymm5, %ymm5
  vaddps %ymm6, %ymm6, %ymm6
  vfmadd132ps %ymm7, %ymm7, %ymm7
  vfmadd132ps %ymm8, %ymm8, %ymm8
  vaddps %ymm9, %ymm9, %ymm9
  vfmadd132ps %ymm10, %ymm10, %ymm10
  vfmadd132ps %ymm11, %ymm11, %ymm11
  vaddps %ymm12, %ymm12, %ymm12
  vfmadd132ps %ymm13, %ymm13, %ymm13
  vfmadd132ps %ymm14, %ymm14, %ymm14
  vaddps %ymm15, %ymm15, %ymm15
  sub %r9, %rdi
  jg nemesfpumix21_loop
  pop %r9
  ret

latfma512:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %zmm6
  vmovups %zmm6, %zmm5
  vmovups %zmm6, %zmm7
  vmovups %zmm6, %zmm8
  vmovups %zmm6, %zmm9
  vmovups %zmm6, %zmm10
  vmovups %zmm6, %zmm11
  vmovups %zmm6, %zmm12
  vmovups %zmm6, %zmm13
  vmovups %zmm6, %zmm14
  vmovups %zmm6, %zmm15
latfma512_loop:
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  vfmadd132ps %zmm6, %zmm5, %zmm7
  sub %r9, %rdi
  jnz latfma512_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

latfma256:
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
latfma256_loop:
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  vfmadd132ps %ymm6, %ymm5, %ymm7
  sub %r9, %rdi
  jnz latfma256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

latfma128:
  push %r9
  push %r8
  vzeroupper
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  vbroadcastss %xmm6, %xmm6
  vmovups %xmm6, %xmm5
  vmovups %xmm6, %xmm7
  vmovups %xmm6, %xmm8
  vmovups %xmm6, %xmm9
  vmovups %xmm6, %xmm10
  vmovups %xmm6, %xmm11
  vmovups %xmm6, %xmm12
  vmovups %xmm6, %xmm13
  vmovups %xmm6, %xmm14
  vmovups %xmm6, %xmm15
latfma128_loop:
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  vfmadd132ps %xmm6, %xmm5, %xmm7
  sub %r9, %rdi
  jnz latfma128_loop
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
  //vbroadcastss %xmm6, %xmm6
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
  pop %r8
  pop %r9
  ret

latmul128fp:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  //vbroadcastss %xmm6, %xmm6
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
  pop %r8
  pop %r9
  ret

mul128fp:
  push %r9
  push %r8
  mov $20, %r9
  cvtsi2ss %r9, %xmm4
  cvtsi2ss %r9, %xmm3
  cvtsi2ss %r9, %xmm2
  cvtsi2ss %r9, %xmm1
  cvtsi2ss %r9, %xmm0
mul128fp_loop:
  mulps %xmm0, %xmm0
  mulps %xmm1, %xmm1
  mulps %xmm2, %xmm2
  mulps %xmm3, %xmm3
  mulps %xmm4, %xmm4
  mulps %xmm0, %xmm0
  mulps %xmm1, %xmm1
  mulps %xmm2, %xmm2
  mulps %xmm3, %xmm3
  mulps %xmm4, %xmm4
  mulps %xmm0, %xmm0
  mulps %xmm1, %xmm1
  mulps %xmm2, %xmm2
  mulps %xmm3, %xmm3
  mulps %xmm4, %xmm4
  mulps %xmm0, %xmm0
  mulps %xmm1, %xmm1
  mulps %xmm2, %xmm2
  mulps %xmm3, %xmm3
  mulps %xmm4, %xmm4
  sub %r9, %rdi
  jnz mul128fp_loop
  movq %xmm1, %rax
  pop %r8
  pop %r9
  ret

add128fp:
  push %r9
  push %r8
  mov $20, %r9
  cvtsi2ss %r9, %xmm4
  cvtsi2ss %r9, %xmm3
  cvtsi2ss %r9, %xmm2
  cvtsi2ss %r9, %xmm1
  cvtsi2ss %r9, %xmm0
add128fp_loop:
  addps %xmm0, %xmm0
  addps %xmm1, %xmm1
  addps %xmm2, %xmm2
  addps %xmm3, %xmm3
  addps %xmm4, %xmm4
  addps %xmm0, %xmm0
  addps %xmm1, %xmm1
  addps %xmm2, %xmm2
  addps %xmm3, %xmm3
  addps %xmm4, %xmm4
  addps %xmm0, %xmm0
  addps %xmm1, %xmm1
  addps %xmm2, %xmm2
  addps %xmm3, %xmm3
  addps %xmm4, %xmm4
  addps %xmm0, %xmm0
  addps %xmm1, %xmm1
  addps %xmm2, %xmm2
  addps %xmm3, %xmm3
  addps %xmm4, %xmm4
  sub %r9, %rdi
  jnz add128fp_loop
  movq %xmm1, %rax
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
  mov %r9, %r15
  imul %r9, %r14
  mov %r9, %r14
  imul %r9, %r13
  mov %r9, %r13
  imul %r9, %r12
  mov %r9, %r12
  imul %r9, %r11
  mov %r9, %r11
  imul %r9, %r10
  mov %r9, %r10
  imul %r9, %r8
  mov %r9, %r8
  imul %r9, %rbx
  mov %r9, %rbx
  imul %r9, %rcx
  mov %r9, %rcx
  imul %r9, %rsi
  mov %r9, %rsi
  imul %r9, %r15
  mov %r9, %r15
  imul %r9, %r14
  mov %r9, %r14
  imul %r9, %r13
  mov %r9, %r13
  imul %r9, %r12
  mov %r9, %r12
  imul %r9, %r11
  mov %r9, %r11
  imul %r9, %r10
  mov %r9, %r10
  imul %r9, %r8
  mov %r9, %r8
  imul %r9, %rbx
  mov %r9, %rbx
  imul %r9, %rcx
  mov %r9, %rcx
  imul %r9, %rsi
  mov %r9, %rsi
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

loadscalar:
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
  mov $20, %r9
loadscalar_loop:
  mov (%rsi), %r15
  mov 8(%rsi), %r14
  mov 16(%rsi), %r13
  mov 24(%rsi), %r12
  mov 32(%rsi), %r11
  mov 40(%rsi), %r10
  mov 48(%rsi), %r15
  mov 56(%rsi), %r14
  mov 64(%rsi), %r13
  mov 72(%rsi), %r12 
  mov 80(%rsi), %r11
  mov 88(%rsi), %r10
  mov 96(%rsi), %r15
  mov 104(%rsi), %r14
  mov 112(%rsi), %r13  
  mov 120(%rsi), %r12
  mov 128(%rsi), %r11
  mov 136(%rsi), %r10
  mov 144(%rsi), %r15
  mov 152(%rsi), %r14   
  sub %r9, %rdi
  jnz loadscalar_loop
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

spacedstorescalar:
  push %rbx
  push %rcx
  push %r8
  push %r9
  mov $20, %r9
spacedstorescalar_loop:
  mov %rdi, (%rsi)
  mov %rdi, 64(%rsi)
  mov %rdi, 128(%rsi)
  mov %rdi, 192(%rsi)
  mov %rdi, 256(%rsi)
  mov %rdi, 320(%rsi)
  mov %rdi, 384(%rsi)
  mov %rdi, 448(%rsi)
  mov %rdi, 512(%rsi)
  mov %rdi, 576(%rsi)
  mov %rdi, 640(%rsi)
  mov %rdi, 704(%rsi)
  mov %rdi, 768(%rsi)
  mov %rdi, 832(%rsi)
  mov %rdi, 896(%rsi)
  mov %rdi, 960(%rsi)
  mov %rdi, 1024(%rsi)
  mov %rdi, 1088(%rsi)
  mov %rdi, 1152(%rsi)
  mov %rdi, 1216(%rsi)
  sub %r9, %rdi
  jnz spacedstorescalar_loop
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret


spacedload128:
  push %rbx
  push %rcx
  push %r8
  push %r9
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

load512:
  push %rbx
  push %rcx
  push %r8
  push %r9
  mov $20, %r9
load512_loop:
  vmovaps (%rsi), %zmm10
  vmovaps (%rsi), %zmm11
  vmovaps (%rsi), %zmm12
  vmovaps (%rsi), %zmm13
  vmovaps (%rsi), %zmm14
  vmovaps (%rsi), %zmm10
  vmovaps (%rsi), %zmm11
  vmovaps (%rsi), %zmm12
  vmovaps (%rsi), %zmm13
  vmovaps (%rsi), %zmm14
  vmovaps (%rsi), %zmm10
  vmovaps (%rsi), %zmm11
  vmovaps (%rsi), %zmm12
  vmovaps (%rsi), %zmm13
  vmovaps (%rsi), %zmm14
  vmovaps (%rsi), %zmm10
  vmovaps (%rsi), %zmm11
  vmovaps (%rsi), %zmm12
  vmovaps (%rsi), %zmm13
  vmovaps (%rsi), %zmm14
  sub %r9, %rdi
  jnz load512_loop
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

store512:
  push %rbx
  push %rcx
  push %r8
  push %r9
  vmovaps (%rsi), %zmm10
  vmovaps %zmm10, %zmm11
  vmovaps %zmm10, %zmm12
  vmovaps %zmm10, %zmm13
  vmovaps %zmm10, %zmm14
  mov $20, %r9
store512_loop:
  vmovaps %zmm10, (%rdx)
  vmovaps %zmm11, (%rdx)
  vmovaps %zmm12, (%rdx)
  vmovaps %zmm13, (%rdx)
  vmovaps %zmm14, (%rdx)
  vmovaps %zmm10, (%rdx)
  vmovaps %zmm11, (%rdx)
  vmovaps %zmm12, (%rdx)
  vmovaps %zmm13, (%rdx)
  vmovaps %zmm14, (%rdx)
  vmovaps %zmm10, (%rdx)
  vmovaps %zmm11, (%rdx)
  vmovaps %zmm12, (%rdx)
  vmovaps %zmm13, (%rdx)
  vmovaps %zmm14, (%rdx)
  vmovaps %zmm10, (%rdx)
  vmovaps %zmm11, (%rdx)
  vmovaps %zmm12, (%rdx)
  vmovaps %zmm13, (%rdx)
  vmovaps %zmm14, (%rdx)
  sub %r9, %rdi
  jnz store512_loop
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

pdepmultest:
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
  xor %rbx, %rbx
  xor %rcx, %rcx
  xor %rsi, %rsi
  xor %r10, %r10
  xor %r11, %r11
  xor %r12, %r12
  xor %r13, %r13
  xor %r14, %r14
  xor %r15, %r15
pdepmultest_loop:
  pdep %r8, %r15, %r15
  imul %r9, %r14
  pdep %r8, %r13, %r13
  imul %r9, %r12
  pdep %r8, %r11, %r11
  imul %r9, %r10
  pdep %r8, %rcx, %rcx
  imul %r9, %rbx
  pdep %r8, %r15, %r15
  imul %r9, %rsi
  pdep %r8, %r15, %r15
  imul %r9, %r14
  pdep %r8, %r13, %r13
  imul %r9, %r12
  pdep %r8, %r11, %r11
  imul %r9, %r10
  pdep %r8, %rcx, %rcx
  imul %r9, %rbx
  pdep %r8, %r15, %r15
  imul %r9, %rsi
  sub %r9, %rdi
  jnz pdepmultest_loop
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

depmovtest:
  push %rbx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
depmovtest_loop:
  mov %r15, %r12
  mov %r12, %r14
  mov %r14, %r13
  mov %r13, %r11
  mov %r11, %r15
  mov %r15, %r12
  mov %r12, %r14
  mov %r14, %r13
  mov %r13, %r11
  mov %r11, %r15
  mov %r15, %r12
  mov %r12, %r14
  mov %r14, %r13
  mov %r13, %r11
  mov %r11, %r15
  mov %r15, %r12
  mov %r12, %r14
  mov %r14, %r13
  mov %r13, %r11
  mov %r11, %r15
  sub %r9, %rdi
  jnz depmovtest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rbx
  ret

vecdepmovtest:
  push %rbx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  cvtsi2ss %r9, %xmm15
  xor %rbx, %rbx
vecdepmovtest_loop:
  movaps %xmm15, %xmm12
  movaps %xmm12, %xmm14
  movaps %xmm14, %xmm13
  movaps %xmm13, %xmm11
  movaps %xmm11, %xmm15
  movaps %xmm15, %xmm12
  movaps %xmm12, %xmm14
  movaps %xmm14, %xmm13
  movaps %xmm13, %xmm11
  movaps %xmm11, %xmm15
  movaps %xmm15, %xmm12
  movaps %xmm12, %xmm14
  movaps %xmm14, %xmm13
  movaps %xmm13, %xmm11
  movaps %xmm11, %xmm15
  movaps %xmm15, %xmm12
  movaps %xmm12, %xmm14
  movaps %xmm14, %xmm13
  movaps %xmm13, %xmm11
  movaps %xmm11, %xmm15
  sub %r9, %rdi
  jnz vecdepmovtest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rbx
  ret 

vecindepmovtest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  cvtsi2ss %r9, %xmm0
  movaps %xmm0, %xmm1
  movaps %xmm0, %xmm10
  movaps %xmm0, %xmm11
  movaps %xmm0, %xmm12
  xor %rbx, %rbx
vecindepmovtest_loop:
  movaps %xmm10, %xmm15
  movaps %xmm11, %xmm14
  movaps %xmm12, %xmm13
  movaps %xmm0, %xmm15
  movaps %xmm1, %xmm14
  movaps %xmm10, %xmm15
  movaps %xmm11, %xmm14
  movaps %xmm12, %xmm13
  movaps %xmm0, %xmm15
  movaps %xmm1, %xmm14
  movaps %xmm10, %xmm15
  movaps %xmm11, %xmm14
  movaps %xmm12, %xmm13
  movaps %xmm0, %xmm15
  movaps %xmm1, %xmm14
  movaps %xmm10, %xmm15
  movaps %xmm11, %xmm14
  movaps %xmm12, %xmm13
  movaps %xmm0, %xmm15
  movaps %xmm1, %xmm14
  sub %r9, %rdi
  jnz vecindepmovtest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret

indepmovtest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
indepmovtest_loop:
  mov %r10, %r15
  mov %r11, %r14
  mov %r12, %r13
  mov %rax, %r15
  mov %rcx, %r14
  mov %r10, %r15
  mov %r11, %r14
  mov %r12, %r13
  mov %rax, %r15
  mov %rcx, %r14
  mov %r10, %r15
  mov %r11, %r14
  mov %r12, %r13
  mov %rax, %r15
  mov %rcx, %r14
  mov %r10, %r15
  mov %r11, %r14
  mov %r12, %r13
  mov %rax, %r15
  mov %rcx, %r14
  sub %r9, %rdi
  jnz indepmovtest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret

movzerotest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
movzerotest_loop:
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  mov $0, %r15
  sub %r9, %rdi
  jnz movzerotest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret

xorzerotest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
xorzerotest_loop:
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  xor %r15, %r15
  sub %r9, %rdi
  jnz xorzerotest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret

vecxorzerotest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  cvtsi2ss %r9, %xmm0
  xor %rbx, %rbx
vecxorzerotest_loop:
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  xorps %xmm0, %xmm0
  sub %r9, %rdi
  jnz vecxorzerotest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret 

subzerotest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
subzerotest_loop:
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r15, %r15
  sub %r9, %rdi
  jnz subzerotest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret

vecsubzerotest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  cvtsi2ss %r9, %xmm15
  xor %rbx, %rbx
vecsubzerotest_loop:
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  subss %xmm15, %xmm15
  sub %r9, %rdi
  jnz subzerotest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret 

depaddimmtest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
depaddimmtest_loop:
  add $1, %r15
  add $2, %r15
  add $3, %r15
  add $4, %r15
  add $5, %r15
  add $6, %r15
  add $7, %r15
  add $8, %r15
  add $9, %r15
  add $10, %r15
  add $11, %r15
  add $12, %r15
  add $13, %r15
  add $14, %r15
  add $15, %r15
  add $16, %r15
  add $17, %r15
  add $18, %r15
  add $19, %r15
  add $20, %r15
  sub %r9, %rdi
  jnz depaddimmtest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret

depinctest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
depinctest_loop:
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  inc %r15
  sub %r9, %rdi
  jnz depinctest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret

depdectest:
  push %rbx
  push %rcx
  push %r8
  push %r9
  push %r15
  push %r14
  push %r13
  push %r12
  push %r11
  push %r10
  mov $1, %r8
  mov $20, %r9
  xor %r15, %r15
  not %r15
  xor %rbx, %rbx
depdectest_loop:
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  dec %r15
  sub %r9, %rdi
  jnz depdectest_loop
  pop %r10
  pop %r11
  pop %r12
  pop %r13
  pop %r14
  pop %r15
  pop %r9
  pop %r8
  pop %rcx
  pop %rbx
  ret

/* FMA4 tests */
fma4_256:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  movups %xmm6, -32(%rsp)
  vbroadcastss -32(%rsp), %ymm6
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
fma4_256_loop:
  vfmaddps %ymm6, %ymm6, %ymm5, %ymm5
  vfmaddps %ymm6, %ymm6, %ymm7, %ymm7
  vfmaddps %ymm6, %ymm6, %ymm8, %ymm8
  vfmaddps %ymm6, %ymm6, %ymm9, %ymm9
  vfmaddps %ymm6, %ymm6, %ymm10, %ymm10
  vfmaddps %ymm6, %ymm6, %ymm11, %ymm11
  vfmaddps %ymm6, %ymm6, %ymm12, %ymm12
  vfmaddps %ymm6, %ymm6, %ymm13, %ymm13
  vfmaddps %ymm6, %ymm6, %ymm14, %ymm14
  vfmaddps %ymm6, %ymm6, %ymm15, %ymm15
  vfmaddps %ymm6, %ymm6, %ymm5, %ymm5
  vfmaddps %ymm6, %ymm6, %ymm7, %ymm7
  vfmaddps %ymm6, %ymm6, %ymm8, %ymm8
  vfmaddps %ymm6, %ymm6, %ymm9, %ymm9
  vfmaddps %ymm6, %ymm6, %ymm10, %ymm10
  vfmaddps %ymm6, %ymm6, %ymm11, %ymm11
  vfmaddps %ymm6, %ymm6, %ymm12, %ymm12
  vfmaddps %ymm6, %ymm6, %ymm13, %ymm13
  vfmaddps %ymm6, %ymm6, %ymm14, %ymm14
  vfmaddps %ymm6, %ymm6, %ymm15, %ymm15
  sub %r9, %rdi
  jnz fma4_256_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret

fma4_128:
  push %r9
  push %r8
  mov $20, %r9
  movq %r9, %xmm1
  cvtsi2ss %r9, %xmm6
  movups %xmm6, -32(%rsp)
  vbroadcastss -32(%rsp), %xmm6
  movups %xmm6, %xmm5
  movups %xmm6, %xmm7
  movups %xmm6, %xmm8
  movups %xmm6, %xmm9
  movups %xmm6, %xmm10
  movups %xmm6, %xmm11
  movups %xmm6, %xmm12
  movups %xmm6, %xmm13
  movups %xmm6, %xmm14
  movups %xmm6, %xmm15
fma4_128_loop:
  vfmaddps %xmm6, %xmm6, %xmm5, %xmm5
  vfmaddps %xmm6, %xmm6, %xmm7, %xmm7
  vfmaddps %xmm6, %xmm6, %xmm8, %xmm8
  vfmaddps %xmm6, %xmm6, %xmm9, %xmm9
  vfmaddps %xmm6, %xmm6, %xmm10, %xmm10
  vfmaddps %xmm6, %xmm6, %xmm11, %xmm11
  vfmaddps %xmm6, %xmm6, %xmm12, %xmm12
  vfmaddps %xmm6, %xmm6, %xmm13, %xmm13
  vfmaddps %xmm6, %xmm6, %xmm14, %xmm14
  vfmaddps %xmm6, %xmm6, %xmm15, %xmm15
  vfmaddps %xmm6, %xmm6, %xmm5, %xmm5
  vfmaddps %xmm6, %xmm6, %xmm7, %xmm7
  vfmaddps %xmm6, %xmm6, %xmm8, %xmm8
  vfmaddps %xmm6, %xmm6, %xmm9, %xmm9
  vfmaddps %xmm6, %xmm6, %xmm10, %xmm10
  vfmaddps %xmm6, %xmm6, %xmm11, %xmm11
  vfmaddps %xmm6, %xmm6, %xmm12, %xmm12
  vfmaddps %xmm6, %xmm6, %xmm13, %xmm13
  vfmaddps %xmm6, %xmm6, %xmm14, %xmm14
  vfmaddps %xmm6, %xmm6, %xmm15, %xmm15
  sub %r9, %rdi
  jnz fma4_128_loop
  movq %xmm1, %rax
  vzeroupper
  pop %r8
  pop %r9
  ret
