.text

.global latencytest
.global preplatencyarr
.global stlftest
.global stlftest32
.global stlftest128
.global matchedstlftest

/* r4 = ptr to arr
   r5 = arr len
   convert values in array from array indexes to pointers. they're 64-bit */
/* r12-r20 are temp regs */
preplatencyarr:
  /* convert offset into address just like in the compiled code */
  xor $r12, $r12, $r12
  xor $r13, $r13, $r13
  xor $r14, $r14, $r14
  xor $r15, $r15, $r15
  addi.d $r14, $r14, 1
preplatencyarr_loop:
  /* use r12 to address array. r15 = array index */
  alsl.d $r12, $r15, $r0, 0x3  /* * 8 bytes = 64 bits */
  add.d $r12, $r4, $r12        /* add to array base address */
  ld.d $r13, $r12, 0           /* load 64-bit value from array into r13 */
  alsl.d $r13, $r13, $r0, 0x3  /* loaded value is index. do same array indexing calculation */
  add.d $r13, $r4, $r13
  st.d $r13, $r12, 0           /* first arg to store is the value, second is the address */
  add.d $r15, $r15, $r14       /* increment array index */
  bne $r15, $r5, preplatencyarr_loop
b preplatencyarr_end
  nop
preplatencyarr_end:
  jr $r1

/* r4 = iteration count
   r5 = ptr to arr
   do pointer chasing for specified iteration count */ 
latencytest:
  xor $r12, $r12, $r12
  xor $r13, $r13, $r13
  xor $r14, $r14, $r14
  addi.d $r14, $r14, 1
  ld.d $r12, $r5, 0
latencytest_loop:
  ld.d $r12, $r12, 0
  add.d $r13, $r13, $r14
  bne $r4, $r13, latencytest_loop
  jr $r1

stlftest:
  jr $r1

stlftest32:
  jr $r1

stlftest128:
  jr $r1

matchedstlftest:
  jr $r1
