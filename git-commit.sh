#!/bin/bash

############################ Options #########
export RAMDISK=lzma  #"lzo","gz","bz2","lzma"#
export KERNEL=Image  #"Image","zImage"       #
export ANDROID=jb    #"jb","kk"              #
export RECOVERY=CWM  #"CWM","TWRP"           #
##############################################

export WORKDIR=$(pwd)
export LINUXDIR="$WORKDIR"/kernel
export CROSS_COMPILE=/usr/bin/arm-linux-gnueabi-
export CC="$CROSS_COMPILE"gcc
export CXX="$CROSS_COMPILE"g++
export ARCH=arm
export FLAGS='cc-option,-marm,-mlittle-endian,-mtune=cortex-A8,-mfpu=neon,-mfloat-abi=hard,-mabi=aapcs-linux,-mno-thumb-interwork,-march=armv7-a,-march=armv5t -Wa,-march=armv7-a'
export LINUXVER=3.4.0
export FS=fs-"$ANDROID"
export KBUILD_BUILD_USER=RafaeL_
export KBUILD_BUILD_HOST=_BaugiS

ls -l $CROSS_COMPILE*
	find $WORKDIR -name '*.sh' -exec chmod a+x {} \;
	find $WORKDIR -name '*.pl' -exec chmod a+x {} \;
	find $WORKDIR -name '*.py' -exec chmod a+x {} \;
	find $WORKDIR -name '*.elf' -exec rm -Rf {} \;
	find $WORKDIR/vendor/semc/build/ -name 'ramdisk.*.cpio' -exec rm -Rf {} \;
	find $WORKDIR/vendor/semc/build/sin -name 'ramdisk.*' -exec rm -Rf {} \;
	find $WORKDIR/vendor/semc/build/$FS -name '*.ko' -exec rm -Rf {} \;
	find $WORKDIR/vendor/semc/build/sin -name '*mage' -exec rm -Rf {} \;
cd $WORKDIR/vendor/broadcom/wlan/dhd/linux && make clean && touch $WORKDIR/clean0
cd $LINUXDIR && make clean && make mrproper && make distclean && touch $WORKDIR/clean1

cd $WORKDIR
if [ -f clean0 ] && [ -f clean1 ]; then
	rm clean0 && rm clean1
	git add .
	git commit -a && touch commit
fi

if [ -f commit ]; then
	git push -u origin master && rm commit
fi
echo 'hit <Enter> to close!!!'; read