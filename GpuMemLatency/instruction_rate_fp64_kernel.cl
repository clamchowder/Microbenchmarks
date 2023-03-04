#define rate_local_mem_test_size 256
__kernel void fp64_add_rate_test(__global double2 *A, int count, __global double2 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global double2 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    double2 v0 = local_a[masked_tid];
    double2 v1 = local_a[masked_tid + 1];
    double2 v2 = local_a[masked_tid + 2];
    double2 v3 = local_a[masked_tid + 3];
    double2 v4 = v0 + v1;
    double2 v5 = v0 + v2;
    double2 v6 = v0 + v3;
    double2 v7 = v1 + v2;
    double2 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        v0 += acc;
        v1 += acc;
        v2 += acc;
        v3 += acc;
        v4 += acc;
        v5 += acc;
        v6 += acc;
        v7 += acc;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp64_fma_rate_test(__global double2 *A, int count, __global double2 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global double2 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    double2 v0 = local_a[masked_tid];
    double2 v1 = local_a[masked_tid + 1];
    double2 v2 = local_a[masked_tid + 2];
    double2 v3 = local_a[masked_tid + 3];
    double2 v4 = v0 + v1;
    double2 v5 = v0 + v2;
    double2 v6 = v0 + v3;
    double2 v7 = v1 + v2;
    double2 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        v0 += acc * v0;
        v1 += acc * v1;
        v2 += acc * v2;
        v3 += acc * v3;
        v4 += acc * v4;
        v5 += acc * v5;
        v6 += acc * v6;
        v7 += acc * v7;
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}

__kernel void fp64_mad_rate_test(__global double2 *A, int count, __global double2 *ret) {
    int tid = get_local_id(0);
    int max_offset = get_local_size(0);
    __global double2 *local_a = A;

    int masked_tid = tid & (rate_local_mem_test_size - 1);
    double2 v0 = local_a[masked_tid];
    double2 v1 = local_a[masked_tid + 1];
    double2 v2 = local_a[masked_tid + 2];
    double2 v3 = local_a[masked_tid + 3];
    double2 v4 = v0 + v1;
    double2 v5 = v0 + v2;
    double2 v6 = v0 + v3;
    double2 v7 = v1 + v2;
    double2 acc = local_a[0];

    for (int i = 0; i < count; i++) {
        v0 = mad(acc, v0, v0);
        v1 = mad(acc, v1, v1);
        v2 = mad(acc, v2, v2);
        v3 = mad(acc, v3, v3);
        v4 = mad(acc, v4, v3);
        v5 = mad(acc, v5, v5);
        v6 = mad(acc, v6, v6);
        v7 = mad(acc, v7, v7);
    }

    ret[get_global_id(0)] = v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
}
