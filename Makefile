# Folders to recursive make into, not everything has a Makefile
FOLDERS = CoherencyLatency MemoryLatency MemoryBandwidth InstructionRate Meshsim CoreClockChecker GpuMemLatency
REV := $(shell git rev-parse --short HEAD)
DIRREV := clammarks-$(REV)

machine: $(FOLDERS) 

all:
	for CURRENT in $(FOLDERS) ; do \
		$(MAKE) -C $$CURRENT all ; \
	done

clean:
	find . -type f -name "*.o" -exec rm -f {} \; && find . -type f -executable -exec rm -f {} \;

package:
	rm -rf "$(DIRREV)" "clammarks.txz"
	mkdir "$(DIRREV)"
	cp "LICENSE" "$(DIRREV)"
	find "$(DIRREV)" -type f -name "*.sample" -exec rm -f {} \;
	rm -f "$(DIRREV)/description" "$(DIRREV)/exclude"
	mkdir "$(DIRREV)/amd64"
	find . -type f -name "*amd64" -executable -exec cp {} "$(DIRREV)/amd64" \;
	find GpuMemLatency -type f -name "*.cl" -exec cp {} "$(DIRREV)/amd64" \;
	mkdir "$(DIRREV)/aarch64"
	find . -type f -name "*aarch64" -executable -exec cp {} "$(DIRREV)/aarch64" \;
	mkdir "$(DIRREV)/riscv64"
	find . -type f -name "*riscv64" -executable -exec cp {} "$(DIRREV)/riscv64" \;
	mkdir "$(DIRREV)/win64"
	find . -type f -name "*exe" -executable -exec cp {} "$(DIRREV)/win64" \;
	tar caf "clammarks.txz" "$(DIRREV)"

$(folders): .FORCE
		$(MAKE) -C $@ 

.FORCE:

.PHONY: machine
