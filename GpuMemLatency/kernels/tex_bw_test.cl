__constant sampler_t funny_sampler = CLK_NORMALIZED_COORDS_TRUE | // coordinates are from 0 to 1 (float)
                                        CLK_ADDRESS_REPEAT | // going out of bounds = replicate
                                        CLK_FILTER_NEAREST;
__kernel void tex_bw_test(__read_only image2d_t A, int count, __global float* ret) {
    int localId = get_local_id(0);
    float pos = get_global_id(0) * native_recip((float)get_global_size(0));
    float2 increment;
    increment.x = 0.01; // guessing
    increment.y = 0.01;

    float2 current0, current1, current2, current3;
    current0.x = pos;
    current0.y = pos;
    current1.x = 0.1 + (localId / 10000);
    current1.y = 0.1 + (localId / 10000);
    current2.x = 0.01 + (localId / 10000);
    current2.y = 0.01 + (localId / 10000);
    current3.x = 0.002 + (localId / 5000);
    current3.y = 0.001 + (localId / 5000);

    float4 tmp0 = read_imagef(A, funny_sampler, current0);
    float4 tmp1 = read_imagef(A, funny_sampler, current1);
    float4 tmp2 = read_imagef(A, funny_sampler, current2);
    float4 tmp3 = read_imagef(A, funny_sampler, current3);
    for (int i = 0; i < count; i += 4)
    {
        tmp0 += read_imagef(A, funny_sampler, current0);
        tmp1 += read_imagef(A, funny_sampler, current1);
        tmp2 += read_imagef(A, funny_sampler, current2);
        tmp3 += read_imagef(A, funny_sampler, current3);
        current0 += increment;
        current1 += increment;
        current2 += increment;
        current3 += increment;
    }

    *ret = dot(tmp0, tmp1) + dot(tmp2, tmp3);
}