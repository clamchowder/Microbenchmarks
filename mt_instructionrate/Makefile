x86:
	gcc -pthread -masm=intel x86_mt_instructionrate.s mt_instructionrate.c ../Common/timing.c -o x86_mt_instructionrate -static
aarch64:
	gcc -pthread mt_instructionrate.c arm_mt_instructionrate.s ../Common/timing.c -o arm_mt_instructionrate
ppc64:
	gcc -pthread -mregnames mt_instructionrate.c ppc64_mt_instructionrate.s ../Common/timing.c -o ppc64_mt_instructionrate
