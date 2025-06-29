#define fixed_tex_test_size 1024
__kernel void buffer_bw_test(__read_only image1d_buffer_t A, uint count, __global float* ret) {
    int threadId = get_global_id(0);
    int localId = get_local_id(0);
    int localSize = get_local_size(0);
    int groupId = get_group_id(0);
    uint4 acc1 = read_imageui(A, 0);
    uint4 acc2 = read_imageui(A, 1);
    uint4 acc3 = read_imageui(A, 2);
    uint4 acc4 = read_imageui(A, 3);

    int idx0 = localId;
    int idx1 = localId + localSize;
    int idx2 = localId + localSize * 2;

    // Each read_imageui reads out a 4-wide vector
    for (int i = 0; i < count; i += 16) {
        acc1 += read_imageui(A, idx0);
        acc2 += read_imageui(A, idx1);
        acc3 += read_imageui(A, idx2);
        acc4 += read_imageui(A, idx0 + 1);
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;
    }

    float4 out1 = convert_float4(acc1);
    float4 out2 = convert_float4(acc2);
    float4 out3 = convert_float4(acc3);
    float4 out4 = convert_float4(acc4);
    ret[threadId] = dot(out1, out2) + dot(out3, out4);
}

#define local_mem_bw_test_size 1024
__kernel void mixed_buffer_bw_test(__global float4* A, __read_only image1d_buffer_t buffer_A, uint count, __global float* ret) {
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
    for (int i = 0; i < count; i += (16*4)) {
        local_a[idx0] += read_imagef(buffer_A, idx1) * read_imagef(buffer_A, idx2); // 4 * (3R 1W)
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        local_a[idx0] += read_imagef(buffer_A, idx1) * read_imagef(buffer_A, idx2);
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        local_a[idx0] += read_imagef(buffer_A, idx1) * read_imagef(buffer_A, idx2);
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;

        local_a[idx0] += read_imagef(buffer_A, idx1) * read_imagef(buffer_A, idx2);
        idx0 = (idx0 + localSize) & 0x3FF;
        idx1 = (idx1 + localSize) & 0x3FF;
        idx2 = (idx2 + localSize) & 0x3FF;
    }

    ret[threadId] = dot(local_a[get_local_id(0)], local_a[get_local_id(0) + 1]);
}