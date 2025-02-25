.global clktsctest
.global fma_zmm_tsctest
.global fma_zmm_regonly_tsctest

/* rcx = iterations, return elapsed TSC in rax */ 
clktsctest:
  push %rdx
  push %rbx
  push %r8
  push %r9
  push %r10
  push %rdi
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
  pop %rdi
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
  push %rdi
  push %r15
  mov %rcx, %rdi
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
  mov %rdx, %r15
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
  vfmadd132ps (%r15), %zmm1, %zmm16
  vfmadd132ps 64(%r15), %zmm2, %zmm17
  add %r8, %rbx
  vfmadd132ps 128(%r15), %zmm3, %zmm18
  vfmadd132ps 192(%r15), %zmm4, %zmm19
  add %r8, %rbx
  vfmadd132ps 256(%r15), %zmm5, %zmm20
  vfmadd132ps 384(%r15), %zmm6, %zmm21
  add %r8, %rbx
  vfmadd132ps 448(%r15), %zmm7, %zmm22
  vfmadd132ps 512(%r15), %zmm0, %zmm23
  add %r8, %rbx
  vfmadd132ps 576(%r15), %zmm1, %zmm24
  vfmadd132ps 640(%r15), %zmm2, %zmm25
  add %r8, %rbx
  vfmadd132ps 576(%r15), %zmm3, %zmm26
  vfmadd132ps 640(%r15), %zmm4, %zmm27
  add %r8, %rbx
  vfmadd132ps (%r15), %zmm1, %zmm28
  vfmadd132ps 64(%r15), %zmm2, %zmm29
  add %r8, %rbx
  vfmadd132ps 128(%r15), %zmm3, %zmm30
  vfmadd132ps 192(%r15), %zmm4, %zmm31
  add %r8, %rbx
  vfmadd132ps 256(%r15), %zmm5, %zmm7
  vfmadd132ps 384(%r15), %zmm6, %zmm15
  add %r8, %rbx
  vfmadd132ps 448(%r15), %zmm7, %zmm14
  vfmadd132ps 512(%r15), %zmm0, %zmm13
  add %r8, %rbx
  vfmadd132ps 576(%r15), %zmm1, %zmm12
  vfmadd132ps 640(%r15), %zmm2, %zmm11
  add %r8, %rbx
  vfmadd132ps (%r15), %zmm2, %zmm10
  vfmadd132ps 64(%r15), %zmm3, %zmm9
  add %r8, %rbx
  vfmadd132ps 128(%r15), %zmm4, %zmm8
  vfmadd132ps 192(%r15), %zmm5, %zmm16
  add %r8, %rbx
  vfmadd132ps 256(%r15), %zmm0, %zmm17
  vfmadd132ps 384(%r15), %zmm1, %zmm18
  add %r8, %rbx
  vfmadd132ps 448(%r15), %zmm0, %zmm19
  vfmadd132ps 512(%r15), %zmm0, %zmm20
  add %r8, %rbx
  vfmadd132ps (%r15), %zmm0, %zmm21
  vfmadd132ps 64(%r15), %zmm1, %zmm22
  add %r8, %rbx
  vfmadd132ps 128(%r15), %zmm2, %zmm23
  vfmadd132ps 192(%r15), %zmm3, %zmm24
  add %r8, %rbx
  vfmadd132ps 256(%r15), %zmm4, %zmm25
  vfmadd132ps 384(%r15), %zmm5, %zmm26
  add %r8, %rbx
  vfmadd132ps 448(%r15), %zmm6, %zmm27
  vfmadd132ps 512(%r15), %zmm7, %zmm28
  add %r8, %rbx
  vfmadd132ps (%r15), %zmm0, %zmm29
  vfmadd132ps 64(%r15), %zmm1, %zmm30
  sub %r9, %rdi
  jnz fma_zmm_tsctest_loop
  rdtsc
  shl $32, %rdx
  add %rdx, %rax /* now rax has the new value */
  sub %r10, %rax /* subtract old TSC value from the new one, which should be larger */
  pop %r15
  pop %rdi
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  pop %rdx
  ret


/* rcx = iterations, rdx = ptr to fp array */
fma_zmm_regonly_tsctest:
  push %rdx
  push %rbx
  push %r8
  push %r9
  push %r10
  push %rdi
  push %r15
  mov %rcx, %rdi
  mov $1, %r8
  mov $20, %r9
  xor %rbx, %rbx
  mov %rdx, %r15
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
fma_zmm_regonly_tsctest_loop:
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm1, %zmm16
  vfmadd132ps %zmm0, %zmm2, %zmm17
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm3, %zmm18
  vfmadd132ps %zmm0, %zmm4, %zmm19
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm5, %zmm20
  vfmadd132ps %zmm0, %zmm6, %zmm21
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm7, %zmm22
  vfmadd132ps %zmm0, %zmm0, %zmm23
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm1, %zmm24
  vfmadd132ps %zmm0, %zmm2, %zmm25
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm3, %zmm26
  vfmadd132ps %zmm0, %zmm4, %zmm27
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm1, %zmm28
  vfmadd132ps %zmm0, %zmm2, %zmm29
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm3, %zmm30
  vfmadd132ps %zmm0, %zmm4, %zmm31
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm5, %zmm7
  vfmadd132ps %zmm0, %zmm6, %zmm15
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm7, %zmm14
  vfmadd132ps %zmm0, %zmm0, %zmm13
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm1, %zmm12
  vfmadd132ps %zmm0, %zmm2, %zmm11
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm2, %zmm10
  vfmadd132ps %zmm0, %zmm3, %zmm9
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm4, %zmm8
  vfmadd132ps %zmm0, %zmm5, %zmm16
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm0, %zmm17
  vfmadd132ps %zmm0, %zmm1, %zmm18
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm0, %zmm19
  vfmadd132ps %zmm0, %zmm0, %zmm20
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm0, %zmm21
  vfmadd132ps %zmm0, %zmm1, %zmm22
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm2, %zmm23
  vfmadd132ps %zmm0, %zmm3, %zmm24
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm4, %zmm25
  vfmadd132ps %zmm0, %zmm5, %zmm26
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm6, %zmm27
  vfmadd132ps %zmm0, %zmm7, %zmm28
  add %r8, %rbx
  vfmadd132ps %zmm0, %zmm0, %zmm29
  vfmadd132ps %zmm0, %zmm1, %zmm30
  sub %r9, %rdi
  jnz fma_zmm_regonly_tsctest_loop
  rdtsc
  shl $32, %rdx
  add %rdx, %rax /* now rax has the new value */
  sub %r10, %rax /* subtract old TSC value from the new one, which should be larger */
  pop %r15
  pop %rdi
  pop %r10
  pop %r9
  pop %r8
  pop %rbx
  pop %rdx
  ret
