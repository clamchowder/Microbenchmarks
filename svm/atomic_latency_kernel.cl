__kernel void atomic_exec_latency_test(__global int* A, int count, __global int* ret) {
    int current = 1;
    while (current <= 2 * count) {
        if (atomic_cmpxchg(A, current - 1, current) == current - 1) {
            current += 2;
            // printf("gpu current = %d\n", current);
        } // else printf("A = %d wait for %d\n", *A, current - 1);
    }
}