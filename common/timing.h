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
#endif
