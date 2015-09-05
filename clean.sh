#!/bin/bash

source ./config.sh

find ${WORKDIR} -name '*.sh' -exec chmod a+x {} \;
find ${WORKDIR} -name '*.pl' -exec chmod a+x {} \;
find ${WORKDIR} -name '*.py' -exec chmod a+x {} \;
find ${WORKDIR} -name '*.elf' -exec rm -Rf {} \;
find ${WORKDIR}/vendor/semc/build/ -name 'ramdisk.*.cpio' -exec rm -Rf {} \;
find ${WORKDIR}/vendor/semc/build/sin -name 'ramdisk.*' -exec rm -Rf {} \;
find ${WORKDIR}/vendor/semc/build/${FS} -name '*.ko' -exec rm -Rf {} \;
find ${WORKDIR}/vendor/semc/build/sin -name '*mage' -exec rm -Rf {} \;
cd ${WORKDIR}/vendor/broadcom/wlan/dhd/linux && make clean && touch ${WORKDIR}/clean0
cd ${LINUXDIR} && make clean && make mrproper && make distclean && touch ${WORKDIR}/clean1
