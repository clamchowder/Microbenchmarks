__kernel void atomic_exec_latency_test(__global int* A, int count, __global int* ret) {
    int current = get_global_id(0) + 1;
    while (current <= 2 * count) {
        if (atomic_cmpxchg(A, current - 1, current) == current - 1) {
            current += 2;
        }
    }
}