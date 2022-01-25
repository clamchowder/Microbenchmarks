#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys\timeb.h>
#include <windows.h>
#include <tchar.h>

#define ITERATIONS 100000000

int default_test_sizes[36] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048, 
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536, 98304,
                               131072, 262144, 393216, 524288, 1048576 };

float RunTest(uint32_t size_kb, uint64_t iterations, void *mem);
float RunAsmTest(uint32_t size_kb, uint64_t iterations, void* mem);
bool GetPrivilege();

extern "C" void preplatencyarr(uint64_t * mem, uint64_t element_count);
extern "C" uint64_t latencytest(uint64_t iterations, uint64_t *mem);

int main(int argc, char* argv[]) {
    void* arr = NULL;

    if (argc > 1 && _strnicmp(argv[1], "hugepages", 9) == 0)
    {
        fprintf(stderr, "Will attempt to use large pages\n");
        GetPrivilege();
        arr = VirtualAlloc(NULL, default_test_sizes[(sizeof(default_test_sizes) / sizeof(int)) - 1] * 1024, MEM_RESERVE | MEM_COMMIT | MEM_LARGE_PAGES, PAGE_READWRITE);
        if (arr == NULL)
        {
            fprintf(stderr, "Failed to get memory via VirtualAlloc: %d\n", GetLastError());
            return -1;
        }
    }

    printf("Region,Latency (ns)\n");
    for (int i = 0; i < sizeof(default_test_sizes) / sizeof(int); i++)
    {
        printf("%d,%f\n", default_test_sizes[i], RunAsmTest(default_test_sizes[i], ITERATIONS, arr));
    }

    printf("If you didn't run this through cmd, now you can copy the results");
    scanf("\n");

    return 0;
}

/// <summary>
/// Heuristic to make sure test runs for enough time but not too long
/// </summary>
/// <param name="size_kb">Region size</param>
/// <param name="iterations">base iterations</param>
/// <returns>scaled iterations</returns>
uint64_t scale_iterations(uint32_t size_kb, uint64_t iterations) {
    uint64_t retval = iterations;
    if (size_kb <= 512) retval *= 10;
    if (size_kb > 4096) retval /= 10;
    if (size_kb > 131072) retval /= 30;
    return retval;
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

void FillPatternArr64(uint64_t* pattern_arr, uint64_t list_size, uint64_t byte_increment) {
    uint32_t increment = byte_increment / sizeof(uint64_t);
    uint32_t element_count = list_size / increment;
    for (int i = 0; i < element_count; i++) {
        pattern_arr[i * increment] = i * increment;
    }

    int iter = element_count;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint64_t tmp = pattern_arr[iter * increment];
        pattern_arr[iter * increment] = pattern_arr[j * increment];
        pattern_arr[j * increment] = tmp;
    }
}

float RunAsmTest(uint32_t size_kb, uint64_t iterations, void* mem) {
    struct timeb start, end;
    uint32_t list_size = size_kb * 1024 / sizeof(void *);

    uint64_t* A;
    if (mem == NULL) {
        A = (uint64_t *)malloc(size_kb * 1024);
    }
    else {
        A = (uint64_t *)mem;
    }

    memset(A, 0, 1024 * size_kb);
    FillPatternArr64(A, size_kb * 1024 / sizeof(uint64_t), 64);
    preplatencyarr(A, size_kb * 1024 / sizeof(uint64_t));
    uint64_t scaled_iterations = scale_iterations(size_kb, iterations);

    ftime(&start);
    uint64_t sum = latencytest(scaled_iterations, A);
    ftime(&end);
    int64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
    float latency = 1e6 * (float)time_diff_ms / (float)scaled_iterations;
    if (mem == NULL) free(A);

    if (sum == 0) printf("sum == 0 (???)\n");
    return latency;
}

float RunTest(uint32_t size_kb, uint64_t iterations, void *mem) {
    struct timeb start, end;
    uint32_t list_size = size_kb * 1024 / 4;
    uint32_t sum = 0, current;

    // Fill list to create random access pattern
    int* A;
    if (mem == NULL) {
        A = (int*)malloc(sizeof(int) * list_size);
    } else {
        A = (int*)mem;
    }

    for (int i = 0; i < list_size; i++) {
        A[i] = i;
    }

    int iter = list_size;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint32_t tmp = A[iter];
        A[iter] = A[j];
        A[j] = tmp;
    }

    uint64_t scaled_iterations = scale_iterations(size_kb, iterations);

    // Run test
    ftime(&start);
    current = A[0];
    for (int i = 0; i < scaled_iterations; i++) {
        current = A[current];
        sum += current;
    }
    ftime(&end);
    int64_t time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
    float latency = 1e6 * (float)time_diff_ms / (float)scaled_iterations;
    if (mem == NULL) free(A);

    if (sum == 0) printf("sum == 0 (???)\n");
    return latency;
}

bool GetPrivilege()
{
    HANDLE           hToken;
    TOKEN_PRIVILEGES tp;
    BOOL             status;
    DWORD            error;

    // open process token
    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &hToken))
    {
        fprintf(stderr, "OpenProcessToken failed: %d\n", GetLastError());
        return false;
    }

    // get the luid
    if (!LookupPrivilegeValue(NULL, TEXT("SeLockMemoryPrivilege"), &tp.Privileges[0].Luid))
    {
        fprintf(stderr, "Could not get luid: %d\n", GetLastError());
        return false;
    }

    // enable privilege
    tp.PrivilegeCount = 1;
    tp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;
    status = AdjustTokenPrivileges(hToken, FALSE, &tp, 0, (PTOKEN_PRIVILEGES)NULL, 0);

    // It is possible for AdjustTokenPrivileges to return TRUE and still not succeed.
    // So always check for the last error value.
    error = GetLastError();
    if (!status || (error != ERROR_SUCCESS))
    {
        fprintf(stderr, "AdjustTokenPrivileges failed with status %d, error %d\n", status, error);
        return false;
    }

    // close the handle
    if (!CloseHandle(hToken))
    {
        fprintf(stderr, "CloseHandle failed: %d\n", GetLastError());
        return false;
    }

    fprintf(stderr, "Got SeLockMemoryPrivilege\n");
}