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

__kernel void sum_bw_test(__global float* A, int count, int size, __global int* ret) {
    int threadId = get_global_id(0);
    float result = 0;
    for (int i = 0, idx = threadId; i < count; i++, idx++) {
        if (idx >= size) idx = 0;
        result += A[i];
    }

    ret[threadId] = result;
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