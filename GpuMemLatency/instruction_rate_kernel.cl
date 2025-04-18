#define rate_local_mem_test_size 512

// A must be at least (local size * 4) uint32 elements in size, but must not exceed local mem size
// jk it doesn't use local mem now
__kernel void int32_add_rate_test(__global uint4 *A, int count, __global uint4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);

    __local uint4 local_a[rate_local_mem_test_size];
    for (int i = tid;i < rate_local_mem_test_size; i += max_offset)
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);
    // __global uint4 *local_a = A;

    int masked_tid = min(tid, rate_local_mem_test_size - 8);
    uint4 v0 = local_a[masked_tid];
    uint4 v1 = local_a[masked_tid + 1];
    uint4 v2 = local_a[masked_tid + 2];
    uint4 v3 = local_a[masked_tid + 3];
    uint4 v4 = local_a[masked_tid + 4];
    uint4 v5 = local_a[masked_tid + 5];
    uint4 v6 = local_a[masked_tid + 6];
    uint4 v7 = local_a[masked_tid + 7];

    for (int i = 0; i < count; i++) {
        uint4 acc = local_a[i & (rate_local_mem_test_size - 1)];
        v0 += acc;
        v1 += acc;
        v2 += acc;
        v3 += acc;
        v4 += acc;
        v5 += acc;
        v6 += acc;
        v7 += acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void int32_mul_rate_test(__global uint4 *A, int count, __global uint4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global uint4 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    uint4 v0 = local_a[masked_tid];
    uint4 v1 = local_a[masked_tid + 1];
    uint4 v2 = local_a[masked_tid + 2];
    uint4 v3 = local_a[masked_tid + 3];
    uint4 v4 = v0 + v1;
    uint4 v5 = v0 + v2;
    uint4 v6 = v0 + v3;
    uint4 v7 = v1 + v2;
    uint4 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        //uint4 acc = local_a[i & (rate_local_mem_test_size) - 1];
        v0 *= acc;
        v1 *= acc;
        v2 *= acc;
        v3 *= acc;
        v4 *= acc;
        v5 *= acc;
        v6 *= acc;
        v7 *= acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp32_add_rate_test(__global float4 *A, int count, __global float4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float4 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float4 v0 = local_a[masked_tid];
    float4 v1 = local_a[masked_tid + 1];
    float4 v2 = local_a[masked_tid + 2];
    float4 v3 = local_a[masked_tid + 3];
    float4 v4 = v0 + v1;
    float4 v5 = v0 + v2;
    float4 v6 = v0 + v3;
    float4 v7 = v1 + v2;
    float4 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        //float4 acc = local_a[i & (rate_local_mem_test_size) - 1];
        v0 += acc;
        v1 += acc;
        v2 += acc;
        v3 += acc;
        v4 += acc;
        v5 += acc;
        v6 += acc;
        v7 += acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp32_rcp_rate_test(__global float4 *A, int count, __global float4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float4 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float4 v0 = local_a[masked_tid];
    float4 v1 = local_a[masked_tid + 1];
    float4 v2 = local_a[masked_tid + 2];
    float4 v3 = local_a[masked_tid + 3];
    float4 v4 = v0 + v1;
    float4 v5 = v0 + v2;
    float4 v6 = v0 + v3;
    float4 v7 = v1 + v2;
    float4 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        v0 = native_recip(v0);
        v1 = native_recip(v1);
        v2 = native_recip(v2);
        v3 = native_recip(v3);
        v4 = native_recip(v4);
        v5 = native_recip(v5);
        v6 = native_recip(v6);
        v7 = native_recip(v7);
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp32_rsqrt_rate_test(__global float4 *A, int count, __global float4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float4 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float4 v0 = local_a[masked_tid];
    float4 v1 = local_a[masked_tid + 1];
    float4 v2 = local_a[masked_tid + 2];
    float4 v3 = local_a[masked_tid + 3];
    float4 v4 = v0 + v1;
    float4 v5 = v0 + v2;
    float4 v6 = v0 + v3;
    float4 v7 = v1 + v2;
    float4 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        v0 = native_rsqrt(v0);
        v1 = native_rsqrt(v1);
        v2 = native_rsqrt(v2);
        v3 = native_rsqrt(v3);
        v4 = native_rsqrt(v4);
        v5 = native_rsqrt(v5);
        v6 = native_rsqrt(v6);
        v7 = native_rsqrt(v7);
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void int64_add_rate_test(__global ulong2 *A, int count, __global ulong2 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global ulong2 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    ulong2 v0 = local_a[masked_tid];
    ulong2 v1 = local_a[masked_tid + 1];
    ulong2 v2 = local_a[masked_tid + 2];
    ulong2 v3 = local_a[masked_tid + 3];
    ulong2 v4 = v0 + v1;
    ulong2 v5 = v0 + v2;
    ulong2 v6 = v0 + v3;
    ulong2 v7 = v1 + v2;
    ulong2 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        //uint4 acc = local_a[i & (rate_local_mem_test_size) - 1];
        v0 += acc;
        v1 += acc;
        v2 += acc;
        v3 += acc;
        v4 += acc;
        v5 += acc;
        v6 += acc;
        v7 += acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void int64_mul_rate_test(__global ulong2 *A, int count, __global ulong2 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global ulong2 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    ulong2 v0 = local_a[masked_tid];
    ulong2 v1 = local_a[masked_tid + 1];
    ulong2 v2 = local_a[masked_tid + 2];
    ulong2 v3 = local_a[masked_tid + 3];
    ulong2 v4 = v0 + v1;
    ulong2 v5 = v0 + v2;
    ulong2 v6 = v0 + v3;
    ulong2 v7 = v1 + v2;
    ulong2 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        //uint4 acc = local_a[i & (rate_local_mem_test_size) - 1];
        v0 *= acc;
        v1 *= acc;
        v2 *= acc;
        v3 *= acc;
        v4 *= acc;
        v5 *= acc;
        v6 *= acc;
        v7 *= acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}


__kernel void mix_fp32_int32_add_rate_test(__global float4 *A, int count, __global float4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    
    __local int4 local_a[rate_local_mem_test_size];
    for (int i = tid;i < rate_local_mem_test_size; i += max_offset)
        local_a[i] = convert_int4_sat(A[i]);
    barrier(CLK_LOCAL_MEM_FENCE); 

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float4 v0 = A[masked_tid];
    float4 v1 = A[masked_tid + 1];
    float4 v2 = A[masked_tid + 2];
    float4 v3 = A[masked_tid + 3];
    int4 v4 = convert_int4_sat(v0 + v1);
    int4 v5 = convert_int4_sat(v0 + v2);
    int4 v6 = convert_int4_sat(v0 + v3);
    int4 v7 = convert_int4_sat(v1 + v2);
    float4 fp_acc = A[0];

    for (int i = 0; i < count; i++) {
	int4 int_acc = local_a[i & (rate_local_mem_test_size - 1)];
        v0 += fp_acc;
        v1 += fp_acc;
        v2 += fp_acc;
        v3 += fp_acc;
        v4 += int_acc;
        v5 += int_acc;
        v6 += int_acc;
        v7 += int_acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + convert_float4(v4 + v5 + v6 + v7);
}

__kernel void mix_fp32_int32_addmul_rate_test(__global float4 *A, int count, __global float4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float4 *fp32_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float4 v0 = fp32_a[masked_tid];
    float4 v1 = fp32_a[masked_tid + 1];
    float4 v2 = fp32_a[masked_tid + 2];
    float4 v3 = fp32_a[masked_tid + 3];
    int4 v4 = convert_int4_sat(v0 + v1);
    int4 v5 = convert_int4_sat(v0 + v2);
    int4 v6 = convert_int4_sat(v0 + v3);
    int4 v7 = convert_int4_sat(v1 + v2);
    float4 fp_acc = fp32_a[0];
    int4 int_acc = convert_int4_sat(fp32_a[0]);

    for (int i = 0; i < count; i++) {
        v0 += fp_acc;
        v1 += fp_acc;
        v2 += fp_acc;
        v3 += fp_acc;
        v4 *= int_acc;
        v5 *= int_acc;
        v6 *= int_acc;
        v7 *= int_acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + convert_float4(v4 + v5 + v6 + v7);
}

__kernel void fp32_fma_rate_test(__global float4 *A, int count, __global float4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float4 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float4 v0 = local_a[masked_tid];
    float4 v1 = local_a[masked_tid + 1];
    float4 v2 = local_a[masked_tid + 2];
    float4 v3 = local_a[masked_tid + 3];
    float4 v4 = local_a[masked_tid + 4];
    float4 v5 = local_a[masked_tid + 5];
    float4 v6 = local_a[masked_tid + 6];
    float4 v7 = local_a[masked_tid + 7];
    float4 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        v0 += acc * v0;
        v1 += acc * v1;
        v2 += acc * v2;
        v3 += acc * v3;
        v4 += acc * v4;
        v5 += acc * v5;
        v6 += acc * v6;
        v7 += acc * v7;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp32_builtin_fma_rate_test(__global float4 *A, int count, __global float4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float4 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float4 v0 = local_a[masked_tid];
    float4 v1 = local_a[masked_tid + 1];
    float4 v2 = local_a[masked_tid + 2];
    float4 v3 = local_a[masked_tid + 3];
    float4 v4 = local_a[masked_tid + 4];
    float4 v5 = local_a[masked_tid + 5];
    float4 v6 = local_a[masked_tid + 6];
    float4 v7 = local_a[masked_tid + 7];
    float4 acc = local_a[0];

    for (int i = 0; i < count; i++) {
	v0 = fma(acc, v0, v0);
	v1 = fma(acc, v1, v1);
	v2 = fma(acc, v2, v2);
	v3 = fma(acc, v3, v3);
	v4 = fma(acc, v4, v4);
	v5 = fma(acc, v5, v5);
	v6 = fma(acc, v6, v6);
	v7 = fma(acc, v7, v7);
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp32_mad_rate_test(__global float4 *A, int count, __global float4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float4 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float4 v0 = local_a[masked_tid];
    float4 v1 = local_a[masked_tid + 1];
    float4 v2 = local_a[masked_tid + 2];
    float4 v3 = local_a[masked_tid + 3];
    float4 v4 = v0 + v1;
    float4 v5 = v0 + v2;
    float4 v6 = v0 + v3;
    float4 v7 = v1 + v2;
    float4 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        //float4 acc = local_a[i & (rate_local_mem_test_size) - 1];
        v0 = mad(acc, v0, v0);
        v1 = mad(acc, v1, v1);
        v2 = mad(acc, v2, v2);
        v3 = mad(acc, v3, v3);
        v4 = mad(acc, v4, v4);
        v5 = mad(acc, v5, v5);
        v6 = mad(acc, v6, v6);
        v7 = mad(acc, v7, v7);
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void int16_add_rate_test(__global short8 *A, int count, __global short8 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    //__global short8 *local_a = A;

    __local short8 local_a[rate_local_mem_test_size];
    for (int i = tid;i < rate_local_mem_test_size; i += max_offset)
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE); 

    int masked_tid = min(tid, rate_local_mem_test_size - 8);
    short8 v0 = local_a[masked_tid];
    short8 v1 = local_a[masked_tid + 1];
    short8 v2 = local_a[masked_tid + 2];
    short8 v3 = local_a[masked_tid + 3];
    short8 v4 = local_a[masked_tid + 4];
    short8 v5 = local_a[masked_tid + 5];
    short8 v6 = local_a[masked_tid + 6];
    short8 v7 = local_a[masked_tid + 7];

    for (int i = 0; i < count; i++) {
	short8 acc = local_a[i & (rate_local_mem_test_size - 1)];
        v0 += acc;
        v1 += acc;
        v2 += acc;
        v3 += acc;
        v4 += acc;
        v5 += acc;
        v6 += acc;
        v7 += acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void int16_mul_rate_test(__global short8 *A, int count, __global short8 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    //__global short8 *local_a = A;

    __local short8 local_a[rate_local_mem_test_size];
    for (int i = tid;i < rate_local_mem_test_size; i += max_offset)
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);  

    int masked_tid = min(tid, rate_local_mem_test_size - 8);
    short8 v0 = local_a[masked_tid];
    short8 v1 = local_a[masked_tid + 1];
    short8 v2 = local_a[masked_tid + 2];
    short8 v3 = local_a[masked_tid + 3];
    short8 v4 = local_a[masked_tid + 4];
    short8 v5 = local_a[masked_tid + 5];
    short8 v6 = local_a[masked_tid + 6]; 
    short8 v7 = local_a[masked_tid + 7];

    for (int i = 0; i < count; i++) {
	short8 acc = local_a[i & (rate_local_mem_test_size - 1)];
        v0 *= acc;
        v1 *= acc;
        v2 *= acc;
        v3 *= acc;
        v4 *= acc;
        v5 *= acc;
        v6 *= acc;
        v7 *= acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void int8_add_rate_test(__global char16 *A, int count, __global char16 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global char16 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    char16 v0 = local_a[masked_tid];
    char16 v1 = local_a[masked_tid + 1];
    char16 v2 = local_a[masked_tid + 2];
    char16 v3 = local_a[masked_tid + 3];
    char16 v4 = v0 + v1;
    char16 v5 = v0 + v2;
    char16 v6 = v0 + v3;
    char16 v7 = v1 + v2;
    char16 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        v0 += acc;
        v1 += acc;
        v2 += acc;
        v3 += acc;
        v4 += acc;
        v5 += acc;
        v6 += acc;
        v7 += acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void int8_mul_rate_test(__global char16 *A, int count, __global char16 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global char16 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    char16 v0 = local_a[masked_tid];
    char16 v1 = local_a[masked_tid + 1];
    char16 v2 = local_a[masked_tid + 2];
    char16 v3 = local_a[masked_tid + 3];
    char16 v4 = v0 + v1;
    char16 v5 = v0 + v2;
    char16 v6 = v0 + v3;
    char16 v7 = v1 + v2;
    char16 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        v0 *= acc;
        v1 *= acc;
        v2 *= acc;
        v3 *= acc;
        v4 *= acc;
        v5 *= acc;
        v6 *= acc;
        v7 *= acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp32_fma_latency_test(__global float *A, int count, __global float *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float v0 = local_a[masked_tid];
    float v1 = local_a[masked_tid + 1];
    float v2 = local_a[masked_tid + 2];
    float v3 = local_a[masked_tid + 3];
    float v4 = v0 + v1;
    float v5 = v0 + v2;
    float v6 = v0 + v3;
    float v7 = v1 + v2;
    float acc = local_a[0];

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 + acc * v0;
        v1 = v0 + acc * v1;
        v2 = v1 + acc * v2;
        v3 = v2 + acc * v3;
        v4 = v3 + acc * v4;
        v5 = v4 + acc * v5;
        v6 = v5 + acc * v6;
        v7 = v6 + acc * v7;

        v0 = v7 + acc * v0;
        v1 = v0 + acc * v1;
        v2 = v1 + acc * v2;
        v3 = v2 + acc * v3;
        v4 = v3 + acc * v4;
        v5 = v4 + acc * v5;
        v6 = v5 + acc * v6;
        v7 = v6 + acc * v7;

        v0 = v7 + acc * v0;
        v1 = v0 + acc * v1;
        v2 = v1 + acc * v2;
        v3 = v2 + acc * v3;
        v4 = v3 + acc * v4;
        v5 = v4 + acc * v5;
        v6 = v5 + acc * v6;
        v7 = v6 + acc * v7;

        v0 = v7 + acc * v0;
        v1 = v0 + acc * v1;
        v2 = v1 + acc * v2;
        v3 = v2 + acc * v3;
        v4 = v3 + acc * v4;
        v5 = v4 + acc * v5;
        v6 = v5 + acc * v6;
        v7 = v6 + acc * v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));


    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}

__kernel void int32_add_scalar_latency_test(__global uint *A, int count, __global uint *ret) {
    int tid = 0;
    int max_offset = get_local_size(0);

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    uint v0 = A[masked_tid];
    uint v1 = A[masked_tid + 1];
    uint v2 = A[masked_tid + 2];
    uint v3 = A[masked_tid + 3];
    uint v4 = v0 + v1;
    uint v5 = v0 + v2;
    uint v6 = v0 + v3;
    uint v7 = v1 + v2;

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[0] = v0 + v1;
    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}

__kernel void fp32_mul_latency_test(__global float *A, int count, __global float *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float v0 = local_a[masked_tid];
    float v1 = local_a[masked_tid + 1];
    float v2 = local_a[masked_tid + 2];
    float v3 = local_a[masked_tid + 3];
    float v4 = v0 + v1;
    float v5 = v0 + v2;
    float v6 = v0 + v3;
    float v7 = v1 + v2;
    float acc = local_a[0];

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;

    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}
 
__kernel void fp32_mul_scalar_latency_test(__global float *A, int count, __global float *ret) {
    int tid = 0;
    int max_offset = get_local_size(0);
    __global float *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float v0 = local_a[masked_tid];
    float v1 = local_a[masked_tid + 1];
    float v2 = local_a[masked_tid + 2];
    float v3 = local_a[masked_tid + 3];
    float v4 = v0 + v1;
    float v5 = v0 + v2;
    float v6 = v0 + v3;
    float v7 = v1 + v2;
    float acc = local_a[0];

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;

    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}

__kernel void fp32_add_scalar_latency_test(__global float *A, int count, __global float *ret) {
    int tid = 0;
    int max_offset = get_local_size(0);
    __global float *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float v0 = local_a[masked_tid];
    float v1 = local_a[masked_tid + 1];
    float v2 = local_a[masked_tid + 2];
    float v3 = local_a[masked_tid + 3];
    float v4 = v0 + v1;
    float v5 = v0 + v2;
    float v6 = v0 + v3;
    float v7 = v1 + v2;
    float acc = local_a[0];

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 8) {
        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[get_global_id(0)] = v0 + v1;
    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}

__kernel void fp32_fma_scalar_latency_test(__global float *A, int count, __global float *ret) {
    int tid = 0;
    int max_offset = get_local_size(0);
    __global float *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float v0 = local_a[masked_tid];
    float v1 = local_a[masked_tid + 1];
    float v2 = local_a[masked_tid + 2];
    float v3 = local_a[masked_tid + 3];
    float v4 = v0 + v1;
    float v5 = v0 + v2;
    float v6 = v0 + v3;
    float v7 = v1 + v2;
    float acc = local_a[0];

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 + acc * v0;
        v1 = v0 + acc * v1;
        v2 = v1 + acc * v2;
        v3 = v2 + acc * v3;
        v4 = v3 + acc * v4;
        v5 = v4 + acc * v5;
        v6 = v5 + acc * v6;
        v7 = v6 + acc * v7;

        v0 = v7 + acc * v0;
        v1 = v0 + acc * v1;
        v2 = v1 + acc * v2;
        v3 = v2 + acc * v3;
        v4 = v3 + acc * v4;
        v5 = v4 + acc * v5;
        v6 = v5 + acc * v6;
        v7 = v6 + acc * v7;

        v0 = v7 + acc * v0;
        v1 = v0 + acc * v1;
        v2 = v1 + acc * v2;
        v3 = v2 + acc * v3;
        v4 = v3 + acc * v4;
        v5 = v4 + acc * v5;
        v6 = v5 + acc * v6;
        v7 = v6 + acc * v7;

        v0 = v7 + acc * v0;
        v1 = v0 + acc * v1;
        v2 = v1 + acc * v2;
        v3 = v2 + acc * v3;
        v4 = v3 + acc * v4;
        v5 = v4 + acc * v5;
        v6 = v5 + acc * v6;
        v7 = v6 + acc * v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[get_global_id(0)] = v0;
    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}

__kernel void fp32_add_latency_test(__global float *A, int count, __global float *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float v0 = local_a[masked_tid];
    float v1 = local_a[masked_tid + 1];
    float v2 = local_a[masked_tid + 2];
    float v3 = local_a[masked_tid + 3];
    float v4 = v0 + v1;
    float v5 = v0 + v2;
    float v6 = v0 + v3;
    float v7 = v1 + v2;
    float acc = local_a[0];

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;

    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}

__kernel void int32_add_latency_test(__global uint *A, int count, __global uint *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    uint v0 = A[masked_tid];
    uint v1 = A[masked_tid + 1];
    uint v2 = A[masked_tid + 2];
    uint v3 = A[masked_tid + 3];
    uint v4 = v0 + v1;
    uint v5 = v0 + v2;
    uint v6 = v0 + v3;
    uint v7 = v1 + v2;
    
    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;

        v0 = v7 + v0;
        v1 = v0 + v1;
        v2 = v1 + v2;
        v3 = v2 + v3;
        v4 = v3 + v4;
        v5 = v4 + v5;
        v6 = v5 + v6;
        v7 = v6 + v7;
    }

    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[7] = v6 + v7;
    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
}

__kernel void int32_mul_latency_test(__global uint *A, int count, __global uint *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global uint *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    uint v0 = local_a[masked_tid];
    uint v1 = local_a[masked_tid + 1];
    uint v2 = local_a[masked_tid + 2];
    uint v3 = local_a[masked_tid + 3];
    uint v4 = v0 + v1;
    uint v5 = v0 + v2;
    uint v6 = v0 + v3;
    uint v7 = v1 + v2;
    uint acc = local_a[0];

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}

__kernel void int32_mul_scalar_latency_test(__global uint *A, int count, __global uint *ret) {
    int tid = 0;
    int max_offset = get_local_size(0);
    __global uint *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    uint v0 = local_a[masked_tid];
    uint v1 = local_a[masked_tid + 1];
    uint v2 = local_a[masked_tid + 2];
    uint v3 = local_a[masked_tid + 3];
    uint v4 = v0 + v1;
    uint v5 = v0 + v2;
    uint v6 = v0 + v3;
    uint v7 = v1 + v2;
    uint acc = local_a[0];

    uint clk_lo = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    for (int i = 0; i < count; i += 4) {
        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;

        v0 = v7 * v0;
        v1 = v0 * v1;
        v2 = v1 * v2;
        v3 = v2 * v3;
        v4 = v3 * v4;
        v5 = v4 * v5;
        v6 = v5 * v6;
        v7 = v6 * v7;
    }

    uint clk_lo_after = __builtin_amdgcn_s_getreg(29 | (31U << 11));
    uint clk_hi_after = __builtin_amdgcn_s_getreg(30 | (31U << 11));
    uint hwid_after = __builtin_amdgcn_s_getreg(23 | (31U << 11));

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
    __global uint *ret_as_int = (__global uint *)ret;
    ret_as_int[1] = hwid;
    ret_as_int[2] = clk_lo;
    ret_as_int[3] = clk_hi;
    ret_as_int[4] = clk_lo_after;
    ret_as_int[5] = clk_hi_after;
    ret_as_int[6] = hwid_after;
    ret_as_int[7] = 123;
}

__kernel void fp32_divergence_rate_test(__global float *A, int count, __global float *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float v0 = local_a[masked_tid];
    float v1 = local_a[masked_tid + 1];
    float v2 = local_a[masked_tid + 2];
    float v3 = local_a[masked_tid + 3];
    float v4 = v0 + v1;
    float v5 = v0 + v2;
    float v6 = v0 + v3;
    float v7 = v1 + v2;
    float acc = A[0];
    float op = A[get_global_id(0)];

    if (op < 1.0) {
        for (int i = 0; i < count; i++) {
            if (op < 0.5) {
                v0 += acc;
                v1 += acc;
                v2 += acc;
                v3 += acc;
                v4 += acc;
                v5 += acc;
                v6 += acc;
                v7 += acc;
            }
            else
            {
                v0 *= acc;
                v1 *= acc;
                v2 *= acc;
                v3 *= acc;
                v4 *= acc;
                v5 *= acc;
                v6 *= acc;
                v7 *= acc;
            }
        }
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp32_partition_rate_test(__global float *A, int count, __global float *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global float *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    float v0 = local_a[masked_tid];
    float v1 = local_a[masked_tid + 1];
    float v2 = local_a[masked_tid + 2];
    float v3 = local_a[masked_tid + 3];
    float v4 = v0 + v1;
    float v5 = v0 + v2;
    float v6 = v0 + v3;
    float v7 = v1 + v2;
    float acc = A[0];
    float op = A[get_global_id(0)];

    if (op < 1.0) {
        for (int i = 0; i < count; i++) {
            v0 += acc;
            v1 += acc;
            v2 += acc;
            v3 += acc;
            v4 += acc;
            v5 += acc;
            v6 += acc;
            v7 += acc;
        }
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}
