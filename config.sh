#!/bin/bash

##################### Options ################
export RAMDISK=lzma  #"lzo","gz","bz2","lzma"#
export KERNEL=Image  #"Image","zImage"       #
export ANDROID=jb    #"jb","kk"              #
export RECOVERY=CWM  #"CWM","TWRP"           #
export GCCV=4.6      #"4.6","4.7"            #
##############################################

export KBUILD_BUILD_USER=RafaeL_
export KBUILD_BUILD_HOST=_BaugiS
export LINUXVER=3.4.0
export FS=fs-${ANDROID}

export WORKDIR=$(pwd)
export LINUXDIR=${WORKDIR}/kernel

export TOOLCHAINS_HOME=/usr
export CROSS_COMPILE_PATH=${TOOLCHAINS_HOME}/bin
export CROSS_COMPILE=${CROSS_COMPILE_PATH}/arm-linux-gnueabi-
export CC=${CROSS_COMPILE}gcc
export CXX=${CROSS_COMPILE}g++

export LIBS="-L${TOOLCHAINS_HOME}/lib \
-L${TOOLCHAINS_HOME}/arm-linux-gnueabi/lib \
-L${TOOLCHAINS_HOME}/lib/gcc/arm-linux-gnueabi/${GCCV}"

export INCLUDES="-I${TOOLCHAINS_HOME}/include \
-I${TOOLCHAINS_HOME}/arm-linux-gnueabi/include \
-I${TOOLCHAINS_HOME}/lib/gcc/arm-linux-gnueabi/${GCCV}/include \
-I${TOOLCHAINS_HOME}/lib/gcc/arm-linux-gnueabi/${GCCV}/include-fixed"

export ARCH=arm
export FLAGS='cc-option,-marm,-mlittle-endian,-mtune=cortex-A8,-mfpu=neon, \
-mfloat-abi=hard,-mabi=aapcs-linux,-mno-thumb-interwork,-march=armv7-a, \
-march=armv5t,-Wa,-march=armv7-a'
