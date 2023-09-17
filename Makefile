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
	rm -rf "clammarks-$(REV)" "clammarks-$(REV).txz"
	mkdir "clammarks-$(REV)"
	find . -type f -executable -exec cp {} "clammarks-$(REV)" \;
	tar caf "clammarks-$(REV).txz" "clammarks-$(REV)"

$(folders): .FORCE
		$(MAKE) -C $@ 

.FORCE:

.PHONY: machine
