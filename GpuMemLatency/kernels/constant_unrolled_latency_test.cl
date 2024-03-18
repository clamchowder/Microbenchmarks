// latency test like the unrolled one above, but with input as constant memory
__kernel void constant_unrolled_latency_test(__constant const int* A, int count, __global int* ret) {
    //int current = A[0];
    int current = get_global_size(0) > 1 ? ret[get_global_id(0)]: A[0];
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