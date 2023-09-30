.text
.global clktsctest

.global _clktsctest

.balign 4

/* x0 = iterations, return elapsed TSC in x0 */
_clktsctest:
clktsctest:
  sub sp, sp, #0x40
  stp x10, x11, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x14, x15, [sp, #0x30]
  mov x10, 1
  mov x11, 20
  mov x12, 0
  /* stackoverflow says this is a good idea */
  mrs x14, cntvct_el0
clktsctest_loop:
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  add x12, x12, x10
  sub x0, x0, x11
  cbnz x0, clktsctest_loop
  mrs x15, cntvct_el0
  sub x0, x15, x14
  ldp x14, x15, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x10, x11, [sp, #0x10]
  add sp, sp, #0x40
  ret
