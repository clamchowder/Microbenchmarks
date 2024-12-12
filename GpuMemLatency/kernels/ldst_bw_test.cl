#define ldst_bw_test_size 1024
// test load/store bandwidth with a small test size that should fit in L1
__kernel void ldst_bw_test(__global float* A, uint count, __global float* ret) {
    int threadId = get_global_id(0);
    int localId = get_local_id(0);
    int localSize = get_local_size(0);
    int groupId = get_group_id(0);
    float acc1 = 1.1;
    float acc2 = 2.2;
    float acc3 = 3.3;
    float acc4 = 4.4;

    // assumes local memory size is at least 1024 float4s
    int idx0 = localId;
    int idx1 = localId + localSize;
    int idx2 = localId + localSize * 2;
    for (int i = 0; i < count; i += 12) { 
        acc1 += A[idx0] * A[idx1] + A[idx2];
        acc2 += A[idx0 + 1] * A[idx1 + 1] + A[idx2 + 1];
        acc3 += A[idx0 + 2] * A[idx1 + 2] + A[idx2 + 2];
        acc4 += A[idx0 + 3] * A[idx1 + 3] + A[idx2 + 3];
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;
    }

    ret[threadId] = acc1 + acc2 + acc3 + acc4;
}