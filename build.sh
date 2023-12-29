#!/bin/bash

# Assemble the bootloader using NASM
nasm boot/bootloader.asm

# Run QEMU with the assembled bootloader
qemu-system-i386 -drive file=boot/bootloader,format=raw -monitor stdio