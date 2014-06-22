#!/bin/bash

cd ./ramdisk/ && find . | cpio -o -H newc | bzip2 > ../sin/ramdisk.bz2
