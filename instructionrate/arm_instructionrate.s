.text

.global clktest
.global addtest
.global eortest
.global maddaddtest
.global cmptest
.global addmultest
.global addmul21test
.global mixaddjmp21test
.global mul32test
.global mul64test
.global latmul64test
.global noptest
.global fusejmptest
.global jmptest
.global mixmuljmptest
.global mixmuljmptest21
.global mixaddjmptest
.global rortest
.global mixmulrortest

.global vecadd128test
.global latvecadd128test
.global vecmul128test
.global latvecmul128test
.global mixvecaddmul128test
.global faddtest
.global latfaddtest
.global latfmultest
.global latvecfadd128test
.global latvecfmul128test
.global vecfadd128test
.global vecfmul128test
.global mixvecfaddfmul128test
.global mixaddvecadd128test
.global mix3to1addvecadd128test
.global mix1to1addvecadd128test
.global mixmulvecmultest
.global mixvecmulfmultest
.global mixvecaddfaddtest
.global mixjmpvecaddtest
.global mixjmpvecmultest
.global vecfma128test
.global latvecfma128test
.global scalarfmatest
.global latscalarfmatest

.global mixvecfaddfma128test
.global mixvecfmulfma128test
.global loadtest
.global mixloadstoretest
.global mix21loadstoretest
.global vecloadtest
.global vecstoretest

//renamer tests
.global indepmovtest
.global depmovtest
.global xorzerotest
.global movzerotest
.global subzerotest

/* x0 = arg = iteration count. all iteration counts must be divisible by 10 */
clktest:
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  mov x15, 1
  mov x14, 20
  eor x13, x13, x13
clktest_loop:
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  add x13, x13, x15
  sub x0, x0, x14
  cbnz x0, clktest_loop
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x30
  ret

noptest:
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  mov x15, 1
  mov x14, 30
  eor x13, x13, x13
noptest_loop:
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
  sub x0, x0, x14
  cbnz x0, noptest_loop
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x30
  ret

addtest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 30
  eor x13, x13, x13
  eor x12, x12, x12
  eor x11, x11, x11
  eor x10, x10, x10
  eor x9, x9, x9
addtest_loop:
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add x9, x9, x15
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add x9, x9, x15
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add x9, x9, x15
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add x9, x9, x15
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add x9, x9, x15
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add x9, x9, x15
  sub x0, x0, x14
  cbnz x0, addtest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret 

maddaddtest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 20
  eor x13, x13, x13
  eor x12, x12, x12
  eor x11, x11, x11
  mov x10, 2
  eor x9, x9, x9
  mov x8, 3
maddaddtest_loop:
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  madd x10, x8, x0, x15
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  madd x10, x8, x0, x15 
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  madd x10, x8, x0, x15  
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  madd x10, x8, x0, x15  
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  madd x10, x8, x0, x15  
  sub x0, x0, x14
  cbnz x0, maddaddtest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret 

eortest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 30
  eor x13, x13, x13
  eor x12, x12, x12
  eor x11, x11, x11
  eor x10, x10, x10
  eor x9, x9, x9
eortest_loop:
  eor x13, x13, x15
  eor x12, x12, x15
  eor x11, x11, x15
  eor x10, x10, x15
  eor x9, x9, x15
  eor x13, x13, x15
  eor x12, x12, x15
  eor x11, x11, x15
  eor x10, x10, x15
  eor x9, x9, x15
  eor x13, x13, x15
  eor x12, x12, x15
  eor x11, x11, x15
  eor x10, x10, x15
  eor x9, x9, x15
  eor x13, x13, x15
  eor x12, x12, x15
  eor x11, x11, x15
  eor x10, x10, x15
  eor x9, x9, x15
  eor x13, x13, x15
  eor x12, x12, x15
  eor x11, x11, x15
  eor x10, x10, x15
  eor x9, x9, x15
  eor x13, x13, x15
  eor x12, x12, x15
  eor x11, x11, x15
  eor x10, x10, x15
  eor x9, x9, x15
  sub x0, x0, x14
  cbnz x0, eortest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

cmptest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 30
  eor x13, x13, x13
  eor x12, x12, x12
  eor x11, x11, x11
  eor x10, x10, x10
  eor x9, x9, x9
cmptest_loop:
  cmp x13, x13
  cmp x12, x12
  cmp x11, x11
  cmp x10, x10
  cmp x9, x9 
  cmp x13, x13
  cmp x12, x12
  cmp x11, x11
  cmp x10, x10
  cmp x9, x9 
  cmp x13, x13
  cmp x12, x12
  cmp x11, x11
  cmp x10, x10
  cmp x9, x9 
  cmp x13, x13
  cmp x12, x12
  cmp x11, x11
  cmp x10, x10
  cmp x9, x9 
  cmp x13, x13
  cmp x12, x12
  cmp x11, x11
  cmp x10, x10
  cmp x9, x9 
  cmp x13, x13
  cmp x12, x12
  cmp x11, x11
  cmp x10, x10
  cmp x9, x9 
  sub x0, x0, x14
  cbnz x0, cmptest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret 

addmultest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 2
  mov x14, 20
  mov x13, 2
  eor x12, x12, x12
  mov x11, 2
  eor x10, x10, x10
  mov x9, 2
  mov x8, 2
addmultest_loop:
  mul w13, w13, w15
  add x12, x12, x15
  mul w11, w11, w15
  add x10, x10, x15
  mul w9, w9, w15
  add x12, x12, x15
  mul w8, w8, w15
  add x10, x10, x15
  mul w13, w13, w15
  add x12, x12, x15
  mul w11, w11, w15
  add x10, x10, x15
  mul w9, w9, w15
  add x12, x12, x15
  mul w8, w8, w15
  add x10, x10, x15
  mul w13, w13, w15
  add x12, x12, x15
  mul w11, w11, w15
  add x10, x10, x15
  sub x0, x0, x14
  cbnz x0, addmultest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

addmul21test:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 2
  mov x14, 24
  mov x13, 2
  eor x12, x12, x12
  mov x11, 2
  eor x10, x10, x10
  mov x9, 2
  mov x8, 2
addmul21test_loop:
  mul w13, w13, w15
  add x12, x12, x15
  add x10, x10, x15
  mul w11, w11, w15
  add x12, x12, x15
  add x10, x10, x15
  mul w9, w9, w15
  add x12, x12, x15
  add x10, x10, x15
  mul w8, w8, w15
  add x12, x12, x15
  add x10, x10, x15
  mul w13, w13, w15
  add x12, x12, x15
  add x10, x10, x15
  mul w11, w11, w15
  add x12, x12, x15
  add x10, x10, x15
  mul w9, w9, w15
  add x12, x12, x15
  add x10, x10, x15
  mul w8, w8, w15
  add x12, x12, x15
  add x10, x10, x15
  sub x0, x0, x14
  cmp x0, 0
  b.gt addmul21test_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret 


mul32test:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 2
  mov x14, 20
  mov x13, x15
  mov x12, x15
  mov x11, x15
  mov x10, x15
  mov x9, x15
  mov x8, x15
mul32test_loop:
  mul w13, w13, w15
  mul w12, w12, w15
  mul w11, w11, w15
  mul w10, w10, w15
  mul w9, w9, w15
  mul w8, w8, w15
  mul w13, w13, w15
  mul w12, w12, w15
  mul w11, w11, w15
  mul w10, w10, w15
  mul w9, w9, w15
  mul w8, w8, w15
  mul w13, w13, w15
  mul w12, w12, w15
  mul w11, w11, w15
  mul w10, w10, w15
  mul w9, w9, w15
  mul w8, w8, w15
  mul w13, w13, w15
  mul w12, w12, w15
  sub x0, x0, x14
  cbnz x0, mul32test_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mul64test:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 2
  mov x14, 20
  mov x13, x15
  mov x12, x15
  mov x11, x15
  mov x10, x15
  mov x9, x15
  mov x8, x15
mul64test_loop:
  mul x13, x13, x15
  mul x12, x12, x15
  mul x11, x11, x15
  mul x10, x10, x15
  mul x9, x9, x15
  mul x8, x8, x15
  mul x13, x13, x15
  mul x12, x12, x15
  mul x11, x11, x15
  mul x10, x10, x15
  mul x9, x9, x15
  mul x8, x8, x15
  mul x13, x13, x15
  mul x12, x12, x15
  mul x11, x11, x15
  mul x10, x10, x15
  mul x9, x9, x15
  mul x8, x8, x15
  mul x13, x13, x15
  mul x12, x12, x15
  sub x0, x0, x14
  cbnz x0, mul64test_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

latmul64test:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 2
  mov x14, 20
  mov x13, x15
latmul64test_loop:
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  mul x13, x13, x13
  sub x0, x0, x14
  cbnz x0, latmul64test_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

/* needs an additional parameter passed in x1 - ptr to array of 4 floats */
vecadd128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
vecadd128test_loop:
  add v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  add v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  add v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  add v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  add v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  add v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  add v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  add v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  add v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  add v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  sub x0, x0, x14
  cbnz x0, vecadd128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

latvecadd128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
latvecadd128test_loop:
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  add v16.4s, v16.4s, v16.4s
  sub x0, x0, x14
  cbnz x0, latvecadd128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

faddtest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr s16, [x1]
  ldr s17, [x1, #0x4]
  ldr s18, [x1, #0x8]
  ldr s19, [x1, #0xC]
  ldr s20, [x1]
  ldr s21, [x1, #0x4]
faddtest_loop:
  fadd s16, s16, s16
  fadd s17, s17, s17
  fadd s18, s18, s18
  fadd s19, s19, s19
  fadd s20, s20, s20
  fadd s21, s21, s21
  fadd s16, s16, s16
  fadd s17, s17, s17
  fadd s18, s18, s18
  fadd s19, s19, s19
  fadd s20, s20, s20
  fadd s21, s21, s21
  fadd s16, s16, s16
  fadd s17, s17, s17
  fadd s18, s18, s18
  fadd s19, s19, s19
  fadd s20, s20, s20
  fadd s21, s21, s21
  fadd s16, s16, s16
  fadd s17, s17, s17
  sub x0, x0, x14
  cbnz x0, faddtest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

latfaddtest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr s16, [x1]
latfaddtest_loop:
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  fadd s16, s16, s16
  sub x0, x0, x14
  cbnz x0, latfaddtest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

latfmultest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr s16, [x1]
latfmultest_loop:
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  fmul s16, s16, s16
  sub x0, x0, x14
  cbnz x0, latfmultest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

latvecmul128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
latvecmul128test_loop:
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  mul v16.4s, v16.4s, v16.4s
  sub x0, x0, x14
  cbnz x0, latvecmul128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

vecmul128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
vecmul128test_loop:
  mul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  mul v18.4s, v18.4s, v18.4s
  mul v19.4s, v19.4s, v19.4s
  mul v20.4s, v20.4s, v20.4s
  mul v21.4s, v21.4s, v21.4s
  mul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  mul v18.4s, v18.4s, v18.4s
  mul v19.4s, v19.4s, v19.4s
  mul v20.4s, v20.4s, v20.4s
  mul v21.4s, v21.4s, v21.4s
  mul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  mul v18.4s, v18.4s, v18.4s
  mul v19.4s, v19.4s, v19.4s
  mul v20.4s, v20.4s, v20.4s
  mul v21.4s, v21.4s, v21.4s
  mul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  sub x0, x0, x14
  cbnz x0, vecmul128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

scalarfmatest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
  ldr q24, [x1]
  ldr q25, [x1]
scalarfmatest_loop:
  fmadd s16, s16, s16, s16
  fmadd s17, s17, s17, s17
  fmadd s18, s18, s18, s18
  fmadd s19, s19, s19, s19
  fmadd s20, s20, s20, s20
  fmadd s21, s21, s21, s21
  fmadd s22, s22, s22, s22
  fmadd s23, s23, s23, s23
  fmadd s24, s24, s24, s24
  fmadd s25, s25, s25, s25
  fmadd s16, s16, s16, s16
  fmadd s17, s17, s17, s17
  fmadd s18, s18, s18, s18
  fmadd s19, s19, s19, s19
  fmadd s20, s20, s20, s20
  fmadd s21, s21, s21, s21
  fmadd s22, s22, s22, s22
  fmadd s23, s23, s23, s23
  fmadd s24, s24, s24, s24
  fmadd s25, s25, s25, s25
  sub x0, x0, x14
  cbnz x0, scalarfmatest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

latscalarfmatest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
latscalarfmatest_loop:
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  fmadd s16, s16, s16, s16
  sub x0, x0, x14
  cbnz x0, latscalarfmatest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

vecfma128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
  ldr q24, [x1]
  ldr q25, [x1]
vecfma128test_loop:
  fmla v16.4s, v16.4s, v16.4s
  fmla v17.4s, v17.4s, v17.4s
  fmla v18.4s, v18.4s, v18.4s
  fmla v19.4s, v19.4s, v19.4s
  fmla v20.4s, v20.4s, v20.4s
  fmla v21.4s, v21.4s, v21.4s
  fmla v22.4s, v22.4s, v22.4s
  fmla v23.4s, v23.4s, v23.4s
  fmla v24.4s, v24.4s, v24.4s
  fmla v25.4s, v25.4s, v25.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v17.4s, v17.4s, v17.4s
  fmla v18.4s, v18.4s, v18.4s
  fmla v19.4s, v19.4s, v19.4s
  fmla v20.4s, v20.4s, v20.4s
  fmla v21.4s, v21.4s, v21.4s
  fmla v22.4s, v22.4s, v22.4s
  fmla v23.4s, v23.4s, v23.4s
  fmla v24.4s, v24.4s, v24.4s
  fmla v25.4s, v25.4s, v25.4s
  sub x0, x0, x14
  cbnz x0, vecfma128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixvecfmulfma128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
  ldr q24, [x1]
  ldr q25, [x1]
mixvecfmulfma128test_loop:
  fmla v16.4s, v16.4s, v16.4s
  fmul v17.4s, v17.4s, v17.4s
  fmla v18.4s, v18.4s, v18.4s
  fmul v19.4s, v19.4s, v19.4s
  fmla v20.4s, v20.4s, v20.4s
  fmul v21.4s, v21.4s, v21.4s
  fmla v22.4s, v22.4s, v22.4s
  fmul v23.4s, v23.4s, v23.4s
  fmla v24.4s, v24.4s, v24.4s
  fmul v25.4s, v25.4s, v25.4s
  fmla v16.4s, v16.4s, v16.4s
  fmul v17.4s, v17.4s, v17.4s
  fmla v18.4s, v18.4s, v18.4s
  fmul v19.4s, v19.4s, v19.4s
  fmla v20.4s, v20.4s, v20.4s
  fmul v21.4s, v21.4s, v21.4s
  fmla v22.4s, v22.4s, v22.4s
  fmul v23.4s, v23.4s, v23.4s
  fmla v24.4s, v24.4s, v24.4s
  fmul v25.4s, v25.4s, v25.4s
  sub x0, x0, x14
  cbnz x0, mixvecfmulfma128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixvecfaddfma128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
  ldr q24, [x1]
  ldr q25, [x1]
mixvecfaddfma128test_loop:
  fmla v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fmla v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  fmla v20.4s, v20.4s, v20.4s
  fadd v21.4s, v21.4s, v21.4s
  fmla v22.4s, v22.4s, v22.4s
  fadd v23.4s, v23.4s, v23.4s
  fmla v24.4s, v24.4s, v24.4s
  fadd v25.4s, v25.4s, v25.4s
  fmla v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fmla v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  fmla v20.4s, v20.4s, v20.4s
  fadd v21.4s, v21.4s, v21.4s
  fmla v22.4s, v22.4s, v22.4s
  fadd v23.4s, v23.4s, v23.4s
  fmla v24.4s, v24.4s, v24.4s
  fadd v25.4s, v25.4s, v25.4s
  sub x0, x0, x14
  cbnz x0, mixvecfaddfma128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

latvecfma128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
latvecfma128test_loop:
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  fmla v16.4s, v16.4s, v16.4s
  sub x0, x0, x14
  cbnz x0, latvecfma128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

vecfadd128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
vecfadd128test_loop:
  fadd v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fadd v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  fadd v20.4s, v20.4s, v20.4s
  fadd v21.4s, v21.4s, v21.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fadd v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  fadd v20.4s, v20.4s, v20.4s
  fadd v21.4s, v21.4s, v21.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fadd v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  fadd v20.4s, v20.4s, v20.4s
  fadd v21.4s, v21.4s, v21.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  sub x0, x0, x14
  cbnz x0, vecfadd128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

latvecfadd128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
latvecfadd128test_loop:
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  fadd v16.4s, v16.4s, v16.4s
  sub x0, x0, x14
  cbnz x0, latvecfadd128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

vecfmul128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
vecfmul128test_loop:
  fmul v16.4s, v16.4s, v16.4s
  fmul v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  fmul v19.4s, v19.4s, v19.4s
  fmul v20.4s, v20.4s, v20.4s
  fmul v21.4s, v21.4s, v21.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  fmul v19.4s, v19.4s, v19.4s
  fmul v20.4s, v20.4s, v20.4s
  fmul v21.4s, v21.4s, v21.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  fmul v19.4s, v19.4s, v19.4s
  fmul v20.4s, v20.4s, v20.4s
  fmul v21.4s, v21.4s, v21.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v17.4s, v17.4s, v17.4s
  sub x0, x0, x14
  cbnz x0, vecfmul128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

latvecfmul128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
latvecfmul128test_loop:
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  fmul v16.4s, v16.4s, v16.4s
  sub x0, x0, x14
  cbnz x0, latvecfmul128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixvecfaddfmul128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
mixvecfaddfmul128test_loop:
  fmul v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  fmul v20.4s, v20.4s, v20.4s
  fadd v21.4s, v21.4s, v21.4s
  fmul v22.4s, v22.4s, v22.4s
  fadd v23.4s, v23.4s, v23.4s
  fmul v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  fmul v20.4s, v20.4s, v20.4s
  fadd v21.4s, v21.4s, v21.4s
  fmul v22.4s, v22.4s, v22.4s
  fadd v23.4s, v23.4s, v23.4s
  fmul v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  sub x0, x0, x14
  cbnz x0, mixvecfaddfmul128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixvecaddmul128test:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
mixvecaddmul128test_loop:
  mul v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  mul v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  mul v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  mul v22.4s, v22.4s, v22.4s
  add v23.4s, v23.4s, v23.4s
  mul v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  mul v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  mul v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  mul v22.4s, v22.4s, v22.4s
  add v23.4s, v23.4s, v23.4s
  mul v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  mul v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  sub x0, x0, x14
  cbnz x0, mixvecaddmul128test_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixaddvecadd128test:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 30
  eor x13, x13, x13
  eor x12, x12, x12
  eor x11, x11, x11
  eor x10, x10, x10
  eor x9, x9, x9
  eor x8, x8, x8
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
mixaddvecadd128test_loop:
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add x10, x10, x15
  add v22.4s, v22.4s, v22.4s
  add v23.4s, v23.4s, v23.4s
  sub x0, x0, x14
  cbnz x0, mixaddvecadd128test_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mix3to1addvecadd128test:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 40
  eor x13, x13, x13
  eor x12, x12, x12
  eor x11, x11, x11
  eor x10, x10, x10
  eor x9, x9, x9
  eor x8, x8, x8
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
mix3to1addvecadd128test_loop:
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v16.4s, v16.4s, v16.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v17.4s, v17.4s, v17.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v18.4s, v18.4s, v18.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v19.4s, v19.4s, v19.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v20.4s, v20.4s, v20.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v16.4s, v16.4s, v16.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v17.4s, v17.4s, v17.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v18.4s, v18.4s, v18.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v19.4s, v19.4s, v19.4s
  add x13, x13, x15
  add x12, x12, x15
  add x11, x11, x15
  add v20.4s, v20.4s, v20.4s
  sub x0, x0, x14
  cbnz x0, mix3to1addvecadd128test_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mix1to1addvecadd128test:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 40
  eor x13, x13, x13
  eor x12, x12, x12
  eor x11, x11, x11
  eor x10, x10, x10
  eor x9, x9, x9
  eor x8, x8, x8
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
mix1to1addvecadd128test_loop:
  add x13, x13, x15
  add v16.4s, v16.4s, v16.4s
  add x12, x12, x15
  add v17.4s, v17.4s, v17.4s
  add x11, x11, x15
  add v18.4s, v18.4s, v18.4s
  add x10, x10, x15
  add v19.4s, v19.4s, v19.4s

  add x13, x13, x15
  add v16.4s, v16.4s, v16.4s
  add x12, x12, x15
  add v17.4s, v17.4s, v17.4s
  add x11, x11, x15
  add v18.4s, v18.4s, v18.4s
  add x10, x10, x15
  add v19.4s, v19.4s, v19.4s

  add x13, x13, x15
  add v16.4s, v16.4s, v16.4s
  add x12, x12, x15
  add v17.4s, v17.4s, v17.4s
  add x11, x11, x15
  add v18.4s, v18.4s, v18.4s
  add x10, x10, x15
  add v19.4s, v19.4s, v19.4s

  add x13, x13, x15
  add v16.4s, v16.4s, v16.4s
  add x12, x12, x15
  add v17.4s, v17.4s, v17.4s
  add x11, x11, x15
  add v18.4s, v18.4s, v18.4s
  add x10, x10, x15
  add v19.4s, v19.4s, v19.4s

  add x13, x13, x15
  add v16.4s, v16.4s, v16.4s
  add x12, x12, x15
  add v17.4s, v17.4s, v17.4s
  add x11, x11, x15
  add v18.4s, v18.4s, v18.4s
  add x10, x10, x15
  add v19.4s, v19.4s, v19.4s

  sub x0, x0, x14
  cbnz x0, mix1to1addvecadd128test_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mixmulvecmultest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 2
  mov x14, 20
  mov x13, x15
  mov x12, x15
  mov x11, x15
  mov x10, x15
  mov x9, x15
  mov x8, x15
  mov x7, x15
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1]
  ldr q22, [x1]
  ldr q23, [x1]
mixmulvecmultest_loop:
  mul w8, w8, w15
  mul v16.4s, v16.4s, v16.4s
  mul w9, w9, w15
  mul v17.4s, v17.4s, v17.4s
  mul w10, w10, w15
  mul v18.4s, v18.4s, v18.4s
  mul w11, w11, w15
  mul v19.4s, v19.4s, v19.4s
  mul w12, w12, w15
  mul v20.4s, v20.4s, v20.4s
  mul w8, w8, w15
  mul v16.4s, v16.4s, v16.4s
  mul w9, w9, w15
  mul v17.4s, v17.4s, v17.4s
  mul w10, w10, w15
  mul v18.4s, v18.4s, v18.4s
  mul w11, w11, w15
  mul v19.4s, v19.4s, v19.4s
  mul w12, w12, w15
  mul v20.4s, v20.4s, v20.4s
  sub x0, x0, x14
  cbnz x0, mixmulvecmultest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mixvecmulfmultest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x2]
  ldr q18, [x1]
  ldr q19, [x2]
  ldr q20, [x1]
  ldr q21, [x2]
mixvecmulfmultest_loop:
  fmul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  mul v19.4s, v19.4s, v19.4s
  fmul v20.4s, v20.4s, v20.4s
  mul v21.4s, v21.4s, v21.4s
  fmul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  mul v19.4s, v19.4s, v19.4s
  fmul v20.4s, v20.4s, v20.4s
  mul v21.4s, v21.4s, v21.4s
  fmul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  fmul v18.4s, v18.4s, v18.4s
  mul v19.4s, v19.4s, v19.4s
  fmul v20.4s, v20.4s, v20.4s
  mul v21.4s, v21.4s, v21.4s
  fmul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  sub x0, x0, x14
  cbnz x0, mixvecmulfmultest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixvecaddfaddtest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x2]
  ldr q18, [x1]
  ldr q19, [x2]
  ldr q20, [x1]
  ldr q21, [x2]
mixvecaddfaddtest_loop:
  fadd v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  fadd v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  fadd v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  fadd v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  fadd v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  fadd v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  fadd v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  fadd v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  fadd v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s
  fadd v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  sub x0, x0, x14
  cbnz x0, mixvecaddfaddtest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixjmpvecaddtest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 30
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
mixjmpvecaddtest_loop:
  add v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v20.4s, v20.4s, v20.4s
  add v16.4s, v16.4s, v16.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v17.4s, v17.4s, v17.4s
  add v18.4s, v18.4s, v18.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v19.4s, v19.4s, v19.4s
  add v20.4s, v20.4s, v20.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v20.4s, v20.4s, v20.4s
  add v16.4s, v16.4s, v16.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v17.4s, v17.4s, v17.4s
  add v18.4s, v18.4s, v18.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  add v19.4s, v19.4s, v19.4s
  add v20.4s, v20.4s, v20.4s
  cbz x0, mixjmpvecaddtest_jellydonut
  sub x0, x0, x14
  cbnz x0, mixjmpvecaddtest_loop
mixjmpvecaddtest_jellydonut:
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixjmpvecmultest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
mixjmpvecmultest_loop:
  mul v16.4s, v16.4s, v16.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v17.4s, v17.4s, v17.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v18.4s, v18.4s, v18.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v19.4s, v19.4s, v19.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v20.4s, v20.4s, v20.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v16.4s, v16.4s, v16.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v17.4s, v17.4s, v17.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v18.4s, v18.4s, v18.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v19.4s, v19.4s, v19.4s
  cbz x0, mixjmpvecmultest_jellydonut
  mul v20.4s, v20.4s, v20.4s
  cbz x0, mixjmpvecmultest_jellydonut
  sub x0, x0, x14
  cbnz x0, mixjmpvecmultest_loop
mixjmpvecmultest_jellydonut:
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

vecloadtest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
vecloadtest_loop:
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  sub x0, x0, x14
  cbnz x0, vecloadtest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

vecstoretest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
vecstoretest_loop:
  str q16, [x2]
  str q17, [x2]
  str q18, [x2]
  str q19, [x2]
  str q20, [x2]
  str q16, [x2]
  str q17, [x2]
  str q18, [x2]
  str q19, [x2]
  str q20, [x2]
  str q16, [x2]
  str q17, [x2]
  str q18, [x2]
  str q19, [x2]
  str q20, [x2]
  str q16, [x2]
  str q17, [x2]
  str q18, [x2]
  str q19, [x2]
  str q20, [x2]
  sub x0, x0, x14
  cbnz x0, vecstoretest_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

loadtest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x14, 20
loadtest_loop:
  ldr x10, [x1]
  ldr x11, [x1]
  ldr x12, [x1]
  ldr x13, [x1]
  ldr x15, [x1]
  ldr x10, [x1]
  ldr x11, [x1]
  ldr x12, [x1]
  ldr x13, [x1]
  ldr x15, [x1]
  ldr x10, [x1]
  ldr x11, [x1]
  ldr x12, [x1]
  ldr x13, [x1]
  ldr x15, [x1]
  ldr x10, [x1]
  ldr x11, [x1]
  ldr x12, [x1]
  ldr x13, [x1]
  ldr x15, [x1]
  sub x0, x0, x14
  cbnz x0, loadtest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mixloadstoretest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x14, 20
mixloadstoretest_loop:
  ldr x10, [x1]
  str x14, [x2]
  ldr x11, [x1]
  str x14, [x2]
  ldr x12, [x1]
  str x14, [x2]
  ldr x13, [x1]
  str x14, [x2]
  ldr x15, [x1]
  str x14, [x2]
  ldr x10, [x1]
  str x14, [x2]
  ldr x11, [x1]
  str x14, [x2]
  ldr x12, [x1]
  str x14, [x2]
  ldr x13, [x1]
  str x14, [x2]
  ldr x15, [x1]
  str x14, [x2]
  sub x0, x0, x14
  cbnz x0, mixloadstoretest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mix21loadstoretest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x14, 30
mix21loadstoretest_loop:
  ldr x10, [x1]
  ldr x11, [x1]
  str x14, [x2]
  ldr x12, [x1]
  ldr x13, [x1]
  str x14, [x2]
  ldr x10, [x1]
  ldr x11, [x1]
  str x14, [x2]
  ldr x12, [x1]
  ldr x13, [x1]
  str x14, [x2]
  ldr x10, [x1]
  ldr x11, [x1]
  str x14, [x2]
  ldr x12, [x1]
  ldr x13, [x1]
  str x14, [x2]
  ldr x10, [x1]
  ldr x11, [x1]
  str x14, [x2]
  ldr x12, [x1]
  ldr x13, [x1]
  str x14, [x2]
  ldr x10, [x1]
  ldr x11, [x1]
  str x14, [x2]
  ldr x12, [x1]
  ldr x13, [x1]
  str x14, [x2]
  sub x0, x0, x14
  cbnz x0, mix21loadstoretest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

jmptest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
jmptest_loop:
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  cbz x0, jmptest_jellydonut
  sub x0, x0, x14
  cbnz x0, jmptest_loop
jmptest_jellydonut:
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

fusejmptest:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 20
fusejmptest_loop:
  nop
  nop
  cmp x0, 0
  b.eq jmptest_jellydonut
  nop
  nop
  cmp x0, 0
  b.eq jmptest_jellydonut
  nop
  nop
  cmp x0, 0
  b.eq jmptest_jellydonut
  nop
  nop
  cmp x0, 0
  b.eq jmptest_jellydonut
  nop
  sub x0, x0, x14
  cmp x0, 0
  b.ne fusejmptest_loop
fusejmptest_jellydonut:
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret

mixmuljmptest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x8, 7
  mov x9, 6
  mov x10, 1
  mov x11, 2
  mov x12, 3
  mov x13, 4
  mov x15, 5
  mov x14, 20
mixmuljmptest_loop:
  mul x10, x10, x15
  mul x11, x11, x15
  mul x12, x12, x15
  mul x13, x13, x15
  mul x9, x9, x15
  mul x8, x8, x15
  mul x10, x10, x15
  mul x11, x11, x15
  mul x12, x12, x15
  mul x13, x13, x15
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  sub x0, x0, x14
  cbnz x0, mixmuljmptest_loop
mixmuljmptest_jellydonut:
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mixmuljmptest21:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x8, 7
  mov x9, 6
  mov x10, 1
  mov x11, 2
  mov x12, 3
  mov x13, 4
  mov x15, 5
  mov x14, 30
mixmuljmptest21_loop:
  mul x10, x10, x15
  mul x11, x11, x15
  mul x12, x12, x15
  mul x13, x13, x15
  mul x9, x9, x15
  mul x8, x8, x15
  mul x10, x10, x15
  mul x11, x11, x15
  mul x12, x12, x15
  mul x13, x13, x15
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  cbz x0, mixmuljmptest21_jellydonut
  mul x10, x10, x15
  mul x11, x11, x15
  mul x12, x12, x15
  mul x13, x13, x15
  mul x9, x9, x15
  mul x8, x8, x15
  mul x10, x10, x15
  mul x11, x11, x15
  mul x12, x12, x15
  mul x13, x13, x15
  sub x0, x0, x14
  cbnz x0, mixmuljmptest21_loop
mixmuljmptest21_jellydonut:
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mixaddjmptest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x8, 7
  mov x9, 6
  mov x10, 1
  mov x11, 2
  mov x12, 3
  mov x13, 4
  mov x15, 5
  mov x14, 20
mixaddjmptest_loop:
  add x10, x10, x15
  add x11, x11, x15
  add x12, x12, x15
  add x13, x13, x15
  add x9, x9, x15
  add x8, x8, x15
  add x10, x10, x15
  add x11, x11, x15
  add x12, x12, x15
  add x13, x13, x15
  cbz x0, mixaddjmptest_jellydonut
  cbz x0, mixaddjmptest_jellydonut
  cbz x0, mixaddjmptest_jellydonut
  cbz x0, mixaddjmptest_jellydonut
  cbz x0, mixaddjmptest_jellydonut
  cbz x0, mixaddjmptest_jellydonut
  cbz x0, mixaddjmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  cbz x0, mixmuljmptest_jellydonut
  sub x0, x0, x14
  cbnz x0, mixmuljmptest_loop
mixaddjmptest_jellydonut:
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

mixaddjmp21test:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40] 
  mov x8, 7
  mov x9, 6
  mov x10, 1
  mov x11, 2
  mov x12, 3
  mov x13, 4
  mov x15, 5
  mov x14, 15
mixaddjmp21test_loop:
  add x10, x10, x15
  add x11, x11, x15
  cbz x0, mixaddjmp21test_jellydonut
  
  add x12, x12, x15
  add x13, x13, x15
  cbz x0, mixaddjmp21test_jellydonut
  
  add x9, x9, x15
  add x8, x8, x15
  cbz x0, mixaddjmp21test_jellydonut
  
  add x10, x10, x15
  add x11, x11, x15
  cbz x0, mixaddjmp21test_jellydonut
  
  add x12, x12, x15
  add x13, x13, x15
  cbz x0, mixaddjmp21test_jellydonut

  sub x0, x0, x14
  cmp x0, 0
  b.gt mixaddjmp21test_loop
mixaddjmp21test_jellydonut:
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50 
  ret


mixmulrortest:
  sub sp, sp, #0x80
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  stp x19, x20, [sp, #0x50]
  stp x21, x22, [sp, #0x60]
  stp x23, x24, [sp, #0x70]
  mov x8, 7
  mov x9, 6
  mov x10, 1
  mov x11, 2
  mov x12, 3
  mov x13, 4
  mov x15, 5
  mov x19, x8
  mov x20, x8
  mov x21, x8
  mov x22, x8
  mov x23, x8
  mov x24, x8
  mov x14, 20
mixmulrortest_loop:
  ror x24, x24, 1
  ror x23, x23, 1
  ror x22, x22, 1
  ror x21, x21, 1
  ror x20, x20, 1
  mul x10, x10, x15
  mul x11, x11, x15
  mul x12, x12, x15
  mul x13, x13, x15
  mul x9, x9, x15
  ror x24, x24, 1
  ror x23, x23, 1
  ror x22, x22, 1
  ror x21, x21, 1
  ror x20, x20, 1
  mul x8, x8, x15
  mul x10, x10, x15
  mul x11, x11, x15
  mul x12, x12, x15
  mul x13, x13, x15
  sub x0, x0, x14
  cbnz x0, mixmulrortest_loop
  ldp x23, x24, [sp, #0x70]
  ldp x21, x22, [sp, #0x60]
  ldp x19, x20, [sp, #0x50]
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x80
  ret


rortest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x8, 7
  mov x9, 6
  mov x10, 1
  mov x11, 2
  mov x12, 3
  mov x13, 4
  mov x15, 5
  mov x14, 20
rortest_loop:
  ror x10, x10, 1
  ror x11, x11, 1
  ror x12, x12, 1
  ror x13, x13, 1
  ror x9, x9, 1
  ror x8, x8, 1
  ror x10, x10, 1
  ror x11, x11, 1
  ror x12, x12, 1
  ror x13, x13, 1
  ror x10, x10, 1
  ror x11, x11, 1
  ror x12, x12, 1
  ror x13, x13, 1
  ror x9, x9, 1
  ror x8, x8, 1
  ror x10, x10, 1
  ror x11, x11, 1
  ror x12, x12, 1
  ror x13, x13, 1
  sub x0, x0, x14
  cbnz x0, rortest_loop
rortest_jellydonut:
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

depmovtest:
  sub sp, sp, #0x40
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  mov x15, 1
  mov x14, 20
  eor x13, x13, x13
depmovtest_loop:
  mov x12, x15
  mov x10, x12
  mov x13, x10
  mov x11, x13
  mov x15, x11
  mov x12, x15
  mov x10, x12
  mov x13, x10
  mov x11, x13
  mov x15, x11
  mov x12, x15
  mov x10, x12
  mov x13, x10
  mov x11, x13
  mov x15, x11
  mov x12, x15
  mov x10, x12
  mov x13, x10
  mov x11, x13
  mov x15, x11
  sub x0, x0, x14
  cbnz x0, depmovtest_loop
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x40
  ret

indepmovtest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 20
  eor x13, x13, x13
indepmovtest_loop:
  mov x10, x15
  mov x11, x14
  mov x12, x13
  mov x9, x15
  mov x8, x14
  mov x10, x15
  mov x11, x14
  mov x12, x13
  mov x9, x15
  mov x8, x14
  mov x10, x15
  mov x11, x14
  mov x12, x13
  mov x9, x15
  mov x8, x14
  mov x10, x15
  mov x11, x14
  mov x12, x13
  mov x9, x15
  mov x8, x14
  sub x0, x0, x14
  cbnz x0, indepmovtest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

xorzerotest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 20
xorzerotest_loop:
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  eor x15, x15, x15
  sub x0, x0, x14
  cbnz x0, xorzerotest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

movzerotest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 20
movzerotest_loop:
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  mov x15, 0
  sub x0, x0, x14
  cbnz x0, movzerotest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

subzerotest:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  mov x15, 1
  mov x14, 20
subzerotest_loop:
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x15, x15, x15
  sub x0, x0, x14
  cbnz x0, subzerotest_loop
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret
