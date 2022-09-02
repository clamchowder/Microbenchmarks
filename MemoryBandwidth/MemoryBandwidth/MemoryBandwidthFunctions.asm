section .text

bits 64

global sse_asm_read
global sse_asm_copy
global sse_asm_write
global sse_asm_add
global avx_asm_read
global avx_asm_write
global avx_asm_copy
global avx_asm_cflip
global avx_asm_add
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

; rcx = ptr to arr
; rdx = arr_length
; r8 = iterations
avx_asm_copy:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  push r13
  xor rsi, rsi
  mov r9, rdx
  shr r9, 1    ; start destination at array + length / 2
  mov r15, 256 ; load in blocks of 128 bytes
  mov r13, r9
  sub r13, 64
  lea rdi, [rcx + rsi * 4]
  lea r14, [rcx + r9 * 4]
avx_copy_pass_loop:
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  vmovaps ymm4, [rdi + 128]
  vmovaps ymm5, [rdi + 160]
  vmovaps ymm6, [rdi + 192]
  vmovaps ymm7, [rdi + 224]
  vmovaps [r14], ymm0
  vmovaps [r14 + 32], ymm1
  vmovaps [r14 + 64], ymm2
  vmovaps [r14 + 96], ymm3
  vmovaps [r14 + 128], ymm4
  vmovaps [r14 + 160], ymm5
  vmovaps [r14 + 192], ymm6
  vmovaps [r14 + 224], ymm7
  add rsi, 64
  add rdi, r15  ; increment src/dst pointers
  add r14, r15
  cmp r13, rsi  ; end location is at half
  jge avx_copy_pass_loop
  xor rsi, rsi
  lea rdi, [rcx + rsi * 4] ; back to start
  lea r14, [rcx + r9 * 4]
  dec r8                  ; decrement iteration counter
  jnz avx_copy_pass_loop
  pop r13
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret


; changes the ordering of vector sized elements within a cacheline
 avx_asm_cflip:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  mov r15, 256 ; load in blocks of 256 bytes
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break. 128 elements per iteration
  xor r9, r9   ; not doing start anymore, too lazy to clean up code
  ; mov rsi, r9  ; assume we're passed in an aligned start location O.o
  xor rsi, rsi
  xor rbx, rbx
  lea rdi, [rcx + rsi * 4]
  mov r14, rdi
avx_asm_cflip_pass_loop:
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  vmovaps [rdi + 96], ymm0
  vmovaps [rdi + 64], ymm1
  vmovaps [rdi + 32], ymm2
  vmovaps [rdi], ymm3
  vmovaps ymm0, [rdi + 128]
  vmovaps ymm1, [rdi + 160]
  vmovaps ymm2, [rdi + 192]
  vmovaps ymm3, [rdi + 224]
  vmovaps [rdi + 224], ymm0
  vmovaps [rdi + 192], ymm1
  vmovaps [rdi + 160], ymm2
  vmovaps [rdi + 128], ymm3
  add rsi, 64
  add rdi, r15
  vmovaps ymm0, [rdi]
  vmovaps ymm1, [rdi + 32]
  vmovaps ymm2, [rdi + 64]
  vmovaps ymm3, [rdi + 96]
  vmovaps [rdi + 96], ymm0
  vmovaps [rdi + 64], ymm1
  vmovaps [rdi + 32], ymm2
  vmovaps [rdi], ymm3
  vmovaps ymm0, [rdi + 128]
  vmovaps ymm1, [rdi + 160]
  vmovaps ymm2, [rdi + 192]
  vmovaps ymm3, [rdi + 224]
  vmovaps [rdi + 224], ymm0
  vmovaps [rdi + 192], ymm1
  vmovaps [rdi + 160], ymm2
  vmovaps [rdi + 128], ymm3
  add rsi, 64
  add rdi, r15
  cmp rdx, rsi
  jge asm_avx_cflip_iteration_count
  mov rsi, rbx
  lea rdi, [rcx + rsi * 4]  ; back to start
asm_avx_cflip_iteration_count:
  cmp r9, rsi
  jnz avx_asm_cflip_pass_loop ; skip iteration decrement if we're not back to start
  sub r8, 2
  jnz avx_asm_cflip_pass_loop
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret

avx_asm_add:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  mov r15, 256 ; load in blocks of 256 bytes
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
  xor r9, r9   ; not doing start anymore, too lazy to clean up code
  ; mov rsi, r9  ; assume we're passed in an aligned start location O.o
  xor rsi, rsi
  xor rbx, rbx
  lea rdi, [rcx + rsi * 4]
  mov r14, rdi
  vmovaps ymm4, [rdi]
avx_asm_add_pass_loop:
  ; xmm0 to 5 are considered volatile
  vaddps ymm0, ymm4, [rdi]
  vaddps ymm1, ymm4, [rdi + 32]
  vaddps ymm2, ymm4, [rdi + 64]
  vaddps ymm3, ymm4, [rdi + 96]
  vmovaps [rdi], ymm0
  vmovaps [rdi + 32], ymm1
  vmovaps [rdi + 64], ymm2
  vmovaps [rdi + 96], ymm3
  vaddps ymm0, ymm4, [rdi + 128]
  vaddps ymm1, ymm4, [rdi + 160]
  vaddps ymm2, ymm4, [rdi + 192]
  vaddps ymm3, ymm4, [rdi + 224]
  vmovaps [rdi + 128], ymm0
  vmovaps [rdi + 160], ymm1
  vmovaps [rdi + 192], ymm2
  vmovaps [rdi + 224], ymm3

  add rsi, 64
  add rdi, r15
  vaddps ymm0, ymm4, [rdi]
  vaddps ymm1, ymm4, [rdi + 32]
  vaddps ymm2, ymm4, [rdi + 64]
  vaddps ymm3, ymm4, [rdi + 96]
  vmovaps [rdi], ymm0
  vmovaps [rdi + 32], ymm1
  vmovaps [rdi + 64], ymm2
  vmovaps [rdi + 96], ymm3
  vaddps ymm0, ymm4, [rdi + 128]
  vaddps ymm1, ymm4, [rdi + 160]
  vaddps ymm2, ymm4, [rdi + 192]
  vaddps ymm3, ymm4, [rdi + 224]
  vmovaps [rdi + 128], ymm0
  vmovaps [rdi + 160], ymm1
  vmovaps [rdi + 192], ymm2
  vmovaps [rdi + 224], ymm3
  add rsi, 64
  add rdi, r15
  cmp rdx, rsi
  jge asm_avx_add_iteration_count
  mov rsi, rbx
  lea rdi, [rcx + rsi * 4]  ; back to start
asm_avx_add_iteration_count:
  cmp r9, rsi
  jnz avx_asm_add_pass_loop ; skip iteration decrement if we're not back to start
  sub r8, 2
  jnz avx_asm_add_pass_loop
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
  ; mov rsi, r9  ; assume we're passed in an aligned start location O.o
  xor rsi, rsi
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
  xor r9, r9
  xor rsi, rsi
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

; rcx = float ptr to arr, rdx = fp32 elements in arr, r8 = iterations
sse_asm_write:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  mov r15, 256 ; load in blocks of 256 bytes
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
  xor r9, r9
  xor rsi, rsi
  xor rbx, rbx
  lea rdi, [rcx + rsi * 4]
  mov r14, rdi
  movaps xmm0, [rdi]
sse_write_pass_loop:
  movaps [rdi], xmm0
  movaps [rdi + 16], xmm0
  movaps [rdi + 32], xmm0
  movaps [rdi + 48], xmm0
  movaps [rdi + 64], xmm0
  movaps [rdi + 80], xmm0
  movaps [rdi + 96], xmm0
  movaps [rdi + 112], xmm0
  movaps [rdi + 128], xmm0
  movaps [rdi + 144], xmm0
  movaps [rdi + 160], xmm0
  movaps [rdi + 176], xmm0
  movaps [rdi + 192], xmm0
  movaps [rdi + 208], xmm0
  movaps [rdi + 224], xmm0
  movaps [rdi + 240], xmm0
  add rsi, 64
  add rdi, r15
  movaps [rdi], xmm0
  movaps [rdi + 16], xmm0
  movaps [rdi + 32], xmm0
  movaps [rdi + 48], xmm0
  movaps [rdi + 64], xmm0
  movaps [rdi + 80], xmm0
  movaps [rdi + 96], xmm0
  movaps [rdi + 112], xmm0
  movaps [rdi + 128], xmm0
  movaps [rdi + 144], xmm0
  movaps [rdi + 160], xmm0
  movaps [rdi + 176], xmm0
  movaps [rdi + 192], xmm0
  movaps [rdi + 208], xmm0
  movaps [rdi + 224], xmm0
  movaps [rdi + 240], xmm0
  add rsi, 64
  add rdi, r15
  cmp rdx, rsi
  jge sse_write_iteration_count
  mov rsi, rbx
  lea rdi, [rcx + rsi * 4]  ; back to start
sse_write_iteration_count:
  cmp r9, rsi
  jnz sse_write_pass_loop ; skip iteration decrement if we're not back to start
  dec r8
  jg sse_write_pass_loop
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret


; rcx = ptr to arr
; rdx = arr_length
; r8 = iterations
sse_asm_copy:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  push r13
  xor rsi, rsi
  mov r9, rdx
  shr r9, 1    ; start destination at array + length / 2
  mov r15, 256 ; load in blocks of 128 bytes
  mov r13, r9
  sub r13, 64
  lea rdi, [rcx + rsi * 4]
  lea r14, [rcx + r9 * 4]
sse_copy_pass_loop:
  movaps xmm0, [rdi]
  movaps xmm1, [rdi + 16]
  movaps xmm2, [rdi + 32]
  movaps xmm3, [rdi + 48]
  movaps xmm4, [rdi + 64]
  movaps xmm5, [rdi + 80]
  movaps xmm6, [rdi + 96]
  movaps xmm7, [rdi + 112]
  movaps [r14], xmm0
  movaps [r14 + 16], xmm1
  movaps [r14 + 32], xmm2
  movaps [r14 + 48], xmm3
  movaps [r14 + 64], xmm4
  movaps [r14 + 80], xmm5
  movaps [r14 + 96], xmm6
  movaps [r14 + 112], xmm7

  movaps xmm0, [rdi + 128]
  movaps xmm1, [rdi + 144]
  movaps xmm2, [rdi + 160]
  movaps xmm3, [rdi + 176]
  movaps xmm4, [rdi + 192]
  movaps xmm5, [rdi + 208]
  movaps xmm6, [rdi + 224]
  movaps xmm7, [rdi + 240]
  movaps [r14 + 128], xmm0
  movaps [r14 + 144], xmm1
  movaps [r14 + 160], xmm2
  movaps [r14 + 176], xmm3
  movaps [r14 + 192], xmm4
  movaps [r14 + 208], xmm5
  movaps [r14 + 224], xmm6
  movaps [r14 + 240], xmm7

  add rsi, 64
  add rdi, r15  ; increment src/dst pointers
  add r14, r15
  cmp r13, rsi  ; end location is at half
  jge sse_copy_pass_loop
  xor rsi, rsi
  lea rdi, [rcx + rsi * 4] ; back to start
  lea r14, [rcx + r9 * 4]
  dec r8                  ; decrement iteration counter
  jnz sse_copy_pass_loop
  pop r13
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret

sse_asm_add:
  push rsi
  push rdi
  push rbx
  push r15
  push r14
  mov r15, 256 ; load in blocks of 256 bytes
  sub rdx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
  xor r9, r9
  xor rsi, rsi
  xor rbx, rbx
  lea rdi, [rcx + rsi * 4]
  mov r14, rdi
  movaps xmm5, [rdi]
sse_add_pass_loop:
  movaps xmm0, xmm5
  movaps xmm1, xmm5
  movaps xmm2, xmm5
  movaps xmm3, xmm5
  addps xmm0, [rdi]
  addps xmm1, [rdi + 16]
  addps xmm2, [rdi + 32]
  addps xmm3, [rdi + 48]
  movaps [rdi], xmm0
  movaps [rdi + 16], xmm1
  movaps [rdi + 32], xmm2
  movaps [rdi + 48], xmm3

  movaps xmm0, xmm5
  movaps xmm1, xmm5
  movaps xmm2, xmm5
  movaps xmm3, xmm5
  addps xmm0, [rdi + 64]
  addps xmm1, [rdi + 80]
  addps xmm2, [rdi + 96]
  addps xmm3, [rdi + 112]
  movaps [rdi + 64], xmm0
  movaps [rdi + 80], xmm1
  movaps [rdi + 96], xmm2
  movaps [rdi + 112], xmm3

  movaps xmm0, xmm5
  movaps xmm1, xmm5
  movaps xmm2, xmm5
  movaps xmm3, xmm5
  addps xmm0, [rdi + 128]
  addps xmm1, [rdi + 144]
  addps xmm2, [rdi + 160]
  addps xmm3, [rdi + 176]
  movaps [rdi + 128], xmm0
  movaps [rdi + 144], xmm1
  movaps [rdi + 160], xmm2
  movaps [rdi + 176], xmm3

  movaps xmm0, xmm5
  movaps xmm1, xmm5
  movaps xmm2, xmm5
  movaps xmm3, xmm5
  addps xmm0, [rdi + 192]
  addps xmm1, [rdi + 208]
  addps xmm2, [rdi + 224]
  addps xmm3, [rdi + 240]
  movaps [rdi + 192], xmm0
  movaps [rdi + 208], xmm1
  movaps [rdi + 224], xmm2
  movaps [rdi + 240], xmm3

  add rsi, 64
  add rdi, r15
  movaps xmm0, xmm5
  movaps xmm1, xmm5
  movaps xmm2, xmm5
  movaps xmm3, xmm5
  addps xmm0, [rdi]
  addps xmm1, [rdi + 16]
  addps xmm2, [rdi + 32]
  addps xmm3, [rdi + 48]
  movaps [rdi], xmm0
  movaps [rdi + 16], xmm1
  movaps [rdi + 32], xmm2
  movaps [rdi + 48], xmm3

  movaps xmm0, xmm5
  movaps xmm1, xmm5
  movaps xmm2, xmm5
  movaps xmm3, xmm5
  addps xmm0, [rdi + 64]
  addps xmm1, [rdi + 80]
  addps xmm2, [rdi + 96]
  addps xmm3, [rdi + 112]
  movaps [rdi + 64], xmm0
  movaps [rdi + 80], xmm1
  movaps [rdi + 96], xmm2
  movaps [rdi + 112], xmm3

  movaps xmm0, xmm5
  movaps xmm1, xmm5
  movaps xmm2, xmm5
  movaps xmm3, xmm5
  addps xmm0, [rdi + 128]
  addps xmm1, [rdi + 144]
  addps xmm2, [rdi + 160]
  addps xmm3, [rdi + 176]
  movaps [rdi + 128], xmm0
  movaps [rdi + 144], xmm1
  movaps [rdi + 160], xmm2
  movaps [rdi + 176], xmm3

  movaps xmm0, xmm5
  movaps xmm1, xmm5
  movaps xmm2, xmm5
  movaps xmm3, xmm5
  addps xmm0, [rdi + 192]
  addps xmm1, [rdi + 208]
  addps xmm2, [rdi + 224]
  addps xmm3, [rdi + 240]
  movaps [rdi + 192], xmm0
  movaps [rdi + 208], xmm1
  movaps [rdi + 224], xmm2
  movaps [rdi + 240], xmm3
  add rsi, 64
  add rdi, r15
  cmp rdx, rsi
  jge sse_add_iteration_count
  mov rsi, rbx
  lea rdi, [rcx + rsi * 4]  ; back to start
sse_add_iteration_count:
  cmp r9, rsi
  jnz sse_add_pass_loop ; skip iteration decrement if we're not back to start
  sub r8, 2
  jg sse_add_pass_loop
  pop r14
  pop r15
  pop rbx
  pop rdi
  pop rsi
  ret
