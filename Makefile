# Folders to recursive make into, not everything has a Makefile
FOLDERS = CoherencyLatency MemoryLatency MemoryBandwidth InstructionRate Meshsim CoreClockChecker GpuMemLatency
REV := $(shell git rev-parse --short HEAD)

machine: $(FOLDERS) 

all:
	for CURRENT in $(FOLDERS) ; do \
		$(MAKE) -C $$CURRENT all ; \
	done

clean:
	find . -type f -name "*.o" -exec rm -f {} \; && find . -type f -executable -exec rm -f {} \;

package:
	export REV=$(REV)
	rm -rf "clammarks-$(REV)" "clammarks.txz"
	mkdir "clammarks-$(REV)"
	find GpuMemLatency -type f -name "*.cl" -exec cp {} "clammarks-$(REV)" \;
	find . -type f -executable -exec cp {} "clammarks-$(REV)" \;
	find "clammarks-$(REV)" -type f -name "*.sample" -exec rm -f {} \;
	rm -f "clammarks-$(REV)/description"
	rm -f "clammarks-$(REV)/exclude"
	tar caf "clammarks.txz" "clammarks-$(REV)"

$(folders): .FORCE
		$(MAKE) -C $@ 

.FORCE:

.PHONY: machine
