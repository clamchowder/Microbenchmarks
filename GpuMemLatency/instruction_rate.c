#include "opencltest.h"

float fp64_instruction_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_float* A,
    cl_float* result);

float fp16_instruction_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_float* A,
    cl_float* result);

float run_rate_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_float* A,
    cl_float* result,
    float totalOps);

float run_latency_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_float* A,
    cl_float* result,
    float opsPerIteration);

float global_totalOps;

float instruction_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int forcefp16,
    int forcefp64)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float gOpsPerSec = 0, opsPerIteration;
    cl_int ret;
    int64_t time_diff_ms;
    int float4_element_count = thread_count * 4;

    cl_program program = build_program(context, "instruction_rate_kernel.cl", NULL);
    if (saveprogram) write_program(program, "irate");
    cl_kernel fp32_fma_latency_kernel = clCreateKernel(program, "fp32_fma_latency_test", &ret);
    cl_kernel fp32_add_latency_kernel = clCreateKernel(program, "fp32_add_latency_test", &ret);
    cl_kernel int32_add_latency_kernel = clCreateKernel(program, "int32_add_latency_test", &ret);
    cl_kernel int32_mul_latency_kernel = clCreateKernel(program, "int32_mul_latency_test", &ret);
    cl_kernel fp32_mul_latency_kernel = clCreateKernel(program, "fp32_mul_latency_test", &ret);

    cl_kernel int32_add_scalar_latency_kernel = clCreateKernel(program, "int32_add_scalar_latency_test", &ret);
    cl_kernel int32_mul_scalar_latency_kernel = clCreateKernel(program, "int32_mul_scalar_latency_test", &ret);
    cl_kernel fp32_add_scalar_latency_kernel = clCreateKernel(program, "fp32_add_scalar_latency_test", &ret);
    cl_kernel fp32_fma_scalar_latency_kernel = clCreateKernel(program, "fp32_fma_scalar_latency_test", &ret);
    cl_kernel fp32_mul_scalar_latency_kernel = clCreateKernel(program, "fp32_mul_scalar_latency_test", &ret);

    float* A = (float*)malloc(sizeof(float) * float4_element_count * 4);
    float* result = (float*)malloc(sizeof(float) * 4 * thread_count);

    if (!A || !result)
    {
        fprintf(stderr, "Failed to allocate memory instruction rate test\n");
    }

    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, float4_element_count * sizeof(float), NULL, &ret);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * 4 * thread_count, NULL, &ret);

    // Integer test first
    uint32_t *int32_A = (uint32_t*)A;
    for (int i = 0; i < float4_element_count * 4; i++)
    {
        int32_A[i] = i + 1;
    }

    // 4x int4 * 8 per iteration, and count the loop increment too
    opsPerIteration = 4.0f * 8.0f;
   /*float int32_add_rate = run_rate_test(context, command_queue, int32_add_rate_kernel, thread_count, local_size, chase_iterations,
        float4_element_count, a_mem_obj, result_obj, A, result, opsPerIteration);
    fprintf(stderr, "INT32 G Adds/sec: %f\n", int32_add_rate);*/

    printf("===== INT32 add latency =====\n");
    float int32_add_latency = run_latency_test(context, command_queue, int32_add_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "INT32 add latency: %f ns\n", int32_add_latency);

    printf("===== INT32 add latency (scalar) =====\n");
    int32_add_latency = run_latency_test(context, command_queue, int32_add_scalar_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "INT32 add latency (scalar): %f ns\n", int32_add_latency);

    printf("===== INT32 mul latency =====\n");
    float int32_mul_latency = run_latency_test(context, command_queue, int32_mul_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "INT32 mul latency: %f ns\n", int32_mul_latency);

    printf("===== INT32 mul latency (scalar) =====\n");
    int32_mul_latency = run_latency_test(context, command_queue, int32_mul_scalar_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "INT32 mul latency (scalar): %f ns\n", int32_mul_latency);

    cl_float* fp32_A = (cl_float*)A;
    for (int i = 0; i < float4_element_count * 4; i++)
    {
        fp32_A[i] = 0.5f * i;
    }

    printf("===== FP32 add latency =====\n");
    float fp32_add_latency = run_latency_test(context, command_queue, fp32_add_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "FP32 add latency: %f ns\n", fp32_add_latency);

    printf("===== FP32 add latency (scalar) =====\n");
    fp32_add_latency = run_latency_test(context, command_queue, fp32_add_scalar_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "FP32 add latency (scalar): %f ns\n", fp32_add_latency);

    printf("===== FP32 fma latency =====\n");
    float fp32_fma_latency = run_latency_test(context, command_queue, fp32_fma_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "FP32 FMA latency: %f ns\n", fp32_fma_latency);

    printf("===== FP32 fma latency (scalar) =====\n");
    fp32_fma_latency = run_latency_test(context, command_queue, fp32_fma_scalar_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "FP32 FMA latency (scalar): %f ns\n", fp32_fma_latency);

    printf("===== FP32 mul latency =====\n");
    fp32_fma_latency = run_latency_test(context, command_queue, fp32_mul_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "FP32 mul latency: %f ns\n", fp32_fma_latency);
    fp32_fma_latency = run_latency_test(context, command_queue, fp32_mul_scalar_latency_kernel, chase_iterations, float4_element_count, a_mem_obj, result_obj, A, result, 8.0f);
    fprintf(stderr, "FP32 mul latency (scalar): %f ns\n", fp32_fma_latency);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    return gOpsPerSec;
}

// Runs an instruction rate test. The kernel is expected to perform opsPerIteration * chase_iterations operations
// Mostly simplifies the uber instruction rate test above. Expects memory to be pre-allocated for example.
// Returns GOPS
float run_rate_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_float* A,
    cl_float* result,
    float opsPerIteration)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    cl_int ret;
    float totalOps, gOpsPerSec;
    uint64_t time_diff_ms = 0;

    memset(result, 0, sizeof(float) * 4 * thread_count);

    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, float4_element_count * sizeof(float), A, 0, NULL, NULL);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * 4 * thread_count, result, 0, NULL, NULL);
    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue);

    //fprintf(stderr, "Submitting fp32 add kernel to command queue\n");
    // start with a low iteration count and try to make it work for all GPUs without needing manual iteration adjustment
    while (time_diff_ms < TARGET_TIME_MS / 2) {
        start_timing();
        ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
        if (ret != CL_SUCCESS)
        {
            fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
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

        totalOps = (float)chase_iterations * opsPerIteration * (float)thread_count;
        gOpsPerSec = ((float)totalOps / 1e9) / ((float)time_diff_ms / 1000);
        //fprintf(stderr, "chase iterations: %d, thread count: %d\n", chase_iterations, thread_count);
        //fprintf(stderr, "total ops: %f (%.2f G)\ntotal time: %llu ms\n", totalOps, totalOps / 1e9, time_diff_ms);

        chase_iterations = adjust_iterations(chase_iterations, time_diff_ms);
        clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    }

    return gOpsPerSec;
}


// Variation of the test above but input array size is aligned with assumed wave size.
// if partitioning pattern, this will test partitioning with active waves in the specified pattern
float run_divergence_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t wave,
    int *partitionPattern)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    uint32_t active_threads = thread_count;
    cl_int ret;
    float totalOps, gOpsPerSec;
    uint64_t time_diff_ms = 0;
    uint32_t chase_iterations = 2500000;

    cl_program program = build_program(context, "instruction_rate_kernel.cl", NULL);
    cl_kernel kernel = clCreateKernel(program, partitionPattern == NULL ? "fp32_divergence_rate_test" : "fp32_partition_rate_test", &ret);
    
    float* result = (float*)malloc(sizeof(float) * thread_count);
    float* A = (float*)malloc(sizeof(float) * thread_count);
    memset(result, 0, sizeof(float) * thread_count);

    if (partitionPattern != NULL) active_threads = 0;
    if (partitionPattern != NULL) fprintf(stderr, "\n");

    for (int i = 0; i < thread_count; i++)
    {
        if (partitionPattern == NULL) {
            // divergence test
            if ((i / wave) % 2 == 0) A[i] = 0.2f;
            else A[i] = 0.8f;
        }
        else
        {
            if (partitionPattern[(i / wave)]) {
                A[i] = 0.2f;
                fprintf(stderr, "a ");
                active_threads++;
            }
            else
            {
                fprintf(stderr, "_ ");
                A[i] = 1.2f;
            }

            if ((i + 1) % wave == 0)
            {
                fprintf(stderr, "\n");
            }
        }
    }

    if (partitionPattern != NULL) fprintf(stderr, "\nActive threads: %d\n", active_threads);

    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, thread_count * sizeof(float), NULL, &ret);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, thread_count * sizeof(float), NULL, &ret);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, thread_count * sizeof(float), A, 0, NULL, NULL);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, thread_count * sizeof(float), result, 0, NULL, NULL);
    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue);

    // start with a low iteration count and try to make it work for all GPUs without needing manual iteration adjustment
    while (time_diff_ms < TARGET_TIME_MS / 2) {
        start_timing();
        ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
        if (ret != CL_SUCCESS)
        {
            fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
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

        totalOps = (float)chase_iterations * 8 * (float)active_threads;
        gOpsPerSec = ((float)totalOps / 1e9) / ((float)time_diff_ms / 1000);
        //fprintf(stderr, "chase iterations: %d, thread count: %d\n", chase_iterations, thread_count);
        //fprintf(stderr, "total ops: %f (%.2f G)\ntotal time: %llu ms\n", totalOps, totalOps / 1e9, time_diff_ms);

        chase_iterations = adjust_iterations(chase_iterations, time_diff_ms);
        clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    }

    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    free(A);
    free(result);
    clReleaseKernel(kernel);
    clReleaseProgram(program);
    return gOpsPerSec;
}

void print_rdna4_hwid(uint32_t hwid) {
    uint32_t sa_id = (hwid >> 16) & 1; // 16
    uint32_t wgp_id = (hwid >> 10) & 0xF; // 13:10
    uint32_t simd_id = (hwid >> 8) & 3; // 9:8
    uint32_t wave_id = hwid & 0x1F; // 4:0
    uint32_t cu_id = simd_id & 1;
    uint32_t simd_in_cu_id = (simd_id >> 1);

    printf("\tShader Array %u, ", sa_id);
    printf("WGP %u, ", wgp_id);
    printf("SIMD %u ", simd_id);
    printf("(on CU %u SIMD %u): ", cu_id, simd_in_cu_id);
    printf("Wave %u\n", wave_id);
}

#define LATENCY_SAMPLES 5
float run_latency_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_float* A,
    cl_float* result,
    float opsPerIteration)
{
    size_t global_item_size = 1;
    size_t local_item_size = 1;
    cl_int ret;
    float latency;
    uint64_t time_diff_ms = 0;
    uint32_t* intresult;

    // hack around latency taking longer
    chase_iterations = chase_iterations / 50;

    // thread count is a high value for throughput tests. use a few elements to get extra data from latency tests
    memset(result, 0, sizeof(float) * 8);

    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, float4_element_count * sizeof(float), A, 0, NULL, NULL);
    ret = clEnqueueWriteBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * 8, result, 0, NULL, NULL);
    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&result_obj);
    clFinish(command_queue);

    // fprintf(stderr, "Submitting kernel to command queue\n");
    // start with a low iteration count and try to make it work for all GPUs without needing manual iteration adjustment
    while (time_diff_ms < TARGET_TIME_MS / 2) {
        start_timing();
        ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
        if (ret != CL_SUCCESS)
        {
            fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
            latency = 0;
            return 0;
        }

        ret = clFinish(command_queue);
        if (ret != CL_SUCCESS)
        {
            printf("Failed to finish command queue. clFinish returned %d\n", ret);
            latency = 0;
            return 0;
        }

        time_diff_ms = end_timing();
        chase_iterations = adjust_iterations(chase_iterations, time_diff_ms);
        clSetKernelArg(kernel, 1, sizeof(cl_int), (void*)&chase_iterations);
        ret = clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * 8, result, 0, NULL, NULL);
        clFinish(command_queue);
        intresult = (uint32_t*)result;

        // sink, start hwid, cycles lo, cycles hi, end cycles lo, end cycle hi, end hwid
        uint64_t startclk = intresult[2] | ((uint64_t)intresult[3] << 32);
        uint64_t endclk = intresult[4] | ((uint64_t)intresult[5] << 32);
        uint32_t start_hwid = intresult[1];
        uint32_t end_hwid = intresult[6];
        uint32_t recv = intresult[7];
        printf("---Started on---\n");
        print_rdna4_hwid(start_hwid);
        printf("---Ended on---\n");
        print_rdna4_hwid(end_hwid);

        printf("Start clk %u %u end clk %u %u\n", intresult[2], intresult[3], intresult[4], intresult[5]);
        printf("Iterations: %u\n", chase_iterations);
        printf("Elapsed clk: %f G\n", (float)(endclk - startclk) / 1e9);
        printf("test: %u\n", recv);
        printf("%f cycles per iteration\n", (float)(endclk - startclk) / (chase_iterations * opsPerIteration));
    }

    float totalOps = (float)chase_iterations * opsPerIteration * (float)global_item_size;
    latency = (float)time_diff_ms * 1e6 / totalOps;

    // Now the iteration count is set. Try for an average?
    float latencySum = 0.0f, latencyMin = 0.0f;
    for (int i = 0; i < LATENCY_SAMPLES; i++)
    {
        clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global_item_size, &local_item_size, 0, NULL, NULL);
        clFinish(command_queue);
        clEnqueueReadBuffer(command_queue, result_obj, CL_TRUE, 0, sizeof(float) * 8, result, 0, NULL, NULL);
        clFinish(command_queue);
        intresult = (uint32_t*)result;
        uint64_t startclk = intresult[2] | ((uint64_t)intresult[3] << 32);
        uint64_t endclk = intresult[4] | ((uint64_t)intresult[5] << 32);
        float currentLatencyClks = (float)(endclk - startclk) / (chase_iterations * opsPerIteration);
        latencySum += currentLatencyClks;
        if (i == 0) latencyMin = currentLatencyClks;
        else if (currentLatencyClks < latencyMin) latencyMin = currentLatencyClks;
        fprintf(stderr, "%d: %f clks. Min %f clks, avg %f clks\n", i, currentLatencyClks, latencyMin, latencySum / (i + 1.0f));
    }
    
    //fprintf(stderr, "chase iterations: %d, thread count: %d\n", chase_iterations, thread_count);
    //fprintf(stderr, "total ops: %f (%.2f G)\ntotal time: %llu ms\n", totalOps, totalOps / 1e9, time_diff_ms);
    return latency;
}

// taking out FP64 because some implementations don't support it. putting another build program + create kernel section
// in the main instruction rate test function would be too messy
float fp64_instruction_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_float *A,
    cl_float*result)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float gOpsPerSec, totalOps;
    cl_int ret;
    int64_t time_diff_ms;

    // FP64 add test
    uint32_t low_chase_iterations = chase_iterations / 4;
    cl_double* fp64_A = (cl_double*)A;
    for (int i = 0; i < float4_element_count * 2; i++)
    {
        fp64_A[i] = 0.5f * i;
    }

    memset(result, 0, sizeof(float) * 4 * thread_count);

    cl_program program = build_program(context, "instruction_rate_fp64_kernel.cl", NULL);
    if (saveprogram) write_program(program, "fp64irate");
    cl_kernel fp64_add_rate_kernel = clCreateKernel(program, "fp64_add_rate_test", &ret);
    cl_kernel fp64_fma_rate_kernel = clCreateKernel(program, "fp64_fma_rate_test", &ret);
    cl_kernel fp64_mad_rate_kernel = clCreateKernel(program, "fp64_mad_rate_test", &ret);
    totalOps = 2.0f * 8.0f;
    gOpsPerSec = run_rate_test(context, command_queue, fp64_add_rate_kernel, thread_count, local_size, low_chase_iterations,
        float4_element_count, a_mem_obj, result_obj, A, result, totalOps);
    fprintf(stderr, "FP64 G Adds/sec: %f\n", gOpsPerSec);
    gOpsPerSec = run_rate_test(context, command_queue, fp64_fma_rate_kernel, thread_count, local_size, low_chase_iterations,
        float4_element_count, a_mem_obj, result_obj, A, result, totalOps);
    fprintf(stderr, "FP64 G FMAs/sec: %f : %f FP64 GFLOPs\n", gOpsPerSec, gOpsPerSec * 2);
    gOpsPerSec = run_rate_test(context, command_queue, fp64_mad_rate_kernel, thread_count, local_size, low_chase_iterations,
        float4_element_count, a_mem_obj, result_obj, A, result, totalOps);
    fprintf(stderr, "FP64 G mad()/sec: %f : %f FP64 GFLOPs\n", gOpsPerSec, gOpsPerSec * 2);

    return gOpsPerSec;
}

// taking out FP16 too because it requires an extension to be supported
float fp16_instruction_rate_test(cl_context context,
    cl_command_queue command_queue,
    uint32_t thread_count,
    uint32_t local_size,
    uint32_t chase_iterations,
    int float4_element_count,
    cl_mem a_mem_obj,
    cl_mem result_obj,
    cl_float* A,
    cl_float* result)
{
    size_t global_item_size = thread_count;
    size_t local_item_size = local_size;
    float gOpsPerSec, totalOps;
    cl_int ret;
    int64_t time_diff_ms;

    // FP64 add test
    uint32_t low_chase_iterations = chase_iterations / 4;
    cl_half* fp16_A = (cl_float*)A;
    for (int i = 0; i < float4_element_count * 8; i++)
    {
        fp16_A[i] = (cl_half)(0.5f * i);
    }

    memset(result, 0, sizeof(float) * 4 * thread_count);

    cl_program program = build_program(context, "instruction_rate_fp16_kernel.cl", NULL);
    if (saveprogram) write_program(program, "fp16irate");
    cl_kernel fp16_add_rate_kernel = clCreateKernel(program, "fp16_add_rate_test", &ret);
    cl_kernel fp16_fma_rate_kernel = clCreateKernel(program, "fp16_fma_rate_test", &ret);
    cl_kernel fp16_rsqrt_rate_kernel = clCreateKernel(program, "fp16_rsqrt_rate_test", &ret);
    totalOps = 8.0f * 8.0f;
    gOpsPerSec = run_rate_test(context, command_queue, fp16_add_rate_kernel, thread_count, local_size, low_chase_iterations,
        float4_element_count, a_mem_obj, result_obj, A, result, totalOps);
    fprintf(stderr, "FP16 G Adds/sec: %f\n", gOpsPerSec);
    gOpsPerSec = run_rate_test(context, command_queue, fp16_fma_rate_kernel, thread_count, local_size, low_chase_iterations,
        float4_element_count, a_mem_obj, result_obj, A, result, totalOps);
    fprintf(stderr, "FP16 G FMAs/sec: %f : %f FP16 GFLOPs\n", gOpsPerSec, gOpsPerSec * 2);
    /*gOpsPerSec = run_rate_test(context, command_queue, fp16_rsqrt_rate_kernel, thread_count, local_size, low_chase_iterations,
        float4_element_count, a_mem_obj, result_obj, A, result, totalOps);
    fprintf(stderr, "FP16 G native_rsqrt/sec: %f\n", gOpsPerSec);*/

    return gOpsPerSec;
}
