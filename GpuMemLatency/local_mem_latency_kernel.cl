// for testing total local memory capacity by seeing when threads can no longer overlap in time
// due to local mem capacity limits across the GPU
// calling code expected to define LATENCY_LOCAL_MEM_SIZE
__kernel void unrolled_latency_test_localmem(__global const int* A, int count, __global int* ret) {
    __local int local_a[LATENCY_LOCAL_MEM_SIZE];
    int start = A[0]; // this will test scalar latency, always
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
        local_a[i & (LATENCY_LOCAL_MEM_SIZE - 1)] = current;
    }

    ret[0] = local_a[current & (LATENCY_LOCAL_MEM_SIZE - 1)];
}
