#!/bin/bash

source ./config.sh

source ./clean.sh

if [ -f clean0 ] && [ -f clean1 ]; then
	rm clean0 && rm clean1

	echo "Ready to configure? Hit <Enter> to Continue or <Ctrl>+<C> to Cancel!" && sleep 1 && read
	cd $LINUXDIR && make fuji_nozomi_"$ANDROID"_defconfig $FLAGS && make xconfig $FLAGS

	echo "Ready to compile? Hit <Enter> to Continue or <Ctrl>+<C> to Cancel!" && sleep 1 && read
	export KBUILD_BUILD_VERSION=$(date +%Y%m%d%H%M)
	cd $LINUXDIR && make -j`grep processor /proc/cpuinfo | wc -l` $FLAGS
	cd $WORKDIR/vendor/broadcom/wlan/dhd/linux && make -j`grep processor /proc/cpuinfo | wc -l` $FLAGS
	cd $WORKDIR

	source ./repack.sh
fi
