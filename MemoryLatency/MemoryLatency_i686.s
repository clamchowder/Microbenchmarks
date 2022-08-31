.text

.global @latencytest@8
.global @preplatencyarr@8
.global @stlftest@8
.global @matchedstlftest@8
.global latencytest
.global preplatencyarr
.global stlftest
.global matchedstlftest

/* fastcall specified in source file, so
   ecx = ptr to arr
   edx = arr len
   convert values in array from array indexes to pointers
   there has to be a way to make C do this but high level
   programming languages suck and make simple things harder than they should be
*/
preplatencyarr:
@preplatencyarr@8:
  push %eax
  push %esi
  xor %esi, %esi    /* esi = array index */
preplatencyarr_loop:
  mov (%ecx,%esi,4), %eax   /* load target array index into eax */
  lea (%ecx,%eax,4), %eax   /* calculate target address -> eax */
  mov %eax, (%ecx,%esi,4)   /* replace array index with target address */
  inc %esi
  cmp %esi, %edx
  jne preplatencyarr_loop
  pop %esi
  pop %eax
  ret

/* ecx = iterations
   edx = ptr to arr
   do pointer chasing for specified iteration count
*/
latencytest:
@latencytest@8:
  push %esi
  mov (%edx), %esi
  xor %eax, %eax
latencytest_loop:
  mov (%esi), %esi
  add %esi, %eax
  dec %ecx
  jnz latencytest_loop
  pop %esi
  ret

/* ecx = iterations
   edx = ptr to array. first two 32-bit ints in array are store and load offsets respectively
   mismatch load and store sizes by using 16-bit loads and 32-bit stores
*/
stlftest:
@stlftest@8:
  push %esi
  push %edi
  mov (%edx), %eax   /* just get some value into rax (store value */
  mov (%edx), %esi
  mov 4(%edx), %edi
  add %edx, %esi     /* esi = store ptr */
  add %edx, %edi     /* edi = load ptr */
stlftest_loop:
  mov %eax, (%esi)   /* 32-bit store */
  mov (%edi), %ax   /* 16-bit load that possibly gets forwarded result */
  mov %eax, (%esi)
  mov (%edi), %ax
  mov %eax, (%esi)
  mov (%edi), %ax
  mov %eax, (%esi)
  mov (%edi), %ax
  mov %eax, (%esi)
  mov (%edi), %ax
  sub $5, %ecx
  jg stlftest_loop
  pop %edi
  pop %esi
  ret

matchedstlftest:
@matchedstlftest@8:
  push %esi
  push %edi
  mov (%edx), %eax   /* just get some value into rax (store value */
  mov (%edx), %esi
  mov 4(%edx), %edi
  add %edx, %esi     /* esi = store ptr */
  add %edx, %edi     /* edi = load ptr */
matchedstlftest_loop:
  mov %eax, (%esi)
  mov (%edi), %eax
  mov %eax, (%esi)
  mov (%edi), %eax
  mov %eax, (%esi)
  mov (%edi), %eax
  mov %eax, (%esi)
  mov (%edi), %eax
  mov %eax, (%esi)
  mov (%edi), %eax
  sub $5, %ecx
  jg matchedstlftest_loop
  pop %edi
  pop %esi
  ret
