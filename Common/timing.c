#ifdef _MSC_VER
#include <sys\timeb.h>
__declspec(selectany) struct timeb start, end;
void start_timing() {
    ftime(&start);
}

unsigned int end_timing() {
    ftime(&end);
    return 1000 * (end.time - start.time) + (end.millitm - start.millitm);
}

void start_timing_ts(struct timeb *startTimeb) {
    ftime(startTimeb);
}

unsigned int end_timing_ts(struct timeb* startTimeb) {
    struct timeb end;
    ftime(&end);
    return 1000 * (end.time - startTimeb->time) + (end.millitm - startTimeb->millitm);
}
#else
#include <sys/time.h>
#include <stddef.h>
struct timeval startTv, endTv;
void start_timing() {
    gettimeofday(&startTv, NULL);
}

unsigned int end_timing() {
    gettimeofday(&endTv, NULL);
    return (unsigned int)((endTv.tv_sec - startTv.tv_sec) * 1000 + (endTv.tv_usec - startTv.tv_usec) / 1000);
}

void start_timing_ts(struct timeval* start) {
    gettimeofday(start, NULL);
}

unsigned int end_timing_ts(struct timeval* start) {
    struct timeval end;
    gettimeofday(&end, NULL);
    return (unsigned int)((end.tv_sec - start->tv_sec) * 1000 + (end.tv_usec - start->tv_usec) / 1000);

}
#endif

unsigned long long scale_iterations_to_target(unsigned long long last_iteration_count, float last_time, float target_time) {
  // safety measure to deal with nasty timer precision issues if the system is fast
  if (last_time < 50) return last_iteration_count * 2;
  return last_iteration_count * (target_time / last_time);
}
