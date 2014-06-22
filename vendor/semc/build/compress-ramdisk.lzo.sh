#!/bin/bash

cd ./ramdisk/ && find . | cpio -o -H newc | lzop > ../sin/ramdisk.lzo
