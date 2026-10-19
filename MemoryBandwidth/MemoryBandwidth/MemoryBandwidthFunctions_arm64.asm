        AREA    AsmCode, CODE, READONLY    ; marks a code area called AsmCode
        EXPORT neon_asm_read
        EXPORT neon_asm_cl_read
        EXPORT neon_asm_write
        EXPORT neon_asm_add
        EXPORT sve_gather_read

; x0 = ptr to arr
; x1 = fp32 elements in arr
; x2 = iterations
neon_asm_read FUNCTION
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128
  mov x14, 0 ; array index
  mov x13, 0 ; comparison
  mov x15, x0 ; array position
neon_asm_read_pass_loop
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q22, [x15, 112]
  add x14, x14, 32
  add x15, x15, 128
  cmp x14, x1
  b.lt neon_asm_read_pass_loop
  mov x14, 0
  mov x15, x0
  subs x2, x2, 1
  b.gt neon_asm_read_pass_loop
  ldp x14, x15, [sp, #0x10]
  ldp x12, x13, [sp, #0x20]
  add sp, sp, #0x30
  fadd s0, s0, s16
  ret
  ENDFUNC

; x0 = ptr to arr
; x1 = fp32 elements in arr
; x2 = iterations
neon_asm_cl_read FUNCTION
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128
  mov x14, 0 ; array index
  mov x13, 0 ; comparison
  mov x15, x0 ; array position
neon_asm_cl_read_pass_loop
  ldr q16, [x15]
  ldr q20, [x15, 64]
  add x14, x14, 32
  add x15, x15, 128
  cmp x14, x1
  b.lt neon_asm_cl_read_pass_loop
  mov x14, 0
  mov x15, x0
  subs x2, x2, 1
  b.gt neon_asm_cl_read_pass_loop
  ldp x14, x15, [sp, #0x10]
  ldp x12, x13, [sp, #0x20]
  add sp, sp, #0x30
  fadd s0, s0, s16
  ret
  ENDFUNC

neon_asm_write FUNCTION
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128
  mov x14, 0 ; array index
  mov x13, 0 ; comparison
  mov x15, x0 ; array position
  ldr q16, [x15]
  ldr q17, [x15]
  ldr q18, [x15]
  ldr q19, [x15]
  ldr q20, [x15]
  ldr q21, [x15]
  ldr q22, [x15]
neon_asm_write_pass_loop
  str q16, [x15]
  str q17, [x15, 16]
  str q18, [x15, 32]
  str q19, [x15, 48]
  str q20, [x15, 64]
  str q21, [x15, 80]
  str q22, [x15, 96]
  str q22, [x15, 112]
  add x14, x14, 32
  add x15, x15, 128
  cmp x14, x1
  b.lt neon_asm_write_pass_loop
  mov x14, 0
  mov x15, x0
  subs x2, x2, 1
  b.gt neon_asm_write_pass_loop
  ldp x14, x15, [sp, #0x10]
  ldp x12, x13, [sp, #0x20]
  add sp, sp, #0x30
  fadd s0, s0, s16
  ret
  ENDFUNC

neon_asm_add FUNCTION
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128
  mov x14, 0 ; array index
  mov x13, 0 ; comparison
  mov x15, x0 ; array position
  ldr q0, [x15]
neon_asm_add_pass_loop
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q23, [x15, 112]
  add v16.4s, v16.4s, v0.4s
  add v17.4s, v17.4s, v0.4s
  add v18.4s, v18.4s, v0.4s
  add v19.4s, v19.4s, v0.4s
  add v20.4s, v20.4s, v0.4s
  add v21.4s, v21.4s, v0.4s
  add v22.4s, v22.4s, v0.4s
  add v23.4s, v23.4s, v0.4s
  str q16, [x15]
  str q17, [x15, 16]
  str q18, [x15, 32]
  str q19, [x15, 48]
  str q20, [x15, 64]
  str q21, [x15, 80]
  str q22, [x15, 96]
  str q23, [x15, 112]
  add x14, x14, 32
  add x15, x15, 128
  cmp x14, x1
  b.lt neon_asm_add_pass_loop
  mov x14, 0
  mov x15, x0
  subs x2, x2, 2
  b.gt neon_asm_add_pass_loop
  ldp x14, x15, [sp, #0x10]
  ldp x12, x13, [sp, #0x20]
  add sp, sp, #0x30
  fadd s0, s0, s16
  ret
  ENDFUNC

sve_gather_read FUNCTION
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128
  mov x14, 0 ; array index
  mov x13, 0 ; comparison
  mov x15, x0 ; array position

  ; set up an index vector, all in same 16B
  ; replicate two of them, see if there's an optimization
  mov x12, 0
  str x12, [x0]
  mov x12, 0
  str x12, [x0, 8]
  mov x12, 0
  str x12, [x0, 16]
  mov x12, 0
  str x12, [x0, 24]
  ldr q0, [x0]

  ; generate 7 more
  mov w12, 0
  fmov s16, w12
  dup v16.4s, v16.s[0]
  add v1.4s, v0.4s, v16.4s
  add v2.4s, v1.4s, v16.4s
  add v3.4s, v2.4s, v16.4s
  add v4.4s, v3.4s, v16.4s
  add v5.4s, v4.4s, v16.4s
  add v6.4s, v5.4s, v16.4s
  add v7.4s, v6.4s, v16.4s

  ptrue p0.s
sve_gather_read_pass_loop
  ld1w z16.s, p0/z, [x15, z0.s, uxtw#2]
  ld1w z17.s, p0/z, [x15, z1.s, uxtw#2]
  ld1w z18.s, p0/z, [x15, z2.s, uxtw#2]
  ld1w z19.s, p0/z, [x15, z3.s, uxtw#2]
  ld1w z20.s, p0/z, [x15, z4.s, uxtw#2]
  ld1w z21.s, p0/z, [x15, z5.s, uxtw#2]
  ld1w z22.s, p0/z, [x15, z6.s, uxtw#2]
  ld1w z23.s, p0/z, [x15, z7.s, uxtw#2]
  add x14, x14, 32
  add x15, x15, 128
  cmp x14, x1
  b.lt sve_gather_read_pass_loop
  mov x14, 0
  mov x15, x0
  subs x2, x2, 1
  b.gt sve_gather_read_pass_loop
  ldp x14, x15, [sp, #0x10]
  ldp x12, x13, [sp, #0x20]
  add sp, sp, #0x30
  fadd s0, s0, s16
  ret
  ENDFUNC

END