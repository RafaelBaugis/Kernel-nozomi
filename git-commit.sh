#!/bin/bash

source ./rootcheck.sh

source ./config.sh

source ./realclean.sh

cd ${WORKDIR}

if [ -f clean0 ] && [ -f clean1 ]; then
	rm clean0 && rm clean1
	git add .
	git commit -a && touch commit
fi

if [ -f commit ]; then
	git push -u origin master && rm commit
fi

echo 'hit <Enter> to close!!!'; read
