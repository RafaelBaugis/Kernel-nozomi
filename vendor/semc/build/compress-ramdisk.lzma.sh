#!/bin/bash

cd ./ramdisk/ && find . | cpio -o -H newc | lzma > ../sin/ramdisk.lzma
