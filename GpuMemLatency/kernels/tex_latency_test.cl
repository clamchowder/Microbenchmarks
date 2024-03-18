__kernel void tex_latency_test(__read_only image1d_buffer_t A, int count, __global int* ret, int list_size) {
    int localId = get_local_id(0);
    // uint4 current = read_imageui(A, direct_sampler, 0); // using sampler screws things up
    int startPos = get_global_size(0) > 1 ? ret[get_global_id(0)] : 0;
    uint4 current = read_imageui(A, startPos);
    // printf("start x: %u -> %u\n", startPos, current.x);
    for (int i = 0; i < count; i += 10) {
        // printf("current: %u %u %u %u, address: %d\n", current.x, current.y, current.z, current.w, (int)current.x / 4);
        //current = read_imageui(A, direct_sampler, i);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        current = read_imageui(A, current.x);
        //printf("%d: current read: %u %u %u %u\n", i, current.x, current.y, current.z, current.w);
        // local_a[localId] = current;
    }

    ret[get_global_id(0)] = current.x;
}
