        AREA    AsmCode, CODE, READONLY    ; marks a code area called AsmCode
        EXPORT neon_asm_read
        EXPORT neon_asm_write

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

END