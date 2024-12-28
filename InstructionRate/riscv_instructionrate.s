.text

.global clktest
.global addtest
.global faddtest
.global fmultest
.global mixfaddfmultest
.global fmatest
.global faddlattest
.global fmullattest
.global fmalattest

/* a0 = iterations, a1 = data arr */
clktest:
  mv t0, x0
  mv t1, x0
  addi t1, t1, 1
clktest_loop:
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  add t0, t0, t1
  addi a0, a0, -20
  blt x0, a0, clktest_loop
  ret

addtest:
  mv t0, x0
  addi t0, t0, 1
  mv t1, t0
  mv t2, t0
  mv t3, t0
  mv t4, t0
  mv t5, t0
  mv t6, t0
addtest_loop:
  add t1, t1, t6
  add t2, t2, t6
  add t3, t3, t6
  add t4, t4, t6
  add t5, t5, t6
  add t1, t1, t6
  add t2, t2, t6
  add t3, t3, t6
  add t4, t4, t6
  add t5, t5, t6 
  add t1, t1, t6
  add t2, t2, t6
  add t3, t3, t6
  add t4, t4, t6
  add t5, t5, t6
  add t1, t1, t6
  add t2, t2, t6
  add t3, t3, t6
  add t4, t4, t6
  add t5, t5, t6  
  addi a0, a0, -20
  blt x0, a0, addtest_loop
  ret

/* f0-7 are fp temporaries */
faddtest:
  flw f0, (a1)
  flw f1, 4(a1)
  flw f2, 8(a1)
  flw f3, 12(a1)
  fsub.d f4, f4, f4
  fsub.d f5, f5, f5
  fsub.d f6, f6, f6
  fsub.d f7, f7, f7
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0
faddtest_loop:
  fadd.d f1, f1, f0
  fadd.d f2, f2, f0
  fadd.d f3, f3, f0
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0
  fadd.d f1, f1, f0
  fadd.d f2, f2, f0
  fadd.d f3, f3, f0
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0 
  addi a0, a0, -14
  blt x0, a0, faddtest_loop
  ret

faddlattest:
  flw f0, (a1)
  flw f1, 4(a1)
  flw f2, 8(a1)
  flw f3, 12(a1)
  fsub.d f4, f4, f4
  fsub.d f5, f5, f5
  fsub.d f6, f6, f6
  fsub.d f7, f7, f7
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0
faddlattest_loop:
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1
  fadd.d f1, f1, f1 
  addi a0, a0, -14
  blt x0, a0, faddlattest_loop
  ret 

fmultest:
  flw f0, (a1)
  flw f1, 4(a1)
  flw f2, 8(a1)
  flw f3, 12(a1)
  fsub.d f4, f4, f4
  fsub.d f5, f5, f5
  fsub.d f6, f6, f6
  fsub.d f7, f7, f7
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0
fmultest_loop:
  fmul.d f1, f1, f0
  fmul.d f2, f2, f0
  fmul.d f3, f3, f0
  fmul.d f4, f4, f0
  fmul.d f5, f5, f0
  fmul.d f6, f6, f0
  fmul.d f7, f7, f0
  fmul.d f1, f1, f0
  fmul.d f2, f2, f0
  fmul.d f3, f3, f0
  fmul.d f4, f4, f0
  fmul.d f5, f5, f0
  fmul.d f6, f6, f0
  fmul.d f7, f7, f0 
  addi a0, a0, -14
  blt x0, a0, fmultest_loop
  ret 

fmullattest:
  flw f0, (a1)
  flw f1, 4(a1)
  flw f2, 8(a1)
  flw f3, 12(a1)
  fsub.d f4, f4, f4
  fsub.d f5, f5, f5
  fsub.d f6, f6, f6
  fsub.d f7, f7, f7
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0
fmullattest_loop:
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1
  fmul.d f1, f1, f1 
  addi a0, a0, -14
  blt x0, a0, fmullattest_loop
  ret

mixfaddfmultest:
  flw f0, (a1)
  flw f1, 4(a1)
  flw f2, 8(a1)
  flw f3, 12(a1)
  fsub.d f4, f4, f4
  fsub.d f5, f5, f5
  fsub.d f6, f6, f6
  fsub.d f7, f7, f7
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0
mixfaddfmultest_loop:
  fadd.d f1, f1, f0
  fmul.d f2, f2, f0
  fadd.d f3, f3, f0
  fmul.d f4, f4, f0
  fadd.d f5, f5, f0
  fmul.d f6, f6, f0
  fadd.d f7, f7, f0
  fmul.d f1, f1, f0
  fadd.d f2, f2, f0
  fmul.d f3, f3, f0
  fadd.d f4, f4, f0
  fmul.d f5, f5, f0
  fadd.d f6, f6, f0
  fmul.d f7, f7, f0 
  addi a0, a0, -14
  blt x0, a0, mixfaddfmultest_loop
  ret  

fmatest:
  flw f0, (a1)
  flw f1, 4(a1)
  flw f2, 8(a1)
  flw f3, 12(a1)
  fsub.d f4, f4, f4
  fsub.d f5, f5, f5
  fsub.d f6, f6, f6
  fsub.d f7, f7, f7
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0
fmatest_loop:
  fmadd.d f1, f1, f1, f0
  fmadd.d f2, f2, f2, f0
  fmadd.d f3, f3, f3, f0
  fmadd.d f4, f4, f4, f0
  fmadd.d f5, f5, f5, f0
  fmadd.d f6, f6, f6, f0
  fmadd.d f7, f7, f7, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f2, f2, f2, f0
  fmadd.d f3, f3, f3, f0
  fmadd.d f4, f4, f4, f0
  fmadd.d f5, f5, f5, f0
  fmadd.d f6, f6, f6, f0
  fmadd.d f7, f7, f7, f0 
  addi a0, a0, -14
  blt x0, a0, fmatest_loop
  ret  

fmalattest:
  flw f0, (a1)
  flw f1, 4(a1)
  flw f2, 8(a1)
  flw f3, 12(a1)
  fsub.d f4, f4, f4
  fsub.d f5, f5, f5
  fsub.d f6, f6, f6
  fsub.d f7, f7, f7
  fadd.d f4, f4, f0
  fadd.d f5, f5, f0
  fadd.d f6, f6, f0
  fadd.d f7, f7, f0
fmalattest_loop:
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0
  fmadd.d f1, f1, f1, f0 
  addi a0, a0, -14
  blt x0, a0, fmalattest_loop
  ret
