#include "opencltest.h"

// default test sizes for latency, in KB
int default_test_sizes[] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 600, 768, 1024, 1536, 2048, 3072, 4096, 5120, 6144, 
    8192, 16384, 18432, 20480, 24576, 25600, 28672, 32768, 36864, 40960, 49152, 41200, 65536, 98304, 131072, 196608, 262144, 524288, 1048576 };

// lining this up with nemes's VK bw test sizes. units for this one are in bytes
const uint64_t default_bw_test_sizes[] = {
    4096, 8192, 12288, 16384, 20480, 24576, 28672, 32768, 40960, 49152, 57344, 65536, 81920, 98304, 114688, 131072,
        196608, 262144, 393216, 458752, 524288, 786432, 1048576, 1572864, 2097152, 3145728, 4194304, 6291456, 8388608, 12582912, 16777216, 20971520,
        25165824, 33554432, 37748736, 41943040, 50331648, 58720256, 67108864, 100663296, 134217728, 201326592, 268435456, 402653184, 536870912, 805306368,
        1073741824, 1610579968, 2147483648, 3221225472, 4294967296
};

float int_exec_latency_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t iterations);

uint32_t scale_bw_iterations(uint32_t base_iterations, uint32_t size_kb);
uint64_t scale_iterations(uint32_t size_kb, uint64_t iterations);

cl_ulong get_max_buffer_size();
cl_ulong get_max_constant_buffer_size();

enum TestType {
    GlobalMemLatency,
    ConstantMemLatency,
    LocalMemLatency,
    TexMemLatency,
    GlobalAtomicLatency,
    LocalAtomicLatency,
    GlobalMemBandwidth,
    LocalMemBandwidth,
    TextureThroughput,
    MemBandwidthWorkgroupScaling,
    CoreToCore,
    LinkBandwidth,
    InstructionRate,
};


int main(int argc, char* argv[]) {
    cl_int ret;
    uint32_t stride = 1211;
    uint32_t list_size = 3840 * 2160 * 4;
    uint32_t chase_iterations = 1e6 * 7;
    // skip = 0 means auto
    uint32_t thread_count = 1, local_size = 1, skip = 0;
    float result;
    int platform_index = -1, device_index = -1;
    short amdLatencyWorkaround = false;
    enum TestType testType = GlobalMemLatency;
    char thread_count_set = 0, local_size_set = 0, chase_iterations_set = 0, skip_set = 0;
    int sizeKb = 0;

    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char* arg = argv[argIdx] + 1;
            if (_strnicmp(arg, "stride", 6) == 0) {
                argIdx++;
                stride = atoi(argv[argIdx]);
                fprintf(stderr, "Using stride = %u\n", stride);
            }
            else if (_strnicmp(arg, "iterations", 10) == 0) {
                argIdx++;
                chase_iterations = atoi(argv[argIdx]);
                chase_iterations_set = 1;
                fprintf(stderr, "Using %u iterations\n", chase_iterations);
            }
            else if (_strnicmp(arg, "threads", 7) == 0) {
                argIdx++;
                thread_count = atoi(argv[argIdx]);
                thread_count_set = 1;
                fprintf(stderr, "Using %u threads\n", thread_count);
            }
            else if (_strnicmp(arg, "localsize", 9) == 0) {
                argIdx++;
                local_size = atoi(argv[argIdx]);
                local_size_set = 1;
                fprintf(stderr, "Using local size = %u\n", local_size);
            }
            else if (_strnicmp(arg, "platform", 8) == 0) {
                argIdx++;
                platform_index = atoi(argv[argIdx]);
                fprintf(stderr, "Using OpenCL platform index %d\n", platform_index);
            }
            else if (_strnicmp(arg, "device", 6) == 0) {
                argIdx++;
                device_index = atoi(argv[argIdx]);
                fprintf(stderr, "Using OpenCL device index %d\n", device_index);
            }
            else if (_strnicmp(arg, "bwskip", 6) == 0) {
                argIdx++;
                skip = atoi(argv[argIdx]);
                fprintf(stderr, "Workgroups will be spaced %u apart\n", skip);
            }
            else if (_strnicmp(arg, "amdlatencyworkaround", 20) == 0) {
                amdLatencyWorkaround = true;
                fprintf(stderr, "Using workaround to hit AMD vector cache (not scalar cache)\n");
            }
            else if (_strnicmp(arg, "sizekb", 6) == 0) {
                argIdx++;
                sizeKb = atoi(argv[argIdx]);
                fprintf(stderr, "Only testing %d KB\n", sizeKb);
            }
            else if (_strnicmp(arg, "test", 4) == 0) {
                argIdx++;
                if (_strnicmp(argv[argIdx], "latency", 7) == 0) {
                    testType = GlobalMemLatency;
                    fprintf(stderr, "Testing global memory latency\n");
                }
                else if (_strnicmp(argv[argIdx], "constantlatency", 15) == 0) {
                    testType = ConstantMemLatency;
                    fprintf(stderr, "Testing constant memory latency\n");
                }
                else if (_strnicmp(argv[argIdx], "globalatomic", 13) == 0) {
                    testType = GlobalAtomicLatency;
                    fprintf(stderr, "Testing global atomic latency\n");
                }
                else if (_strnicmp(argv[argIdx], "locallatency", 13) == 0) {
                    testType = LocalMemLatency;
                    fprintf(stderr, "Testing local mem latency\n");
                }
                else if (_strnicmp(argv[argIdx], "texlatency", 10) == 0) {
                    testType = TexMemLatency;
                    fprintf(stderr, "Testing texture mem latency\n");
                }
                else if (_strnicmp(argv[argIdx], "localatomic", 11) == 0) {
                    testType = LocalAtomicLatency;
                    fprintf(stderr, "Testing local atomic latency\n");
                }
                else if (_strnicmp(argv[argIdx], "bw", 2) == 0) {
                    testType = GlobalMemBandwidth;
                    fprintf(stderr, "Testing global memory bandwidth\n");

                    // Somewhat reasonable defaults
                    if (!thread_count_set) thread_count = 131072;
                    if (!local_size_set) local_size = 256;
                    if (!chase_iterations_set) chase_iterations = 500000;
                }
                else if (_strnicmp(argv[argIdx], "localbw", 7) == 0) {
                    testType = LocalMemBandwidth;
                    if (!thread_count_set) thread_count = 262144;
                    if (!local_size_set) local_size = 256;
                    fprintf(stderr, "Testing local memory bandwidth\n");
                }
                else if (_strnicmp(argv[argIdx], "scaling", 7) == 0)
                {
                    testType = MemBandwidthWorkgroupScaling;
                    fprintf(stderr, "Testing BW scaling with workgroups\n");
                    if (!chase_iterations_set) chase_iterations = 20000000;
                }
                else if (_strnicmp(argv[argIdx], "c2c", 3) == 0)
                {
                    testType = CoreToCore;
                    fprintf(stderr, "Testing latency with global atomics across CU count\n");
                }
                else if (_strnicmp(argv[argIdx], "link", 4) == 0)
                {
                    testType = LinkBandwidth;
                    fprintf(stderr, "Testing host <-> GPU link bandwidth\n");
                    if (!chase_iterations_set) chase_iterations = 30000000;
                }
                else if (_strnicmp(argv[argIdx], "instructionrate", 15) == 0)
                {
                    testType = InstructionRate;
                    fprintf(stderr, "Testing instruction rate\n");
                    if (!chase_iterations_set) chase_iterations = 1000;
                    if (!local_size_set && !thread_count_set) {
                        local_size = 256;
                        thread_count = 32768;
                        fprintf(stderr, "Selecting local size = %d, threads = %d\n", local_size, thread_count);
                    }
                }
                else if (_strnicmp(argv[argIdx], "tmu", 3) == 0)
                {
                    testType = TextureThroughput;
                    fprintf(stderr, "Testing TMUs\n");
                }
                else {
                    fprintf(stderr, "I'm so confused. Unknown test type %s\n", argv[argIdx]);
                }
            }
        }
    }

    if (argc == 1)
    {
        fprintf(stderr, "Usage:\n\t[-test <latency/constantlatency/globalatomic/localatomic/bw>]\n\t[-platform <platform id>]\n\t[-device <device id>]\n");
        fprintf(stderr, "\t[-threads <opencl thread count>]\n\t[-localsize <opencl workgroup size>]\n\t[-bwskip <workgroup spacing>]\n");
        fprintf(stderr, "Number of threads (OpenCL global work size) must be divisible by local work size\n");
    }

    fprintf(stderr, "Using %d threads with local size %d\n", thread_count, local_size);
#pragma region opencl_overhead
    // Create an OpenCL context
    cl_context context = get_context_from_user(platform_index, device_index);
    if (context == NULL) exit(1);

    // Load kernel
    cl_program program = build_program(context, "kernel.cl");

    // Create a command queue
    cl_command_queue command_queue = clCreateCommandQueue(context, selected_device_id, 0, &ret);
    fprintf(stderr, "clCreateCommandQueue returned %d\n", ret);

    cl_kernel latency_kernel = clCreateKernel(program, "unrolled_latency_test", &ret);
    cl_kernel latency_kernel_amdworkaround = clCreateKernel(program, "unrolled_latency_test_amdvectorworkaround", &ret);
    cl_kernel bw_kernel = clCreateKernel(program, "sum_bw_test", &ret);
    cl_kernel constant_kernel = clCreateKernel(program, "constant_unrolled_latency_test", &ret);
    cl_kernel int_exec_latency_test_kernel = clCreateKernel(program, "int_exec_latency_test", &ret);
    cl_kernel atomic_latency_test_kernel = clCreateKernel(program, "atomic_exec_latency_test", &ret);
    cl_kernel local_atomic_latency_test_kernel = clCreateKernel(program, "local_atomic_latency_test", &ret);
    cl_kernel c2c_atomic_latency_test_kernel = clCreateKernel(program, "c2c_atomic_exec_latency_test", &ret);
    cl_kernel dummy_add_kernel = clCreateKernel(program, "dummy_add", &ret);
    cl_kernel local_bw_kernel = clCreateKernel(program, "local_bw_test", &ret);
    cl_kernel tex_latency_kernel = clCreateKernel(program, "tex_latency_test", &ret);
    cl_kernel tex_bw_kernel = clCreateKernel(program, "tex_bw_test", &ret);
#pragma endregion opencl_overhead

    max_global_test_size = get_max_buffer_size();

    if (testType == GlobalAtomicLatency)
    {
        result = int_atomic_latency_test(context, command_queue, atomic_latency_test_kernel, chase_iterations, false);
        printf("global atomic latency: %f\n", result);
    }
    else if (testType == LocalAtomicLatency)
    {
        result = int_atomic_latency_test(context, command_queue, local_atomic_latency_test_kernel, chase_iterations, true);
        printf("local atomic latency: %f\n", result);
    }
    else if (testType == GlobalMemLatency)
    {
        fprintf(stderr, "Doing %d K p-chase iterations with stride %d over %d KiB region\n", chase_iterations / 1000, stride, list_size * 4 / 1024);
        printf("\nSattolo, global memory latency (up to %lu K) unroll:\n", max_global_test_size / 1024);

        cl_kernel globalMemLatencyKernel = latency_kernel;
        if (amdLatencyWorkaround)
        {
            fprintf(stderr, "Using workaround to hit vector cache on AMD GPUs, GCN and later, instead of the scalar cache\n");
            globalMemLatencyKernel = latency_kernel_amdworkaround;
        }

        for (int size_idx = 0; size_idx < sizeof(default_test_sizes) / sizeof(int); size_idx++) {
            if (max_global_test_size < sizeof(int) * 256 * default_test_sizes[size_idx]) {
                printf("%d K would exceed device's max buffer size of %lu K, stopping here.\n", default_test_sizes[size_idx], max_global_test_size / 1024);
                break;
            }
            result = latency_test(context, command_queue, globalMemLatencyKernel, 256 * default_test_sizes[size_idx], (default_test_sizes[size_idx], chase_iterations), true, amdLatencyWorkaround);
            printf("%d,%f\n", default_test_sizes[size_idx], result);
            if (result == 0) {
                printf("Something went wrong, not testing anything bigger.\n");
                break;
            }
        }
    }
    else if (testType == ConstantMemLatency)
    {
        cl_ulong max_constant_test_size = get_max_constant_buffer_size();
        printf("\nSattolo, constant memory (up to %lu K), no-unroll:\n", max_constant_test_size / 1024);

        for (int size_idx = 0; size_idx < sizeof(default_test_sizes) / sizeof(int); size_idx++) {
            if (max_constant_test_size < sizeof(int) * 256 * default_test_sizes[size_idx]) {
                printf("%d K would exceed device's max constant buffer size of %lu K, stopping here.\n", default_test_sizes[size_idx], max_constant_test_size / 1024);
                break;
            }
            result = latency_test(context, command_queue, constant_kernel, 256 * default_test_sizes[size_idx], scale_iterations(default_test_sizes[size_idx], chase_iterations), true, false);
            printf("%d,%f\n", default_test_sizes[size_idx], result);
            if (result == 0) {
                printf("Something went wrong, not testing anything bigger.\n");
                break;
            }
        }
    }
    else if (testType == TexMemLatency)
    {
        cl_ulong max_tex_test_size = get_max_tex_buffer_size();
        for (int size_idx = 0; size_idx < sizeof(default_test_sizes) / sizeof(int); size_idx++) {
            if (default_test_sizes[size_idx] * 1024 > max_tex_test_size) {
                printf("%d K would exceed device's texture buffer size of %lu K, stopping here.\n", default_test_sizes[size_idx], max_tex_test_size / 1024);
                break;
            }

            result = tex_latency_test(context, command_queue, tex_latency_kernel, 256 * default_test_sizes[size_idx], scale_iterations(default_test_sizes[size_idx], chase_iterations));
            printf("%d,%f\n", default_test_sizes[size_idx], result);
            if (result == 0) {
                printf("Something went wrong, not testing anything bigger.\n");
                break;
            }
        }
    }
    else if (testType == TextureThroughput)
    {
        cl_ulong max_2d_tex_width = get_max_2d_tex_width();
        cl_ulong max_2d_tex_height = get_max_2d_tex_height();
        fprintf(stderr, "max 2D texture dimensions: %lu x %lu\n", max_2d_tex_width, max_2d_tex_height);
        float gtexels = tex_bw_test(context,
            command_queue,
            tex_bw_kernel,
            256, // width
            256, // height
            thread_count,
            local_size,
            1,
            chase_iterations);
        printf("Texels: %f G/s\n", gtexels);
    }
    else if (testType == LocalMemLatency)
    {
        cl_kernel local_kernel = clCreateKernel(program, "local_unrolled_latency_test", &ret);
        result = latency_test(context, command_queue, local_kernel, 1024, chase_iterations, true, false);
        printf("Local mem latency: %f\n", result);
    }
    else if (testType == GlobalMemBandwidth)
    {
        fprintf(stderr, "Using %u threads, %u local size, %u base iterations\n", thread_count, local_size, chase_iterations);
        printf("\nMemory bandwidth (up to %lu K):\n", max_global_test_size / 1024);

        if (!sizeKb) {
            for (int size_idx = 0; size_idx < sizeof(default_bw_test_sizes) / sizeof(unsigned long long); size_idx++) {
                uint64_t testSizeKb = default_bw_test_sizes[size_idx] / 1024;
                if ((max_global_test_size / 1024) < testSizeKb) {
                    printf("%lu K would exceed device's max buffer size of %lu K, stopping here.\n", testSizeKb, max_global_test_size / 1024);
                    break;
                }

                result = bw_test(context,
                    command_queue,
                    bw_kernel, 256 * testSizeKb,
                    thread_count,
                    local_size,
                    skip,
                    scale_bw_iterations(chase_iterations, testSizeKb));

                printf("%lu,%f\n", testSizeKb, result);
                if (result == 0) {
                    printf("Something went wrong, not testing anything bigger.\n");
                    break;
                }
            }
        }
        else {
            result = bw_test(context,
                command_queue,
                bw_kernel, 256 * sizeKb,
                thread_count,
                local_size,
                skip,
                scale_bw_iterations(chase_iterations, sizeKb));

            printf("%lu,%f\n", sizeKb, result);
            if (result == 0) {
                printf("Something went wrong, not testing anything bigger.\n");
            }
        }
    }
    else if (testType == LocalMemBandwidth)
    {
        if (chase_iterations_set) 
        {
            fprintf(stderr, "Using %u threads, %u local size, %u base iterations\n", thread_count, local_size, chase_iterations);
            printf("\nLocal memory bandwidth: ");
            int64_t elapsed_ms = 0;
            result = local_bw_test(context, command_queue, local_bw_kernel, thread_count, local_size, chase_iterations, &elapsed_ms);
            printf("%f GB/s\n", result);
            fprintf(stderr, "Elapsed time: %lld ms", elapsed_ms);
        }
        else
        {
            int64_t elapsed_ms = 0, target_ms = 1500;
            chase_iterations = 500000;
            while (elapsed_ms < target_ms / 2)
            {
                result = local_bw_test(context, command_queue, local_bw_kernel, thread_count, local_size, chase_iterations, &elapsed_ms);
                fprintf(stderr, "%u threads, %u local size, %u iterations ==> %f GB/s, elapsed time %lld ms\n", 
                    thread_count, local_size, chase_iterations, result, elapsed_ms);
                if (elapsed_ms < 25) chase_iterations *= 2;
                else chase_iterations = (uint32_t)((float)chase_iterations * (target_ms / elapsed_ms));
                if (result == 0)
                {
                    fprintf(stderr, "Run failed\n");
                    break;
                }
        }

            printf("Local memory bandwidth: %f GB/s\n", result);
        }
    }
    else if (testType == MemBandwidthWorkgroupScaling)
    {
        uint32_t testSizeCount = sizeof(default_bw_test_sizes) / sizeof(unsigned long long);
        cl_uint cuCount = getCuCount();

        fprintf(stderr, "Device has %u compute units\n", cuCount);

        float* scalingResults = (float*)malloc(sizeof(float) * cuCount * testSizeCount);
        for (uint32_t workgroupCount = 1; workgroupCount <= cuCount; workgroupCount++)
        {
            if (!sizeKb) {
                for (int size_idx = 0; size_idx < testSizeCount; size_idx++)
                {
                    uint64_t testSizeKb = default_bw_test_sizes[size_idx] / 1024;
                    fprintf(stderr, "Testing size %lu KB, %u workgroups\n", testSizeKb, workgroupCount);
                    if ((max_global_test_size / 1024) < testSizeKb) {
                        printf("%lu K would exceed device's max buffer size of %lu K\n", testSizeKb, max_global_test_size / 1024);
                        scalingResults[(workgroupCount - 1) * testSizeCount + size_idx] = 0;
                        continue;
                    }

                    result = bw_test(context,
                        command_queue,
                        bw_kernel, 256 * testSizeKb,
                        local_size * workgroupCount,
                        local_size,
                        skip,
                        scale_bw_iterations(chase_iterations, testSizeKb));

                    scalingResults[(workgroupCount - 1) * testSizeCount + size_idx] = result;
                    fprintf(stderr, "%u workgroups, %lu KB = %f GB/s\n", workgroupCount, testSizeKb, result);
                }
            }
            else {
                fprintf(stderr, "Testing size %d KB, %u workgroups\n", sizeKb, workgroupCount);
                result = bw_test(context,
                    command_queue,
                    bw_kernel, 256 * sizeKb,
                    local_size * workgroupCount,
                    local_size,
                    skip,
                    scale_bw_iterations(chase_iterations, sizeKb));
                scalingResults[workgroupCount - 1] = result;
                fprintf(stderr, "%u workgroups, %lu KB = %f GB/s\n", workgroupCount, sizeKb, result);
            }
        }

        if (!sizeKb) {
            for (uint32_t workgroupCount = 1; workgroupCount <= cuCount; workgroupCount++)
            {
                printf(",%u", workgroupCount);
            }
            printf("\n");

            for (int size_idx = 0; size_idx < testSizeCount; size_idx++)
            {
                printf("%llu", default_bw_test_sizes[size_idx] / 1024);
                for (uint32_t workgroupCount = 1; workgroupCount <= cuCount; workgroupCount++)
                {
                    printf(",%f", scalingResults[(workgroupCount - 1) * testSizeCount + size_idx]);
                }

                printf("\n");
            }
        }
        else {
            printf("For %d KB:\n", sizeKb);
            for (int workgroupIdx = 0; workgroupIdx < cuCount; workgroupIdx++)
            {
                printf("%d,%f\n", workgroupIdx + 1, scalingResults[workgroupIdx]);
            }

            printf("\n");
        }

        free(scalingResults);
    }
    else if (testType == CoreToCore)
    {
        c2c_atomic_latency_test(context, command_queue, c2c_atomic_latency_test_kernel, chase_iterations);
     }
    else if (testType == LinkBandwidth)
    {
        link_bw_test(context, command_queue, dummy_add_kernel, chase_iterations);
    }
    else if (testType == InstructionRate)
    {
        instruction_rate_test(context, command_queue, thread_count, local_size, chase_iterations);
    }

    //printf("If you didn't run this through cmd, now you can copy the results. And press ctrl+c to close");
    //scanf("\n");

    // Clean up
    cleanup:
    ret = clFlush(command_queue);
    ret = clFinish(command_queue);
    ret = clReleaseKernel(latency_kernel);
    ret = clReleaseProgram(program);
    ret = clReleaseCommandQueue(command_queue);
    ret = clReleaseContext(context);
    return 0;
}

/// <summary>
/// Heuristic to make sure test runs for enough time but not too long
/// </summary>
/// <param name="size_kb">Region size</param>
/// <param name="iterations">base iterations</param>
/// <returns>scaled iterations</returns>
uint64_t scale_iterations(uint32_t size_kb, uint64_t iterations) {
    return 10 * iterations / pow(size_kb, 1.0 / 4.0);
}

#define INT_EXEC_INPUT_SIZE 16
float int_exec_latency_test(cl_context context,
    cl_command_queue command_queue,
    cl_kernel kernel,
    uint32_t iterations)
{
    cl_int ret;
    cl_int result = 0;
    size_t global_item_size = 1;
    size_t local_item_size = 1;
    float latency;
    uint32_t time_diff_ms;
    uint32_t A[INT_EXEC_INPUT_SIZE];

    for (int i = 0; i < INT_EXEC_INPUT_SIZE; i++) A[i] = i;

    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, INT_EXEC_INPUT_SIZE * sizeof(uint32_t), NULL, &ret);
    cl_mem result_obj = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(cl_int), NULL, &result);
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, INT_EXEC_INPUT_SIZE * sizeof(uint32_t), A, 0, NULL, NULL);
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
    latency = 1e6 * (float)time_diff_ms / (float)(iterations * 12);

cleanup:
    clFlush(command_queue);
    clFinish(command_queue);
    clReleaseMemObject(a_mem_obj);
    clReleaseMemObject(result_obj);
    return latency;
}

uint32_t scale_bw_iterations(uint32_t base_iterations, uint32_t size_kb)
{
    if (size_kb < 4096) return base_iterations;
    else return base_iterations / 2;
}
