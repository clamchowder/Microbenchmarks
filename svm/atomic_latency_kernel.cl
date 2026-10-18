__kernel void atomic_exec_latency_test(__global atomic_int* A, int count) {
    int current = 1;
    int expected = 0;
    while (current <= 2 * count) {
        /*if (atomic_cmpxchg(A, current - 1, current) == current - 1) {
            current += 2;
            // printf("gpu current = %d\n", current);
        } // else printf("A = %d wait for %d\n", *A, current - 1);*/
        expected = current - 1;
        if (atomic_compare_exchange_strong_explicit(A, &expected, current, memory_order_seq_cst, memory_order_seq_cst, memory_scope_all_svm_devices)) {
            current += 2;
        }
    }
}

__kernel void increment_on_gpu(__global int *A)
{
    *A = *A + 1;
}

// uses B to flush GL2
/*__kernel void flush_atomic_exec_latency_test(__global atomic_int* A, int count, __global float4 *B, int b_count_f32) {
    int current = 1;
    int global_id = get_global_id(0);
    int wave_add = 32; // use high half of wave64
    float4 va, vb;
    while (current <= 2 * count) {
        if (atomic_cmpxchg(A, current - 1, current) == current - 1) {
            current += 2;
            // printf("gpu current = %d\n", current);
        } else if (global_id >= wave_add) {
           // 8x float4
            for (int i = global_id - wave_add; i < b_count_f32 - (wave_add * 32); i += 32*wave_add) {
                float4 v0 = B[i];
                float4 v1 = B[i+wave_add];
                float4 v2 = B[i+(wave_add*2)];
                float4 v3 = B[i+(wave_add*3)];
                float4 v4 = B[i+(wave_add*4)];
                float4 v5 = B[i+(wave_add*5)];
                float4 v6 = B[i+(wave_add*6)];
                float4 v7 = B[i+(wave_add*7)];
                va = v0 + v1 + v2 + v3;
                vb = v4 * v5 + v6 + v7;
            }
        }
    }
    if (global_id >= wave_add) {
        B[global_id - wave_add] = va + vb;
    }
}*/