#!/bin/bash

source ./config.sh

source ./realclean.sh

cd ${WORKDIR}

if [ -f clean0 ] && [ -f clean1 ]; then
	rm clean0 && rm clean1
	if [ ! -f commit ]; then
		git add .
		git commit -a && touch commit
	fi
fi

if [ -f commit ]; then
	git push -u origin master && rm commit
fi

echo 'hit <Enter> to close!!!'; read
