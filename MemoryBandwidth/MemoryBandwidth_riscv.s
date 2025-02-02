.text

.global asm_read
.global asm_write
.global asm_cflip
.global asm_copy
.global asm_add
.global flush_icache
.global readbankconflict
.global readbankconflict128

/* a0 = arr, a1 = arr_len, a2 = iterations */
asm_read:
  addi sp, sp, -16
  mv t1, a0           /* t4 = ptr */
  mv t2, x0           /* offset in arr */
  mv t3, x0           /* iteration counter */
asm_read_pass_loop:
  ld t4, (t1)
  ld t5, 8(t1)
  ld t6, 16(t1)
  ld t4, 24(t1)
  ld t5, 32(t1)
  ld t6, 40(t1)
  ld t4, 48(t1)
  ld t5, 56(t1)
  addi t2, t2, 16     /* add 32-bit elements read this iteration */
  addi t1, t1, 64     /* increment address */
  blt t2, a1, asm_read_pass_loop
  mv t2, x0           /* reset offset */
  mv t1, a0           /* reset array addr*/
  addi t3, t3, 1
  blt t3, a2, asm_read_pass_loop 
  ret

asm_write:
  addi sp, sp, -16
  mv t1, a0           /* t4 = ptr */
  mv t2, x0           /* offset in arr */
  mv t3, x0           /* iteration counter */
asm_write_pass_loop:
  sd t4, (t1)
  sd t5, 8(t1)
  sd t6, 16(t1)
  sd t4, 24(t1)
  sd t5, 32(t1)
  sd t6, 40(t1)
  sd t4, 48(t1)
  sd t5, 56(t1)
  addi t2, t2, 16     /* add 32-bit elements read this iteration */
  addi t1, t1, 64     /* increment address */
  blt t2, a1, asm_write_pass_loop
  mv t2, x0           /* reset offset */
  mv t1, a0           /* reset array addr*/
  addi t3, t3, 1
  blt t3, a2, asm_write_pass_loop 
  ret

asm_copy:
  ret

asm_add:
  addi sp, sp, -16
  mv t1, a0           /* t4 = ptr */
  mv t2, x0           /* offset in arr */
  mv t3, x0           /* iteration counter */
asm_add_pass_loop:
  ld t4, (t1)
  addi t4, t4, 1
  sd t4, (t1)
  
  ld t5, 8(t1)
  addi t5, t5, 1
  sd t5, 8(t1)
  
  ld t6, 16(t1)
  addi t6, t6, 1
  sd t6, 16(t1)
  
  ld t4, 24(t1)
  addi t4, t4, 1
  sd t4, 24(t1)
  
  ld t5, 32(t1)
  addi t5, t5, 1
  sd t5, 32(t1)
  
  ld t6, 40(t1)
  addi t6, t6, 1
  sd t6, 40(t1)
  
  ld t4, 48(t1)
  addi t4, t4, 1
  sd t4, 48(t1)
  
  ld t5, 56(t1)
  addi t5, t5, 1
  sd t5, 56(t1)
  addi t2, t2, 16     /* add 32-bit elements read this iteration */
  addi t1, t1, 64     /* increment address */
  blt t2, a1, asm_add_pass_loop
  mv t2, x0           /* reset offset */
  mv t1, a0           /* reset array addr*/
  addi t3, t3, 2      /* count adds as two */
  blt t3, a2, asm_add_pass_loop 
  ret 

asm_cflip:
  ret

readbankconflict:
  ret

readbankconflict128:
  ret
