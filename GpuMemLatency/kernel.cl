// unused but here as a reference. suffers from loop overhead on AMD cards
__kernel void simple_latency_test(__global const int* A, int count, __global int* ret) {
    int current = A[0];
    int result;
    for (int i = 0; i < count; i++) {
        result += current;
        current = A[current];
    }

    ret[0] = result;
}

// Cacheline size in bytes, must correspond to what's defined for the latency test
#define CACHELINE_SIZE 64

// unrolled until terascale no longer saw further improvement (10x unroll)
// assumes count will be a multiple of 10. but it won't be too inaccurate with a big count
// not divisible by 10
__kernel void unrolled_latency_test(__global const int* A, int count, __global int* ret) {
    int current = A[0];
    int result;
    for (int i = 0; i < count; i += 10) {
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
    }

    ret[0] = result;
}

__kernel void unrolled_latency_test_amdvectorworkaround(__global const int* A, int count, __global int* ret) {
    int start = A[1 + get_local_id(0)];
    int current = A[start];
    int result;
    for (int i = 0; i < count; i += 10) {
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
    }

    ret[0] = result;
}

// Takes size as an additional argument, meant to run many pointer chasing threads in parallel
// Tries to measure a GPU's latency hiding ability at varying levels of parallelism
__kernel void parallel_latency_test(__global const int* A, int count, int size, __global int* ret) {
    size_t threadId = get_global_id(0);
    int current = A[threadId % size];
    int result = 0;
    for (int i = 0; i < count; i += 10) {
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
    }

    ret[threadId] = result;
}

// latency test like the unrolled one above, but with input as constant memory
__kernel void constant_unrolled_latency_test(__constant const int* A, int count, __global int* ret) {
    int current = A[0];
    int result;
    for (int i = 0; i < count; i += 10) {
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
        result += current;
        current = A[current];
    }

    ret[0] = result;
}

#define local_mem_test_size 1024
// uses local memory (LDS/shmem)
__kernel void local_unrolled_latency_test(__global const int* A, int count, __global int* ret) {
    __local int local_a[local_mem_test_size]; // 4 KB, should be present on all GPUs, amirite?
    // better be fast
    for (int i = get_local_id(0);i < local_mem_test_size; i += get_local_size(0))
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);

    // everyone else can chill/get masked off
    if (get_local_id(0) == 0) {
        int current = local_a[0];
        int result;
        for (int i = 0; i < count; i += 10) {
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
            result += current;
            current = local_a[current];
        }

        ret[0] = result;
    }
}


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

#define local_mem_bw_test_size 4096
// test bandwidth with local memory. A must be at least local_mem_bw_test_size in floats
__kernel void local_bw_test(__global uint* A, uint count, __global uint* ret) {
    __local uint local_a[local_mem_bw_test_size];
    int threadId = get_global_id(0);
    int localId = get_local_id(0);
    int localSize = get_local_size(0);
    int groupId = get_group_id(0);
    uint acc1 = 1;
    uint acc2 = 2;
    uint acc3 = 3;
    uint acc4 = 4;
    int max_idx = local_mem_bw_test_size - localSize * 4;

    // workgroup-wide copy from global mem into local mem
    for (int i = get_local_id(0);i < local_mem_bw_test_size; i += get_local_size(0))
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);

    // assumes local memory size is at least 1024 float4s
    int idx = localId;
    for (int i = 0; i < count; i += 6) { // 4x read-modify-write
        local_a[idx] += local_a[idx + localSize];
        local_a[idx + localSize * 2] += local_a[idx + localSize * 3];
        idx += localSize * 4;
        if (idx > max_idx) idx = localId;
    }

    ret[threadId] = local_a[localId];
}

// A = inputs, fixed size
__kernel void int_exec_latency_test(__global int* A, int count, __global int* ret) {
    int sum = 0;
    int input1 = A[0], input2 = A[1], input3 = A[2], input4 = A[3];
    for (int i = 0; i < count; i++) {
        sum += input1;
        sum += input2;
        sum += input3;
        sum += input4;
        sum += input1;
        sum += input2;
        sum += input3;
        sum += input4;
        sum += input1;
        sum += input2;
        sum += input3;
        sum += input4;
    }
}

// hoping each thread/workgroup lands on a different CU
// A = pointer to location being bounced around
// count = iterations
// ret = sink
// t1 = id of thread 1
// t2 = id of thread 2
__kernel void c2c_atomic_exec_latency_test(__global int* A, int count, __global int* ret, int t1, int t2) {
    int global_id = get_global_id(0);
    int current = 0;
    if (global_id == t1) current = 1;
    else if (global_id == t2) current = 2;

    if (global_id == t1 || global_id == t2) {
        //printf("gid: %d, t1: %d, t2: %d, A: %d, current = %d\n", global_id, t1, t2, *A, current);
        while (current <= 2 * count) {
            if (atomic_cmpxchg(A, current - 1, current) == current - 1) {
                current += 2;
            }
        }
        ret[0] = current;
    }
}

__kernel void atomic_exec_latency_test(__global int* A, int count, __global int* ret) {
    int current = get_global_id(0) + 1;
    while (current <= 2 * count) {
        if (atomic_cmpxchg(A, current - 1, current) == current - 1) {
            current += 2;
        }
    }
}

__kernel void local_atomic_latency_test(__global int* A, int count, __global int* ret) {
    __local int a[1];
    int current = get_global_id(0) + 1;
    if (current == 1) a[0] = A[0];
    barrier(CLK_LOCAL_MEM_FENCE);

    while (current <= 2 * count) {
        if (atomic_cmpxchg(a, current - 1, current) == current - 1) {
            current += 2;
        }
    }
}

__kernel void dummy_add(__global int* A) {
    A[get_global_id(0)]++;
}
