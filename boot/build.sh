#!/bin/bash

# Assemble boot.asm to raw binary file
nasm -f bin -o build/boot.bin boot.asm

# Delete the previous ISO if it exists
# rm -f ../ISO/os.iso

# Create ISO image (macOS only) for the future, currently broken
# hdiutil makehybrid -o ../ISO/os.iso -hfs -iso -no-emul-boot -boot-load-size 4 -eltorito-boot build/boot.bin .

# Boot with the ISO using QEMU
qemu-system-i386 -drive  file=build/boot.bin,format=raw -monitor stdio
