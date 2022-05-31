#include "opencltest.h"

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

    FILE* fp = NULL;
    char* source_str;
    size_t source_size;
    fp = fopen("instruction_rate_kernel.cl", "r");
    if (!fp) {
        fprintf(stderr, "Failed to load kernel.\n");
        exit(1);
    }
    source_str = (char*)malloc(MAX_SOURCE_SIZE);
    source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);
    fclose(fp);

    cl_program program = clCreateProgramWithSource(context, 1, (const char**)&source_str, (const size_t*)&source_size, &ret);
    ret = clBuildProgram(program, 1, &selected_device_id, NULL, NULL, NULL);
    fprintf(stderr, "clBuildProgram for instruction rate returned %d\n", ret);
    if (ret == -11)
    {
        size_t log_size;
        fprintf(stderr, "OpenCL kernel build error\n");
        clGetProgramBuildInfo(program, selected_device_id, CL_PROGRAM_BUILD_LOG, 0, NULL, &log_size);
        char* log = (char*)malloc(log_size);
        clGetProgramBuildInfo(program, selected_device_id, CL_PROGRAM_BUILD_LOG, log_size, log, NULL);
        fprintf(stderr, "%s\n", log);
        free(log);
    }

    cl_kernel int32_add_rate_kernel = clCreateKernel(program, "int32_add_rate_test", &ret);

    float* A = (float*)malloc(sizeof(float) * float4_element_count);
    float* result = (float*)malloc(sizeof(float) * 4 * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory instruction rate test\n");
    }

    fprintf(stderr, "Filling test array\n");
    // Integer test first
    uint32_t *int32_A = (uint32_t*)A;
    for (int i = 0; i < float4_element_count; i++)
    {
        int32_A[i] = i + 1;
    }

    fprintf(stderr, "Copying test arrays to device\n");
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

    fprintf(stderr, "Submitting int32 add kernel to command queue\n");
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
    totalOps = chase_iterations * (4 * 8 + 1) * thread_count;
    gOpsPerSec = ((float)totalOps / 1e9) / ((float)time_diff_ms / 1000);

    fprintf(stderr, "%f G INT32 Adds/sec\n", gOpsPerSec);
    fprintf(stderr, "total ops: %f\ntotal time: %llu ms\n", totalOps, time_diff_ms);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * 4 * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);


cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    free(source_str);
    return gOpsPerSec;
}
