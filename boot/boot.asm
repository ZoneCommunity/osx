[bits 16]

section .text
    jmp start

start:
    jmp $

times 510 - ($-$$) db 0   ; Fill the rest of the sector with zeros
dw 0xAA55
