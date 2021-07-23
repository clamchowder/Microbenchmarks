section .text

bits 64

global avx_asm_read

; rcx = float ptr to arr, rdx = fp32 elements in arr, r8 = iterations
; return something in xmm0
avx_asm_read:
  push rsi
  push rdi
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
avx_asm_read_loop
  xor rsi, rsi
avx_asm_read_pass_loop:
  lea rdi, [rcx + rsi * 4]
  ; xmm0 to 5 are considered volatile
  vmovups ymm0, [rdi]
  vmovups ymm1, [rdi + 32]
  vmovups ymm2, [rdi + 64]
  vmovups ymm3, [rdi + 96]
  add rsi, 32
  lea rdi, [rcx + rsi * 4]
  vmovups ymm0, [rdi]
  vmovups ymm1, [rdi + 32]
  vmovups ymm2, [rdi + 64]
  vmovups ymm3, [rdi + 96]
  add rsi, 32
  lea rdi, [rcx + rsi * 4]
  vmovups ymm0, [rdi]
  vmovups ymm1, [rdi + 32]
  vmovups ymm2, [rdi + 64]
  vmovups ymm3, [rdi + 96]
  add rsi, 32
  lea rdi, [rcx + rsi * 4]
  vmovups ymm0, [rdi]
  vmovups ymm1, [rdi + 32]
  vmovups ymm2, [rdi + 64]
  vmovups ymm3, [rdi + 96]
  add rsi, 32
  cmp rdx, rsi
  jge avx_asm_read_pass_loop
  dec r8
  jnz avx_asm_read_loop
  pop rdi
  pop rsi
  ret