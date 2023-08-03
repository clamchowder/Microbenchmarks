// MemoryBandwidth.c : Version for linux (x86 and ARM)
// Mostly the same as the x86-only VS version, but a bit more manual

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#ifndef __MINGW32__
#include <sys/syscall.h>
#endif

#include <sys/time.h>
#include <unistd.h>
#include <sched.h>
#include <pthread.h>
#include <sched.h>
#include <math.h>
#include <sys/mman.h>
#include <sys/sysinfo.h>
#include <errno.h>
#ifdef NUMA
#include <numa.h>
#endif

#define HUGEPAGE_HACK 1
#undef HUGEPAGE_HACK

#pragma GCC diagnostic ignored "-Wattributes"

int default_test_sizes[] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576, 1572864, 2097152, 3145728 };

typedef struct BandwidthTestThreadData {
    uint64_t iterations;
    uint64_t arr_length;
    uint64_t start;
    float* arr;
    float bw; // written to by the thread
    cpu_set_t cpuset; // if numa set, will set affinity
} BandwidthTestThreadData;

float MeasureBw(uint64_t sizeKb, uint64_t iterations, uint64_t threads, int shared, int nopBytes, int coreNode, int memNode);

#ifdef __x86_64
#include <cpuid.h>
float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute((ms_abi));
extern float sse_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float sse_write(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float sse_ntwrite(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float avx512_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float avx512_write(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float avx512_copy(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float avx512_add(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float repmovsb_copy(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float repmovsd_copy(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float repstosb_write(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float repstosd_write(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
float (*bw_func)(float*, uint64_t, uint64_t, uint64_t start) __attribute__((ms_abi));
#else
float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
float (*bw_func)(float*, uint64_t, uint64_t, uint64_t start);
#endif

#ifdef __x86_64
extern float asm_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float asm_write(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float asm_copy(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float asm_cflip(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
extern float asm_add(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) __attribute__((ms_abi));
#else
extern float asm_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
extern float asm_write(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
extern float asm_copy(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
extern float asm_cflip(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
extern float asm_add(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start);
#endif

#ifdef __aarch64__
extern void flush_icache(void *arr, uint64_t length);
#endif

#ifdef __x86_64
__attribute((ms_abi)) float instr_read(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) {
#else
float instr_read(float *arr, uint64_t arr_length, uint64_t iterations, uint64_t start) { 
#endif
    void (*nopfunc)(uint64_t) __attribute((ms_abi)) = (__attribute((ms_abi)) void(*)(uint64_t))arr;
    for (int iterIdx = 0; iterIdx < iterations; iterIdx++) nopfunc(iterations);
    return 1.1f;
}

void FillInstructionArray(uint64_t *nops, uint64_t sizeKb, int nopSize, int branchInterval); 
uint64_t GetIterationCount(uint64_t testSize, uint64_t threads);
void *ReadBandwidthTestThread(void *param);
void *allocate_memory(size_t bytes, unsigned int threadOffset);
uint64_t gbToTransfer = 512;
int branchInterval = 0; 

#ifdef NUMA
#define NUMA_STRIPE 1
#define NUMA_SEQ 2
#define NUMA_CROSSNODE 3
#define NUMA_AUTO 4
#define NUMA_DOUBLE_CROSSNODE 5
int numa = 0;
#endif

int main(int argc, char *argv[]) {
    int threads = 1;
    int cpuid_data[4];
    int shared = 1;
    int sleepTime = 0;
    int methodSet = 0, nopBytes = 0, testBankConflict = 0;
    int testBankConflict128 = 0;
    int singleSize = 0, autothreads = 0;
    int testSizeCount = sizeof(default_test_sizes) / sizeof(int);

#ifdef __x86_64
    int sseSupported = 0, avxSupported = 0, avx512Supported = 0;
    sseSupported = __builtin_cpu_supports("sse");
    if (sseSupported) fprintf(stderr, "SSE supported\n");
    avxSupported = __builtin_cpu_supports("avx");
    if (avxSupported) fprintf(stderr, "AVX supported\n");
    // gcc has no __builtin_cpu_supports for avx512, so check by hand.
    // eax = 7 -> extended features, bit 16 of ebx = avx512f
    uint32_t cpuidEax, cpuidEbx, cpuidEcx, cpuidEdx;
    __cpuid_count(7, 0, cpuidEax, cpuidEbx, cpuidEcx, cpuidEdx);
    if (cpuidEbx & (1UL << 16)) {
        fprintf(stderr, "AVX512 supported\n");
        avx512Supported = 1;
    }
#endif

    bw_func = asm_read;
    for (int argIdx = 1; argIdx < argc; argIdx++) {
        if (*(argv[argIdx]) == '-') {
            char *arg = argv[argIdx] + 1;
            if (strncmp(arg, "threads", 7) == 0) {
                argIdx++;
                threads = atoi(argv[argIdx]);
                fprintf(stderr, "Using %d threads\n", threads);
            } else if (strncmp(arg, "shared", 6) == 0) {
                shared = 1;
                fprintf(stderr, "Using shared array\n");
            } else if (strncmp(arg, "sleep", 5) == 0) {
                argIdx++;
                sleepTime = atoi(argv[argIdx]);
                fprintf(stderr, "Sleeping for %d second between tests\n", sleepTime);
            } else if (strncmp(arg, "private", 7) == 0) {
                shared = 0;
                fprintf(stderr, "Using private array for each thread\n");
            } else if (strncmp(arg, "branchinterval", 14) == 0) {
                argIdx++;
                branchInterval = atoi(argv[argIdx]);
                fprintf(stderr, "Will add a branch roughly every %d bytes\n", branchInterval * 8);
            } else if (strncmp(arg, "sizekb", 6) == 0) {
                argIdx++;
        singleSize = atoi(argv[argIdx]);
                fprintf(stderr, "Testing %d KB\n", singleSize);
            } else if (strncmp(arg, "data", 4) == 0) {
                argIdx++;
                gbToTransfer = atoi(argv[argIdx]);
                fprintf(stderr, "Base GB to transfer: %lu\n", gbToTransfer);
            }
            else if (strncmp(arg, "autothreads", 11) == 0) {
                argIdx++;
                autothreads = atoi(argv[argIdx]);
                fprintf(stderr, "Testing bw scaling up to %d threads\n", autothreads);
            }
#ifdef NUMA
            else if (strncmp(arg, "numa", 4) == 0) {
                argIdx++;
                fprintf(stderr, "Attempting to be NUMA aware\n");
                if (strncmp(argv[argIdx], "crossnode", 4) == 0) {
                    fprintf(stderr, "Testing node to node bandwidth, 1 GB test size\n");
                    numa = NUMA_CROSSNODE;
                    singleSize = 1048576;
                } else if (strncmp(argv[argIdx], "seq", 3) == 0) {
                    fprintf(stderr, "Filling NUMA nodes one by one\n");
                    numa = NUMA_SEQ;
                } else if (strncmp(argv[argIdx], "stripe", 6) == 0) {
                    fprintf(stderr, "Striping threads across NUMA nodes\n");
                    numa = NUMA_STRIPE;
                } else if (strncmp(argv[argIdx], "doublecross", 10) == 0) {
                    fprintf(stderr, "Crossnode, with two nodes\n");
                    numa = NUMA_DOUBLE_CROSSNODE;
                }
            }
#endif
            else if (strncmp(arg, "method", 6) == 0) {
                methodSet = 1;
                argIdx++;
                if (strncmp(argv[argIdx], "scalar", 6) == 0) {
                    bw_func = scalar_read;
                    fprintf(stderr, "Using scalar C code\n");
                } else if (strncmp(argv[argIdx], "asm", 3) == 0) {
                    bw_func = asm_read;
                    fprintf(stderr, "Using ASM code (AVX or NEON)\n");
                } else if (strncmp(argv[argIdx], "write", 5) == 0) {
                    bw_func = asm_write;
                    fprintf(stderr, "Using ASM code (AVX or NEON), testing write bw instead of read\n");
                    #ifdef __x86_64
                    if (avx512Supported) {
                        fprintf(stderr, "Using AVX-512 because that's supported\n");
                        bw_func = avx512_write;
                    }
                    #endif
                } else if (strncmp(argv[argIdx], "copy", 4) == 0) {
                    bw_func = asm_copy;
                    fprintf(stderr, "Using ASM code (AVX or NEON), testing copy bw instead of read\n");
                    #ifdef __x86_64
                    if (avx512Supported) {
                        fprintf(stderr, "Using AVX-512 because that's supported\n");
                        bw_func = avx512_copy;
                    }
                    #endif
                } else if (strncmp(argv[argIdx], "cflip", 5) == 0) {
                    bw_func = asm_cflip;
                    fprintf(stderr, "Using ASM code (AVX or NEON), flipping order of elements within cacheline\n");
                } else if (strncmp(argv[argIdx], "add", 3) == 0) {
                    bw_func = asm_add;
                    fprintf(stderr, "Using ASM code (AVX or NEON), adding constant to array\n");
                    #ifdef __x86_64
                    if (avx512Supported) {
                        fprintf(stderr, "Using AVX-512 because that's supported\n");
                        bw_func = avx512_add;
                    }
                    #endif
                }

                else if (strncmp(argv[argIdx], "instr8", 6) == 0) {
                    nopBytes = 8;
            bw_func = instr_read;
                    fprintf(stderr, "Testing instruction fetch bandwidth with 8 byte instructions.\n");
                } else if (strncmp(argv[argIdx], "instr4", 6) == 0) {
                    nopBytes = 4;
            bw_func = instr_read;
                    fprintf(stderr, "Testing instruction fetch bandwidth with 4 byte instructions.\n");
                } else if (strncmp(argv[argIdx], "instr2", 6) == 0) {
            nopBytes = 2;
            bw_func = instr_read;
            fprintf(stderr, "Testing instruction fetch bandwith with 2 byte instructions.\n");
        }
                #ifdef __x86_64
                else if (strncmp(argv[argIdx], "instrk8_4", 8) == 0) {
                    nopBytes = 3;
                    bw_func = instr_read;
                    fprintf(stderr, "Testing instruction bandwidth using 4B NOP encoding recommended in the Athlon optimization manual\n");
                }
                else if (strncmp(argv[argIdx], "avx512", 6) == 0) {
                    bw_func = avx512_read;
                    fprintf(stderr, "Using ASM code, AVX512\n");
                }
                else if (strncmp(argv[argIdx], "sse_write", 9) == 0) {
                    bw_func = sse_write;
                    fprintf(stderr, "Using SSE to test write bandwidth\n");
                }
                else if (strncmp(argv[argIdx], "sse_ntwrite", 11) == 0) {
                    bw_func = sse_ntwrite;
                    fprintf(stderr, "Using SSE NT writes to test write bandwidth\n");
                } 
                else if (strncmp(argv[argIdx], "sse", 3) == 0) {
                    bw_func = sse_read;
                    fprintf(stderr, "Using ASM code, SSE\n");
                }
                else if (strncmp(argv[argIdx], "avx", 3) == 0) {
                    bw_func = asm_read;
                    fprintf(stderr, "Using ASM code, AVX\n");
                } 
                else if (strncmp(argv[argIdx], "repmovsb", 8) == 0) {
                    bw_func = repmovsb_copy;
                    fprintf(stderr, "Using REP MOVSB to copy\n");
                }
                else if (strncmp(argv[argIdx], "repmovsd", 8) == 0) {
                    bw_func = repmovsd_copy;
                    fprintf(stderr, "Using REP MOVSD to copy\n");
                }
                else if (strncmp(argv[argIdx], "repstosb", 9) == 0) {
                    bw_func = repstosb_write;
                    fprintf(stderr, "Using REP STOSB to write\n");
                } 
                else if (strncmp(argv[argIdx], "repstosd", 9) == 0) {
                    bw_func = repstosd_write;
                    fprintf(stderr, "Using REP STOSD to write\n");
                }  
                #endif
        
            }
        } else {
            fprintf(stderr, "Expected - parameter\n");
            fprintf(stderr, "Usage: [-threads <thread count>] [-private] [-method <scalar/asm/avx512>] [-sleep <time in seconds>] [-sizekb <single test size>]\n");
        }
    }

#ifdef __x86_64
    // if no method was specified, attempt to pick the best one for x86
    // for aarch64 we'll just use NEON because SVE basically doesn't exist
    if (!methodSet) {
        bw_func = scalar_read;
        if (sseSupported) {
            bw_func = sse_read;
        }

        if (avxSupported) {
            bw_func = asm_read;
        }


        if (avx512Supported) {
            bw_func = avx512_read;
        }
    }
#endif

    if (autothreads > 0) {
        float *threadResults = (float *)malloc(sizeof(float) * autothreads * testSizeCount);
        printf("Auto threads mode, up to %d threads\n", autothreads);
        for (int threadIdx = 1; threadIdx <= autothreads; threadIdx++) {
            if (singleSize != 0) {
                threadResults[threadIdx - 1] = MeasureBw(singleSize, GetIterationCount(singleSize, threadIdx), threadIdx, shared, nopBytes, 0, 0);
                fprintf(stderr, "%d threads: %f GB/s\n", threadIdx, threadResults[threadIdx - 1]);
            } else {
                for (int i = 0; i < testSizeCount; i++) {
                    int currentTestSize = default_test_sizes[i];
                    //fprintf(stderr, "Testing size %d\n", currentTestSize);
                    threadResults[(threadIdx - 1) * testSizeCount + i] = MeasureBw(currentTestSize, GetIterationCount(currentTestSize, threadIdx), threadIdx, shared, nopBytes, 0, 0);
                    fprintf(stderr, "%d threads, %d KB total: %f GB/s\n", threadIdx, currentTestSize, threadResults[(threadIdx - 1) * testSizeCount + i]);
                }
            }
        }

        if (singleSize != 0) {
            printf("Threads, BW (GB/s)\n");
            for (int i = 0;i < autothreads; i++) {
                printf("%d,%f\n", i + 1, threadResults[i]);
            }
        } else {
            printf("Test size down, threads across, value = GB/s\n");
            for (int sizeIdx = 0; sizeIdx < testSizeCount; sizeIdx++) {
                printf("%d", default_test_sizes[sizeIdx]);
                for (int threadIdx = 1; threadIdx <= autothreads; threadIdx++) {
                    printf(",%f", threadResults[(threadIdx - 1) * testSizeCount + sizeIdx]);
                }

                printf("\n");
            }
        }

        free(threadResults);
    } 
#ifdef NUMA
    else if (numa == NUMA_CROSSNODE) {
        if (numa_available() == -1) {
        fprintf(stderr, "NUMA is not available\n");
        return 0;
    }

        struct bitmask *nodeBitmask = numa_allocate_cpumask();
    int numaNodeCount = numa_max_node() + 1;
    fprintf(stderr, "System has %d NUMA nodes\n", numaNodeCount);
        float *crossnodeBandwidths = (float *)malloc(sizeof(float) * numaNodeCount * numaNodeCount);
    memset(crossnodeBandwidths, 0, sizeof(float) * numaNodeCount * numaNodeCount);
        for (int cpuNode = 0; cpuNode < numaNodeCount; cpuNode++) {
            numa_node_to_cpus(cpuNode, nodeBitmask);
        int nodeCpuCount = numa_bitmask_weight(nodeBitmask);
        if (nodeCpuCount == 0) {
            fprintf(stderr, "Node %d has no cores\n", cpuNode);
            continue;
        }

        fprintf(stderr, "Node %d has %d cores\n", cpuNode, nodeCpuCount);
            for (int memNode = 0; memNode < numaNodeCount; memNode++) {
            fprintf(stderr, "Testing CPU node %d to mem node %d\n", cpuNode, memNode);
                crossnodeBandwidths[cpuNode * numaNodeCount + memNode] = 
                MeasureBw(singleSize, GetIterationCount(singleSize, nodeCpuCount), nodeCpuCount, shared, nopBytes, cpuNode, memNode);
            fprintf(stderr, "CPU node %d <- mem node %d: %f\n", cpuNode, memNode, crossnodeBandwidths[cpuNode * numaNodeCount + memNode]);
            }
        }

        for (int memNode = 0; memNode < numaNodeCount; memNode++) {
        printf(",%d", memNode);
    }

    printf("\n");
    for (int cpuNode = 0; cpuNode < numaNodeCount; cpuNode++) {
        printf("%d", cpuNode);
        for (int memNode = 0; memNode < numaNodeCount; memNode++) {
            printf(",%f", crossnodeBandwidths[cpuNode * numaNodeCount + memNode]);
        }

        printf("\n");
    }

        numa_free_cpumask(nodeBitmask);
    free(crossnodeBandwidths);
    }
#endif
    else {
        printf("Using %d threads\n", threads);
        if (singleSize == 0)
        {
            for (int i = 0; i < testSizeCount; i++)
            {
                printf("%d,%f\n", default_test_sizes[i], MeasureBw(default_test_sizes[i], GetIterationCount(default_test_sizes[i], threads), threads, shared, nopBytes, 0, 0));
                if (sleepTime > 0) sleep(sleepTime);
            }
        }
        else
        {
            printf("%d,%f\n", singleSize, MeasureBw(singleSize, GetIterationCount(singleSize, threads), threads, shared, nopBytes, 0, 0));
        }
    }

    return 0;
}

/// <summary>
/// Given test size in KB, return a good iteration count
/// </summary>
/// <param name="testSize">test size in KB</param>
/// <returns>Iterations per thread</returns>
uint64_t GetIterationCount(uint64_t testSize, uint64_t threads)
{
    if (testSize > 64) gbToTransfer = 64;
    if (testSize > 512) gbToTransfer = 64;
    if (testSize > 8192) gbToTransfer = 64;
    uint64_t iterations = gbToTransfer * 1024 * 1024 / testSize;
    if (iterations % 2 != 0) iterations += 1;  // must be even

    if (iterations < 8) return 8; // set a minimum to reduce noise
    else return iterations;
}

void FillInstructionArray(uint64_t *nops, uint64_t sizeKb, int nopSize, int branchInterval) {
#ifdef __x86_64
    char nop2b[8] = { 0x66, 0x90, 0x66, 0x90, 0x66, 0x90, 0x66, 0x90 };
    char nop2b_xor[8] = { 0x31, 0xc0, 0x31, 0xc0, 0x31, 0xc0, 0x31, 0xc0 };
    char nop8b[8] = { 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };

    // zen/piledriver optimization manual uses this pattern
    char nop4b[8] = { 0x0F, 0x1F, 0x40, 0x00, 0x0F, 0x1F, 0x40, 0x00 };

    // athlon64 (K8) optimization manual pattern
    char k8_nop4b[8] = { 0x66, 0x66, 0x66, 0x90, 0x66, 0x66, 0x66, 0x90 };
    char nop4b_with_branch[8] = { 0x0F, 0x1F, 0x40, 0x00, 0xEB, 0x00, 0x66, 0x90 };
#endif

#ifdef __aarch64__
    char nop4b[8] = { 0x1F, 0x20, 0x03, 0xD5, 0x1F, 0x20, 0x03, 0xD5 };

    // hack this to deal with graviton 1 / A72
    // nop + mov x0, 0
    char nop8b[8] = { 0x00, 0x00, 0x80, 0xD2, 0x00, 0x00, 0x80, 0xD2 }; 
    // mov x0, 0 + ldr x0, [sp] 
    char nop8b1[8] = { 0x00, 0x00, 0x80, 0xD2, 0x00, 0x00, 0x80, 0xD2 }; 
#endif

#ifdef __riscv
    // nop, fmv.s fa0, fa5
    char nop4b[8] = { 0x13, 0x00, 0x00, 0x00, 0x53, 0x85, 0xf7, 0x20 };

    // hack this to deal with graviton 1 / A72
    // nop + mov x0, 0
    char nop8b[8] = { 0x13, 0x00, 0x00, 0x00, 0x53, 0x85, 0xf7, 0x20  }; 
    // mov x0, 0 + ldr x0, [sp] 
    char nop8b1[8] = { 0x13, 0x00, 0x00, 0x00, 0xe0, 0x03, 0x40, 0xf9 };  
#endif 
    
    uint64_t *nop8bptr;
    if (nopSize == 8) nop8bptr = (uint64_t *)(nop8b);
    else if (nopSize == 4) nop8bptr = (uint64_t *)(nop4b);
    #ifdef __x86_64
    else if (nopSize == 2) nop8bptr = (uint64_t *)(nop2b_xor);
    else if (nopSize == 3) nop8bptr = (uint64_t *)(k8_nop4b);
    #endif
    else {
        fprintf(stderr, "%d byte instruction length isn't supported :(\n", nopSize);
    }

    uint64_t elements = sizeKb * 1024 / 8 - 1;
    for (uint64_t nopIdx = 0; nopIdx < elements; nopIdx++) {
        nops[nopIdx] = *nop8bptr;
#ifdef __x86_64
    uint64_t *nopBranchPtr = (uint64_t *)nop4b_with_branch;
    if (branchInterval > 1 && nopIdx % branchInterval == 0) nops[nopIdx] = *nopBranchPtr;
#endif
#ifdef __aarch64__
    if (nopSize == 8) {
          uint64_t *otherNops = (uint64_t *)nop8b1;
          if (nopIdx & 1) nops[nopIdx] = *otherNops;
    }
#endif
    }

    // ret
    #ifdef __x86_64
    unsigned char *functionEnd = (unsigned char *)(nops + elements);
    functionEnd[0] = 0xC3;
    #endif
    #ifdef __aarch64__
    uint64_t *functionEnd = (uint64_t *)(nops + elements);
    functionEnd[0] = 0XD65F03C0;
    //flush_icache((void *)nops, funcLen);
    __builtin___clear_cache(nops, functionEnd);
    #endif
    #ifdef __riscv
    uint64_t *functionEnd = (unsigned char *)(nops + elements);
    functionEnd[0] = 0x8082;
    #endif 

#ifndef HUGEPAGE_HACK
    size_t funcLen = sizeKb * 1024;
    uint64_t nopfuncPage = (~0xFFF) & (uint64_t)(nops);
    size_t mprotectLen = (0xFFF & (uint64_t)(nops)) + funcLen;
    
    if (mprotect((void *)nopfuncPage, mprotectLen, PROT_EXEC | PROT_READ | PROT_WRITE) < 0) {
        fprintf(stderr, "mprotect failed, errno %d\n", errno);
    }
#endif
}

// If coreNode and memNode are set, use the specified numa config
// otherwise if numa is set to stripe or seq, respect that
float MeasureBw(uint64_t sizeKb, uint64_t iterations, uint64_t threads, int shared, int nopBytes, int coreNode, int memNode) {
    struct timeval startTv, endTv;
    struct timezone startTz, endTz;
    float bw = 0;
    uint64_t elements = sizeKb * 1024 / sizeof(float);

    if (!shared && sizeKb < threads) {
        fprintf(stderr, "Too many threads for this test size\n");
        return 0;
    }

    // make sure this is divisble by 512 bytes, since the unrolled asm loop depends on that
    // it's hard enough to get close to theoretical L1D BW as is, so we don't want additional cmovs or branches
    // in the hot loop
    uint64_t private_elements = ceil((double)sizeKb / (double)threads) * 256;
    //fprintf(stderr, "Actual data: %lu B\n", private_elements * 4 * threads);
    //fprintf(stderr, "Data per thread: %lu B\n", private_elements * 4);

    // make array and fill it with something, if shared
    float* testArr = NULL;
    if (shared){
        //testArr = (float*)aligned_alloc(64, elements * sizeof(float));
        testArr = allocate_memory(elements * sizeof(float), 0);
        if (testArr == NULL) {
                fprintf(stderr, "Could not allocate memory\n");
                return 0;
        }

        if (nopBytes == 0) {
            for (uint64_t i = 0; i < elements; i++) {
                testArr[i] = i + 0.5f;
            }
        } else FillInstructionArray((uint64_t *)testArr, sizeKb, nopBytes, branchInterval);
    }
    else
    {
        elements = private_elements; // will fill arrays below, per-thread
    }

    pthread_t* testThreads = (pthread_t*)malloc(threads * sizeof(pthread_t));
    struct BandwidthTestThreadData* threadData = (struct BandwidthTestThreadData*)malloc(threads * sizeof(struct BandwidthTestThreadData));
#ifdef NUMA
    // if numa, tell each thread to set an affinity mask
    struct bitmask *nodeBitmask = NULL;
    cpu_set_t cpuset;
    
    if (numa == NUMA_CROSSNODE) {
        nodeBitmask = numa_allocate_cpumask();
    int nprocs = get_nprocs();
        numa_node_to_cpus(coreNode, nodeBitmask); 
    CPU_ZERO(&cpuset);

    // provided functions for manipultaing bitmask don't work
    // for (int i = 0; i < nprocs; i++)
    //   if (numa_bitmask_isbitset(nodeBitmask, i)) CPU_SET(i, &cpuset);
    // bitmask has fields:
    // - size = number of bits
    // - maskp = pointer to bitmap
    // cpu_set_t has field __bits. have to assume it's CPU_SETSIZE bits
    // also assume bitmap size is divisible by 8 (byte size)
    memcpy(cpuset.__bits, nodeBitmask->maskp, nodeBitmask->size / 8);
    }
#endif

    for (uint64_t i = 0; i < threads; i++) {
        if (shared)
        {
            threadData[i].arr = testArr;
            threadData[i].iterations = iterations;
        }
        else
        {
#ifdef NUMA
            int cpuCount = get_nprocs();
            if (numa == NUMA_CROSSNODE) {
                threadData[i].arr = numa_alloc_onnode(elements * sizeof(float), memNode);
                threadData[i].cpuset = cpuset;
            } else if (numa) {
                // Figure out which nodes actually have CPUs and memory
                //int numaNodeCount = numa_max_node() + 1;
                int numaNodeCount = 4;   // for knl. geez
                if (numa == NUMA_SEQ) {
                    // unimplemented
                    fprintf(stderr, "sequential numa node fill not implemented yet\n");
                } else if (numa == NUMA_STRIPE) {
                    memNode = i % numaNodeCount;
                    coreNode = memNode;
                } else if (numa == NUMA_DOUBLE_CROSSNODE) {
                    // hardcode source nodes to 0,1 and destinations 2,3
		    // edit this later for one-off testing
                    coreNode = i & 1;
                    memNode = (i & 1);
                    fprintf(stderr, "Thread %d: Core %d -> mem %d\n", i, coreNode, memNode);
                }

                for(int cpuIdx = 0; cpuIdx < get_nprocs(); cpuIdx++) {
                    CPU_ZERO(&(threadData[i].cpuset));
                    if(CPU_ISSET(i, &(threadData[i].cpuset))) {
                        fprintf(stderr, "bitmask not cleared\n");
                    }
                }

                threadData[i].arr = numa_alloc_onnode(elements * sizeof(float), memNode);

                for(int cpuIdx = 0; cpuIdx < get_nprocs(); cpuIdx++) {
                    CPU_ZERO(&(threadData[i].cpuset));
                    if(CPU_ISSET(i, &(threadData[i].cpuset))) {
                        fprintf(stderr, "bitmask not cleared\n");
                    }
                }

                // cpu node affinity has to be set for each thread
                nodeBitmask = numa_allocate_cpumask();
                numa_node_to_cpus(coreNode, nodeBitmask); 
                CPU_ZERO(&(threadData[i].cpuset));
                fprintf(stderr, "\tNode %d has CPUs:", coreNode);
                for (int cpuIdx = 0; cpuIdx < cpuCount; cpuIdx++) { 
                    if (numa_bitmask_isbitset(nodeBitmask, cpuIdx))  {
                        CPU_SET(cpuIdx, &(threadData[i].cpuset)); 
                    }
                }
            } else {
#endif
                // Not NUMA aware. Allocate memory normally
		//threadData[i].arr = (float*)aligned_alloc(64, elements * sizeof(float));
                threadData[i].arr = allocate_memory(elements * sizeof(float), i);
                if (threadData[i].arr == NULL)
                {
                    fprintf(stderr, "Could not allocate memory for thread %ld\n", i);
                    return 0;
                }
#ifdef NUMA
	}
#endif

        if (nopBytes == 0) {
            for (uint64_t arr_idx = 0; arr_idx < elements; arr_idx++) {
                threadData[i].arr[arr_idx] = arr_idx + i + 0.5f;
            }
        } else FillInstructionArray((uint64_t *)threadData[i].arr, elements * sizeof(float) / 1024, nopBytes, branchInterval);

            threadData[i].iterations = iterations * threads;
        }

        threadData[i].arr_length = elements;
        threadData[i].bw = 0;
        threadData[i].start = 0;
        //if (elements > 8192 * 1024) threadData[i].start = 4096 * i; // must be multiple of 128 because of unrolling
        //int pthreadRc = pthread_create(testThreads + i, NULL, ReadBandwidthTestThread, (void *)(threadData + i));
    }


    gettimeofday(&startTv, &startTz);
    for (uint64_t i = 0; i < threads; i++) pthread_create(testThreads + i, NULL, ReadBandwidthTestThread, (void *)(threadData + i));
    for (uint64_t i = 0; i < threads; i++) pthread_join(testThreads[i], NULL);
    gettimeofday(&endTv, &endTz);

    uint64_t time_diff_ms = 1000 * (endTv.tv_sec - startTv.tv_sec) + ((endTv.tv_usec - startTv.tv_usec) / 1000);
    double gbTransferred = iterations * sizeof(float) * elements * threads / (double)1e9;
    bw = 1000 * gbTransferred / (double)time_diff_ms;
    if (!shared) bw = bw * threads; // iteration count is divided by thread count if in thread private mode
    //printf("%f GB, %lu ms\n", gbTransferred, time_diff_ms);
#ifdef NUMA
    if (numa) numa_free_cpumask(nodeBitmask);
#endif
    free(testThreads);
    #ifndef HUGEPAGE_HACK
    free(testArr); // should be null in not-shared (private) mode
    #endif

    if (!shared) {
        for (uint64_t i = 0; i < threads; i++) {
#ifdef NUMA
        if (numa) numa_free(threadData[i].arr, elements * sizeof(float));
        else
#endif
#ifndef HUGEPAGE_HACK
            free(threadData[i].arr);
#endif
        }
    }

    free(threadData);
    return bw;
}

// one place to make memory allocation calls
#define HUGEPAGE_HACK_SIZE (1048576*1024)
void *hugepageBuffer = NULL;
void *allocate_memory(size_t bytes, unsigned int threadOffset)
{
    void *dst = NULL;
    #ifndef HUGEPAGE_HACK
    int posix_memalign_rc = 0;
    if (posix_memalign_rc != posix_memalign((void **)(&dst), 64, bytes)) {
        fprintf(stderr, "Could not allocate memory: %d\n", posix_memalign_rc);
        return NULL;
    }

    return dst;
    #else
    // todo: make this less of a hack
    if (hugepageBuffer == NULL)
    {
        hugepageBuffer = mmap(NULL, HUGEPAGE_HACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
        if (hugepageBuffer == NULL)
        {
            fprintf(stderr, "Could not mmap memory with hugetlb\n");
            return NULL;
        }

        if (threadOffset * bytes + bytes > HUGEPAGE_HACK_SIZE)
        {
            fprintf(stderr, "Oh no\n");
            return NULL;
        }
    }

    // fprintf(stderr, "Array offset for thread %d is %llu KB\n", threadOffset, bytes * threadOffset / 1024);
    return (void *)((char *)hugepageBuffer + (bytes * threadOffset));
    #endif
}

#ifdef __x86_64
__attribute((ms_abi)) float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) {
#else
float scalar_read(float* arr, uint64_t arr_length, uint64_t iterations, uint64_t start) {
#endif
    float sum = 0;
    if (start + 16 >= arr_length) return 0;

    uint64_t iter_idx = 0, i = start;
    float s1 = 0, s2 = 1, s3 = 0, s4 = 1, s5 = 0, s6 = 1, s7 = 0, s8 = 1;
    while (iter_idx < iterations) {
        s1 += arr[i];
        s2 *= arr[i + 1];
        s3 += arr[i + 2];
        s4 *= arr[i + 3];
        s5 += arr[i + 4];
        s6 *= arr[i + 5];
        s7 += arr[i + 6];
        s8 *= arr[i + 7];
        i += 8;
        if (i + 7 >= arr_length) i = 0;
        if (i == start) iter_idx++;
    }

    sum += s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8;

    return sum;
}

void *ReadBandwidthTestThread(void *param) {
    BandwidthTestThreadData* bwTestData = (BandwidthTestThreadData*)param;
#ifdef NUMA
    if (numa) {
        int affinity_rc = sched_setaffinity(gettid(), sizeof(cpu_set_t), &(bwTestData->cpuset));
    if (affinity_rc != 0) {
        fprintf(stderr, "wtf set affinity failed: %s\n",strerror(errno));
        
    }
    }
#endif
    float sum = bw_func(bwTestData->arr, bwTestData->arr_length, bwTestData->iterations, bwTestData->start);
    if (sum == 0) printf("woohoo\n");
    pthread_exit(NULL);
}
