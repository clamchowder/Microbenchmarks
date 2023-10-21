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
  sd s0, (sp)
  mv t4, x0
  addi t4, t4, 16     /* ??? */
  vsetvli t0, t4, e32  /* request vector length of some big value? always gives back 4 but not if we ask for 4*/
  mv t4, t0
  mv t1, a0           /* t1 = current address */
  slli t0, t0, 4      /* increment every loop by vec len * unroll factor of 4 */
  slli a1, a1, 2      /* get array length in bytes */
  add a1, a1, a0      /* array bound address */
  sub a1, a1, t0      /* make sure there's enough room for the last iteration */
  mv t3, x0           /* t3 = iteration counter */

  /* precompute offsets */
  slli t4, t4, 2  /* vec len given in number of 32-bit elements */
  mv t5, t4
  mv t6, t4
  slli t5, t5, 1 /* vec len * 2 */
  add t6, t6, t5 /* t6 = vec len * 3 */
asm_read_pass_loop:
  vlw.v v0, (t1)
  add s0, t1, t4
  vlw.v v1, (s0)
  add s0, t1, t5
  vlw.v v2, (s0)
  add s0, t1, t6
  vlw.v v3, (s0)
  add t1, t1, t0      /* increment address */
  blt t1, a1, asm_read_pass_loop
  addi t3, t3, 1
  mv t1, a0           /* reset array addr*/
  blt t3, a2, asm_read_pass_loop
  ld s0, (sp)
  addi sp, sp, 16
  fld fa0, (a0)
  ret

asm_write:
  addi sp, sp, -16
  sd s0, (sp)
  mv t4, x0
  addi t4, t4, 16     /* ??? */
  vsetvli t0, t4, e32  /* request vector length of some big value? always gives back 4 but not if we ask for 4*/
  mv t4, t0
  mv t1, a0           /* t1 = current address */
  slli t0, t0, 4      /* increment every loop by vec len * unroll factor of 4 */
  slli a1, a1, 2      /* get array length in bytes */
  add a1, a1, a0      /* array bound address */
  sub a1, a1, t0      /* make sure there's enough room for the last iteration */
  mv t3, x0           /* t3 = iteration counter */

  /* precompute offsets */
  slli t4, t4, 2  /* vec len given in number of 32-bit elements */
  mv t5, t4
  mv t6, t4
  slli t5, t5, 1 /* vec len * 2 */
  add t6, t6, t5 /* t6 = vec len * 3 */
  vlw.v v0, (a0)
asm_write_pass_loop:
  vsw.v v0, (t1)
  add s0, t1, t4
  vsw.v v1, (s0)
  add s0, t1, t5
  vsw.v v2, (s0)
  add s0, t1, t6
  vsw.v v3, (s0)
  add t1, t1, t0      /* increment address */
  blt t1, a1, asm_write_pass_loop
  addi t3, t3, 1
  mv t1, a0           /* reset array addr*/
  blt t3, a2, asm_write_pass_loop
  ld s0, (sp)
  addi sp, sp, 16
  fld fa0, (a0)
  ret

asm_copy:
  ret

asm_add:
  addi sp, sp, -16
  sd s0, (sp)
  mv t4, x0
  addi t4, t4, 16     /* ??? */
  vsetvli t0, t4, e32  /* request vector length of some big value? always gives back 4 but not if we ask for 4*/
  mv t4, t0
  mv t1, a0           /* t1 = current address */
  slli t0, t0, 4      /* increment every loop by vec len * unroll factor of 4 */
  slli a1, a1, 2      /* get array length in bytes */
  add a1, a1, a0      /* array bound address */
  sub a1, a1, t0      /* make sure there's enough room for the last iteration */
  mv t3, x0           /* t3 = iteration counter */

  /* precompute offsets */
  slli t4, t4, 2  /* vec len given in number of 32-bit elements */
  mv t5, t4
  mv t6, t4
  slli t5, t5, 1 /* vec len * 2 */
  add t6, t6, t5 /* t6 = vec len * 3 */
  vlw.v v4, (a0)
asm_add_pass_loop:
  vlw.v v0, (t1)
  vadd.vv v0, v0, v4
  vsw.v v0, (t1)

  add s0, t1, t4
  vlw.v v1, (s0)
  vadd.vv v1, v1, v4
  vsw.v v1, (s0)

  add s0, t1, t5
  vlw.v v2, (s0)
  vadd.vv v2, v2, v4
  vsw.v v2, (s0)

  add s0, t1, t6
  vlw.v v3, (s0)
  vadd.vv v3, v3, v4
  vsw.v v3, (s0)

  add t1, t1, t0      /* increment address */
  blt t1, a1, asm_add_pass_loop
  addi t3, t3, 1
  mv t1, a0           /* reset array addr*/
  blt t3, a2, asm_add_pass_loop
  ld s0, (sp)
  addi sp, sp, 16
  fld fa0, (a0)
  ret

asm_cflip:
  ret

readbankconflict:
  ret

readbankconflict128:
  ret
