#!/bin/sh

make_all () {
	make amd64
	make clean-obj
	LDFLAGS="-lm -L ocl-icd-arm64/usr/lib/aarch64-linux-gnu -lOpenCL" make aarch64
	make clean-obj
	LDFLAGS="-lm -L ocl-icd-riscv64/usr/lib/riscv64-linux-gnu -lOpenCL" make riscv64
	make clean-obj
	CPPFLAGS="-I OpenCL-SDK-${OCL_VER}-Win-x64/include" LDFLAGS="-lm -L OpenCL-SDK-${OCL_VER}-Win-x64/lib -lOpenCL" make w64
	make clean-obj
}

linux_deps () {
	for ARCH in arm64 riscv64; do
	if ! grep -q $ARCH /etc/apt/sources.list; then
		echo "deb [arch=${ARCH}] http://ports.ubuntu.com/ubuntu-ports $(lsb_release -c -s) universe" | sudo tee -a /etc/apt/sources.list
		echo "deb-src [arch=${ARCH}] http://ports.ubuntu.com/ubuntu-ports $(lsb_release -c -s) universe" | sudo tee -a /etc/apt/sources.list
		sudo apt update
	fi
		apt-get download "ocl-icd-libopencl1:${ARCH}"
		find . -type f -name "*${ARCH}*.deb" -exec dpkg-deb -x {} "ocl-icd-${ARCH}" \;
done
cp ocl-icd-arm64/usr/lib/aarch64-linux-gnu/libOpenCL.so.1 ocl-icd-arm64/usr/lib/aarch64-linux-gnu/libOpenCL.so
cp ocl-icd-riscv64/usr/lib/riscv64-linux-gnu/libOpenCL.so.1 ocl-icd-riscv64/usr/lib/riscv64-linux-gnu/libOpenCL.so
}

w64_deps () {
	curl -fssLO "https://github.com/KhronosGroup/OpenCL-SDK/releases/download/${OCL_VER}/OpenCL-SDK-${OCL_VER}-Win-x64.zip"
	unzip "OpenCL-SDK-${OCL_VER}-Win-x64.zip"
}

linux_deps
w64_deps
make_all
