#!/bin/bash

##################### Options ################
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
