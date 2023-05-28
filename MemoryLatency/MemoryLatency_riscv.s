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

/* x0 = iteration count
   x1 = ptr to arr. first 32-bit int = store offset, second = load offset */
stlftest:
stlftest_loop:
  ret

stlftest32:
stlftest32_loop:
  ret

/* x0 = iteration count
   x1 = ptr to arr. first 32-bit int = store offset, second = load offset */
stlftest128:
stlftest128_loop:
  ret

matchedstlftest:
matchedstlftest_loop:
  ret
