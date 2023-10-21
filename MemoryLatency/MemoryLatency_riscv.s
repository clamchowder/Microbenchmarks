.text

.global latencytest
.global preplatencyarr
.global stlftest
.global stlftest32
.global stlftest128
.global matchedstlftest

/* x10 = ptr to arr
   x11 = arr len
   x5-x7, x28-31 are temporaries
   convert values in array from array indexes to pointers */
preplatencyarr:
  li x7, 0   /* index */
  mv x5, x10 /* x5 = pointer into array */
preplatencyarr_loop:
  ld x28, (x5)  /* x28 = index into array to translate */
  slli x28, x28, 3
  add x28, x28, x10
  sd x28, (x5)
  addi x5, x5, 8
  addi x7, x7, 1
  blt x7, x11, preplatencyarr_loop 
  ret

/* x10 = iteration count
   x11 = ptr to arr
   do pointer chasing for specified iteration count */
latencytest:
  li x7, 0 /* iteration count */
  mv x5, x11
  mv x6, x11
  addi x6, x6, 64
  li x28, 0
  li x29, 0
latencytest_loop:
  ld x5, (x5)
  addi x7, x7, 1
  blt x7, x10, latencytest_loop
  mv x10, x5
  ret

/* a0 = iteration count
   a1 = ptr to arr. first 32-bit int = store offset, second = load offset */
stlftest:
  lw t0, (a1)
  lw t1, 4(a1)
  add t0, t0, a1
  add t1, t1, a1
  mv t2, a0
  mv t3, x0
stlftest_loop:
  sd t2, (t0)
  lw t2, (t1)
  sd t2, (t0)
  lw t2, (t1) 
  sd t2, (t0)
  lw t2, (t1) 
  sd t2, (t0)
  lw t2, (t1) 
  sd t2, (t0)
  lw t2, (t1) 
  addi t3, t3, 5
  blt t3, a0, stlftest_loop
  ret

stlftest32:
  lw t0, (a1)
  lw t1, 4(a1)
  add t0, t0, a1
  add t1, t1, a1
  mv t3, x0
stlftest32_loop:
  sw t2, (t0)
  lh t2, (t1)
  sw t2, (t0)
  lh t2, (t1) 
  sw t2, (t0)
  lh t2, (t1) 
  sw t2, (t0)
  lh t2, (t1) 
  sw t2, (t0)
  lh t2, (t1)
  addi t3, t3, 5
  blt t3, a0, stlftest32_loop
  ret

/* since I'm only dealing with C910 and I know the vec len is 128... */
stlftest128:
  mv t4, x0
  addi t4, t4, 32     /* ??? */
  vsetvli t0, t4, e8  /* request vector length of some big value? always gives back 4 but not if we ask for 4*/
  lw t0, (a1)
  lw t1, 4(a1)
  add t0, t0, a1
  add t1, t1, a1
  mv t3, x0
stlftest128_loop:
  vsw.v v0, (t0)
  fld f0, (t1)
  vsw.v v0, (t0)
  fld f0, (t1) 
  vsw.v v0, (t0)
  fld f0, (t1) 
  vsw.v v0, (t0)
  fld f0, (t1) 
  vsw.v v0, (t0)
  fld f0, (t1)
  addi t3, t3, 5
  blt t3, a0, stlftest128_loop
  ret

matchedstlftest:
  lw t0, (a1)
  lw t1, 4(a1)
  add t0, t0, a1
  add t1, t1, a1
  mv t2, a0
  mv t3, x0
matchedstlftest_loop:
  sd t2, (t0)
  ld t2, (t1)
  sd t2, (t0)
  ld t2, (t1) 
  sd t2, (t0)
  ld t2, (t1) 
  sd t2, (t0)
  ld t2, (t1) 
  sd t2, (t0)
  ld t2, (t1) 
  addi t3, t3, 5
  blt t3, a0, matchedstlftest_loop
  ret
