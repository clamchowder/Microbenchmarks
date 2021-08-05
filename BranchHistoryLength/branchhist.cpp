#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys\timeb.h>
#include <time.h>
#include <windows.h>
#include <bcrypt.h>

int default_test_sizes[30] = { 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 512, 600, 768, 1024, 1536, 2048,
                               3072, 4096, 5120, 6144, 8192, 10240, 12288, 16384, 24567, 32768, 65536 };

BCRYPT_ALG_HANDLE hCryptProv = NULL;
extern "C" uint64_t branchtest(uint64_t iterations, uint32_t * arr, uint32_t arrLen);
float runtest(uint32_t historyLen, int random);

int main(int argc, char *argv[]) {
  printf("History Length, Latency\n");
  
  HRESULT hr = BCryptOpenAlgorithmProvider(&hCryptProv, BCRYPT_RNG_ALGORITHM, 0, 0);
  if (FAILED(hr))
  {
      fprintf(stderr, "failed to get bcrypt rng provider\n");
      return 0;
  }

  for (uint32_t i = 0;i < sizeof(default_test_sizes) / sizeof(int); i++) {
    uint32_t testSize = default_test_sizes[i];
    printf("%d, %f, %f\n", testSize, runtest(testSize, 1), runtest(testSize, 0));
  }
  
  return 0;
}

float runtest(uint32_t historyLen, int random) {
  struct timeb start, end;
  uint64_t iterations = 150000000, sink = 0;
  uint32_t *testArr = (uint32_t *)malloc(sizeof(uint32_t) * historyLen);
  uint32_t randomNumber;
  int64_t time_diff_ms;
  float latency;
  HRESULT hr;

  for (uint32_t i = 0; i < historyLen; i++) {
      hr = BCryptGenRandom(hCryptProv, (PUCHAR)&randomNumber, sizeof(uint32_t), 0);
      if (FAILED(hr)) {
          fprintf(stderr, "failed to generate random number\n");
          goto runtest_done;
      }
      testArr[i] = random ? (randomNumber) : 0;
  }

  ftime(&start);
  sink = branchtest(iterations, testArr, historyLen);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)iterations;
  //if (random) fprintf(stderr, "Non-Taken: %f%\n", (float)sink/(float)iterations);
runtest_done:
  free(testArr);
  return latency;
}

