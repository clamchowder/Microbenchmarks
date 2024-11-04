section .text
bits 64

global asm_read

; rcx = ptr to array
; rdx = array length in bytes
; r8 = stop flag
; r9 = throttle factor
; return bytes read in rax
asm_read:
  push rdi
  push rsi
  push r10
  push r11
  mov rdi, rcx  ; save array base address
  xor rsi, rsi  ; index
  xor rax, rax  ; return value
asm_read_pass_loop:
  movups xmm0, [rdi]
  movups xmm0, [rdi + 16]
  movups xmm0, [rdi + 32]
  movups xmm0, [rdi + 48]
  movups xmm0, [rdi + 64]
  movups xmm0, [rdi + 80]
  movups xmm0, [rdi + 96]
  movups xmm0, [rdi + 112]

  add rdi, 128
  add rsi, 128    ; update index
  add rax, 128    ; update return value

  test r9, r9               ; need to throttle?
  jz asm_read_throttle_end
  mov r10, r9
asm_read_throttle:
  dec r10
  jnz asm_read_throttle;
asm_read_throttle_end:
  mov r10d, [r8]           ; check stop flag
  test r10d, r10d
  jnz asm_read_end

  cmp rdx, rsi             ; array len - index > 0?
  jg asm_read_pass_loop
  mov rdi, rcx             ; reset to start
  xor rsi, rsi             ; and reset index
  jmp asm_read_pass_loop
asm_read_end:
  pop r11
  pop r10
  pop rsi
  pop rdi
  ret