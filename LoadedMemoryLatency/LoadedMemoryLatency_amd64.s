.global asm_read
.global asm_add

/* rcx = ptr to array
   rdx = arr length in bytes
   r8 = stop flag
   r9 = throttle factor
   return bytes read in rax
*/
asm_read:
  push %rdi
  push %rsi
  push %r10
  push %r11
  mov %rcx, %rdi
  xor %rsi, %rsi
  xor %rax, %rax
asm_read_pass_loop:
  /* load 128B */
  movups (%rdi), %xmm0
  movups 16(%rdi), %xmm0
  movups 32(%rdi), %xmm0
  movups 48(%rdi), %xmm0
  movups 64(%rdi), %xmm0
  movups 80(%rdi), %xmm0
  movups 96(%rdi), %xmm0
  movups 112(%rdi), %xmm0

  add $128, %rdi
  add $128, %rsi
  add $128, %rax

  test %r9, %r9
  jz asm_read_throttle_end
  mov %r9, %r10
asm_read_throttle:
  dec %r10
  jnz asm_read_throttle
asm_read_throttle_end:
  /* check stop flag */
  mov (%r8), %r10d
  test %r10d, %r10d
  jnz asm_read_end

  cmp %rsi, %rdx
  jg asm_read_pass_loop
  mov %rcx, %rdi
  xor %rsi, %rsi
  jmp asm_read_pass_loop
asm_read_end:
  pop %r11
  pop %r10
  pop %rsi
  pop %rdi
  ret

/* rcx = ptr to array
   rdx = arr length in bytes
   r8 = stop flag
   r9 = throttle factor
   return bytes read in rax
*/
asm_add:
  push %rdi
  push %rsi
  push %r10
  push %r11
  mov %rcx, %rdi
  xor %rsi, %rsi
  xor %rax, %rax
  xorps %xmm0, %xmm0
  xorps %xmm1, %xmm1
  xorps %xmm2, %xmm2
  xorps %xmm3, %xmm3
  xorps %xmm4, %xmm4
  xorps %xmm5, %xmm5
  xorps %xmm6, %xmm6
  xorps %xmm7, %xmm7
asm_add_pass_loop:
  /* load 128B */
  addps (%rdi), %xmm0
  addps 16(%rdi), %xmm1
  addps 32(%rdi), %xmm2
  addps 48(%rdi), %xmm3
  addps 64(%rdi), %xmm4
  addps 80(%rdi), %xmm5
  addps 96(%rdi), %xmm6
  addps 112(%rdi), %xmm7

  movups %xmm0, (%rdi)
  movups %xmm1, 16(%rdi)
  movups %xmm2, 32(%rdi)
  movups %xmm3, 48(%rdi)
  movups %xmm4, 64(%rdi)
  movups %xmm5, 80(%rdi)
  movups %xmm6, 96(%rdi)
  movups %xmm7, 112(%rdi)

  add $128, %rdi
  add $128, %rsi
  add $256, %rax  /* count both read and write */

  test %r9, %r9
  jz asm_add_throttle_end
  mov %r9, %r10
asm_add_throttle:
  dec %r10
  jnz asm_read_throttle
asm_add_throttle_end:
  /* check stop flag */
  mov (%r8), %r10d
  test %r10d, %r10d
  jnz asm_read_end

  cmp %rsi, %rdx
  jg asm_add_pass_loop
  mov %rcx, %rdi
  xor %rsi, %rsi
  jmp asm_add_pass_loop
asm_add_end:
  pop %r11
  pop %r10
  pop %rsi
  pop %rdi
  ret 
