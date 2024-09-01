.global asm_read

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
