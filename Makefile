include Common/arch_detect.mk

COMPONENTS = CoherencyLatency MemoryLatency MemoryBandwidth InstructionRate Meshsim CoreClockChecker GpuMemLatency

all: $(COMPONENTS) 

ci:
	for COMPONENT in $(COMPONENTS); do $(MAKE) -C $$COMPONENT ci; done

package:
	@sh Common/ci_package.sh

clean-package:
	find . -maxdepth 1 -type d -name "clammarks-*" -exec rm -rf {} \; && rm -f "clammarks.txz"

clean: 
	for COMPONENT in $(COMPONENTS); do $(MAKE) -C $$COMPONENT clean; done

$(COMPONENTS): .FORCE
	$(MAKE) -C $@ 

.FORCE:

.PHONY: all ci package clean-package clean
