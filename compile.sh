#!/bin/bash

source ./rootcheck.sh

source ./config.sh

cd ${WORKDIR}

die () {
    echo >&1 "$@"
    exit 1
}

INPUT=$1

[ "$1" = "" ] && echo "Need Argument"
[ "$1" = "" ] && echo "1 = Clean and Compile"
[ "$1" = "" ] && echo "2 = Clean Configure and Compile"
[ "$1" = "" ] && die "3 = DistClean load Defconfig, Configure and Compile"

if [ ${INPUT} = 1 ] || [ ${INPUT} = 2 ]; then
	cd ${LINUXDIR} && make clean ${FLAGS} || exit
fi
if [ ${INPUT} = 3 ]; then
	cd ${WORKDIR}
	source ./realclean.sh
fi

if [ ${INPUT} = 2 ]; then
	cd ${LINUXDIR} && make xconfig ${FLAGS} || exit
fi
if [ ${INPUT} = 3 ] && [ -f ${WORKDIR}/clean0 ] && [ -f ${WORKDIR}/clean1 ]; then
	cd ${WORKDIR} && rm -Rf clean0 clean1 || exit
	cd ${LINUXDIR} && make fuji_nozomi_${ANDROID}_defconfig ${FLAGS} && make xconfig ${FLAGS} || exit
fi

if [ ${INPUT} = 1 ] || [ ${INPUT} = 2 ] || [ ${INPUT} = 3 ]; then
	echo "Ready to compile? Hit <Enter> to Continue or <Ctrl>+<C> to Cancel!" && sleep 1 && read
	export KBUILD_BUILD_VERSION=$(date +%Y%m%d%H%M)
	cd ${LINUXDIR} && make dep -j`grep processor /proc/cpuinfo | wc -l` ${FLAGS} || exit
	cd ${LINUXDIR} && make -j`grep processor /proc/cpuinfo | wc -l` ${FLAGS} || exit
	cd ${WORKDIR}/vendor/broadcom/wlan/dhd/linux && make -j`grep processor /proc/cpuinfo | wc -l` ${FLAGS} || exit
	cd ${WORKDIR} || exit

	source ./repack.sh
fi
