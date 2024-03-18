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