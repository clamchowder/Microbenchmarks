#define local_mem_bw_test_size 1024
__kernel void local_float4_bw_test(__global float4* A, uint count, __global float* ret) {
    __local float4 local_a[local_mem_bw_test_size];
    int threadId = get_global_id(0);
    int localId = get_local_id(0);
    int localSize = get_local_size(0);
    int groupId = get_group_id(0);
    float4 acc1 = A[get_global_id(0) & 0x3FF];
    float4 acc2 = A[(get_global_id(0) + 1) & 0x3FF];
    float4 acc3 = A[(get_global_id(0) + 2) & 0x3FF];
    float4 acc4 = A[(get_global_id(0) + 3) & 0x3FF];

    // workgroup-wide copy from global mem into local mem
    for (int i = get_local_id(0); i < local_mem_bw_test_size; i += get_local_size(0))
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);

    // assumes local memory size is at least 1024 float4s
    int idx0 = localId;
    int idx1 = localId + localSize;
    int idx2 = localId + localSize * 2;
    for (int i = 0; i < count; i += (12 * 4)) {
        acc1 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        acc2 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        acc3 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        acc4 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;
    }

    ret[threadId] = dot(acc1, acc2) + dot(acc3, acc4);
}

__kernel void mixed_float4_bw_test(__global float4* A, uint count, __global float* ret) {
    __local float4 local_a[local_mem_bw_test_size];
    int threadId = get_global_id(0);
    int localId = get_local_id(0);
    int localSize = get_local_size(0);
    int groupId = get_group_id(0);
    float4 acc1 = A[get_global_id(0) & 0x3FF];
    float4 acc2 = A[(get_global_id(0) + 1) & 0x3FF];
    float4 acc3 = A[(get_global_id(0) + 2) & 0x3FF];
    float4 acc4 = A[(get_global_id(0) + 3) & 0x3FF];
    float4 acc5 = A[(get_global_id(0) + 4) & 0x3FF];
    float4 acc6 = A[(get_global_id(0) + 5) & 0x3FF];
    float4 acc7 = A[(get_global_id(0) + 6) & 0x3FF];
    float4 acc8 = A[(get_global_id(0) + 7) & 0x3FF];

    // workgroup-wide copy from global mem into local mem
    for (int i = get_local_id(0);i < local_mem_bw_test_size; i += get_local_size(0))
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);

    // assumes local memory size is at least 1024 float4s
    int idx0 = localId;
    int idx1 = localId + localSize;
    int idx2 = localId + localSize * 2;
    for (int i = 0; i < count; i += (12*8)) { 
        acc1 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        acc5 += A[idx0] * A[idx1] + A[idx2];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        acc2 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        acc6 += A[idx0] * A[idx1] + A[idx2];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        acc3 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        acc7 += A[idx0] * A[idx1] + A[idx2];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        acc4 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        acc8 += A[idx0] * A[idx1] + A[idx2];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;
    }

    ret[threadId] = dot(acc1, acc2) + dot(acc3, acc4) + dot(acc5, acc6) + dot(acc7, acc8);
}