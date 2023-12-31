#!/bin/bash

# Compile kernel.c to object file
clang -c -m64 -ffreestanding -o kernel.o kernel.c

# Assemble boot.asm to object file
nasm -f elf64 -o boot.o boot.asm

# Link object files to create a kernel binary
ld -o kernel.bin boot.o kernel.o

# Create ISO directory if it doesn't exist
mkdir -p iso

# Copy kernel binary to ISO directory
cp kernel.bin iso/

# Create ISO image using cdrtools (genisoimage)
hdiutil makehybrid -o os.iso -hfs -iso -no-emul-boot -boot-load-size 4 -eltorito-boot iso/kernel.bin iso/
