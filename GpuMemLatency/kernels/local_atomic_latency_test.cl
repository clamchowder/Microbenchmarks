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

#define local_atomic_add_wg_size 256
__kernel void local_atomic_add_test(__global int *A, int count) {
    __local int local_a[local_atomic_add_wg_size];
    local_a[get_local_id(0)] = A[get_global_id(0)];
    barrier(CLK_LOCAL_MEM_FENCE);

    int addend = get_global_id(0);
    int addend1 = addend + 5;
    int addend2 = addend + 6;
    int addend3 = addend + 7;
    int addend4 = addend + 8;
    int addend5 = addend + 9;
    int addend6 = addend + 10;
    int addend7 = addend + 11;
    __local int *target = local_a + get_local_id(0);
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

    A[get_global_id(0)] = local_a[get_local_id(0)];
}