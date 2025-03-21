// unrolled until terascale no longer saw further improvement (10x unroll)
// assumes count will be a multiple of 10. but it won't be too inaccurate with a big count
// not divisible by 10
__kernel void unrolled_latency_test(__global const int* A, int count, __global int* ret) {
    int current = get_global_size(0) > 1 ? ret[get_global_id(0)]: A[0]; // this will test vector latency on AMD. Set to A[0] for scalar latency
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

// A = sectioned pointer chasing array
// ret = holds per-thread start positions, or -1 for masked off
__kernel void mixed_latency_test(__global const int *A, int count, __global int *ret) {
    int current = ret[get_global_id(0)];
    int local_size = get_local_size(0);
    __local int finish[1];

    finish[0] = 0;
    barrier(CLK_LOCAL_MEM_FENCE);

    if (current < 0) return;

    // Array starts with shorter portion. That thread will exit only when the longer thread does
    if (current == 0) {
        int iter = 0;
        int catch = 0;
        int idx = get_global_id(0);
        int acc1 = 0, acc2 = 0, acc3 = 0, acc4 = 0;
        __global const int *A2 = A + local_size;
        __global const int *A3 = A + (local_size * 2);
        __global const int *A4 = A + (local_size * 3);
        while (finish[0] == 0) {
            idx = (idx + local_size) & 0x3FF; // 1024 ints * unroll factor, should fit in cache
            acc1 += A[idx];
            acc2 += A2[idx];
            acc3 += A3[idx];
            acc4 += A4[idx];
            iter += 4;
            if (atomic_cmpxchg(finish, 1, 2) == 1) break;
        }

        ret[get_global_id(0)] = iter;
        ret[1] = acc1 + acc2 + acc3 + acc4;
    } else {
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

        atomic_cmpxchg(finish, 0, 1);
        barrier(CLK_LOCAL_MEM_FENCE);
        ret[get_global_id(0)] = result;
    }
}