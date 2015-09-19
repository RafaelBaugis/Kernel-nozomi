#!/bin/bash

if [ $(whoami) = root ]; then
	echo 'You are' $(whoami)
else
	echo 'You are '$(whoami)', run this as ROOT!' && exit
fi