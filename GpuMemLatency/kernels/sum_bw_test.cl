__kernel void sum_bw_test(__global float* A, uint count, uint float4size, __global float* ret, uint skip, __global uint *startPositions) {
    int threadId = get_global_id(0);
    int localId = get_local_id(0);
    int localSize = get_local_size(0);
    int groupId = get_group_id(0);
    float4 result1 = (0.1f,0.2f,0.3f,0.4f);
    float4 result2 = (1.1f,1.2f,1.3f,1.4f);
    float4 result3 = (2.1f,2.2f,2.3f,2.4f);
    float4 result4 = (3.0f,3.1f,3.2f,3.3f);
    float4 result5 = (4.0f,4.2f,4.1f,4.3f);

    int initialIdx = startPositions[threadId];
    //int initialIdx = (groupId * skip * localSize + localId) % (float4size - 1);
    //startPositions[threadId] = initialIdx; // for debugging

    int idx = initialIdx;
    __global float4 *B = (__global float4 *)A;
    for (int i = 0; i < count; i += 20) {
        result1 += B[idx];
        idx += localSize;
        if (idx >= float4size) idx = initialIdx;

        result2 += B[idx];
        idx += localSize;
        if (idx >= float4size) idx = initialIdx;

        result3 += B[idx];
        idx += localSize;
        if (idx >= float4size) idx = initialIdx;

        result4 += B[idx];
        idx += localSize;
        if (idx >= float4size) idx = initialIdx;

        result5 += B[idx];
        idx += localSize;
        if (idx >= float4size) idx = initialIdx;
    }

    ret[threadId] = dot(result1, result2) + dot(result3, result4) + dot(result4, result5);
}