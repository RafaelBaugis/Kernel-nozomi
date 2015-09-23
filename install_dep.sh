#!/bin/bash

source ./config.sh

apt-get update && \
if [ "$(uname -m)" = "x86_64" ]; then
	apt-get -f install --reinstall gnupg openjdk-6-jdk flex bison gperf libsdl1.2-dev perl sparse \
	original-awk libesd0-dev build-essential dpkg-cross qt4-dev-tools lzop lzma gzip zip curl \
	zlib1g-dev libncurses5-dev gettext texinfo git-core lib32z1-dev lib32ncurses5-dev gcc-multilib \
	g++-multilib && apt-get install ${GCCV}-arm-linux-* && touch apt-ok
else
	apt-get -f install --reinstall gnupg openjdk-6-jdk flex bison gperf libsdl1.2-dev perl sparse \
	original-awk libesd0-dev build-essential dpkg-cross qt4-dev-tools lzop lzma gzip zip curl \
	zlib1g-dev libncurses5-dev gettext texinfo git-core && apt-get install ${GCCV}-arm-linux-* && touch apt-ok
fi

if [ -f apt-ok ]; then
	rm apt-ok
	ln -f -s /usr/bin/moc-qt4 /usr/bin/moc
	ln -f -s /usr/bin/arm-linux-gnueabi-cpp-${GCCV} /usr/bin/arm-linux-gnueabi-cpp
	ln -f -s /usr/bin/arm-linux-gnueabi-gcc-${GCCV} /usr/bin/arm-linux-gnueabi-gcc
	ln -f -s /usr/bin/arm-linux-gnueabi-gcov-${GCCV} /usr/bin/arm-linux-gnueabi-gcov
	apt-get clean && sudo apt-get autoremove
	echo 'System	- Up-dated';
	export INSTDEP=1
else
	echo 'apt-get update	- FAIL'; sleep 5; exit
fi
