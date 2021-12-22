.arch armv8-a
.text

.global asm_read
.global asm_write

/* x0 = ptr to array (was rcx)
 * x1 = arr length (was rdx)
 * x2 = iterations (was r8)
 * x3 = start (was r9)
 */
asm_read:
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128 /* last iteration: rsi == rdx. rsi > rdx = break */
  mov x14, x3     /* set x14 = index into array to start location (x3) */
  eor x13, x13, x13 /* x13 = 0 (for comparison) */
asm_read_pass_loop:
  lsl x12, x14, 2  /* x12 = x14 * 4, because float is 4B */
  add x15, x0, x12 /* ptr (x15) to next element = x0 (base) + x12 (index *4) */
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q22, [x15, 112]
  add x14, x14, 32

  lsl x12, x14, 2  
  add x15, x0, x12 
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q22, [x15, 112]
  add x14, x14, 32

  lsl x12, x14, 2  
  add x15, x0, x12 
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q22, [x15, 112]
  add x14, x14, 32

  lsl x12, x14, 2  
  add x15, x0, x12 
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q22, [x15, 112]
  add x14, x14, 32
  
  cmp x1, x14 /* if x1 (len - 128) - x14 < 0, loop back around */
  csel x14, x13, x14, LT
  cmp x14, x3
  b.ne asm_read_pass_loop /* skip iteration decrement if we're not back to start */
  sub x2, x2, 1
  cbnz x2, asm_read_pass_loop
  ins v0.4s[0], v16.4s[0]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x30
  ret

asm_write:
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128 /* last iteration: rsi == rdx. rsi > rdx = break */
  mov x14, x3     /* set x14 = index into array to start location (x3) */
  eor x13, x13, x13 /* x13 = 0 (for comparison) */
  ldr q16, [x0]
asm_write_pass_loop:
  lsl x12, x14, 2  /* x12 = x14 * 4, because float is 4B */
  add x15, x0, x12 /* ptr (x15) to next element = x0 (base) + x12 (index *4) */
  str q16, [x15]
  str q16, [x15, 16]
  str q16, [x15, 32]
  str q16, [x15, 48]
  str q16, [x15, 64]
  str q16, [x15, 80]
  str q16, [x15, 96]
  str q16, [x15, 112]
  add x14, x14, 32

  lsl x12, x14, 2  
  add x15, x0, x12 
  str q16, [x15]
  str q16, [x15, 16]
  str q16, [x15, 32]
  str q16, [x15, 48]
  str q16, [x15, 64]
  str q16, [x15, 80]
  str q16, [x15, 96]
  str q16, [x15, 112] 
  add x14, x14, 32

  lsl x12, x14, 2  
  add x15, x0, x12 
  str q16, [x15]
  str q16, [x15, 16]
  str q16, [x15, 32]
  str q16, [x15, 48]
  str q16, [x15, 64]
  str q16, [x15, 80]
  str q16, [x15, 96]
  str q16, [x15, 112] 
  add x14, x14, 32

  lsl x12, x14, 2  
  add x15, x0, x12 
  str q16, [x15]
  str q16, [x15, 16]
  str q16, [x15, 32]
  str q16, [x15, 48]
  str q16, [x15, 64]
  str q16, [x15, 80]
  str q16, [x15, 96]
  str q16, [x15, 112] 
  add x14, x14, 32
  
  cmp x1, x14 /* if x1 (len - 128) - x14 < 0, loop back around */
  csel x14, x13, x14, LT
  cmp x14, x3
  b.ne asm_write_pass_loop /* skip iteration decrement if we're not back to start */
  sub x2, x2, 1
  cbnz x2, asm_write_pass_loop
  ins v0.4s[0], v16.4s[0]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x30
  ret 
