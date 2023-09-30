#!/bin/sh

PKG="clammarks-$(git rev-parse --short HEAD)"
rm -rf "$PKG" "clammarks.txz"
mkdir -p "$PKG"

for TARGET in "amd64" "aarch64" "riscv64" "w64"; do
	mkdir "$PKG/$TARGET"
	for COMPONENT in CoherencyLatency MemoryLatency MemoryBandwidth InstructionRate Meshsim CoreClockChecker GpuMemLatency; do
		find "$COMPONENT" -type f -name "*$TARGET*" -executable -exec cp {} "$PKG/$TARGET" \;
	done
	find "GpuMemLatency" -type f -name "*.cl" -exec cp {} "$PKG/$TARGET" \;
done

cp "LICENSE" "$PKG"

tar caf "clammarks.txz" "$PKG"
