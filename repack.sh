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
cd $WORKDIR

find $WORKDIR/vendor/broadcom $LINUXDIR -name '*.ko' -exec cp -f -v {} ./vendor/semc/build/$FS/lib/modules \;
find $LINUXDIR -name "$KERNEL" -exec cp -f -v {} ./vendor/semc/build/sin/$KERNEL \;

cd $WORKDIR/vendor/semc/build/

chmod -R 750 $FS/*
chmod 644 $FS/*.png
chmod 644 $FS/*.rle
	chmod 755 $FS/lib
	chmod 755 $FS/lib/modules
	chmod 644 $FS/lib/modules/*.ko
	chmod 755 $FS/sbin
	chmod 750 $FS/sbin/*
	
	chmod 755 $FS/res
	chmod 644 $FS/res/*
		chmod 755 $FS/res/images
		chmod 644 $FS/res/images/*
			chmod 755 $FS/res/images/charger
			chmod 644 $FS/res/images/charger/*
	
mkdir -p -m 755 $FS/data
mkdir -p -m 755 $FS/dev
mkdir -p -m 755 $FS/proc
mkdir -p -m 755 $FS/sys
mkdir -p -m 755 $FS/system
mkdir -p -m 755 $FS/tmp

chmod 755 $FS/data
chmod 755 $FS/dev
chmod 755 $FS/proc
chmod 755 $FS/sys
chmod 755 $FS/system
chmod 755 $FS/tmp

cd $WORKDIR/vendor/semc/build/$FS && find . | cpio -o -H newc > ../ramdisk/sbin/ramdisk.cpio

cd $WORKDIR/vendor/semc/build/

chmod -R 750 $RECOVERY-recovery/*
	chmod 755 $RECOVERY-recovery/sbin
	chmod 750 $RECOVERY-recovery/sbin/*
	
	chmod 755 $RECOVERY-recovery/res
	chmod 644 $RECOVERY-recovery/res/*
		chmod 755 $RECOVERY-recovery/res/images
		chmod 644 $RECOVERY-recovery/res/images/*
	
mkdir -p -m 755 $RECOVERY-recovery/data
mkdir -p -m 755 $RECOVERY-recovery/dev
mkdir -p -m 755 $RECOVERY-recovery/proc
mkdir -p -m 755 $RECOVERY-recovery/sys
mkdir -p -m 755 $RECOVERY-recovery/system
mkdir -p -m 755 $RECOVERY-recovery/tmp

chmod 755 $RECOVERY-recovery/data
chmod 755 $RECOVERY-recovery/dev
chmod 755 $RECOVERY-recovery/proc
chmod 755 $RECOVERY-recovery/sys
chmod 755 $RECOVERY-recovery/system
chmod 755 $RECOVERY-recovery/tmp

cd $WORKDIR/vendor/semc/build/$RECOVERY-recovery &&  find . | cpio -o -H newc > ../ramdisk/sbin/ramdisk-recovery.cpio

cd $WORKDIR/vendor/semc/build/

chmod -R 750 ramdisk/*
chmod 644 ramdisk/*.rle
	chmod 755 ramdisk/sbin
	chmod 750 ramdisk/sbin/*

cd $WORKDIR/vendor/semc/build && sh ./compress-ramdisk.$RAMDISK.sh && cd $WORKDIR

if [ -f ./vendor/semc/build/sin/$KERNEL ] && [ -f ./vendor/semc/build/sin/ramdisk.$RAMDISK ] && [ -f ./vendor/semc/build/sin/rpm.bin ]; then
	
	cd $WORKDIR/vendor/semc/build/sin/
	
	echo "console=ttyHSL0,115200,n8 androidboot.hardware=semc user_debug=31 androidboot.baseband=msm" > cmdline.txt
	
	perl mkelf.py -o kernel-unsigned.elf $KERNEL@0x40208000 \
	    ramdisk.$RAMDISK@0x41300000,ramdisk \
	    rpm.bin@0x00020000,rpm \
	    cmdline.txt@cmdline

	cd $WORKDIR

	find ./vendor -name 'kernel-unsigned.elf' -exec mv -f -v {} ./ \;

	echo 'All done.'; sleep 5
else
	echo 'Error - Compile Fail!!!'; sleep 5; exit
fi
