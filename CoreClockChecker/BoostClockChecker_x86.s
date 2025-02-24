.global clktsctest
.global fma_zmm_tsctest

/* rcx = iterations, return elapsed TSC in rax */ 
clktsctest:
  push %rdx
  push %rbx
  push %r8
  push %r9
  push %r10
  mov %rcx, %rdi
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
  rdtsc            /* high 32 bits in EDX, low 32 bits in EAX */
  shl $32, %rdx    /* shift high 32 bits into upper half of EDX */
  add %rax, %rdx   /* place full 64-bit value in rdx */
  mov %rdx, %r10
clktsctest_loop:
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  add %r8, %rbx
  sub %r9, %rdi
  jnz clktsctest_loop
  rdtsc
  shl $32, %rdx
  add %rdx, %rax /* now rax has the new value */
  sub %r10, %rax /* subtract old TSC value from the new one, which should be larger */
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  pop %rdx
  ret

/* rcx = iterations, rdx = ptr to fp array */
fma_zmm_tsctest:
  push %rdx
  push %rbx
  push %r8
  push %r9
  push %r10
  mov %rcx, %rdi
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
  vmovups (%rdx), %zmm0
  vmovups 64(%rdx), %zmm1
  vmovups 128(%rdx), %zmm2
  vmovups 192(%rdx), %zmm3
  vmovups 256(%rdx), %zmm4
  vmovups 384(%rdx), %zmm5
  vmovups 448(%rdx), %zmm6
  vmovups 512(%rdx), %zmm7
  add $512, %rdx
  vmovups (%rdx), %zmm8
  vmovups 64(%rdx), %zmm9
  vmovups 128(%rdx), %zmm10
  vmovups 192(%rdx), %zmm11
  vmovups 256(%rdx), %zmm12
  vmovups 384(%rdx), %zmm13
  vmovups 448(%rdx), %zmm14
  vmovups 512(%rdx), %zmm15
  rdtsc            /* high 32 bits in EDX, low 32 bits in EAX */
  shl $32, %rdx    /* shift high 32 bits into upper half of EDX */
  add %rax, %rdx   /* place full 64-bit value in rdx */
  mov %rdx, %r10
fma_zmm_tsctest_loop:
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm8, %zmm16
  add %r8, %rbx
  vfmadd132ps %zmm1, %zmm9, %zmm17
  add %r8, %rbx
  vfmadd132ps %zmm2, %zmm10, %zmm18
  add %r8, %rbx
  vfmadd132ps %zmm3, %zmm11, %zmm19
  add %r8, %rbx
  vfmadd132ps %zmm4, %zmm12, %zmm20
  add %r8, %rbx
  vfmadd132ps %zmm5, %zmm13, %zmm21
  add %r8, %rbx
  vfmadd132ps %zmm6, %zmm14, %zmm22
  add %r8, %rbx
  vfmadd132ps %zmm7, %zmm15, %zmm23
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm8, %zmm16
  add %r8, %rbx
  vfmadd132ps %zmm1, %zmm9, %zmm17
  add %r8, %rbx
  vfmadd132ps %zmm2, %zmm10, %zmm18
  add %r8, %rbx
  vfmadd132ps %zmm3, %zmm11, %zmm19
  add %r8, %rbx
  vfmadd132ps %zmm4, %zmm12, %zmm20
  add %r8, %rbx
  vfmadd132ps %zmm5, %zmm13, %zmm21
  add %r8, %rbx
  vfmadd132ps %zmm6, %zmm14, %zmm22
  add %r8, %rbx
  vfmadd132ps %zmm7, %zmm15, %zmm23
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm8, %zmm24
  add %r8, %rbx
  vfmadd132ps %zmm1, %zmm9, %zmm25
  add %r8, %rbx
  vfmadd132ps %zmm3, %zmm5, %zmm26
  add %r8, %rbx
  vfmadd132ps %zmm11, %zmm10, %zmm27
  sub %r9, %rdi
  jnz fma_zmm_tsctest_loop
  rdtsc
  shl $32, %rdx
  add %rdx, %rax /* now rax has the new value */
  sub %r10, %rax /* subtract old TSC value from the new one, which should be larger */
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  pop %rdx
  ret
