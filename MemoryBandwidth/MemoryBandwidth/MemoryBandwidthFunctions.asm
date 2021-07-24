section .text

bits 64

global avx_asm_read

; rcx = float ptr to arr, rdx = fp32 elements in arr, r8 = iterations, r9 = start index
; return something in xmm0
avx_asm_read:
  push rsi
  push rdi
  push rbx
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
  mov rsi, r9  ; assume we're passed in an aligned start location O.o
  xor rbx, rbx
avx_asm_read_pass_loop:
  lea rdi, [rcx + rsi * 4]
  ; xmm0 to 5 are considered volatile
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  add rsi, 32
  lea rdi, [rcx + rsi * 4]
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  add rsi, 32
  lea rdi, [rcx + rsi * 4]
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  add rsi, 32
  lea rdi, [rcx + rsi * 4]
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  add rsi, 32
  cmp rdx, rsi
  cmovl rsi, rbx ; if rdx - 128 < rsi, loop back around
  cmp r9, rsi
  jnz avx_asm_read_pass_loop ; skip iteration decrement if we're not back to start
  dec r8
  jnz avx_asm_read_pass_loop
  pop rbx
  pop rdi
  pop rsi
  ret