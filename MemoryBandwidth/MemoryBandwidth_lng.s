.text

.global asm_read
.global asm_copy
.global asm_write
.global asm_cflip
.global asm_add
.global readbankconflict
.global readbankconflict128

/* r4 = ptr to array
   r5 = array length in floats
   r6 = iterations */
asm_read:
  xor $r12, $r12, $r12
  addi.d $r12, $r12, 32
  xor $r13, $r13, $r13 /* r13 = index into array */
  xor $r14, $r14, $r14 /* r14 = iteration count */
  xor $r15, $r15, $r15
  add.d $r15, $r15, $r4 /* mov r15, r4 -> use r15 as base addr */
  xor $r16, $r16, $r16  /* array index count */
asm_read_pass_loop:
  xvld $xr1, $r15, 0
  xvld $xr2, $r15, 32 
  xvld $xr3, $r15, 64 
  xvld $xr4, $r15, 128
  xvld $xr5, $r15, 160
  xvld $xr6, $r15, 192
  xvld $xr7, $r15, 224
  addi.d $r16, $r16, 64
  addi.d $r15, $r15, 256
  blt $r16, $r5, asm_read_pass_loop
  xor $r16, $r16, $r16
  xor $r15, $r15, $r15
  add.d $r15, $r15, $r4
  addi.d $r14, $r14, 1
  blt $r14, $r6, asm_read_pass_loop
  jr $r1

asm_copy:
asm_write:
asm_cflip:
asm_add:
readbankconflict:
readbankconflict128:
  jr $r1
