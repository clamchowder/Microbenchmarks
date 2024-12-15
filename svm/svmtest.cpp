#define CL_TARGET_OPENCL_VERSION 300

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>
#include "../Common/timing.h"
#include "../Common/timing.c" // lol avoids trying to link
#include <CL/cl.h>

#ifdef _MSC_VER
#include <Windows.h>
#else
#include <sched.h>
#include <pthread.h>
#endif

#define TARGET_TIME_MS 2000

cl_device_id selected_device_id;
cl_platform_id selected_platform_id;

int checkSVMSupport(cl_device_svm_capabilities desiredCaps);
cl_context get_context_from_user(int platform_index, int device_index);
cl_program build_program(cl_context context, const char* fname, const char* params);
#ifdef _MSC_VER
DWORD WINAPI LatencyTestThread(LPVOID param);
#else
void* LatencyTestThread(void* param);
#endif

float runAtomicsTest(cl_context context, cl_command_queue command_queue);
float runBufferSharingTest(cl_context context, cl_command_queue command_queue);

typedef struct LatencyThreadData {
    uint64_t start;       // initial value to write into target
    uint64_t iterations;  // number of iterations to run
    uint32_t* target;       // value to bounce between threads, init with start - 1
} LatencyData;


#define ALLOC_SIZE 4096

// 4K alignment doesn't work
#define ALLOC_ALIGN 64

enum TestType {
    Atomics,
    BufferSharing,
    Custom
};

int main(int argc, char* argv[])
{
    cl_int ret;
    cl_context context = NULL;
    cl_command_queue command_queue = NULL;
    TestType testType = Atomics;
    int platform_index = -1, device_index = -1;

    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char* arg = argv[argIdx] + 1;
            if (_strnicmp(arg, "atomics", 7) == 0) {
                argIdx++;
                testType = Atomics;
                fprintf(stderr, "Test type = atomics\n");
            }
            else if (_strnicmp(arg, "buffersharing", 13) == 0)
            {
                argIdx++;
                testType = BufferSharing;
                fprintf(stderr, "Test type = buffer sharing\n");
            }
            else if (_strnicmp(arg, "custom", 6) == 0)
            {
                argIdx++;
                testType = Custom;
                fprintf(stderr, "Test type = custom code\n");
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
        }
    }

    if (testType != Custom)
    {
        context = get_context_from_user(platform_index, device_index);
        command_queue = clCreateCommandQueueWithProperties(context, selected_device_id, NULL, &ret);
    }

    if (testType == Atomics)
    {
        runAtomicsTest(context, command_queue);
    }
    else if (testType == BufferSharing)
    {
        runBufferSharingTest(context, command_queue);
    }
    else
    {
        float results[4];
        for (int i = 0; i < 4; i++)
        {
            context = get_context_from_user(1, 0);
            command_queue = clCreateCommandQueueWithProperties(context, selected_device_id, NULL, &ret);
            SetProcessAffinityMask(GetCurrentProcess(), 1UL << i);
            results[i] = runAtomicsTest(context, command_queue);
            clReleaseCommandQueue(command_queue);
            clReleaseContext(context);
        }

        printf("CPU,GPU\n");
        for (int i = 0; i < 4; i++)
        {
            printf("%d,%f\n", i, results[i]);
        }
    }

end:
    if (testType != Custom) {
        clReleaseCommandQueue(command_queue);
        clReleaseContext(context);
    }
    return 0;
}

float runBufferSharingTest(cl_context context, cl_command_queue command_queue)
{
    cl_int ret;
    cl_event evt, buffer_evt;
    size_t gpu_threads = 1;
    uint64_t time_diff_ms;
    float latency;
    uint32_t* testptr, current = 2, iterations = 1000;
    cl_program program = build_program(context, "atomic_latency_kernel.cl", NULL);
    cl_kernel increment_kernel = clCreateKernel(program, "increment_on_gpu", &ret);
    int fineGrainedSupport = checkSVMSupport(CL_DEVICE_SVM_FINE_GRAIN_BUFFER);
    if (fineGrainedSupport) fprintf(stderr, "Device has SVM fine grained buffer support\n");
    else fprintf(stderr, "Device can only use coarse grained buffer sharing\n");
    testptr = (uint32_t*)clSVMAlloc(context, CL_MEM_READ_WRITE | (fineGrainedSupport ? CL_MEM_SVM_FINE_GRAIN_BUFFER : 0), ALLOC_SIZE, ALLOC_ALIGN);
    
    // test setup
    do {
        clSetKernelArgSVMPointer(increment_kernel, 0, testptr);
        *testptr = 0;
        current = 2;
        start_timing();
        for (int i = 0; i < iterations; i++)
        {
            if (!fineGrainedSupport)
            {
                clEnqueueSVMUnmap(command_queue, testptr, 0, NULL, &buffer_evt);
                clWaitForEvents(1, &buffer_evt);
            }
            

            ret = clEnqueueNDRangeKernel(command_queue, increment_kernel, 1, NULL, &gpu_threads, &gpu_threads, 0, NULL, &evt);
            if (ret != CL_SUCCESS)
            {
                fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
                latency = 0;
                goto bufferend;
            }

            clWaitForEvents(1, &evt);
            if (!fineGrainedSupport) {
                clEnqueueSVMMap(command_queue, CL_NON_BLOCKING, CL_MAP_READ | CL_MAP_WRITE, testptr, ALLOC_SIZE, 0, NULL, &buffer_evt);
                clWaitForEvents(1, &buffer_evt);
            }

            if (*testptr == current - 1)
            {
                *testptr = current;
                current += 2;
            }
            else
            {
                fprintf(stderr, "Buffer sharing did not work. Expected %d, test value is still %d\n", current - 1, *testptr);
                goto bufferend;
            }
        }
        time_diff_ms = end_timing();
        latency = (1e6 * (float)time_diff_ms / (float)(iterations));
        printf("Latency: %f ns, %lu ms elapsed time, %u iterations\n", latency, time_diff_ms, iterations);
        iterations = scale_iterations_to_target(iterations, time_diff_ms, TARGET_TIME_MS);

    } while (time_diff_ms < TARGET_TIME_MS / 2);

bufferend:
    clSVMFree(context, testptr);
    clReleaseKernel(increment_kernel);
    clReleaseProgram(program);
    return latency;
}

float runAtomicsTest(cl_context context, cl_command_queue command_queue)
{
    cl_int ret;
    LatencyData latencyData;
    float latency;
    size_t gpu_threads = 1;
    uint64_t time_diff_ms;
    uint32_t* testptr, iterations = 1000000;
    cl_program program;
    cl_kernel atomic_kernel;

    int svmSupport = checkSVMSupport(CL_DEVICE_SVM_ATOMICS);
    if (svmSupport) fprintf(stderr, "Device has SVM support\n");
    else
    {
        fprintf(stderr, "SVM atomics are not supported on selected device. Exiting.\n");
        return 0.0f;
    }

    program = build_program(context, "atomic_latency_kernel.cl", NULL);
    atomic_kernel = clCreateKernel(program, "atomic_exec_latency_test", &ret);
    testptr = (uint32_t*)clSVMAlloc(context, CL_MEM_READ_WRITE | CL_MEM_SVM_FINE_GRAIN_BUFFER | CL_MEM_SVM_ATOMICS, ALLOC_SIZE, ALLOC_ALIGN);
    if (testptr == NULL)
    {
        fprintf(stderr, "Failed to get memory via clSVMAlloc\n");
        goto atomicsend;
    }

    clFinish(command_queue);
    clSetKernelArgSVMPointer(atomic_kernel, 0, testptr);

    do {
        clSetKernelArg(atomic_kernel, 1, sizeof(cl_int), (void*)&iterations);
        latencyData.iterations = iterations;
        latencyData.start = 2; // GPU thread start = 1
        latencyData.target = testptr;
        *testptr = 0;

#ifdef _MSC_VER
        HANDLE testThread;
        DWORD testThreadId;
        testThread = CreateThread(NULL, 0, LatencyTestThread, &latencyData, CREATE_SUSPENDED, &testThreadId);
#else
        pthread_t testThread;
        pthread_create(&testThread, NULL, LatencyTestThread, (void*)&latencyData);
#endif

        start_timing();
#ifdef _MSC_VER
        ResumeThread(testThread);
#else
#endif

        // Blocking call, must come after ResumeThread
        ret = clEnqueueNDRangeKernel(command_queue, atomic_kernel, 1, NULL, &gpu_threads, &gpu_threads, 0, NULL, NULL);
        if (ret != CL_SUCCESS)
        {
            fprintf(stderr, "Failed to submit kernel to command queue. clEnqueueNDRangeKernel returned %d\n", ret);
            latency = 0;
            goto atomicsend;
        }
        clFinish(command_queue);
#ifdef _MSC_VER
        WaitForSingleObject(testThread, INFINITE);
#else
        pthread_join(testThread, NULL);
#endif
        time_diff_ms = end_timing();
        latency = (1e6 * (float)time_diff_ms / (float)(iterations)) / 2;
        printf("Latency: %f ns, %lu ms elapsed time, %u iterations\n", latency, time_diff_ms, iterations);
        iterations = scale_iterations_to_target(iterations, time_diff_ms, TARGET_TIME_MS);
    } while (time_diff_ms < TARGET_TIME_MS / 2);

atomicsend:
    clSVMFree(context, testptr);
    clReleaseKernel(atomic_kernel);
    clReleaseProgram(program);
    return latency;
}

/// <summary>
/// Runs one thread of the latency test. should be run in pairs
/// Always writes to target
/// </summary>
/// <param name="param">Latency test params</param>
/// <returns>next value that would have been written to shared memory</returns>
#ifdef _MSC_VER
DWORD WINAPI LatencyTestThread(LPVOID param) {
#else
void* LatencyTestThread(void* param) {
#endif
    LatencyData* latencyData = (LatencyData*)param;
    uint64_t current = latencyData->start;
    while (current <= 2 * latencyData->iterations) {
#ifdef _MSC_VER
        if (_InterlockedCompareExchange(latencyData->target, current, current - 1) == current - 1) {
#else
        if (__sync_bool_compare_and_swap(latencyData->target, current - 1, current)) {
#endif
            current += 2;
            // fprintf(stderr, "CPU current = %d\n", current);
        }
        // else fprintf(stderr, "target = %d waiting for %d\n", latencyData->target, current - 1);
    }

#ifdef _MSC_VER
    return current;
#else
    pthread_exit(NULL);
#endif
    }


int checkSVMSupport(cl_device_svm_capabilities desiredCaps)
{
    cl_device_svm_capabilities caps;
    cl_int ret = clGetDeviceInfo(selected_device_id, CL_DEVICE_SVM_CAPABILITIES, sizeof(cl_device_svm_capabilities), &caps, 0);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Failed to check for SVM support (%d)\n", ret);
        return 0;
    }

    if (caps & CL_DEVICE_SVM_COARSE_GRAIN_BUFFER) fprintf(stderr, "Device supports coarse grained buffer sharing\n");
    if (caps & CL_DEVICE_SVM_FINE_GRAIN_BUFFER) fprintf(stderr, "Device supports fine grained buffer sharing\n");
    if (caps & CL_DEVICE_SVM_FINE_GRAIN_SYSTEM) fprintf(stderr, "Device supports sharing virtual memory allocated on host\n");
    if (caps & CL_DEVICE_SVM_ATOMICS) fprintf(stderr, "Device supports atomic operations on shared memory\n");

    return caps & desiredCaps;
}

#define MAX_SOURCE_SIZE (0x100000)
cl_program build_program(cl_context context, const char* fname, const char* params)
{
    cl_int ret;
    FILE* fp = NULL;
    char* source_str;
    size_t source_size;
    fp = fopen(fname, "r");
    if (!fp) {
        fprintf(stderr, "Failed to load kernel %s.\n", fname);
        exit(1);
    }
    source_str = (char*)malloc(MAX_SOURCE_SIZE);
    source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);
    fclose(fp);

    cl_program program = clCreateProgramWithSource(context, 1, (const char**)&source_str, (const size_t*)&source_size, &ret);
    ret = clBuildProgram(program, 1, &selected_device_id, params, NULL, NULL);
    //fprintf(stderr, "clBuildProgram %s returned %d\n", fname, ret);
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

    free(source_str);
    return program;
}

/// <summary>
/// populate global variables for opencl device id and platform id
/// </summary>
/// <param name="platform_index">platform index. if -1, prompt user</param>
/// <param name="device_index">device index. if -1. prompt user</param>
/// <returns>opencl context</returns>
cl_context get_context_from_user(int platform_index, int device_index) {
    int i = 0;
    int selected_platform_index = 0, selected_device_index = 0;

    // Get platform and device information
    cl_uint ret_num_devices;
    cl_uint ret_num_platforms;

    cl_int ret = clGetPlatformIDs(0, NULL, &ret_num_platforms);
    cl_platform_id* platforms = NULL;
    cl_device_id* devices = NULL;
    cl_context context = NULL;
    platforms = (cl_platform_id*)malloc(ret_num_platforms * sizeof(cl_platform_id));

    ret = clGetPlatformIDs(ret_num_platforms, platforms, NULL);
    fprintf(stderr, "clGetPlatformIDs returned %d. %d platforms\n", ret, ret_num_platforms);

    for (i = 0; i < ret_num_platforms; i++)
    {
        size_t platform_name_len;
        char* platform_name = NULL;
        if (CL_SUCCESS != clGetPlatformInfo(platforms[i], CL_PLATFORM_NAME, 0, NULL, &platform_name_len)) {
            fprintf(stderr, "Failed to get platform info for platform %d\n", i);
            continue;
        }

        platform_name = (char*)malloc(platform_name_len + 1);
        platform_name[platform_name_len] = 0;

        if (CL_SUCCESS != clGetPlatformInfo(platforms[i], CL_PLATFORM_NAME, platform_name_len, platform_name, NULL)) {
            fprintf(stderr, "Failed to get platform name for platform %d\n", i);
            free(platform_name);
            continue;
        }

        fprintf(stderr, "Platform %d: %s\n", i, platform_name);
        free(platform_name);
    }

    selected_platform_index = platform_index;
    if (selected_platform_index == -1)
    {
        printf("Enter platform #:");
        scanf("%d", &selected_platform_index);
    }

    if (selected_platform_index > ret_num_platforms - 1)
    {
        fprintf(stderr, "platform index out of range\n");
        goto get_context_from_user_end;
    }

    selected_platform_id = platforms[selected_platform_index];

    if (CL_SUCCESS != clGetDeviceIDs(selected_platform_id, CL_DEVICE_TYPE_ALL, 0, NULL, &ret_num_devices)) {
        fprintf(stderr, "Failed to enumerate device ids for platform");
        return NULL;
    }

    devices = (cl_device_id*)malloc(ret_num_devices * sizeof(cl_device_id));
    if (CL_SUCCESS != clGetDeviceIDs(selected_platform_id, CL_DEVICE_TYPE_ALL, ret_num_devices, devices, NULL)) {
        fprintf(stderr, "Failed to get device ids for platform");
        free(devices);
        return NULL;
    }

    fprintf(stderr, "clGetDeviceIDs returned %d devices\n", ret_num_devices);

    for (i = 0; i < ret_num_devices; i++)
    {
        size_t device_name_len;
        char* device_name = NULL;
        if (CL_SUCCESS != clGetDeviceInfo(devices[i], CL_DEVICE_NAME, 0, NULL, &device_name_len)) {
            fprintf(stderr, "Failed to get name length for device %d\n", i);
            continue;
        }

        //fprintf(stderr, "debug: device name length: %d\n", device_name_len);
        device_name = (char*)malloc(device_name_len + 1);
        device_name[device_name_len] = 0;

        if (CL_SUCCESS != clGetDeviceInfo(devices[i], CL_DEVICE_NAME, device_name_len, device_name, &device_name_len)) {
            fprintf(stderr, "Failed to get name for device %d\n", i);
            free(device_name);
            continue;
        }

        fprintf(stderr, "Device %d: %s\n", i, device_name);
        free(device_name);
    }

    selected_device_index = device_index;
    if (selected_device_index == -1)
    {
        fprintf(stderr, "Enter device #:");
        scanf("%d", &selected_device_index);
    }


    if (selected_device_index > ret_num_devices - 1)
    {
        fprintf(stderr, "Device index out of range\n");
        goto get_context_from_user_end;
    }

    selected_device_id = devices[selected_device_index];

    // Create an OpenCL context
    context = clCreateContext(NULL, 1, &selected_device_id, NULL, NULL, &ret);
    fprintf(stderr, "clCreateContext returned %d\n", ret);

get_context_from_user_end:
    free(platforms);
    free(devices);
    return context;
}
