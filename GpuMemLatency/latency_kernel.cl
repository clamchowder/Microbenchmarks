// unused but here as a reference. suffers from loop overhead on AMD cards
__kernel void simple_latency_test(__global const int* A, int count, __global int* ret) {
    int current = A[0];
    int result;
    for (int i = 0; i < count; i++)
    {
        result += current;
        current = A[current];
    }

    ret[0] = result;
}

// unrolled until terascale no longer saw further improvement (10x unroll)
// assumes count will be a multiple of 10. but it won't be too inaccurate with a big count
// not divisible by 10
__kernel void unrolled_latency_test(__global const int* A, int count, __global int* ret) {
    int current = A[0];
    int result;
    for (int i = 0; i < count; i += 10)
    {
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
__kernel void parallel_latency_test(__global int* A, int count, int size, __global int* ret) {
    size_t threadId = get_global_id(0);
    int current = A[threadId % size];
    int result = 0;
    if (count == 1) A[current] = 1;
    for (int i = 0; i < count; i += 10)
    {
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
    for (int i = 0; i < count; i += 10)
    {
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

__kernel void sum_bw_test(__global float* A, int count, int size, __global int* ret) {
    int threadId = get_global_id(0);
    float result = 0;
    for (int i = 0, idx = threadId; i < count; i++, idx++)
    {
        if (idx >= size) idx = 0;
        result += A[i];
    }

    ret[threadId] = result;
}