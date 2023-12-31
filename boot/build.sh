#!/bin/bash

# Assemble boot.asm to raw binary file
nasm -f bin -o boot.bin boot.asm

# Create ISO directory if it doesn't exist
mkdir -p iso

# Copy boot binary to ISO directory
cp boot.bin iso/

# Create ISO image (macOS only)
hdiutil makehybrid -o os.iso -hfs -iso -no-emul-boot -boot-load-size 4 -eltorito-boot iso/boot.bin iso/