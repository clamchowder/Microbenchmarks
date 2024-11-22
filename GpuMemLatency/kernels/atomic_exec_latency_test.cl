__kernel void atomic_exec_latency_test(__global int* A, int count, __global int* ret) {
    int current = get_global_id(0) + 1;
    while (current <= 2 * count) {
        if (atomic_cmpxchg(A, current - 1, current) == current - 1) {
            current += 2;
        }
    }
}

__kernel void atomic_add_test(__global int *A, int count) {
    int addend = get_global_id(0);
    int addend1 = addend + 5;
    int addend2 = addend + 6;
    int addend3 = addend + 7;
    int addend4 = addend + 8;
    int addend5 = addend + 9;
    int addend6 = addend + 10;
    int addend7 = addend + 11;
    __global int *target = A + get_global_id(0);
    for (int i = 0; i < count; i++)
    {
        atomic_add(target, addend);
        atomic_add(target, addend1);
        atomic_add(target, addend2);
        atomic_add(target, addend3);
        atomic_add(target, addend4);
        atomic_add(target, addend5);
        atomic_add(target, addend6);
        atomic_add(target, addend7);
    }
}