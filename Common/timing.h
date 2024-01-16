#ifndef timingincluded
#define timingincluded
#ifdef _MSC_VER
#include <sys\timeb.h>
#else
#include <sys/time.h>
#endif
extern struct timeb start, end;
inline void start_timing();
inline unsigned int end_timing();
unsigned long long scale_iterations_to_target(unsigned long long last_iteration_count, float last_time, float target_time);
#endif
