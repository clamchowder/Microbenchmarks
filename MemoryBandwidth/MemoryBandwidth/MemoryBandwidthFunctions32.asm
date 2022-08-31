section .text

bits 32

global @sse_asm_read32@12
global sse_asm_read32
global @mmx_asm_read32@12
global mmx_asm_read32
global @scalar_asm_read32@12
global scalar_asm_read32
global @dummy@12

@dummy@12:
  mov eax, [esp]
  mov [esp + 4], eax
  add esp, 4
  ret

; ecx = ptr to float array
; edx = arr length
; [esp + 4] = iterations, put this into eax
sse_asm_read32:
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

mmx_asm_read32:
@mmx_asm_read32@12:
  mov eax, [esp + 4]
  push ecx
  push edx
  push esi
  push edi
  sub edx, 64 ; last iteration: rsi == rdx. rsi > rdx = break
  xor esi, esi ; index into array = 0
  lea edi, [ecx + esi * 4]
mmx_read32_pass_loop:
  movq mm0, [edi]
  movq mm1, [edi + 8]
  movq mm2, [edi + 16]
  movq mm3, [edi + 24]
  movq mm4, [edi + 32]
  movq mm5, [edi + 40]
  movq mm6, [edi + 48]
  movq mm7, [edi + 56]

  movq mm0, [edi + 64]
  movq mm1, [edi + 72]
  movq mm2, [edi + 80]
  movq mm3, [edi + 88]
  movq mm4, [edi + 96]
  movq mm5, [edi + 104]
  movq mm6, [edi + 112]
  movq mm7, [edi + 120]

  movq mm0, [edi + 128]
  movq mm1, [edi + 136]
  movq mm2, [edi + 144]
  movq mm3, [edi + 152]
  movq mm4, [edi + 160]
  movq mm5, [edi + 168]
  movq mm6, [edi + 176]
  movq mm7, [edi + 184]

  movq mm0, [edi + 192]
  movq mm1, [edi + 200]
  movq mm2, [edi + 208]
  movq mm3, [edi + 216]
  movq mm4, [edi + 224]
  movq mm5, [edi + 232]
  movq mm6, [edi + 240]
  movq mm7, [edi + 248]
  add esi, 64
  add edi, 256
  cmp edx, esi              ; bounds check, expects size to be multiple of 64 elements
  jge mmx_read32_pass_loop

  ; zero the index, get back to start, decrement iteration count
  xor esi, esi
  lea edi, [ecx + esi * 4]
  dec eax
  jnz mmx_read32_pass_loop
  pop edi
  pop esi
  pop edx
  pop ecx

  mov eax, [esp]
  mov [esp + 4], eax
  add esp, 4
  fld1
  ret

; [esp + 4] = iterations
scalar_asm_read32:
@scalar_asm_read32@12:
  push ebx
  push ecx
  push edx
  push esi
  push edi
  sub edx, 32 ; last iteration: rsi == rdx. rsi > rdx = break
  xor esi, esi ; index into array = 0
  lea edi, [ecx + esi * 4]
scalar_read32_pass_loop:
  mov eax, [edi]
  mov ebx, [edi + 4]
  mov eax, [edi + 8]
  mov ebx, [edi + 12]
  mov eax, [edi + 16]
  mov ebx, [edi + 20]
  mov eax, [edi + 24]
  mov ebx, [edi + 28]
  mov eax, [edi + 32]
  mov ebx, [edi + 36]
  mov eax, [edi + 40]
  mov ebx, [edi + 44]
  mov eax, [edi + 48]
  mov ebx, [edi + 52]
  mov eax, [edi + 56]
  mov ebx, [edi + 60]

  mov eax, [edi + 64]
  mov ebx, [edi + 68]
  mov eax, [edi + 72]
  mov ebx, [edi + 76]
  mov eax, [edi + 80]
  mov ebx, [edi + 84]
  mov eax, [edi + 88]
  mov ebx, [edi + 92]
  mov eax, [edi + 96]
  mov ebx, [edi + 100]
  mov eax, [edi + 104]
  mov ebx, [edi + 108]
  mov eax, [edi + 112]
  mov ebx, [edi + 116]
  mov eax, [edi + 120]
  mov ebx, [edi + 124]

  add esi, 32
  add edi, 128
  cmp edx, esi              ; bounds check, expects size to be multiple of 64 elements
  jge scalar_read32_pass_loop

  ; zero the index, get back to start, decrement iteration count
  xor esi, esi
  lea edi, [ecx + esi * 4]
  dec dword [esp + 24]
  jnz scalar_read32_pass_loop
  pop edi
  pop esi
  pop edx
  pop ecx
  pop ebx

  mov eax, [esp]
  mov [esp + 4], eax
  add esp, 4
  fld1
  ret
