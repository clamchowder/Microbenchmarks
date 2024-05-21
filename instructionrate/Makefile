CC := clang
CFLAGS += -O3
x86_instructionrate: x86_instructionrate.s x86_instructionrate.c
	$(CC) $(CFLAGS) $^ -o $@
arm_instructionrate: arm_instructionrate.s arm_instructionrate.c
	$(CC) $(CFLAGS) $^ -o $@
arm_instructionrate_sve: arm_instructionrate.s arm_instructionrate.c
	$(CC) $(CFLAGS) -march=armv8-a+sve $^ -o $@
x86_fusion: x86_fusion.s x86_fusion.c
	$(CC) $(CFLAGS) $^ -o $@
clean:
	@rm -fr x86_instructionrate arm_instructionrate arm_instructionrate_sve x86_fusion 
