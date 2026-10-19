        AREA    AsmCode, CODE, READONLY    ; marks a code area called AsmCode
        EXPORT preplatencyarr                    ; makes testfunc available to the linker
        EXPORT latencytest
        EXPORT gatherlatencytest

preplatencyarr FUNCTION
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x15, 0
preplatencyarr_loop
  ldr x14, [x0, w15, uxtw #3]
  lsl x14, x14, 3
  add x14, x14, x0
  str x14, [x0, w15, uxtw #3]
  add w15, w15, 1
  cmp x15, x1
  b.ne preplatencyarr_loop
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret
  ENDFUNC

latencytest FUNCTION
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 0
  ldr x15, [x1]
latencytest_loop
  ldr x15, [x15]
  add x14, x14, x15
  sub x0, x0, 1
  cbnz x0, latencytest_loop
  mov x0, x14
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret
  ENDFUNC

gatherlatencytest FUNCTION
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  mov x14, 0
  fmov s0, w14
  dup v0.4s, v0.s[0]
  ptrue p0.s
  ld1w z0.s, p0/z, [x1, z0.s, uxtw#2]
gatherlatencytest_loop
  ld1w z0.s, p0/z, [x1, z0.s, uxtw#2]
  sub x0, x0, 1
  cbnz x0, gatherlatencytest_loop
  mov x0, 1
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret
  ENDFUNC

END