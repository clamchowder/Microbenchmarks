// unrolled until terascale no longer saw further improvement (10x unroll)
// assumes count will be a multiple of 10. but it won't be too inaccurate with a big count
// not divisible by 10
__kernel void unrolled_latency_test(__global const uint* A, int count, __global uint* ret) {
    uint current = get_global_size(0) > 1 ? ret[get_global_id(0)]: A[0]; // this will test vector latency on AMD. Set to A[0] for scalar latency
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