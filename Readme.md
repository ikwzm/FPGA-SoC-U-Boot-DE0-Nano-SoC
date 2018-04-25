FPGA-SoC-U-Boot-DE0-Nano-SoC
====================================================================================

Overview
------------------------------------------------------------------------------------

### Introduction

This Repository provides a U-Boot Image for DE0-Nano-SoC.

### Features

* U-Boot v2017.11 (customized)
  + Build for DE0-Nano-SoC
  + Customized boot by uEnv.txt
  + Customized boot by boot.scr
  + Enable bootmenu

Install U-boot to SD-Card
------------------------------------------------------------------------------------

### Format SD-Card

https://github.com/ikwzm/FPGA-SoC-Linux/blob/master/doc/install/format-disk-de0-nano-soc.md

### Write to SD-Card

Write u-boot-spl.sfp and u-boot.img to the partition of the youngest sector number of SD-Card.

For example, when formatting SD-Card as shown in the previous section, U-Boot writes to partition-3 of SD-Card as follows.

```console
shell$ dd if=u-boot-spl.sfp of=/dev/sdc3 bs=64k seek=0
shell$ dd if=u-boot.img     of=/dev/sdc3 bs=64k seek=4
```

Build U-boot for DE0-Nano-SoC
------------------------------------------------------------------------------------

There are two ways

1. run scripts/build-u-boot-2017.11-de0-nano-soc.sh (easy)
2. run this chapter step-by-step (annoying)

### Download U-boot Source

#### Clone from git.denx.de/u-boot.git

```console
shell$ git clone git://git.denx.de/u-boot.git u-boot-2017.11-de0-nano-soc
```

#### Checkout v2017.11

```console
shell$ cd u-boot-2017.11-de0-nano-soc
shell$ git checkout -b u-boot-2017.11-de0-nano-soc refs/tags/v2017.11
```

### Patch for de0-nano-soc

```console
shell$ patch -p0 < ../files/u-boot-2017.11-de0-nano-soc.diff
shell$ git add --update
shell$ git commit -m "patch for de0-nano-soc"
shell$ git tag -a 2017.11-de0-nano-soc -m "Release 2017.11 for de0-nano-soc"
```

### Setup for Build 

```console
shell$ cd u-boot-2017.11-de0-nano-soc
shell$ export ARCH=arm
shell$ export CROSS_COMPILE=arm-linux-gnueabihf-
shell$ make socfpga_de0_nano_soc_defconfig
```

### Build u-boot

```console
shell$ make
```

### Copy u-boot.img, u-boot.elf and u-boot-spl.sfp to root directory

```console
shell$ cp spl/u-boot-spl.sfp ../u-boot-spl.sfp
shell$ cp u-boot.img         ../u-boot.img
```
