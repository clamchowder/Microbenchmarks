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
  mv t4, x0
  addi t4, t4, 3
  vsetvli t0, t4, e32  /* request vector length of 4 */
  mv t1, a0           /* t1 = current address */
  slli t0, t0, 4      /* increment by vec len * unroll factor of 4 */
  slli a1, a1, 2      /* get array length in bytes */
  add a1, a1, a0      /* array bound address */
  mv t3, x0           /* t3 = iteration counter */
asm_read_pass_loop:
  vlw.v v0, (t1)
  addi t4, t1, 16
  vlw.v v0, (t4)
  addi t4, t1, 32
  vlw.v v0, (t4)
  addi t4, t1, 48
  vlw.v v0, (t4)
  add t1, t1, t0      /* increment address */
  blt t1, a1, asm_read_pass_loop
  addi t3, t3, 1
  mv t1, a0           /* reset array addr*/
  blt t3, a2, asm_read_pass_loop
  ret

asm_write:
  ret

asm_copy:
  ret

asm_add:
  ret

asm_cflip:
  ret

readbankconflict:
  ret

readbankconflict128:
  ret
