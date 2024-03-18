#define local64_test_size 2048 // size was given in 4B elements. This test uses 8B
__kernel void local_64_bw_test(__global ulong* A, uint count, __global ulong* ret) { 
    __local ulong local_a[local64_test_size];
    int threadId = get_global_id(0);
    int localId = get_local_id(0);
    int localSize = get_local_size(0);
    int groupId = get_group_id(0);

    // workgroup-wide copy from global mem into local mem
    for (int i = get_local_id(0);i < local64_test_size; i += get_local_size(0))
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);

    ulong acc0 = 0, acc1 = 0, acc2 = 0, acc3 = 0;

    // assumes local memory size is at least 512x 64-bit uints
    int idx0 = localId;
    int idx1 = localId + localSize;
    for (int i = 0; i < count; i += 8) { 
        acc0 ^= local_a[idx0];
        acc1 ^= local_a[idx1];
        acc2 ^= local_a[idx0 + 1];
        acc3 ^= local_a[idx1 + 1];
        idx0 = (idx0 + localSize) & 0x1FF;
        idx1 = (idx1 + localSize) & 0x1FF;
    }

    ret[threadId] = acc0 + acc1 + acc2 + acc3;
}
