// hoping each thread/workgroup lands on a different CU
// A = pointer to location being bounced around
// count = iterations
// ret = sink
// t1 = id of thread 1
// t2 = id of thread 2
__kernel void c2c_atomic_exec_latency_test(__global int* A, int count, __global int* ret, int t1, int t2) {
    int global_id = get_global_id(0);
    int current = 0;
    if (global_id == t1) current = 1;
    else if (global_id == t2) current = 2;

    if (global_id == t1 || global_id == t2) {
        //printf("gid: %d, t1: %d, t2: %d, A: %d, current = %d\n", global_id, t1, t2, *A, current);
        while (current <= 2 * count) {
            if (atomic_cmpxchg(A, current - 1, current) == current - 1) {
                current += 2;
            }
        }
        ret[0] = current;
    }
}