# Folders to recursive make into, not everything has a Makefile
folders := MemoryLatency MemoryBandwidth instructionrate meshsim CoreClockChecker GpuMemLatency

all: $(folders)

$(folders): .FORCE
		$(MAKE) -C $@


.FORCE:
