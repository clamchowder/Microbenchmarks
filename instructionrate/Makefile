x86_instructionrate: x86_instructionrate.s x86_instructionrate.c
	gcc -O3 x86_instructionrate.s x86_instructionrate.c -o x86_instructionrate
arm_instructionrate: arm_instructionrate.s arm_instructionrate.c
	gcc -O3 arm_instructionrate.s arm_instructionrate.c -o arm_instructionrate
x86_fusion: x86_fusion.s x86_fusion.c
	gcc -O3 x86_fusion.s x86_fusion.c -o x86_fusion
x86_instructionrate_win64:
	x86_64-w64-mingw32-gcc -O3 x86_instructionrate.c x86_instructionrate.s -o x86_instructionrate.exe
mips:
	gcc mips_instructionrate.c mips_instructionrate.s -o mips_instructionrate
