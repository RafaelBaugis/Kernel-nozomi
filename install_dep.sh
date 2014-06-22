#!/bin/bash

sudo apt-get update && \
if [ "$(uname -m)" = "x86_64" ]; then
	sudo apt-get install gnupg openjdk-6-jdk flex bison gperf libsdl1.2-dev perl sparse \
	original-awk libesd0-dev build-essential dpkg-cross qt3-dev-tools lzop lzma gzip zip curl \
	libncurses5-dev zlib1g-dev ia32-libs lib32z1-dev lib32ncurses5-dev gcc-multilib \
	g++-multilib gettext texinfo git-core && sudo apt-get install gcc-4.6-arm-linux-gnueabi && touch apt-ok
else
	sudo apt-get install gnupg openjdk-6-jdk flex bison gperf libsdl1.2-dev perl sparse \
	original-awk libesd0-dev build-essential dpkg-cross qt3-dev-tools lzop lzma gzip zip curl \
	libncurses5-dev zlib1g-dev gettext texinfo git-core && sudo apt-get install gcc-4.6-arm-linux-gnueabi && touch apt-ok
fi

if [ -f apt-ok ]; then
	rm apt-ok
	sudo ln -f -s /usr/bin/arm-linux-gnueabi-cpp-4.6 /usr/bin/arm-linux-gnueabi-cpp
	sudo ln -f -s /usr/bin/arm-linux-gnueabi-gcc-4.6 /usr/bin/arm-linux-gnueabi-gcc
	sudo ln -f -s /usr/bin/arm-linux-gnueabi-gcov-4.6 /usr/bin/arm-linux-gnueabi-gcov
	sudo apt-get clean && sudo apt-get autoremove
	echo 'System	- Up-dated';
else
	echo 'apt-get update	- FAIL'; sleep 5; exit
fi
