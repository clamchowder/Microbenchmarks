#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "../common/timing.h"
#include "../common/timing.c"

#define CACHELINE_SIZE 64

int default_test_sizes[] = { 2, 4, 8, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 600, 768, 1024, 
    1536, 2048, 3072, 4096, 5120, 6144, 8192, 16384, 32768, 65536, 98304, 131072, 196608, 262144, 524288, 1048576 };

cudaError_t TestCudaLatency(int size, uint32_t chase_iterations);

__global__ void latencyKernel(int *a, int *count, int *ret)
{
    int current = a[0];
    for (int i = 0; i < *count; i++) {
        // asm("add.s32 %0, %1, %2;" : "=r"(i) : "r"(j), "r"(k));
        current = a[current];
    }

    ret[0] = current;
}

void FillPatternArr(uint32_t* pattern_arr, uint32_t list_size, uint32_t byte_increment) {
    uint32_t increment = byte_increment / sizeof(uint32_t);
    uint32_t element_count = list_size / increment;
    for (int i = 0; i < element_count; i++) {
        pattern_arr[i * increment] = i * increment;
    }

    int iter = element_count;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint32_t tmp = pattern_arr[iter * increment];
        pattern_arr[iter * increment] = pattern_arr[j * increment];
        pattern_arr[j * increment] = tmp;
    }
}

int main(int argc, char *argv[])
{
    int iter_mul = 7;
    if (argc > 1) { iter_mul = atoi(argv[1]); }
    if (argc > 2) {
        if (argv[2][0] == 'l') cudaDeviceSetCacheConfig(cudaFuncCachePreferL1);
        else if (argv[2][0] == 's') cudaDeviceSetCacheConfig(cudaFuncCachePreferShared);
        else if (argv[2][0] == 'e') cudaDeviceSetCacheConfig(cudaFuncCachePreferEqual);
    }

    fprintf(stderr, "Iterations: %d mil\n", iter_mul);
    // warmup
    TestCudaLatency(2, 1e6 * iter_mul);
    for (int size_idx = 0; size_idx < sizeof(default_test_sizes) / sizeof(int); size_idx++) {
        TestCudaLatency(default_test_sizes[size_idx], 1e6 * iter_mul);
    }

    // cudaDeviceReset must be called before exiting in order for profiling and
    // tracing tools such as Nsight and Visual Profiler to show complete traces.
    cudaError_t cudaStatus = cudaDeviceReset();
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceReset failed!");
        return 1;
    }

    return 0;
}

// Helper function for using CUDA to add vectors in parallel.
cudaError_t TestCudaLatency(int sizeKb, uint32_t chase_iterations)
{
    int *dev_a = 0;
    int *dev_count = 0;
    int *dev_result = 0;
    int64_t time_diff_ms;
    float latency;
    cudaError_t cudaStatus;

    uint32_t result = 0;
    int list_size = 256 * sizeKb;
    uint32_t* A = (uint32_t*)malloc(sizeof(uint32_t) * list_size);
    FillPatternArr((uint32_t*)A, list_size, CACHELINE_SIZE);

    // Choose which GPU to run on, change this on a multi-GPU system.
    cudaStatus = cudaSetDevice(0);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaSetDevice failed!  Do you have a CUDA-capable GPU installed?");
        goto Error;
    }

    // allocate memory for pattern array
    cudaStatus = cudaMallocManaged((void**)&dev_a, sizeof(uint32_t) * list_size, cudaMemAttachGlobal);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMallocManaged failed!");
        goto Error;
    }

    cudaMemAdvise((void*)dev_a, sizeof(uint32_t) * list_size, cudaMemAdviseSetReadMostly, 0);

    // copy result to GPU
    cudaStatus = cudaMemcpy(dev_a, A, list_size * sizeof(uint32_t), cudaMemcpyHostToDevice);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!");
        goto Error;
    }

    cudaStatus = cudaMalloc((void**)&dev_count, sizeof(uint32_t));
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMalloc failed!");
        goto Error;
    }

    cudaStatus = cudaMemcpy(dev_count, &chase_iterations, sizeof(uint32_t), cudaMemcpyHostToDevice);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!");
        goto Error;
    }

    cudaStatus = cudaMalloc((void**)&dev_result, sizeof(uint32_t));
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMalloc failed!");
        goto Error;
    }

    // Launch a kernel on the GPU with one thread for each element.
    start_timing();
    latencyKernel<<<1, 1>>>(dev_a, dev_count, dev_result);

    // Check for any errors launching the kernel
    cudaStatus = cudaGetLastError();
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "Kernel launch failed: %s\n", cudaGetErrorString(cudaStatus));
        goto Error;
    }
    
    // cudaDeviceSynchronize waits for the kernel to finish, and returns
    // any errors encountered during the launch.
    cudaStatus = cudaDeviceSynchronize();
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceSynchronize returned error code %d after launching addKernel!\n", cudaStatus);
        goto Error;
    }

    time_diff_ms = end_timing();
    latency = 1e6 * (float)time_diff_ms / (float)chase_iterations;
    printf("%d,%f\n", sizeKb, latency);

    // Copy output vector from GPU buffer to host memory.
    cudaStatus = cudaMemcpy(&result, dev_result, sizeof(uint32_t), cudaMemcpyDeviceToHost);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!");
        goto Error;
    }

Error:
    cudaFree(dev_result);
    cudaFree(dev_a);
    cudaFree(dev_count);
    
    return cudaStatus;
}
