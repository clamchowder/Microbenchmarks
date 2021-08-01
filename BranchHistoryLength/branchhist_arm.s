.arch armv8-a
.text

.global branchtest


/* 
  aarch64 calling convention:
  x0 = arg0 = iteration count
  x1 = arg1 = ptr to arr (used as w2)
  x2 = arg2 = arr len
*/
branchtest:
  stp x15, x16, [sp, #0x20]
  stp x13, x14, [sp, #0x10]
  eor w16, w16, w16
  eor x14, x14, x14
  eor x13, x13, x13
branchtest_loop:
  ldr w15, [x1, w16, uxtw #2]
  add w16, w16, 1
  cmp w16, w2
  csel x16, x13, x16, EQ
  cbz w15, branchtest_zero
  add x14, x14, 1
branchtest_zero:
  sub x0, x0, 1
  cbnz x0, branchtest_loop
  mov x0, x14
  ldp x13, x14, [sp, #0x10]
  ldp x15, x16, [sp, #0x20]
  ret
