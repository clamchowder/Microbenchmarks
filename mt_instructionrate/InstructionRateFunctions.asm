section .text

bits 64

global sse_int32_add_test
global sse_int32_mul_test
global avx2_int32_add_test
global avx2_int32_mul_test

sse_int32_add_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_int32_add_test_loop:
  paddd xmm0, xmm0
  paddd xmm1, xmm1
  paddd xmm2, xmm2
  paddd xmm3, xmm3
  paddd xmm4, xmm4
  paddd xmm5, xmm5
  sub rcx, 24
  cmp rcx, 0
  jg sse_int32_add_test_loop
  ret

sse_int32_mul_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_int32_mul_test_loop:
  pmulld xmm0, xmm0
  pmulld xmm1, xmm1
  pmulld xmm2, xmm2
  pmulld xmm3, xmm3
  pmulld xmm4, xmm4
  pmulld xmm5, xmm5
  sub rcx, 24
  cmp rcx, 0
  jg sse_int32_mul_test_loop
  ret

avx2_int32_add_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx2_int32_add_test_loop:
  vpaddd ymm0, ymm0, ymm0
  vpaddd ymm1, ymm1, ymm1
  vpaddd ymm2, ymm2, ymm2
  vpaddd ymm3, ymm3, ymm3
  vpaddd ymm4, ymm4, ymm4
  vpaddd ymm5, ymm5, ymm5
  sub rcx, 48
  cmp rcx, 0
  jg avx2_int32_add_test_loop
  ret

avx2_int32_mul_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx2_int32_mul_test_loop:
  vpmulld ymm0, ymm0, ymm0
  vpmulld ymm1, ymm1, ymm1
  vpmulld ymm2, ymm2, ymm2
  vpmulld ymm3, ymm3, ymm3
  vpmulld ymm4, ymm4, ymm4
  vpmulld ymm5, ymm5, ymm5
  sub rcx, 48
  cmp rcx, 0
  jg avx2_int32_mul_test_loop
  ret