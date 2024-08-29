section .text
bits 64

global clktest

; rcx = iteration count
; rdx = address of memory location to monitor
; return elapsed tsc
clktest:
  push rdx
  push rbx
  push r8
  push r9
  push r10
  push r11
  xor rbx, rbx
  mov r8, 1 ; GLC will eliminate adds with immediates or increments
clktest_loop:
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  add rbx, r8
  mov r11d, [rdx]
  test r11d, r11d
  jnz clktest_loop_end ; early exit condition (someone else exited)
  sub rcx, 20
  jg clktest_loop
  mov [rdx], r8
clktest_loop_end:
  mov rax, rbx
  pop r11
  pop r10
  pop r9
  pop r8
  pop rbx
  pop rdx
  ret