.text
.global clktest
.global noptest
.global addtest
.global loadtest

clktest:
  xor $r12, $r12, $r12
  xor $r13, $r13, $r13   /* r13 is just zero */
  xor $r14, $r14, $r14
  addi.d $r14, $r14, 20
  addi.d $r12, $r12, 1
clktest_loop:
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  sub.d $r4, $r4, $r14       /* iteration count = iteration count - 20 */
  bge $r4, $r13, clktest_loop /* if iteration count > 0, jump back to loop */
  jr $r1

/* r4 = iteration count */
noptest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  addi.d $r14, $r14, 20
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
  sub.d $r4, $r4, $r14 
  bge $r4, $r13, noptest_loop
  jr $r1

/* r4 = iteration count */
addtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
addtest_loop:
  add.d $r12, $r12, $r14
  add.d $r13, $r13, $r14
  add.d $r15, $r15, $r14
  add.d $r16, $r16, $r14
  add.d $r17, $r17, $r14
  add.d $r12, $r12, $r14
  add.d $r13, $r13, $r14
  add.d $r15, $r15, $r14
  add.d $r16, $r16, $r14
  add.d $r17, $r17, $r14
  add.d $r12, $r12, $r14
  add.d $r13, $r13, $r14
  add.d $r15, $r15, $r14
  add.d $r16, $r16, $r14
  add.d $r17, $r17, $r14
  add.d $r12, $r12, $r14
  add.d $r13, $r13, $r14
  add.d $r15, $r15, $r14
  add.d $r16, $r16, $r14
  add.d $r17, $r17, $r14
  sub.d $r4, $r4, $r14 
  bge $r4, $r18, addtest_loop
  jr $r1

/* r4 = iteration count, r5 = arr */
loadtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
loadtest_loop:
  ld.d $r12, $r5, 0 
  ld.d $r13, $r5, 1 
  ld.d $r15, $r5, 2 
  ld.d $r16, $r5, 3 
  ld.d $r17, $r5, 5 
  ld.d $r12, $r5, 0
  ld.d $r13, $r5, 1
  ld.d $r15, $r5, 2
  ld.d $r16, $r5, 3
  ld.d $r17, $r5, 5
  ld.d $r12, $r5, 0
  ld.d $r13, $r5, 1
  ld.d $r15, $r5, 2
  ld.d $r16, $r5, 3
  ld.d $r17, $r5, 5
  ld.d $r12, $r5, 0
  ld.d $r13, $r5, 1
  ld.d $r15, $r5, 2
  ld.d $r16, $r5, 3
  ld.d $r17, $r5, 5
  sub.d $r4, $r4, $r14 
  bge $r4, $r18, loadtest_loop
  jr $r1

