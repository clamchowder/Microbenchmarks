#include "opencltest.h"

float bw_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint64_t list_size,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t skip,
    uint32_t chase_iterations)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float bandwidth, total_data_gb;
    cl_int ret;
    cl_int float4size = list_size / 4;
    int64_t time_diff_ms;

    if (skip == 0)
    {
        // nemes's read-combining-defeating heuristic
        uint32_t region_size = list_size * sizeof(float);
        uint32_t current_region_steps = (uint32_t)(region_size / (local_size * 4));
        skip = (chase_iterations + current_region_steps + 1) * local_size * 4;
    }

    float* A = (float*)malloc(sizeof(float) * list_size);
    float* result = (float*)malloc(sizeof(float) * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory for test size %lu KB\n", list_size);
    }

    // assume that cl_uint size is 4 bytes, same as float size
    cl_uint* start_offsets = (cl_uint*)malloc(sizeof(cl_uint) * thread_count);
    cl_uint* calculated_offsets = (cl_uint*)malloc(sizeof(cl_uint) * thread_count);
    memset(calculated_offsets, 0, sizeof(uint32_t) * thread_count);
    for (uint32_t i = 0; i < list_size; i++)
    {
        A[i] = (float)(i * 0.5);
    }

    // tell each thread where to start
    for (uint32_t i = 0; i < thread_count; i++)
    {
        uint32_t localId = i % local_size;
        uint32_t groupId = i / local_size;
        start_offsets[i] = (cl_uint)((groupId * skip * local_size + localId) % (float4size - 1));

        // randomly start each workgroup somewhere - ends up being really bad
        /*cl_uint groupOffset = rand() % (float4size / local_size);
        start_offsets[i] = (cl_uint)((groupOffset * local_size + localId) % (float4size - 1));*/
    }

    // copy array to device
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, list_size * sizeof(float), NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, list_size * sizeof(float), A, 0, NULL, NULL);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * thread_count, NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * thread_count, result, 0, NULL, NULL);
    cl_mem start_offsets_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(cl_uint) * thread_count, NULL, &ret);
    if (ret != 0) fprintf(stderr, "create buffer for start offsets failed. ret = %d\n", ret);
    ret = clEnqueueWriteBuffer(command_queue, start_offsets_obj, CL_TRUE, 0, sizeof(cl_uint) * thread_count, start_offsets, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue write buffer for start offsets failed. ret = %d\n", ret);

    // Set kernel arguments for __kernel void sum_bw_test(__global float* A, int count, int float4size, __global float* ret, int skip, __global int *startPositions)
    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_int), (void*)&float4size);
    clSetKernelArg(kernel, 3, sizeof(cl_mem), (void*)&result_obj);
    clSetKernelArg(kernel, 4, sizeof(cl_int), (void*)&skip);
    clSetKernelArg(kernel, 5, sizeof(cl_mem), (void*)&start_offsets_obj);
    clFinish(command_queue); // writes should be blocking, but are they?

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();

    // each thread does iterations reads
    total_data_gb = sizeof(float) * ((float)chase_iterations * thread_count + thread_count) / 1e9;
    bandwidth = 1000 * (float)total_data_gb / (float)time_diff_ms;

    //fprintf(stderr, "%llu ms, %llu GB\n", time_diff_ms, total_data_gb);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

    ret = clEnqueueReadBuffer(command_queue, start_offsets_obj, CL_TRUE, 0, sizeof(uint32_t) * thread_count, calculated_offsets, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for start offsets failed. ret = %d\n", ret);
    clFinish(command_queue);

    if (memcmp(calculated_offsets, start_offsets, sizeof(uint32_t) * thread_count))
    {
        fprintf(stderr, "mismatch in calculated start offsets\n");
        for (uint32_t i = 0; i < thread_count; i++)
        {
            if (calculated_offsets[i] != start_offsets[i]) {
                fprintf(stderr, "At index %u, calculated from GPU = %u, calculated on CPU = %u. skip=%u\n", i, calculated_offsets[i], start_offsets[i], skip);
                break;
            }
        }
    }

    //fprintf(stderr, "Finished reading result. Sum: %d\n", result[0]);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    clReleaseMemObject(start_offsets_obj);
    free(A);
    free(result);
    free(start_offsets);
    free(calculated_offsets);
    return bandwidth;
}

float tex_bw_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint64_t width,
    uint64_t height,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t randomize,
    uint32_t chase_iterations,
    int64_t *time_ms)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float texels = 0;
    cl_int ret;
    int64_t time_diff_ms;
    uint64_t tex_array_size = 3 * width * height; // texture size in bytes
    cl_mem tex_mem_obj = NULL, a_mem_obj = NULL, result_obj = NULL;

    float* A = (float*)malloc(sizeof(float) * tex_array_size);
    float* result = (float*)malloc(sizeof(float) * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory for %lu x %lu texture\n", width, height);
    }

    // fill array
    for (uint64_t i = 0; i < tex_array_size; i++)
    {
        A[i] = randomize ? rand() * 0.2f : (float)(i * 0.5);
    }

    // create texture from it
    //a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, tex_array_size * sizeof(float), A, &ret);
    //ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, tex_array_size * sizeof(float), A, 0, NULL, NULL);
    cl_image_desc imageDesc;
    memset(&imageDesc, 0, sizeof(cl_image_desc));
    imageDesc.image_type = CL_MEM_OBJECT_IMAGE2D;
    imageDesc.image_width = width;
    imageDesc.image_height = height;
    //imageDesc.mem_object = a_mem_obj;
    //imageDesc.buffer = A;
    cl_image_format imageFormat;
    imageFormat.image_channel_order = CL_R;
    imageFormat.image_channel_data_type = CL_FLOAT;
    tex_mem_obj = clCreateImage(context, CL_MEM_READ_ONLY, &imageFormat, &imageDesc, A, &ret);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to create 2d texture: %d\n", ret);
        goto tex_bw_cleanup;
    }

    size_t origin[] = { 0, 0, 0 };
    size_t region[] = { width, height, 1 };
    ret = clEnqueueWriteImage(command_queue, tex_mem_obj, CL_TRUE, origin, region, 0, 0, A, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to copy 2d texture: %d\n", ret);
        goto tex_bw_cleanup;
    }

    fprintf(stderr, "Created image\n");

    // copy array to device
    result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * thread_count, NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * thread_count, result, 0, NULL, NULL);

    // Set kernel arguments for __kernel void sum_bw_test(__global float* A, int count, int float4size, __global float* ret, int skip, __global int *startPositions)
    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&tex_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue); // writes should be blocking, but are they?

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        texels = 0;
        goto tex_bw_cleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        texels = 0;
        goto tex_bw_cleanup;
    }

    time_diff_ms = end_timing();
    fprintf(stderr, "elapsed time: %lld ms\n", time_diff_ms);

    // each thread does iterations samples, and each sample returns a 4-wide vector
    texels = 1000 * (float)(chase_iterations * thread_count * 4 / 1e9) / (float)time_diff_ms;
    fprintf(stderr, "%u iterations, %u threads, %lu ms\n", chase_iterations, thread_count, time_diff_ms);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

    *time_ms = time_diff_ms;

tex_bw_cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(tex_mem_obj);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    return texels;
}

// must be at least as large as local memory test size in kernel
// list size in 32-bit elements
#define local_mem_bw_test_size 8192
float local_bw_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int64_t *time_ms)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float bandwidth, total_data_gb;
    cl_int ret;
    int64_t time_diff_ms;

    float* A = (uint32_t*)malloc(sizeof(uint32_t) * local_mem_bw_test_size);
    float* result = (uint32_t*)malloc(sizeof(uint32_t) * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory for test size %lu KB\n", local_mem_bw_test_size * 4);
    }

    for (uint32_t i = 0; i < local_mem_bw_test_size; i++)
    {
        A[i] = i + .02;
    }

    // copy array to device
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, local_mem_bw_test_size * sizeof(float), NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, local_mem_bw_test_size * sizeof(float), A, 0, NULL, NULL);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * thread_count, NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * thread_count, result, 0, NULL, NULL);

    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue); // writes should be blocking, but are they?

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();
    *time_ms = time_diff_ms;

    // each thread does iterations reads
    total_data_gb = sizeof(float) * ((float)chase_iterations * thread_count) / 1e9;
    bandwidth = 1000 * (float)total_data_gb / (float)time_diff_ms;

    //fprintf(stderr, "%llu ms, %llu GB\n", time_diff_ms, total_data_gb);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    return bandwidth;
}

#define buffer_test_size 4096 // 1024x uint4
float buffer_bw_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int64_t* time_ms)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float bandwidth, total_data_gb;
    cl_int ret;
    int64_t time_diff_ms;
    cl_mem result_obj;

    uint32_t* A = (uint32_t*)malloc(sizeof(uint32_t) * buffer_test_size);
    float* result = (uint32_t*)malloc(sizeof(float) * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory for test size %lu KB\n", local_mem_bw_test_size * 4);
    }

    for (uint32_t i = 0; i < buffer_test_size; i++)
    {
        A[i] = i + 1;
    }

    // copy array to device
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, buffer_test_size * sizeof(uint32_t), NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, buffer_test_size * sizeof(uint32_t), A, 0, NULL, NULL);

    // handle cl_image stuff
    cl_image_format imageFormat;
    imageFormat.image_channel_data_type = CL_UNSIGNED_INT32;
    imageFormat.image_channel_order = CL_R;
    cl_image_desc imageDesc;
    memset(&imageDesc, 0, sizeof(cl_image_desc));
    imageDesc.buffer = a_mem_obj;
    imageDesc.image_type = CL_MEM_OBJECT_IMAGE1D_BUFFER;
    imageDesc.image_width = buffer_test_size; // width in pixels
    cl_mem tex_obj = tex_obj = clCreateImage(context, CL_MEM_READ_ONLY, &imageFormat, &imageDesc, NULL, &ret);

    size_t origin[] = { 0, 0, 0 };
    size_t region[] = { imageDesc.image_width, 1, 1 };
    ret = clEnqueueWriteImage(command_queue, tex_obj, CL_TRUE, origin, region, 0, 0, A, 0, NULL, NULL);

    result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * thread_count, NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * thread_count, result, 0, NULL, NULL);

    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&tex_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue); // writes should be blocking, but are they?

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();
    *time_ms = time_diff_ms;

    // each thread does iterations reads
    total_data_gb = sizeof(float) * ((float)chase_iterations * thread_count) / 1e9;
    bandwidth = 1000 * (float)total_data_gb / (float)time_diff_ms;

    //fprintf(stderr, "%llu ms, %llu GB\n", time_diff_ms, total_data_gb);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    return bandwidth;
}

float mixed_buffer_bw_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int64_t* time_ms)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float bandwidth, total_data_gb;
    cl_int ret;
    int64_t time_diff_ms;
    cl_mem result_obj;

    uint32_t* A = (uint32_t*)malloc(sizeof(uint32_t) * buffer_test_size);
    float* result = (uint32_t*)malloc(sizeof(float) * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory for test size %lu KB\n", local_mem_bw_test_size * 4);
    }

    for (uint32_t i = 0; i < buffer_test_size; i++)
    {
        A[i] = i + 1.1f;
    }

    // copy array to device
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, buffer_test_size * sizeof(uint32_t), NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, buffer_test_size * sizeof(uint32_t), A, 0, NULL, NULL);

    // handle cl_image stuff
    cl_image_format imageFormat;
    imageFormat.image_channel_data_type = CL_FLOAT;
    imageFormat.image_channel_order = CL_R;
    cl_image_desc imageDesc;
    memset(&imageDesc, 0, sizeof(cl_image_desc));
    imageDesc.buffer = a_mem_obj;
    imageDesc.image_type = CL_MEM_OBJECT_IMAGE1D_BUFFER;
    imageDesc.image_width = buffer_test_size; // width in pixels
    cl_mem tex_obj = tex_obj = clCreateImage(context, CL_MEM_READ_ONLY, &imageFormat, &imageDesc, NULL, &ret);

    size_t origin[] = { 0, 0, 0 };
    size_t region[] = { imageDesc.image_width, 1, 1 };
    ret = clEnqueueWriteImage(command_queue, tex_obj, CL_TRUE, origin, region, 0, 0, A, 0, NULL, NULL);

    result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * thread_count, NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * thread_count, result, 0, NULL, NULL);

    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_mem), (void*)&tex_obj);
    clSetKernelArg(kernel, 2, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 3, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue);

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();
    *time_ms = time_diff_ms;

    // each thread does iterations reads
    total_data_gb = sizeof(float) * ((float)chase_iterations * thread_count) / 1e9;
    bandwidth = 1000 * (float)total_data_gb / (float)time_diff_ms;

    //fprintf(stderr, "%llu ms, %llu GB\n", time_diff_ms, total_data_gb);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    return bandwidth;
}


float local_chase_bw_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    uint32_t wave_size,
    int64_t* time_ms)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float bandwidth, total_data_gb;
    cl_int ret;
    int64_t time_diff_ms;

    uint32_t* A = (uint32_t*)malloc(sizeof(uint32_t) * local_mem_bw_test_size);
    uint32_t* result = (uint32_t*)malloc(sizeof(uint32_t) * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory for test size %lu KB\n", local_mem_bw_test_size * 4);
    }

    for (uint32_t i = 0; i < local_mem_bw_test_size; i++)
    {
        // assumes local_mem_bw_test_size is a power of 2.
        A[i] = i + wave_size & (local_mem_bw_test_size - 1);
    }

    // copy array to device
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, local_mem_bw_test_size * sizeof(uint32_t), NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, local_mem_bw_test_size * sizeof(uint32_t), A, 0, NULL, NULL);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(uint32_t) * thread_count, NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * thread_count, result, 0, NULL, NULL);

    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue); // writes should be blocking, but are they?

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();
    *time_ms = time_diff_ms;

    // each thread does iterations reads
    total_data_gb = sizeof(float) * ((float)chase_iterations * thread_count) / 1e9;
    bandwidth = 1000 * (float)total_data_gb / (float)time_diff_ms;

    //fprintf(stderr, "%llu ms, %llu GB\n", time_diff_ms, total_data_gb);

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint32_t) * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    return bandwidth;
}

#define local64_test_size 2048
float local_64_bw_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int64_t* time_ms)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float bandwidth, total_data_gb;
    cl_int ret;
    int64_t time_diff_ms;

    uint64_t* A = (uint64_t*)malloc(sizeof(uint64_t) * local64_test_size);
    uint64_t* result = (uint64_t*)malloc(sizeof(uint64_t) * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory for test size %lu KB\n", local64_test_size * 4);
    }

    for (uint64_t i = 0; i < local64_test_size; i++)
    {
        A[i] = i;
    }

    // copy array to device
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, local64_test_size * sizeof(uint64_t), NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, local64_test_size * sizeof(uint64_t), A, 0, NULL, NULL);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(uint64_t) * thread_count, NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint64_t) * thread_count, result, 0, NULL, NULL);

    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue); // writes should be blocking, but are they?

    start_timing();
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    ret = clFinish(command_queue); // returns success even when TDR happens?
    if (ret != CL_SUCCESS)
    {
        printf("Failed to finish command queue. clFinish returned %d\n", ret);
        bandwidth = 0;
        goto cleanup;
    }

    time_diff_ms = end_timing();
    *time_ms = time_diff_ms;

    // each thread does iterations reads
    total_data_gb = sizeof(float) * ((float)chase_iterations * thread_count + thread_count) / 1e9;
    bandwidth = 1000 * (float)total_data_gb / (float)time_diff_ms;

    ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(uint64_t) * thread_count, result, 0, NULL, NULL);
    if (ret != 0) fprintf(stderr, "enqueue read buffer for result failed. ret = %d\n", ret);
    clFinish(command_queue);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    return bandwidth;
}


// default test sizes for link bandwidth
const uint64_t default_link_test_sizes[] = { 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152 };

void link_bw_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t iterations)
{
    cl_int ret;
    cl_int result = 0;
    size_t global_item_size;
    size_t local_item_size = 1;
    float gpu_to_host_bandwidth, host_to_gpu_bandwidth, total_data_gb;
    uint32_t time_diff_ms, loop_iterations;
    uint32_t* A;

    int test_size_count = sizeof(default_link_test_sizes) / sizeof(unsigned long long);
    float* results = (float*)malloc(sizeof(float) * 2 * test_size_count);
    memset(results, 0, sizeof(float) * 2 * test_size_count);

    printf("Copy Size (KB), Host to GPU (GB/s), GPU to Host (GB/s)\n");
    for (int size_idx = 0; size_idx < test_size_count; size_idx++) {
        uint64_t testSizeBytes = default_link_test_sizes[size_idx] * 1024;
        uint64_t testSizeKb = default_link_test_sizes[size_idx];

        if (testSizeBytes > max_global_test_size) {
            printf("%d K would exceed device's max buffer size of %lu K, stopping here.\n", testSizeKb, max_global_test_size / 1024);
            break;
        }

        A = (uint32_t*)malloc(testSizeBytes);
        memset(A, 0, testSizeBytes);
        cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, testSizeBytes, NULL, &ret);
        clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
        global_item_size = 1; // only hit the first element, not like we're going to spend time verifying an entire arr especially at large sizes

        // use 1M iterations = 1 GB total to transfer
        loop_iterations = ((uint64_t)iterations * 1000) / (uint64_t)testSizeBytes;
        //fprintf(stderr, "Size: %llu KB, Iterations: %d, base iterations: %d\n", testSizeKb, loop_iterations, iterations);

        start_timing();
        for (int iter_idx = 0; iter_idx < loop_iterations; iter_idx++)
        {
            ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, testSizeBytes, A, 0, NULL, NULL);
            clFinish(command_queue);
        }
        time_diff_ms = end_timing();
        total_data_gb = ((float)loop_iterations * testSizeBytes) / 1e9;
        host_to_gpu_bandwidth = 1000 * (float)total_data_gb / (float)time_diff_ms;
        results[size_idx * 2] = host_to_gpu_bandwidth;
        //fprintf(stderr, "Write to GPU: %f GB transferred in %d ms\n", total_data_gb, time_diff_ms);

        start_timing();
        for (int iter_idx = 0; iter_idx < loop_iterations; iter_idx++)
        {
            ret = clEnqueueReadBuffer(command_queue, a_mem_obj, CL_TRUE, 0, testSizeBytes, A, 0, NULL, NULL);
            clFinish(command_queue);
        }
        time_diff_ms = end_timing();
        total_data_gb = ((float)loop_iterations * testSizeBytes) / 1e9;
        gpu_to_host_bandwidth = 1000 * (float)total_data_gb / (float)time_diff_ms;
        results[size_idx * 2 + 1] = gpu_to_host_bandwidth;
        //fprintf(stderr, "Read from GPU: %f GB transferred in %d ms\n", total_data_gb, time_diff_ms);

        printf("%llu,%f,%f\n", testSizeKb, host_to_gpu_bandwidth, gpu_to_host_bandwidth);

        clReleaseMemObject(a_mem_obj);
        free(A);
    }

    float max = 0;
    for (int size_idx = 0; size_idx < test_size_count; size_idx++) {
        if (results[size_idx * 2] > max) max = results[size_idx * 2];
        if (results[size_idx * 2 + 1] > max) max = results[size_idx * 2 + 1];
    }

    printf("Link bandwidth: %f GB/s\n", max);

cleanup:
    free(results);
    clFlush(command_queue);
    clFinish(command_queue);
}
