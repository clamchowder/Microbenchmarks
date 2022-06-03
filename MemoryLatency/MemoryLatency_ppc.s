.global latencytest
.global preplatencyarr

.global stlftest
.global stlftest32
.global matchedstlftest


/* r3 = ptr to array
   r4 = element count */
preplatencyarr:
  li r5, 0
  li r8, 3
preplatencyarr_loop:
  sl r6, r5, r8
  add r6, r6, r3 
  ld r7, 0(r6) /* r6 = addr, load into r7 */ 
  add r7, r7, r3
  st r7, 0(r6) /* stw has src as first operand */
  addi r5, r5, 1 
  cmpld cr7, r4, r5
  bgt cr7, preplatencyarr_loop
  blr

/* r3 = iteration count
   r4 = ptr to arr */
latencytest:
  li r5, 0
  li r6, 0
  mr r7, r4
latencytest_loop:
  ld r4, 0(r4)
  add r6, r6, r4
  subi r3, r3, 1
  cmpld cr7, r3, r5
  bgt cr7, latencytest_loop
  mr r3, r6
  blr

stlftest:
  blr

stlftest32:
  blr

matchedstlftest:
  blr
