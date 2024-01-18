.text

.global sse_int32_add_test

/* rcx = iteration count, rdx = data */
sse_int32_add_test:
  movups (%rdx), %xmm0
  movups 16(%rdx), %xmm1
  movups 32(%rdx), %xmm2
  movups 48(%rdx), %xmm3
  movups 64(%rdx), %xmm4
  movups 72(%rdx), %xmm5
sse_int32_add_test_loop:
  paddd %xmm0, %xmm0
  paddd %xmm1, %xmm1
  paddd %xmm2, %xmm2
  paddd %xmm3, %xmm3
  paddd %xmm4, %xmm4
  paddd %xmm5, %xmm5
  sub $24, %rcx
  cmp $0, %rcx
  jg sse_int32_add_test_loop
  ret
