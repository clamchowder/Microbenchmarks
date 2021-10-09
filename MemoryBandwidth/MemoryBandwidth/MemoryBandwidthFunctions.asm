section .text

bits 64

global avx_asm_read

; rcx = float ptr to arr, rdx = fp32 elements in arr, r8 = iterations, r9 = start index
; return something in xmm0
avx_asm_read:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  mov r15, 256 ; load in blocks of 256 bytes
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
  mov rsi, r9  ; assume we're passed in an aligned start location O.o
  xor rbx, rbx
  lea rdi, [rcx + rsi * 4]
  mov r14, rdi
avx_asm_read_pass_loop:
  ; xmm0 to 5 are considered volatile
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  vmovaps ymm0, [rdi + 128]
  vmovaps ymm1, [rdi + 160]
  vmovaps ymm2, [rdi + 192]
  vmovaps ymm3, [rdi + 224]
  add rsi, 64
  add rdi, r15
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  vmovaps ymm0, [rdi + 128]
  vmovaps ymm1, [rdi + 160]
  vmovaps ymm2, [rdi + 192]
  vmovaps ymm3, [rdi + 224]
  add rsi, 64
  add rdi, r15
  cmp rdx, rsi
  jge asm_avx_test_iteration_count
  mov rsi, rbx
  lea rdi, [rcx + rsi * 4]  ; back to start
asm_avx_test_iteration_count:
  cmp r9, rsi
  jnz avx_asm_read_pass_loop ; skip iteration decrement if we're not back to start
  dec r8
  jnz avx_asm_read_pass_loop
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret