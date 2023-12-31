#!/bin/bash

# Assemble boot.asm to raw binary file
nasm -f bin -o build/boot.bin boot/boot.asm

# Assemble kernel.asm to raw binary file
nasm -f bin -o build/kernel.bin kernel/zmc.asm

# Create a flat binary image combining the bootloader and kernel
cat build/boot.bin build/kernel.bin > build/os.img

# Boot with QEMU
qemu-system-i386 -drive file=build/os.img,format=raw -monitor stdio
