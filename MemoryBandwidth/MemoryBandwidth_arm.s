.arch armv8-a
.text

.global asm_read
.global asm_write 
.global readbankconflict

/* x0 = ptr to array (was rcx)
 * x1 = arr length (was rdx)
 * x2 = iterations (was r8)
 * x3 = start (was r9)
 */
asm_read:
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128 
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


/* Tests for cache bank conflicts by reading from two locations, spaced by some
   number of bytes
   x0 = ptr to array. first 32-bit int = increment step, because I'm too lazy to mess with the stack
   x1 = array length, in bytes
   x2 = load spacing, in bytes
   x3 = iter count (number of loads to execute) */
readbankconflict:
   sub sp, sp, #0x40
   stp x14, x15, [sp, #0x10]
   stp x12, x13, [sp, #0x20]
   stp x10, x11, [sp, #0x30]
   cmp x1, x2               /* basic check - subtract load spacing from array len */
   b.le readbankconflict_end /* exit immediately if we don't have enough space to iterate */
   sub x12, x1, 20          /* use x12 to check bytes remaining */
   mov x14, x0
   add x13, x0, x2           /* x14 = first load location, x13 = second load location */
   sub x12, x12, 20          /* we're reading 20B ahead */
   ldr x11, [x0]   /* increment, not used right now */
readbankconflict_loop:
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1   
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1 
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1 
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1 
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1 
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1 
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1 
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1 
   
   ldr x10, [x14]
   ldr x15, [x13]
   add x14, x14, 1
   add x13, x13, 1 
   
   sub x12, x12, 20
   sub x3, x3, 20 
   cmp x3, 0
   b.le readbankconflict_end  /* iteration count = exit condition */
   cmp x12, 0                 /* check bytes remaining */
   b.ge readbankconflict_loop /* if positive or equal, continue loop */
   sub x12, x1, 20     /* reset bytes remaining */
   mov x14, x1
   add x13, x1, x2     
   b readbankconflict_loop
readbankconflict_end:
   ldp x10, x11, [sp, #0x30]
   ldp x12, x13, [sp, #0x20]
   ldp x14, x15, [sp, #0x10]
   add sp, sp, #0x40
   ret
