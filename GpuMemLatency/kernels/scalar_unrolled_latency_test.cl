// Ensures the loaded value will be constant across a workgroup
__kernel void scalar_unrolled_latency_test(__global const uint* A, int count, __global uint* ret) {
    uint current = get_num_groups(0) > 1 ? ret[get_group_id(0) * get_local_size(0)]: A[0];
    uint result;
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