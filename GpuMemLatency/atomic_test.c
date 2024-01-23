#include "opencltest.h"

float int_atomic_latency_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t iterations,
    short local,
    uint32_t *time_ms)
{
    cl_int ret;
    cl_int result = 0;
    size_t global_item_size = 2;
    size_t local_item_size = 1;
    float latency;
    uint32_t time_diff_ms;
    uint32_t A = 0;

    if (local)
    {
        local_item_size = 2;
    }

    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(uint32_t), NULL, &ret);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(cl_int), NULL, &result);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, sizeof(uint32_t), &A, 0, NULL, NULL);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(cl_int), &result, 0, NULL, NULL);
    clFinish(command_queue);
    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        latency = 0;
        goto cleanup;
    }
    clFinish(command_queue);
    time_diff_ms = end_timing();
    *time_ms = time_diff_ms;
    latency = (1e6 * (float)time_diff_ms / (float)(iterations)) / 2;

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    return latency;
}

float c2c_atomic_latency_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t iterations)
{
    cl_int ret;
    cl_int result = 0;
    size_t global_item_size;
    size_t local_item_size = 1;
    float latency;
    uint32_t time_diff_ms;
    uint32_t A;

    cl_uint cuCount = getCuCount();
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(uint32_t), NULL, &ret);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(cl_int), NULL, &ret);
    global_item_size = cuCount;

    float* result_arr = (float*)malloc(sizeof(float) * cuCount * cuCount);

    for (cl_int t1_idx = 0; t1_idx < cuCount; t1_idx++)
    {
        for (cl_int t2_idx = 0; t2_idx < cuCount; t2_idx++)
        {
            if (t1_idx == t2_idx) continue;
            fprintf(stderr, "Testing %d -> %d\n", t1_idx, t2_idx);
            A = 0;
            ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, sizeof(uint32_t), &A, 0, NULL, NULL);
            ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(cl_int), &result, 0, NULL, NULL);
            clFinish(command_queue);
            clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
            clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&iterations);
            clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
            clSetKernelArg(kernel, 3, sizeof(cl_int), (void*)&t1_idx);
            clSetKernelArg(kernel, 4, sizeof(cl_int), (void*)&t2_idx);

            start_timing();
            ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
            if (ret != CL_SUCCESS)
            {
                fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
                latency = 0;
                goto cleanup;
            }
            clFinish(command_queue);
            time_diff_ms = end_timing();
            latency = (1e6 * (float)time_diff_ms / (float)(iterations)) / 2;
            fprintf(stderr, "%d -> %d: %f\n", t1_idx, t2_idx, latency);
            result_arr[t1_idx * cuCount + t2_idx] = latency;
        }
    }

    for (cl_int i = 0; i < cuCount; i++)
    {
        printf(",%d", i);
    }
    printf("\n");

    for (cl_int t1_idx = 0; t1_idx < cuCount; t1_idx++)
    {
        printf("%d", t1_idx);
        for (cl_int t2_idx = 0; t2_idx < cuCount; t2_idx++)
        {
            if (t1_idx == t2_idx) printf(",x");
            else printf(",%f", result_arr[t1_idx * cuCount + t2_idx]);
        }
        printf("\n");
    }

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(result_arr);
    return latency;
}
