.arch armv8-a
.text

.global asm_read
.global asm_write
.global asm_cflip
.global asm_copy
.global asm_add
.global flush_icache
.global readbankconflict
.global readbankconflict128

.global _asm_read
.global _asm_write
.global _asm_cflip
.global _asm_copy
.global _asm_add
.global _flush_icache
.global _readbankconflict

.balign 4

/* x0 = ptr to array (was rcx)
 * x1 = arr length (was rdx)
 * x2 = iterations (was r8)
 * x3 = start (was r9)
 */
_asm_read:
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
  add v0.4s, v16.4s, v16.4s
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x30
  ret

_asm_write:
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
  add v0.4s, v16.4s, v16.4s
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x30
  ret

_asm_cflip:
asm_cflip:
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128
  mov x14, x3     /* set x14 = index into array to start location (x3) */
  eor x13, x13, x13 /* x13 = 0 (for comparison) */
asm_cflip_pass_loop:
  lsl x12, x14, 2  /* x12 = x14 * 4, because float is 4B */
  add x15, x0, x12 /* ptr (x15) to next element = x0 (base) + x12 (index *4) */
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  str q16, [x15, 48]
  str q17, [x15, 32]
  str q18, [x15, 16]
  str q19, [x15]
  ldr q16, [x15, 64]
  ldr q17, [x15, 80]
  ldr q18, [x15, 96]
  ldr q19, [x15, 112]
  str q16, [x15, 112]
  str q17, [x15, 96]
  str q18, [x15, 80]
  str q19, [x15, 64]

  add x14, x14, 32
  lsl x12, x14, 2
  add x15, x0, x12
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  str q16, [x15, 48]
  str q17, [x15, 32]
  str q18, [x15, 16]
  str q19, [x15]
  ldr q16, [x15, 64]
  ldr q17, [x15, 80]
  ldr q18, [x15, 96]
  ldr q19, [x15, 112]
  str q16, [x15, 112]
  str q17, [x15, 96]
  str q18, [x15, 80]
  str q19, [x15, 64]

  add x14, x14, 32
  lsl x12, x14, 2
  add x15, x0, x12
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  str q16, [x15, 48]
  str q17, [x15, 32]
  str q18, [x15, 16]
  str q19, [x15]
  ldr q16, [x15, 64]
  ldr q17, [x15, 80]
  ldr q18, [x15, 96]
  ldr q19, [x15, 112]
  str q16, [x15, 112]
  str q17, [x15, 96]
  str q18, [x15, 80]
  str q19, [x15, 64]

  add x14, x14, 32
  lsl x12, x14, 2
  add x15, x0, x12
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  str q16, [x15, 48]
  str q17, [x15, 32]
  str q18, [x15, 16]
  str q19, [x15]
  ldr q16, [x15, 64]
  ldr q17, [x15, 80]
  ldr q18, [x15, 96]
  ldr q19, [x15, 112]
  str q16, [x15, 112]
  str q17, [x15, 96]
  str q18, [x15, 80]
  str q19, [x15, 64]

  cmp x1, x14 /* if x1 (len - 128) - x14 < 0, loop back around */
  csel x14, x13, x14, LT
  cmp x14, x3
  b.ne asm_cflip_pass_loop /* skip iteration decrement if we're not back to start */
  sub x2, x2, 2
  cbnz x2, asm_cflip_pass_loop
  add v0.4s, v16.4s, v16.4s
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x30
  ret

/* x0 = ptr to array (was rcx)
 * x1 = arr length (was rdx)
 * x2 = iterations (was r8)
 * x3 = start (was r9)
 */
_asm_copy:
asm_copy:
  sub sp, sp, #0x50
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x10, x11, [sp, #0x30]
  stp x8, x9, [sp, #0x40]
  asr x11, x1, 1    /* x11 = destination index (length / 2) */
  sub x1, x1, 128
  mov x10, x11      /* use x10 as index into destination */
  mov x14, x3     /* set x14 = index into array to start location (x3) */
  eor x13, x13, x13 /* x13 = 0 (for comparison) */
asm_copy_pass_loop:
  lsl x12, x14, 2  /* x12 = x14 * 4, because float is 4B */
  add x15, x0, x12 /* ptr (x15) to next element = x0 (base) + x12 (index *4) */
  lsl x12, x10, 2  /* x12 = x10 * 4, to calculate destination */
  add x9, x0, x12  /* x9 = ptr to destination */
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q23, [x15, 112]
  str q16, [x9]
  str q17, [x9, 16]
  str q18, [x9, 32]
  str q19, [x9, 48]
  str q20, [x9, 64]
  str q21, [x9, 80]
  str q22, [x9, 96]
  str q23, [x9, 112]
  add x14, x14, 32
  add x10, x10, 32

  lsl x12, x14, 2
  add x15, x0, x12
  lsl x12, x10, 2
  add x9, x0, x12
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q23, [x15, 112]
  str q16, [x9]
  str q17, [x9, 16]
  str q18, [x9, 32]
  str q19, [x9, 48]
  str q20, [x9, 64]
  str q21, [x9, 80]
  str q22, [x9, 96]
  str q23, [x9, 112]
  add x14, x14, 32
  add x10, x10, 32

  cmp x1, x10 /* if destination hits end, loop around */
  csel x14, x13, x14, LT
  csel x10, x11, x10, LT
  cmp x14, x3
  b.ne asm_copy_pass_loop /* skip iteration decrement if we're not back to start */
  sub x2, x2, 1
  cbnz x2, asm_copy_pass_loop
  add v0.4s, v16.4s, v16.4s
  ldp x8, x9, [sp, #0x40]
  ldp x10, x11, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x50
  ret

/* x0 = ptr to array (was rcx)
 * x1 = arr length (was rdx)
 * x2 = iterations (was r8)
 * x3 = start (was r9)
 */
asm_add:
_asm_add:
  sub sp, sp, #0x30
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  sub x1, x1, 128
  mov x14, x3     /* set x14 = index into array to start location (x3) */
  eor x13, x13, x13 /* x13 = 0 (for comparison) */
  ldr q15, [x0]
asm_add_pass_loop:
  lsl x12, x14, 2  /* x12 = x14 * 4, because float is 4B */
  add x15, x0, x12 /* ptr (x15) to next element = x0 (base) + x12 (index *4) */
  ldr q16, [x15]
  ldr q17, [x15, 16]
  ldr q18, [x15, 32]
  ldr q19, [x15, 48]
  ldr q20, [x15, 64]
  ldr q21, [x15, 80]
  ldr q22, [x15, 96]
  ldr q23, [x15, 112]
  add v16.4s, v16.4s, v15.4s
  add v17.4s, v17.4s, v15.4s
  add v18.4s, v18.4s, v15.4s
  add v19.4s, v19.4s, v15.4s
  add v20.4s, v20.4s, v15.4s
  add v21.4s, v21.4s, v15.4s
  add v22.4s, v22.4s, v15.4s
  add v23.4s, v23.4s, v15.4s
  str q16, [x15]
  str q17, [x15, 16]
  str q18, [x15, 32]
  str q19, [x15, 48]
  str q20, [x15, 64]
  str q21, [x15, 80]
  str q22, [x15, 96]
  str q23, [x15, 112]
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
  ldr q23, [x15, 112]
  add v16.4s, v16.4s, v15.4s
  add v17.4s, v17.4s, v15.4s
  add v18.4s, v18.4s, v15.4s
  add v19.4s, v19.4s, v15.4s
  add v20.4s, v20.4s, v15.4s
  add v21.4s, v21.4s, v15.4s
  add v22.4s, v22.4s, v15.4s
  add v23.4s, v23.4s, v15.4s
  str q16, [x15]
  str q17, [x15, 16]
  str q18, [x15, 32]
  str q19, [x15, 48]
  str q20, [x15, 64]
  str q21, [x15, 80]
  str q22, [x15, 96]
  str q23, [x15, 112]
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
  ldr q23, [x15, 112]
  add v16.4s, v16.4s, v15.4s
  add v17.4s, v17.4s, v15.4s
  add v18.4s, v18.4s, v15.4s
  add v19.4s, v19.4s, v15.4s
  add v20.4s, v20.4s, v15.4s
  add v21.4s, v21.4s, v15.4s
  add v22.4s, v22.4s, v15.4s
  add v23.4s, v23.4s, v15.4s
  str q16, [x15]
  str q17, [x15, 16]
  str q18, [x15, 32]
  str q19, [x15, 48]
  str q20, [x15, 64]
  str q21, [x15, 80]
  str q22, [x15, 96]
  str q23, [x15, 112]
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
  ldr q23, [x15, 112]
  add v16.4s, v16.4s, v15.4s
  add v17.4s, v17.4s, v15.4s
  add v18.4s, v18.4s, v15.4s
  add v19.4s, v19.4s, v15.4s
  add v20.4s, v20.4s, v15.4s
  add v21.4s, v21.4s, v15.4s
  add v22.4s, v22.4s, v15.4s
  add v23.4s, v23.4s, v15.4s
  str q16, [x15]
  str q17, [x15, 16]
  str q18, [x15, 32]
  str q19, [x15, 48]
  str q20, [x15, 64]
  str q21, [x15, 80]
  str q22, [x15, 96]
  str q23, [x15, 112]
  add x14, x14, 32

  cmp x1, x14 /* if x1 (len - 128) - x14 < 0, loop back around */
  csel x14, x13, x14, LT
  cmp x14, x3
  b.ne asm_add_pass_loop /* skip iteration decrement if we're not back to start */
  sub x2, x2, 2
  cmp x2, 0
  b.gt asm_add_pass_loop
  ldr q0, [x0]
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
readbankconflict128:
_readbankconflict:
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

/* x0: ptr to array
   x1: array size in bytes */
flush_icache:
_flush_icache:
  sub sp, sp, #0x20
  stp x14, x15, [sp, #0x10]
  asr x0, x0, 6   /* align to 64B cacheline */
  lsl x0, x0, 6
  mov x14, x0
  mov x15, x1
flush_icache_clean_dcache_loop:
  dc civac, x14
  add x14, x14, 64
  sub x15, x15, 64
  b.gt flush_icache_clean_dcache_loop
  dsb ish
  mov x14, x0
  mov x15, x1
flush_icache_clean_icache_loop:
  ic ivau, x14
  add x14, x14, 64
  sub x15, x15, 64
  b.gt flush_icache_clean_icache_loop
  dsb ish
  isb
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x20
  ret
