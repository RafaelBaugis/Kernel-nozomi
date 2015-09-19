#!/bin/bash

source ./rootcheck.sh

source ./config.sh

find ${WORKDIR} -name '*.sh' -exec chmod a+x {} \; || exit
find ${WORKDIR} -name '*.pl' -exec chmod a+x {} \; || exit
find ${WORKDIR} -name '*.py' -exec chmod a+x {} \; || exit
find ${WORKDIR} -name '*.elf' -exec rm -Rf {} \; || exit
find ${WORKDIR}/vendor/semc/build/ -name 'ramdisk.*.cpio' -exec rm -Rf {} \; || exit
find ${WORKDIR}/vendor/semc/build/sin -name 'ramdisk.*' -exec rm -Rf {} \; || exit
find ${WORKDIR}/vendor/semc/build/${FS} -name '*.ko' -exec rm -Rf {} \; || exit
find ${WORKDIR}/vendor/semc/build/sin -name '*mage' -exec rm -Rf {} \; || exit
cd ${WORKDIR}/vendor/broadcom/wlan/dhd/linux && make clean && touch ${WORKDIR}/clean0 || exit
cd ${LINUXDIR} && make clean && make mrproper && make distclean && touch ${WORKDIR}/clean1 || exit
