#!/bin/bash

UBOOT_BUILD_DIR=u-boot-2017.11-de0-nano-soc

### Download U-Boot Source
git clone git://git.denx.de/u-boot.git $UBOOT_BUILD_DIR
cd $UBOOT_BUILD_DIR

#### Checkout v2017.11
git checkout -b u-boot-2017.11-de0-nano-soc refs/tags/v2017.11

### Patch for de0-nano-soc

patch -p0 < ../files/u-boot-2017.11-de0-nano-soc.diff
git add --update
git commit -m "patch for de0-nano-soc"

git tag -a 2017.11-de0-nano-soc -m "Release 2017.11 for de0-nano-soc"

### Setup for Build 

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
make socfpga_de0_nano_soc_defconfig

### Build u-boot

make

### Copy u-boot-spl.sfp and u-boot.img de0-nano-soc/u-boot/

cp spl/u-boot-spl.sfp ../u-boot-spl.sfp
cp u-boot.img         ../u-boot.img
cd ..
