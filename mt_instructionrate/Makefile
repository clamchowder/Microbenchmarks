x86:
	gcc -pthread -masm=intel x86_mt_instructionrate.s mt_instructionrate.c ../Common/timing.c -o x86_mt_instructionrate
aarch64:
	gcc -pthread mt_instructionrate.c arm_mt_instructionrate.s ../Common/timing.c -o arm_mt_instructionrate
