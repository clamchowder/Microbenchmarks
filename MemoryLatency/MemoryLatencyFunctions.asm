section .text
bits 64

global preplatencyarr
global latencytest
global gatherlatencytest

preplatencyarr:
  push r15
  push r14
  xor r15, r15 ; array index
preplatencyarr_loop:
  mov r14, [rcx + r15 * 8]
  lea r14, [rcx + r14 * 8]
  mov [rcx + r15 * 8], r14
  inc r15
  cmp rdx, r15
  jne preplatencyarr_loop
  pop r14
  pop r15
  ret

latencytest:
  push r15
  mov r15, [rdx]
  xor rax, rax
latencytest_loop:
  mov r15, [r15]
  add rax, r15
  dec rcx
  jnz latencytest_loop
  pop r15
  ret

gatherlatencytest:
  push r15
  xor rax, rax
  pxor xmm0, xmm0
  pxor xmm2, xmm2
gatherlatencytest_loop:
  ; generate 1s
  pxor xmm1, xmm1
  pcmpeqb xmm1, xmm2
  vpgatherdd xmm3, [rdx + xmm0 * 4], xmm1
  movdqu xmm0, xmm3
  add rax, r15
  dec rcx
  jnz gatherlatencytest_loop
  pop r15
  ret