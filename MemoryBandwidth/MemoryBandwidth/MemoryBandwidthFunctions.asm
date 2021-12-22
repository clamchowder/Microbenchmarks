section .text

bits 64

global sse_asm_read
global avx_asm_read
global avx_asm_write
global avx512_asm_read

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
  xor r9, r9   ; not doing start anymore, too lazy to clean up code
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

avx_asm_write:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  mov r15, 256 ; load in blocks of 256 bytes
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
  xor r9, r9   ; not doing start anymore, too lazy to clean up code
  mov rsi, r9  ; assume we're passed in an aligned start location O.o
  xor rbx, rbx
  lea rdi, [rcx + rsi * 4]
  mov r14, rdi
  vmovaps ymm0, [rcx]
avx_asm_write_pass_loop:
  vmovaps [rdi], ymm0
  vmovaps [rdi + 32], ymm0
  vmovaps [rdi + 64], ymm0
  vmovaps [rdi + 96], ymm0
  vmovaps [rdi + 128], ymm0
  vmovaps [rdi + 160], ymm0
  vmovaps [rdi + 192], ymm0
  vmovaps [rdi + 224], ymm0
  add rsi, 64
  add rdi, r15
  vmovaps [rdi], ymm0
  vmovaps [rdi + 32], ymm0
  vmovaps [rdi + 64], ymm0
  vmovaps [rdi + 96], ymm0
  vmovaps [rdi + 128], ymm0
  vmovaps [rdi + 160], ymm0
  vmovaps [rdi + 192], ymm0
  vmovaps [rdi + 224], ymm0
  add rsi, 64
  add rdi, r15
  cmp rdx, rsi
  jge asm_avx_write_iteration_count
  mov rsi, rbx
  lea rdi, [rcx + rsi * 4]  ; back to start
asm_avx_write_iteration_count:
  cmp r9, rsi
  jnz avx_asm_write_pass_loop ; skip iteration decrement if we're not back to start
  dec r8
  jnz avx_asm_write_pass_loop
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret

avx512_asm_read:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  mov r15, 256 ; load in blocks of 256 bytes
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
  xor r9, r9   ; not doing start anymore, too lazy to clean up code
  mov rsi, r9  ; assume we're passed in an aligned start location O.o
  xor rbx, rbx
  lea rdi, [rcx + rsi * 4]
  mov r14, rdi
avx512_asm_read_pass_loop:
  vmovaps zmm0, [rdi]
  vmovaps zmm1, [rdi + 64]
  vmovaps zmm2, [rdi + 128]
  vmovaps zmm3, [rdi + 192]
  add rsi, 64
  add rdi, r15
  vmovaps zmm0, [rdi]
  vmovaps zmm1, [rdi + 64]
  vmovaps zmm2, [rdi + 128]
  vmovaps zmm3, [rdi + 192]
  add rsi, 64
  add rdi, r15
  cmp rdx, rsi
  jge asm_avx512_test_iteration_count
  mov rsi, rbx
  lea rdi, [rcx + rsi * 4]  ; back to start
asm_avx512_test_iteration_count:
  cmp r9, rsi
  jnz avx512_asm_read_pass_loop ; skip iteration decrement if we're not back to start
  dec r8
  jnz avx512_asm_read_pass_loop
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret

sse_asm_read:
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
sse_read_pass_loop:
  ; xmm0 to 5 are considered volatile
  movaps xmm0, [rdi]
  movaps xmm1, [rdi + 16]
  movaps xmm2, [rdi + 32]
  movaps xmm3, [rdi + 48]
  movaps xmm0, [rdi + 64]
  movaps xmm1, [rdi + 80]
  movaps xmm2, [rdi + 96]
  movaps xmm3, [rdi + 112]
  movaps xmm0, [rdi + 128]
  movaps xmm1, [rdi + 144]
  movaps xmm2, [rdi + 160]
  movaps xmm3, [rdi + 176]
  movaps xmm0, [rdi + 192]
  movaps xmm2, [rdi + 208]
  movaps xmm2, [rdi + 224]
  movaps xmm2, [rdi + 240]
  add rsi, 64
  add rdi, r15
  movaps xmm0, [rdi]
  movaps xmm1, [rdi + 16]
  movaps xmm2, [rdi + 32]
  movaps xmm3, [rdi + 48]
  movaps xmm0, [rdi + 64]
  movaps xmm1, [rdi + 80]
  movaps xmm2, [rdi + 96]
  movaps xmm3, [rdi + 112]
  movaps xmm0, [rdi + 128]
  movaps xmm1, [rdi + 144]
  movaps xmm2, [rdi + 160]
  movaps xmm3, [rdi + 176]
  movaps xmm0, [rdi + 192]
  movaps xmm2, [rdi + 208]
  movaps xmm2, [rdi + 224]
  movaps xmm2, [rdi + 240]
  add rsi, 64
  add rdi, r15
  cmp rdx, rsi
  jge sse_test_iteration_count
  mov rsi, rbx
  lea rdi, [rcx + rsi * 4]  ; back to start
sse_test_iteration_count:
  cmp r9, rsi
  jnz sse_read_pass_loop ; skip iteration decrement if we're not back to start
  dec r8
  jnz sse_read_pass_loop
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret
