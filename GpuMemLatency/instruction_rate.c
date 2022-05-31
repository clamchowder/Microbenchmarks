#include "opencltest.h"

float fp64_instruction_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_double* A,
    cl_double* result);

float instruction_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float gOpsPerSec, totalOps;
    cl_int ret;
    int64_t time_diff_ms;
    int float4_element_count = local_size * 4;

    cl_program program = build_program(context, "instruction_rate_kernel.cl");
    cl_kernel int32_add_rate_kernel = clCreateKernel(program, "int32_add_rate_test", &ret);
    cl_kernel fp32_add_rate_kernel = clCreateKernel(program, "fp32_add_rate_test", &ret);

    float* A = (float*)malloc(sizeof(float) * float4_element_count * 4);
    float* result = (float*)malloc(sizeof(float) * 4 * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory instruction rate test\n");
    }

    fprintf(stderr, "Filling test array\n");
    // Integer test first
    uint32_t *int32_A = (uint32_t*)A;
    for (int i = 0; i < float4_element_count * 4; i++)
    {
        int32_A[i] = i + 1;
    }

    // copy array to device
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, float4_element_count * sizeof(float), NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, float4_element_count * sizeof(float), A, 0, NULL, NULL);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * 4 * thread_count, NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * 4 * thread_count, result, 0, NULL, NULL);

    // Set kernel arguments for int32_add_rate_test(__global uint4 *A, int count, __global int *ret)
    clSetKernelArg(int32_add_rate_kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(int32_add_rate_kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(int32_add_rate_kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue); // writes should be blocking, but are they?

    //fprintf(stderr, "Submitting int32 add kernel to command queue\n");
    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, int32_add_rate_kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit int32 add kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        gOpsPerSec = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue); 
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        gOpsPerSec = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();

    // each thread does iterations * (4 (int4) * 8 (8 per iteration) + 1 (loop inc)) adds
    totalOps = (float)chase_iterations * (4.0f * 8.0f + 1.0f) * (float)thread_count;
    gOpsPerSec = ((float)totalOps / 1e9) / ((float)time_diff_ms / 1000);

    fprintf(stderr, "%f G INT32 Adds/sec\n", gOpsPerSec);
    //fprintf(stderr, "chase iterations: %d, thread count: %d\n", chase_iterations, thread_count);
    //fprintf(stderr, "total ops: %f (%.2f G)\ntotal time: %llu ms\n", totalOps, totalOps / 1e9, time_diff_ms);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * 4 * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

    if (result[0] == 0) fprintf(stderr, "did not expect result[0] to be zero\n");

    // FP32 add test
    cl_float* fp32_A = (cl_float*)A;
    for (int i = 0; i < float4_element_count * 4; i++)
    {
        fp32_A[i] = 0.5f * i;
    }

    memset(result, 0, sizeof(float) * 4 * thread_count);

    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, float4_element_count * sizeof(float), A, 0, NULL, NULL);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * 4 * thread_count, result, 0, NULL, NULL);
    clSetKernelArg(fp32_add_rate_kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(fp32_add_rate_kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(fp32_add_rate_kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue);

    //fprintf(stderr, "Submitting fp32 add kernel to command queue\n");
    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, fp32_add_rate_kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit fp32 add kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        gOpsPerSec = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue);
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        gOpsPerSec = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();

    // each thread does iterations * (4 (int4) * 8 (8 per iteration) + 1 (loop inc)) adds
    totalOps = (float)chase_iterations * (4.0f * 8.0f + 1.0f) * (float)thread_count;
    gOpsPerSec = ((float)totalOps / 1e9) / ((float)time_diff_ms / 1000);

    fprintf(stderr, "%f G FP32 Adds/sec\n", gOpsPerSec);
    //fprintf(stderr, "chase iterations: %d, thread count: %d\n", chase_iterations, thread_count);
    //fprintf(stderr, "total ops: %f (%.2f G)\ntotal time: %llu ms\n", totalOps, totalOps / 1e9, time_diff_ms);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * 4 * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

    if (checkExtensionSupport("cl_khr_fp64")) {
        fp64_instruction_rate_test(context, command_queue, thread_count, local_size, chase_iterations, float4_element_count,
            a_mem_obj, result_obj, A, result);
    }
    else {
        fprintf(stderr, "FP64 extension not supported\n");
    }

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    return gOpsPerSec;
}

// taking out FP64 because some implementations don't support it
float fp64_instruction_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_double *A,
    cl_double *result)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float gOpsPerSec, totalOps;
    cl_int ret;
    int64_t time_diff_ms;

    // FP64 add test
    uint32_t low_chase_iterations = chase_iterations / 4;
    cl_double* fp64_A = (cl_float*)A;
    for (int i = 0; i < float4_element_count * 2; i++)
    {
        fp64_A[i] = 0.5f * i;
    }

    memset(result, 0, sizeof(float) * 4 * thread_count);

    cl_program program = build_program(context, "instruction_rate_fp64_kernel.cl");
    cl_kernel fp64_add_rate_kernel = clCreateKernel(program, "fp64_add_rate_test", &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, float4_element_count * sizeof(float), A, 0, NULL, NULL);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * 4 * thread_count, result, 0, NULL, NULL);
    clSetKernelArg(fp64_add_rate_kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(fp64_add_rate_kernel, 1, sizeof(cl_int), (void*)&low_chase_iterations);
    clSetKernelArg(fp64_add_rate_kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue);

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, fp64_add_rate_kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit fp64 add kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        gOpsPerSec = 0;
        return 0;
    }

    ret = clFinish(command_queue);
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        gOpsPerSec = 0;
        return 0;
    }

    time_diff_ms = end_timing();

    // each thread does iterations * (2 (double2) * 8 (8 per iteration) + 1 (loop inc)) adds
    totalOps = (float)low_chase_iterations * (2.0f * 8.0f + 1.0f) * (float)thread_count;
    gOpsPerSec = ((float)totalOps / 1e9) / ((float)time_diff_ms / 1000);

    fprintf(stderr, "%f G FP64 Adds/sec\n", gOpsPerSec);
    //fprintf(stderr, "chase iterations: %d, thread count: %d\n", chase_iterations, thread_count);
    //fprintf(stderr, "total ops: %f (%.2f G)\ntotal time: %llu ms\n", totalOps, totalOps / 1e9, time_diff_ms);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * 4 * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    return gOpsPerSec;
}