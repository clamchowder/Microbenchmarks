#define local_mem_bw_test_size 1024
// test bandwidth with local memory. A must be at least local_mem_bw_test_size in floats
__kernel void local_bw_test(__global float* A, uint count, __global float* ret) {
 __local float local_a[local_mem_bw_test_size];
    int threadId = get_global_id(0);
    int localId = get_local_id(0);
    int localSize = get_local_size(0);
    int groupId = get_group_id(0);
    float acc1 = 1.1;
    float acc2 = 2.2;
    float acc3 = 3.3;
    float acc4 = 4.4;

    //printf("subgroup size %d\n", get_sub_group_size());

    // workgroup-wide copy from global mem into local mem
    for (int i = get_local_id(0);i < local_mem_bw_test_size; i += get_local_size(0))
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);

    // assumes local memory size is at least 1024 float4s
    int idx0 = localId;
    int idx1 = localId + localSize;
    int idx2 = localId + localSize * 2;
    for (int i = 0; i < count; i += 12) { 
        acc1 += local_a[idx0] * local_a[idx1] + local_a[idx2];
        acc2 += local_a[idx0 + 1] * local_a[idx1 + 1] + local_a[idx2 + 1];
        acc3 += local_a[idx0 + 2] * local_a[idx1 + 2] + local_a[idx2 + 2];
        acc4 += local_a[idx0 + 3] * local_a[idx1 + 3] + local_a[idx2 + 3];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;
    }

    ret[threadId] = acc1 + acc2 + acc3 + acc4;
}