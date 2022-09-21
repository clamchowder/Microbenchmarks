amd64:
	x86_64-linux-gnu-gcc -pthread -O3 CoreClockChecker.c CoreClockChecker_x86.s -o CoreClockChecker -lm
win64:
	x86_64-w64-mingw32-gcc -pthread -O3 CoreClockChecker.c CoreClockChecker_x86.s -o CoreClockChecker -lm
boostclockchecker:
	gcc -O3 BoostClockChecker.c BoostClockChecker.s -o BoostClockChecker
win64boostclockchecker:
	x86_64-w64-mingw32-gcc BoostClockChecker.c BoostClockChecker.s -o BoostClockChecker.exe
