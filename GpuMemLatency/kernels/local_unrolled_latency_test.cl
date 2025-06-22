#define local_mem_test_size 1024
// uses local memory (LDS/shmem)
__kernel void local_unrolled_latency_test(__global const uint* A, int count, __global uint* ret) {
    __local uint local_a[local_mem_test_size]; // 4 KB, should be present on all GPUs, amirite?
    // better be fast
    for (int i = get_local_id(0);i < local_mem_test_size; i += get_local_size(0))
        local_a[i] = A[i];
    barrier(CLK_LOCAL_MEM_FENCE);

    // everyone else can chill/get masked off
    if (get_local_id(0) == 0) {
        uint current = local_a[0];
        uint result;
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