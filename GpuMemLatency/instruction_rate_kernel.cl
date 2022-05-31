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