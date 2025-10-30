#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "../common/timing.h"
#include "../common/timing.c"

cudaError_t TestCudaDev2Dev(int size, int modifySizeKb, int iterations);

__global__ void touchKernel(int *a) {
   a[threadIdx.x] += threadIdx.x;
}

int main(int argc, char *argv[])
{
    int iter_mul = 7;
    if (argc > 1) { iter_mul = atoi(argv[1]); }
    fprintf(stderr, "iter: %d\n", iter_mul);
    TestCudaDev2Dev(1048576*4, 1, iter_mul);

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
cudaError_t TestCudaDev2Dev(int sizeKb, int modifySizeKb, int iterations)
{
    int *dev_a = 0, *second_dev_a = 0;
    int64_t time_diff_ms;
    float bw;
    cudaError_t cudaStatus;

    uint32_t result = 0;
    int list_size = 256 * sizeKb;
    uint32_t* A = (uint32_t*)malloc(sizeof(uint32_t) * list_size);

    cudaStatus = cudaSetDevice(0);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaSetDevice failed!  Do you have a CUDA-capable GPU installed?");
        goto Error;
    }

    cudaStatus = cudaDeviceEnablePeerAccess(1, 0);
    if (cudaStatus != cudaSuccess) { fprintf(stderr, "Could not enable peer access 0 to device 1\n"); }
    cudaStatus = cudaSetDevice(1);
    cudaStatus = cudaDeviceEnablePeerAccess(0, 0);
    if (cudaStatus != cudaSuccess) { fprintf(stderr, "Could not enable peer access 1 to device 0\n"); }

    // allocate mem on device 0, and copy
    cudaStatus = cudaSetDevice(0);
    cudaStatus = cudaMallocManaged((void**)&dev_a, sizeof(uint32_t) * list_size, cudaMemAttachGlobal);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMallocManaged failed!");
        goto Error;
    }

    for (int i = 0; i < list_size; i++) A[i] = i + 1;
    cudaStatus = cudaMemcpy(dev_a, A, list_size * sizeof(uint32_t), cudaMemcpyHostToDevice);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!");
        goto Error;
    }

    cudaStatus = cudaSetDevice(1);
    cudaStatus = cudaMallocManaged((void**)&second_dev_a, sizeof(uint32_t) * list_size, cudaMemAttachGlobal);
    cudaStatus = cudaMemcpy(dev_a, A, list_size * sizeof(uint32_t), cudaMemcpyHostToDevice);
    cudaStatus = cudaSetDevice(0);

    start_timing();
    for (int i = 0; i < iterations; i += 2) {
        // launch kernel
	cudaSetDevice(0);
        touchKernel<<<1, 1>>>(dev_a);

        cudaStatus = cudaGetLastError();
        if (cudaStatus != cudaSuccess) {
            fprintf(stderr, "Kernel launch failed: %s\n", cudaGetErrorString(cudaStatus));
            goto Error;
        }

	cudaStatus = cudaMemcpyPeer(second_dev_a, 1, dev_a, 0,  sizeof(uint32_t) * list_size);
	if (cudaStatus != cudaSuccess) {
	   fprintf(stderr, "peer to peer memcpy failed: %s\n", cudaGetErrorString(cudaStatus));
	   goto Error;
	}

	// flip
	cudaSetDevice(1);
        touchKernel<<<1, 1>>>(second_dev_a);
	cudaStatus = cudaMemcpyPeer(dev_a, 0, second_dev_a, 1,  sizeof(uint32_t) * list_size);
 	if (cudaStatus != cudaSuccess) {
	   fprintf(stderr, "peer to peer memcpy failed: %s\n", cudaGetErrorString(cudaStatus));
	   goto Error;
	} 
    }

    time_diff_ms = end_timing();
    bw = sizeKb * iterations / (float)time_diff_ms;
    printf("Bandwidth: %f GB/s\n", bw);
    
Error:
    cudaFree(dev_a);
    cudaFree(second_dev_a);
    free(A);
    
    return cudaStatus;
}
