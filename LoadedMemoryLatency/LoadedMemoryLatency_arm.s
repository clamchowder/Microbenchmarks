.global asm_read
.global _asm_read

/* x0 = ptr to array
   x1 = arr length in bytes
   x2 = stop flag
   x3 = throttle factor
   return bytes read in x0
*/
_asm_read:
asm_read:
  sub sp, sp, #0x40
  stp x14, x15, [sp, #0x10]
  stp x12, x13, [sp, #0x20]
  stp x11, x10, [sp, #0x30]
  sub x1, x1, 128
  mov x15, x0    /* ptr into array */
  mov x12, 0     /* current offset into array */
  mov x13, 0     /* data transferred in bytes */
asm_read_pass_loop:
  /* load 128B */
  ldr q16, [x15]
  ldr q16, [x15, 16]
  ldr q16, [x15, 32]
  ldr q16, [x15, 48]
  ldr q16, [x15, 64]
  ldr q16, [x15, 80]
  ldr q16, [x15, 96]
  ldr q16, [x15, 112]
  add x12, x12, 128
  add x15, x15, 128
  add x13, x13, 128

  cbz x3, asm_read_throttle_end
  mov x10, x3    /* save throttle factor */
asm_read_throttle:
  sub x10, x10, 1
  cbnz x10, asm_read_throttle
asm_read_throttle_end:  

  /* end condition */
  ldr w14, [x2]
  cbnz x14, asm_read_end

  /* loop back condition */
  cmp x1, x12
  b.gt asm_read_pass_loop
  mov x15, x0
  mov x12, 0
  b asm_read_pass_loop
asm_read_end:
  mov x0, x13
  ldp x11, x10, [sp, #0x30]
  ldp x12, x13, [sp, #0x20]
  ldp x14, x15, [sp, #0x10]
  add sp, sp, #0x40
  ret
