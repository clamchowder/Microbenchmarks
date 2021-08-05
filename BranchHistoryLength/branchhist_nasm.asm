section .text

bits 64

global branchtest

; fastcall:
; rcx = arg0 = iteration count
; rdx = arg1 = ptr to array
; r8 = arg2 = array length

branchtest:
  push rbx
  push r10
  push r9
  xor rbx, rbx ; rbx is array index
  xor r10, r10
  xor r9, r9
branchtest_loop:
  mov eax, [rdx + rbx + 4]
  inc rbx
  cmp r8, rbx
  cmove rbx, r9  ; if rbx == r8 (array len), loop back to rbx = 0
  and eax, 2
  test eax, eax  ; if zero, skip incrementing r10
  jz branchtest_zero
  inc r10
branchtest_zero:
  dec rcx
  jnz branchtest_loop
  mov rax, r10
  pop r9
  pop r10
  pop rbx
  ret
