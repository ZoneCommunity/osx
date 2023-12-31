#!/bin/bash

# Assemble boot.asm to raw binary file
nasm -f bin -o build/boot.bin boot.asm

# Delete the previous ISO if it exists
rm -f ../ISO/os.iso

# Create ISO image (macOS only)
hdiutil makehybrid -o ../ISO/os.iso -hfs -iso -no-emul-boot -boot-load-size 4 -eltorito-boot build/boot.bin .

# Boot with the ISO using QEMU
qemu-system-x86_64 -cdrom ../ISO/os.iso
