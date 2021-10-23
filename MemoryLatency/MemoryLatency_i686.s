.text

.global @latencytest@8
.global @preplatencyarr@8

/* fastcall specified in source file, so
   ecx = ptr to arr
   edx = arr len
   convert values in array from array indexes to pointers
   there has to be a way to make C do this but high level
   programming languages suck and make simple things harder than they should be
*/
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
