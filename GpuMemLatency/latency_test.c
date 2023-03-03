#include "opencltest.h"

float latency_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t list_size,
    uint32_t chase_iterations,
    short sattolo,
    short amdworkaround)
{
    size_t global_item_size = 1, local_item_size = 1;
    cl_int ret;
    float latency;
    int64_t time_diff_ms;
    uint32_t result;
    uint32_t stride = 1211;
    uint32_t* A = (uint32_t*)malloc(sizeof(uint32_t) * list_size);
    memset(A, 0, sizeof(uint32_t) * list_size);
    if (sattolo) {
        FillPatternArr((uint32_t*)A, list_size, CACHELINE_SIZE);
    }
    else {
        for (int i = 0; i < list_size; i++)
        {
            A[i] = (i + stride) % list_size;
        }
    }

    if (amdworkaround)
    {
        local_item_size = 2;
        global_item_size = 2;
    }

    // copy array to device
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, list_size * sizeof(uint32_t), NULL, &ret);
    clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, list_size * sizeof(uint32_t), A, 0, NULL, NULL);

    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(uint32_t), NULL, &ret);
    clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t), &result, 0, NULL, NULL);
    clFinish(command_queue);

    // Set kernel arguments
    ret = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to set list as kernel arg. clSetKernelArg returned %d\n", ret);
        latency = 0;
        goto cleanup;
    }

    ret = clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    ret = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);

    start_timing();
    // Execute the OpenCL kernel. launch a single thread
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        latency = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        latency = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();
    latency = 1e6 * (float)time_diff_ms / (float)chase_iterations;

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t), &result, 0, NULL, NULL);
    clFinish(command_queue);

    //fprintf(stderr, "Finished reading result. Sum: %d\n", result[0]);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    return latency;
}

float tex_latency_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t list_size,
    uint32_t chase_iterations)
{
    size_t global_item_size = 1, local_item_size = 1;
    cl_int ret = 0;
    uint32_t result;
    cl_mem a_mem_obj = NULL, result_obj = NULL, tex_obj = NULL;
    float latency = 0;
    uint32_t* A = (uint32_t*)malloc(sizeof(uint32_t) * list_size);
    memset(A, 0, sizeof(uint32_t) * list_size);
    FillPatternArr((uint32_t*)A, list_size, CACHELINE_SIZE);

    // use buffer as texture
    a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, list_size * sizeof(uint32_t), NULL, &ret);
    clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, list_size * sizeof(uint32_t), A, 0, NULL, NULL);
    clFinish(command_queue);
    cl_image_format imageFormat;
    imageFormat.image_channel_data_type = CL_UNSIGNED_INT32;
    imageFormat.image_channel_order = CL_R;

    cl_image_desc imageDesc;
    memset(&imageDesc, 0, sizeof(cl_image_desc));
    imageDesc.buffer = a_mem_obj;
    imageDesc.image_type = CL_MEM_OBJECT_IMAGE1D_BUFFER;
    imageDesc.image_width = list_size; // width in pixels
    imageDesc.image_height = 1; // not used for 1D image
    imageDesc.image_depth = 1;  // not used for 1D image
    //imageDesc.mem_object = a_mem_obj;
    tex_obj = clCreateImage(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, &imageFormat, &imageDesc, A, &ret);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to create image: %d\n", ret);
        goto texLatencyCleanup;
    }

    size_t origin[] = { 0, 0, 0 };
    size_t region[] = { imageDesc.image_width, 1, 1 };
    ret = clEnqueueWriteImage(command_queue, tex_obj, CL_TRUE, origin, region, list_size * 4, list_size * 4, A, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to copy image: %d\n", ret);
        goto texLatencyCleanup;
    }

    result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(uint32_t), NULL, &ret);
    clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t), &result, 0, NULL, NULL);
    clFinish(command_queue);

    ret = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&tex_obj);
    ret = clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    ret = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    ret = clSetKernelArg(kernel, 3, sizeof(cl_int), (void*)&list_size);

    start_timing();
    // Execute the OpenCL kernel. launch a single thread
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        latency = 0;
        goto texLatencyCleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        latency = 0;
        goto texLatencyCleanup;
    }

    uint64_t time_diff_ms = end_timing();
    latency = 1e6 * (float)time_diff_ms / (float)chase_iterations;

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t), &result, 0, NULL, NULL);
    //fprintf(stderr, "Result: %d\n", result);
    clFinish(command_queue);

texLatencyCleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(tex_obj);
    clReleaseMemObject(result_obj);
    free(A);
    return latency;
}