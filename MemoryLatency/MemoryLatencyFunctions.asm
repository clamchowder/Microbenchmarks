section .text
bits 64

global preplatencyarr
global latencytest

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