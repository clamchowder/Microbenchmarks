section .text

bits 32

global @sse_asm_read32@12
global @dummy@12

@dummy@12:
  mov eax, [esp]
  mov [esp + 4], eax
  add esp, 4
  ret

; ecx = ptr to float array
; edx = arr length
; [esp + 4] = iterations, put this into eax
@sse_asm_read32@12:
  mov eax, [esp + 4]
  push ecx
  push edx
  push esi
  push edi
  sub edx, 128 ; last iteration: rsi == rdx. rsi > rdx = break
  xor esi, esi ; index into array = 0
  lea edi, [ecx + esi * 4]
sse_read32_pass_loop:
  movaps xmm0, [edi]
  movaps xmm1, [edi + 16]
  movaps xmm2, [edi + 32]
  movaps xmm3, [edi + 48]
  movaps xmm0, [edi + 64]
  movaps xmm1, [edi + 80]
  movaps xmm2, [edi + 96]
  movaps xmm3, [edi + 112]
  movaps xmm0, [edi + 128]
  movaps xmm1, [edi + 144]
  movaps xmm2, [edi + 160]
  movaps xmm3, [edi + 176]
  movaps xmm0, [edi + 192]
  movaps xmm2, [edi + 208]
  movaps xmm2, [edi + 224]
  movaps xmm2, [edi + 240]
  add esi, 64
  add edi, 256
  movaps xmm0, [edi]
  movaps xmm1, [edi + 16]
  movaps xmm2, [edi + 32]
  movaps xmm3, [edi + 48]
  movaps xmm0, [edi + 64]
  movaps xmm1, [edi + 80]
  movaps xmm2, [edi + 96]
  movaps xmm3, [edi + 112]
  movaps xmm0, [edi + 128]
  movaps xmm1, [edi + 144]
  movaps xmm2, [edi + 160]
  movaps xmm3, [edi + 176]
  movaps xmm0, [edi + 192]
  movaps xmm2, [edi + 208]
  movaps xmm2, [edi + 224]
  movaps xmm2, [edi + 240]
  add esi, 64
  add edi, 256
  cmp edx, esi              ; bounds check, expects size to be multiple of 64 elements
  jge sse_read32_pass_loop

  ; zero the index, get back to start, decrement iteration count
  xor esi, esi              
  lea edi, [ecx + esi * 4]  
  dec eax                   
  jnz sse_read32_pass_loop
  pop edi
  pop esi
  pop edx
  pop ecx

  ; I don't understand this calling convention
  ; nothing I looked up explains it
  mov eax, [esp]
  mov [esp + 4], eax
  add esp, 4
  ret
