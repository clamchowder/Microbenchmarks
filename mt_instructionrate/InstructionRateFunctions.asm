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
global sse_fp32_rsqrt_test
global avx_fp32_add_test
global avx_fp32_mul_test
global avx_fp32_muladd_test
global avx_fp32_rsqrt_test
global fp32_fma_test
global fp64_fma_test

global sse_fp64_add_test
global sse_fp64_mul_test
global sse_fp64_muladd_test
global avx_fp64_add_test
global avx_fp64_mul_test
global avx_fp64_muladd_test

global avx512_int32_add_test
global avx512_int32_mul_test
global avx512_int64_add_test
global avx512_int64_mul_test
global avx512_fp32_rsqrt_test
global avx512_fp32_add_test
global avx512_fp32_fma_test
global avx512_fp64_add_test
global avx512_fp64_fma_test

sse_int32_add_test:
  movdqu xmm0, [rdx]
  movdqu xmm1, [rdx + 16]
  movdqu xmm2, [rdx + 32]
  movdqu xmm3, [rdx + 48]
  movdqu xmm4, [rdx + 64]
  movdqu xmm5, [rdx + 72]
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
  movdqu xmm0, [rdx]
  movdqu xmm1, [rdx + 16]
  movdqu xmm2, [rdx + 32]
  movdqu xmm3, [rdx + 48]
  movdqu xmm4, [rdx + 64]
  movdqu xmm5, [rdx + 72]
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
  movdqu xmm0, [rdx]
  movdqu xmm1, [rdx + 16]
  movdqu xmm2, [rdx + 32]
  movdqu xmm3, [rdx + 48]
  movdqu xmm4, [rdx + 64]
  movdqu xmm5, [rdx + 72]
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
  movdqu xmm0, [rdx]
  movdqu xmm1, [rdx + 16]
  movdqu xmm2, [rdx + 32]
  movdqu xmm3, [rdx + 48]
  movdqu xmm4, [rdx + 64]
  movdqu xmm5, [rdx + 72]
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
  vmovdqu ymm0, [rdx]
  vmovdqu ymm1, [rdx + 32]
  vmovdqu ymm2, [rdx + 64]
  vmovdqu ymm3, [rdx + 96]
  vmovdqu ymm4, [rdx + 128]
  vmovdqu ymm5, [rdx + 160]
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
  vmovdqu ymm0, [rdx]
  vmovdqu ymm1, [rdx + 32]
  vmovdqu ymm2, [rdx + 64]
  vmovdqu ymm3, [rdx + 96]
  vmovdqu ymm4, [rdx + 128]
  vmovdqu ymm5, [rdx + 160]
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
  vmovdqu ymm0, [rdx]
  vmovdqu ymm1, [rdx + 32]
  vmovdqu ymm2, [rdx + 64]
  vmovdqu ymm3, [rdx + 96]
  vmovdqu ymm4, [rdx + 128]
  vmovdqu ymm5, [rdx + 160]
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
  vmovdqu ymm0, [rdx]
  vmovdqu ymm1, [rdx + 32]
  vmovdqu ymm2, [rdx + 64]
  vmovdqu ymm3, [rdx + 96]
  vmovdqu ymm4, [rdx + 128]
  vmovdqu ymm5, [rdx + 160]
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

sse_fp32_rsqrt_test:
  movups xmm0, [rdx]
  movups xmm1, [rdx + 16]
  movups xmm2, [rdx + 32]
  movups xmm3, [rdx + 48]
  movups xmm4, [rdx + 64]
  movups xmm5, [rdx + 72]
sse_fp32_rsqrt_test_loop:
  rsqrtps xmm0, xmm0
  rsqrtps xmm1, xmm1
  rsqrtps xmm2, xmm2
  rsqrtps xmm3, xmm3
  rsqrtps xmm4, xmm4
  rsqrtps xmm5, xmm5
  sub rcx, 24
  jg sse_fp32_rsqrt_test_loop
  ret

avx_fp32_rsqrt_test:
  vmovups ymm0, [rdx]
  vmovups ymm1, [rdx + 32]
  vmovups ymm2, [rdx + 64]
  vmovups ymm3, [rdx + 96]
  vmovups ymm4, [rdx + 128]
  vmovups ymm5, [rdx + 160]
avx_fp32_rsqrt_test_loop:
  vrsqrtps ymm0, ymm0
  vrsqrtps ymm1, ymm1
  vrsqrtps ymm2, ymm2
  vrsqrtps ymm3, ymm3
  vrsqrtps ymm4, ymm4
  vrsqrtps ymm5, ymm5
  sub rcx, 48
  jg avx_fp32_rsqrt_test_loop
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

avx512_int32_add_test:
  vmovdqu16 zmm0, [rdx]
  vmovdqu16 zmm1, [rdx + 64]
  vmovdqu16 zmm2, [rdx + 128]
  vmovdqu16 zmm3, [rdx + 192]
  vmovdqu16 zmm4, [rdx + 256]
  vmovdqu16 zmm5, [rdx + 384]
avx512_int32_add_test_loop:
  vpaddd zmm0, zmm0, zmm0
  vpaddd zmm1, zmm1, zmm1
  vpaddd zmm2, zmm2, zmm2
  vpaddd zmm3, zmm3, zmm3
  vpaddd zmm4, zmm4, zmm4
  vpaddd zmm5, zmm5, zmm5
  sub rcx, 96
  jg avx512_int32_add_test_loop
  ret

avx512_int32_mul_test:
  vmovdqu16 zmm0, [rdx]
  vmovdqu16 zmm1, [rdx + 64]
  vmovdqu16 zmm2, [rdx + 128]
  vmovdqu16 zmm3, [rdx + 192]
  vmovdqu16 zmm4, [rdx + 256]
  vmovdqu16 zmm5, [rdx + 384]
avx512_int32_mul_test_loop:
  vpmulld zmm0, zmm0, zmm0
  vpmulld zmm1, zmm1, zmm1
  vpmulld zmm2, zmm2, zmm2
  vpmulld zmm3, zmm3, zmm3
  vpmulld zmm4, zmm4, zmm4
  vpmulld zmm5, zmm5, zmm5
  sub rcx, 96
  jg avx512_int32_mul_test_loop
  ret

avx512_int64_add_test:
  vmovdqu16 zmm0, [rdx]
  vmovdqu16 zmm1, [rdx + 64]
  vmovdqu16 zmm2, [rdx + 128]
  vmovdqu16 zmm3, [rdx + 192]
  vmovdqu16 zmm4, [rdx + 256]
  vmovdqu16 zmm5, [rdx + 384]
avx512_int64_add_test_loop:
  vpaddq zmm0, zmm0, zmm0
  vpaddq zmm1, zmm1, zmm1
  vpaddq zmm2, zmm2, zmm2
  vpaddq zmm3, zmm3, zmm3
  vpaddq zmm4, zmm4, zmm4
  vpaddq zmm5, zmm5, zmm5
  sub rcx, 48
  jg avx512_int64_add_test_loop
  ret

avx512_int64_mul_test:
  vmovdqu16 zmm0, [rdx]
  vmovdqu16 zmm1, [rdx + 64]
  vmovdqu16 zmm2, [rdx + 128]
  vmovdqu16 zmm3, [rdx + 192]
  vmovdqu16 zmm4, [rdx + 256]
  vmovdqu16 zmm5, [rdx + 384]
avx512_int64_mul_test_loop:
  vpmuldq zmm0, zmm0, zmm0
  vpmuldq zmm1, zmm1, zmm1
  vpmuldq zmm2, zmm2, zmm2
  vpmuldq zmm3, zmm3, zmm3
  vpmuldq zmm4, zmm4, zmm4
  vpmuldq zmm5, zmm5, zmm5
  sub rcx, 48
  jg avx512_int64_mul_test_loop
  ret

avx512_fp32_rsqrt_test:
  vmovups zmm0, [rdx]
  vmovups zmm1, [rdx + 64]
  vmovups zmm2, [rdx + 128]
  vmovups zmm3, [rdx + 192]
  vmovups zmm4, [rdx + 256]
  vmovups zmm5, [rdx + 384]
avx512_fp32_rsqrt_test_loop:
  vrsqrt14ps zmm0, zmm0
  vrsqrt14ps zmm1, zmm1
  vrsqrt14ps zmm2, zmm2
  vrsqrt14ps zmm3, zmm3
  vrsqrt14ps zmm4, zmm4
  vrsqrt14ps zmm5, zmm5
  sub rcx, 96
  jg avx512_fp32_rsqrt_test_loop
  ret

avx512_fp32_add_test:
  vmovups zmm0, [rdx]
  vmovups zmm1, [rdx + 64]
  vmovups zmm2, [rdx + 128]
  vmovups zmm3, [rdx + 192]
  vmovups zmm4, [rdx + 256]
  vmovups zmm5, [rdx + 384]
avx512_fp32_add_test_loop:
  vaddps zmm0, zmm0, zmm0
  vaddps zmm1, zmm1, zmm1
  vaddps zmm2, zmm2, zmm2
  vaddps zmm3, zmm3, zmm3
  vaddps zmm4, zmm4, zmm4
  vaddps zmm5, zmm5, zmm5
  sub rcx, 96
  jg avx512_fp32_add_test_loop
  ret

avx512_fp32_fma_test:
  vmovups zmm0, [rdx]
  vmovups zmm1, [rdx + 64]
  vmovups zmm2, [rdx + 128]
  vmovups zmm3, [rdx + 192]
  vmovups zmm4, [rdx + 256]
  vmovups zmm5, [rdx + 384]
avx512_fp32_fma_test_loop:
  vfmadd132ps zmm0, zmm0, zmm0
  vfmadd132ps zmm1, zmm1, zmm1
  vfmadd132ps zmm2, zmm2, zmm2
  vfmadd132ps zmm3, zmm3, zmm3
  vfmadd132ps zmm4, zmm4, zmm4
  vfmadd132ps zmm5, zmm5, zmm5
  sub rcx, 96
  jg avx512_fp32_fma_test_loop
  ret

avx512_fp64_add_test:
  vmovups zmm0, [rdx]
  vmovups zmm1, [rdx + 64]
  vmovups zmm2, [rdx + 128]
  vmovups zmm3, [rdx + 192]
  vmovups zmm4, [rdx + 256]
  vmovups zmm5, [rdx + 384]
avx512_fp64_add_test_loop:
  vfmadd132pd zmm0, zmm0, zmm0
  vfmadd132pd zmm1, zmm1, zmm1
  vfmadd132pd zmm2, zmm2, zmm2
  vfmadd132pd zmm3, zmm3, zmm3
  vfmadd132pd zmm4, zmm4, zmm4
  vfmadd132pd zmm5, zmm5, zmm5
  sub rcx, 48
  jg avx512_fp64_add_test_loop
  ret

avx512_fp64_fma_test:
  vmovups zmm0, [rdx]
  vmovups zmm1, [rdx + 64]
  vmovups zmm2, [rdx + 128]
  vmovups zmm3, [rdx + 192]
  vmovups zmm4, [rdx + 256]
  vmovups zmm5, [rdx + 384]
avx512_fp64_fma_test_loop:
  vfmadd132ps zmm0, zmm0, zmm0
  vfmadd132ps zmm1, zmm1, zmm1
  vfmadd132ps zmm2, zmm2, zmm2
  vfmadd132ps zmm3, zmm3, zmm3
  vfmadd132ps zmm4, zmm4, zmm4
  vfmadd132ps zmm5, zmm5, zmm5
  sub rcx, 48
  jg avx512_fp64_fma_test_loop
  ret