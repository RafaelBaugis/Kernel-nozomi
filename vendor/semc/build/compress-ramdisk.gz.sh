#!/bin/bash

cd ./ramdisk/ && find . | cpio -o -H newc | gzip > ../sin/ramdisk.gz
