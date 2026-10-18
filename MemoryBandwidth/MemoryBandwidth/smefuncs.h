#pragma once

#include <arm_neon.h>

#define CODEPAGE_SIZE 4096
uint32_t getsvl_instrs[] = {
	0xd10083ff, // sub sp, sp, 0x20
	0xf9000bed, // str x13, [sp,16]
	0xd503477f, // smstart
	0x04bf582d, // rdsvl, x13, 1
	0xaa0d03e0, // mov x0,x13
	0xd503467f, // smstop
	0xf9400bed, // ldr x13, [sp,16]
	0x910083ff, // add sp,sp, 0x20
	0xd65f03c0, // ret
};

// On SDXE2, gives 64 byte SVL (ZA is 64x64 bytes)
uint64_t getsvl() {
	uint32_t* dest_arr = (uint32_t*)VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
	memcpy(dest_arr, getsvl_instrs, sizeof(getsvl_instrs));
	
	uint64_t(*getsvl_func)(void) = (uint64_t(*)(void))dest_arr;
	uint64_t rc = getsvl_func();
	VirtualFree(dest_arr, 4096, MEM_RELEASE);
	return rc;
}

uint32_t sme_read_instrs[] = {
	0xd10203ff,
	0xa9013fee,
	0xa90237ec,
	0xa9032fea,
	0xa90423e9,
	0xa9051fe6,
	0xa90613e3,
	0x5280000c,
	0xaa0003ef,
	0x04bf582d,
	0xd37ef5a8,
	0xd37ceda9,
	0xd280000e,
	0xd503477f,
	0xe10001e0,
	0xe10001e1,
	0xe10001e2,
	0xe10001e3,
	0x8b0801ef,
	0x1100118c,
	0x6b0d019f,
	0x54ffff21,
	0x5280000c,
	0x8b0901ce,
	0xeb0101df,
	0x54fffeab,
	0xd280000e,
	0xaa0003ef,
	0xf1000442,
	0x54fffe2c,
	0xd503467f,
	0xa94613e3,
	0xa9051fe6,
	0xa94423e9,
	0xa9432fea,
	0xa94237ec,
	0xa9413fee,
	0x910203ff,
	0xd65f03c0
};

uint32_t sme_write_instrs[]{
0xd10203ff,
0xa9013fee,
0xa90237ec,
0xa9032fea,
0xa90423e9,
0xa9051fe6,
0xa90613e3,
0x5280000c,
0xaa0003ef,
0x04bf582d,
0xd37ef5a8,
0xd37ceda9,
0xd280000e,
0xd503477f,
0xe10001e0,
0xe10001e1,
0xe10001e2,
0xe10001e3,
0x1100118c,
0x6b0d019f,
0x54ffff41,
0x5280000c,
0xe12001e0,
0xe12001e1,
0xe12001e2,
0xe12001e3,
0x8b0801ef,
0x1100118c,
0x6b0d019f,
0x54ffff21,
0x5280000c,
0x8b0901ce,
0xeb0101df,
0x54fffeab,
0xd280000e,
0xaa0003ef,
0xf1000442,
0x54fffe2c,
0xd503467f,
0xa94613e3,
0xa9051fe6,
0xa94423e9,
0xa9432fea,
0xa94237ec,
0xa9413fee,
0x910203ff,
0xd65f03c0
};

float (*sme_read_func)(void*, uint64_t, uint64_t) = NULL;
float sme_read(void* arr, uint64_t arr_length, uint64_t iterations) {
	if (sme_read_func == NULL) {
		uint32_t* dest_arr = (uint32_t*)VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
		memcpy(dest_arr, sme_read_instrs, sizeof(sme_read_instrs));
		sme_read_func = (float(*)(void*, uint64_t, uint64_t))dest_arr;
	}

	__isb(_ARM64_BARRIER_SY);
	sme_read_func(arr, arr_length, iterations);
	return 5.0f;
}

float (*sme_write_func)(void*, uint64_t, uint64_t) = NULL;
float sme_write(void* arr, uint64_t arr_length, uint64_t iterations) {
	if (sme_write_func == NULL) {
		uint32_t* dest_arr = (uint32_t*)VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
		memcpy(dest_arr, sme_write_instrs, sizeof(sme_write_instrs));
		sme_write_func = (float(*)(void*, uint64_t, uint64_t))dest_arr;
	}

	__isb(_ARM64_BARRIER_SY);
	sme_write_func(arr, arr_length, iterations);
	return 5.0f;
}