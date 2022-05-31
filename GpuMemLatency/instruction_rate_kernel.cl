#define rate_local_mem_test_size 256

// A must be at least (local size * 4) uint32 elements in size, but must not exceed local mem size
// jk it doesn't use local mem now
__kernel void int32_add_rate_test(__global uint4 *A, int count, __global uint4 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);

    /*__local uint4 local_a[rate_local_mem_test_size];
    for (int i = tid;i < rate_local_mem_test_size; i += max_offset)
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);*/
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
        v4 += int_acc;
        v5 += int_acc;
        v6 += int_acc;
        v7 += int_acc;
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
    float4 v4 = v0 + v1;
    float4 v5 = v0 + v2;
    float4 v6 = v0 + v3;
    float4 v7 = v1 + v2;
    float4 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        //float4 acc = local_a[i & (rate_local_mem_test_size) - 1];
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