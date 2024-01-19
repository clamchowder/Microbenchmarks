section .text

bits 64

global sse_int32_add_test
global sse_int32_mul_test
global sse_int64_add_test
global sse_int64_mul_test
global avx2_int32_add_test
global avx2_int32_mul_test
global avx2_int64_add_test
global avx2_int64_mul_test
global sse_fp32_add_test
global sse_fp32_mul_test
global sse_fp32_muladd_test
global avx_fp32_add_test
global avx_fp32_mul_test
global avx_fp32_muladd_test
global fp32_fma_test
global fp64_fma_test

global sse_fp64_add_test
global sse_fp64_mul_test
global sse_fp64_muladd_test
global avx_fp64_add_test
global avx_fp64_mul_test
global avx_fp64_muladd_test

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

sse_int64_add_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_int64_add_test_loop:
  paddq xmm0, xmm0
  paddq xmm1, xmm1
  paddq xmm2, xmm2
  paddq xmm3, xmm3
  paddq xmm4, xmm4
  paddq xmm5, xmm5
  sub rcx, 12
  jg sse_int64_add_test_loop
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
  jg sse_int32_mul_test_loop
  ret

sse_int64_mul_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_int64_mul_test_loop:
  pmuludq xmm0, xmm0
  pmuludq xmm1, xmm1
  pmuludq xmm2, xmm2
  pmuludq xmm3, xmm3
  pmuludq xmm4, xmm4
  pmuludq xmm5, xmm5
  sub rcx, 12
  jg sse_int64_mul_test_loop
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
  jg avx2_int32_mul_test_loop
  ret

avx2_int64_add_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx2_int64_add_test_loop:
  vpaddq ymm0, ymm0, ymm0
  vpaddq ymm1, ymm1, ymm1
  vpaddq ymm2, ymm2, ymm2
  vpaddq ymm3, ymm3, ymm3
  vpaddq ymm4, ymm4, ymm4
  vpaddq ymm5, ymm5, ymm5
  sub rcx, 24
  jg avx2_int64_add_test_loop
  ret

avx2_int64_mul_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx2_int64_mul_test_loop:
  vpmuldq ymm0, ymm0, ymm0
  vpmuldq ymm1, ymm1, ymm1
  vpmuldq ymm2, ymm2, ymm2
  vpmuldq ymm3, ymm3, ymm3
  vpmuldq ymm4, ymm4, ymm4
  vpmuldq ymm5, ymm5, ymm5
  sub rcx, 24
  jg avx2_int64_mul_test_loop
  ret

sse_fp32_add_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_fp32_add_test_loop:
  addps xmm0, xmm0
  addps xmm1, xmm1
  addps xmm2, xmm2
  addps xmm3, xmm3
  addps xmm4, xmm4
  addps xmm5, xmm5
  sub rcx, 24
  jg sse_fp32_add_test_loop
  ret

sse_fp64_add_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_fp64_add_test_loop:
  addpd xmm0, xmm0
  addpd xmm1, xmm1
  addpd xmm2, xmm2
  addpd xmm3, xmm3
  addpd xmm4, xmm4
  addpd xmm5, xmm5
  sub rcx, 12
  jg sse_fp64_add_test_loop
  ret

sse_fp32_mul_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_fp32_mul_test_loop:
  mulps xmm0, xmm0
  mulps xmm1, xmm1
  mulps xmm2, xmm2
  mulps xmm3, xmm3
  mulps xmm4, xmm4
  mulps xmm5, xmm5
  sub rcx, 24
  jg sse_fp32_mul_test_loop
  ret

sse_fp64_mul_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_fp64_mul_test_loop:
  mulpd xmm0, xmm0
  mulpd xmm1, xmm1
  mulpd xmm2, xmm2
  mulpd xmm3, xmm3
  mulpd xmm4, xmm4
  mulpd xmm5, xmm5
  sub rcx, 12
  jg sse_fp64_mul_test_loop
  ret

sse_fp32_muladd_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_fp32_muladd_test_loop:
  mulps xmm0, xmm0
  addps xmm0, xmm0
  mulps xmm1, xmm1
  addps xmm1, xmm1
  mulps xmm2, xmm2
  addps xmm2, xmm2
  mulps xmm3, xmm3
  addps xmm3, xmm3
  mulps xmm4, xmm4
  addps xmm4, xmm4
  mulps xmm5, xmm5
  addps xmm5, xmm5
  sub rcx, 24
  jg sse_fp32_muladd_test_loop
  ret

sse_fp64_muladd_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_fp64_muladd_test_loop:
  mulpd xmm0, xmm0
  addpd xmm0, xmm0
  mulpd xmm1, xmm1
  addpd xmm1, xmm1
  mulpd xmm2, xmm2
  addpd xmm2, xmm2
  mulpd xmm3, xmm3
  addpd xmm3, xmm3
  mulpd xmm4, xmm4
  addpd xmm4, xmm4
  mulpd xmm5, xmm5
  addpd xmm5, xmm5
  sub rcx, 12
  jg sse_fp64_muladd_test_loop
  ret

avx_fp32_add_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx_fp32_add_test_loop:
  vaddps ymm0, ymm0, ymm0
  vaddps ymm1, ymm1, ymm1
  vaddps ymm2, ymm2, ymm2
  vaddps ymm3, ymm3, ymm3
  vaddps ymm4, ymm4, ymm4
  vaddps ymm5, ymm5, ymm5
  sub rcx, 48
  jg avx_fp32_add_test_loop
  ret

avx_fp64_add_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx_fp64_add_test_loop:
  vaddpd ymm0, ymm0, ymm0
  vaddpd ymm1, ymm1, ymm1
  vaddpd ymm2, ymm2, ymm2
  vaddpd ymm3, ymm3, ymm3
  vaddpd ymm4, ymm4, ymm4
  vaddpd ymm5, ymm5, ymm5
  sub rcx, 24
  jg avx_fp64_add_test_loop
  ret

avx_fp32_mul_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx_fp32_mul_test_loop:
  vmulps ymm0, ymm0, ymm0
  vmulps ymm1, ymm1, ymm1
  vmulps ymm2, ymm2, ymm2
  vmulps ymm3, ymm3, ymm3
  vmulps ymm4, ymm4, ymm4
  vmulps ymm5, ymm5, ymm5
  sub rcx, 48
  jg avx_fp32_mul_test_loop
  ret

avx_fp64_mul_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx_fp64_mul_test_loop:
  vmulpd ymm0, ymm0, ymm0
  vmulpd ymm1, ymm1, ymm1
  vmulpd ymm2, ymm2, ymm2
  vmulpd ymm3, ymm3, ymm3
  vmulpd ymm4, ymm4, ymm4
  vmulpd ymm5, ymm5, ymm5
  sub rcx, 24
  jg avx_fp64_mul_test_loop
  ret

avx_fp32_muladd_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx_fp32_muladd_test_loop:
  vmulps ymm0, ymm0, ymm0
  vaddps ymm0, ymm0, ymm0
  vmulps ymm1, ymm1, ymm1
  vaddps ymm1, ymm1, ymm1
  vmulps ymm2, ymm2, ymm2
  vaddps ymm2, ymm2, ymm2
  vmulps ymm3, ymm3, ymm3
  vaddps ymm3, ymm3, ymm3
  vmulps ymm4, ymm4, ymm4
  vaddps ymm4, ymm4, ymm4
  vmulps ymm5, ymm5, ymm5
  vaddps ymm5, ymm5, ymm5
  sub rcx, 48
  jg avx_fp32_muladd_test_loop
  ret

avx_fp64_muladd_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx_fp64_muladd_test_loop:
  vmulpd ymm0, ymm0, ymm0
  vaddpd ymm0, ymm0, ymm0
  vmulpd ymm1, ymm1, ymm1
  vaddpd ymm1, ymm1, ymm1
  vmulpd ymm2, ymm2, ymm2
  vaddpd ymm2, ymm2, ymm2
  vmulpd ymm3, ymm3, ymm3
  vaddpd ymm3, ymm3, ymm3
  vmulpd ymm4, ymm4, ymm4
  vaddpd ymm4, ymm4, ymm4
  vmulpd ymm5, ymm5, ymm5
  vaddpd ymm5, ymm5, ymm5
  sub rcx, 24
  jg avx_fp64_muladd_test_loop
  ret

fp32_fma_test:
  vzeroall
  vmovups ymm0, [rdx]
  vmovups ymm1, ymm0
  vmovups ymm2, ymm0
  vmovups ymm3, ymm0
  vmovups ymm4, ymm0
  vmovups ymm5, ymm0
  vmovups ymm6, ymm0
fp32_fma_test_loop:
  vfmadd132ps ymm0, ymm0, ymm6
  vfmadd132ps ymm1, ymm1, ymm6
  vfmadd132ps ymm2, ymm2, ymm6
  vfmadd132ps ymm3, ymm3, ymm6
  vfmadd132ps ymm4, ymm4, ymm6
  vfmadd132ps ymm5, ymm5, ymm6
  sub rcx, 48
  jg fp32_fma_test_loop
  ret

fp64_fma_test:
  vzeroall
  vmovups ymm0, [rdx]
  vmovups ymm1, ymm0
  vmovups ymm2, ymm0
  vmovups ymm3, ymm0
  vmovups ymm4, ymm0
  vmovups ymm5, ymm0
  vmovups ymm6, ymm0
fp64_fma_test_loop:
  vfmadd132pd ymm0, ymm0, ymm6
  vfmadd132pd ymm1, ymm1, ymm6
  vfmadd132pd ymm2, ymm2, ymm6
  vfmadd132pd ymm3, ymm3, ymm6
  vfmadd132pd ymm4, ymm4, ymm6
  vfmadd132pd ymm5, ymm5, ymm6
  sub rcx, 24
  jg fp64_fma_test_loop
  ret