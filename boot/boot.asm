[bits 16]
[org 0x7c00]

start:
    ; Load the kernel
    mov ax, 0x07E0 ; Segment to load kernel
    mov es, ax
    mov bx, 0x0000 ; Offset to load kernel
    mov ah, 0x02 ; Function to read disk sectors
    mov al, 1 ; Number of sectors to read
    mov ch, 0 ; Cylinder number
    mov cl, 2 ; Sector number
    mov dh, 0 ; Head number
    int 0x13 ; BIOS interrupt for disk I/O

    ; Jump to the loaded kernel
    jmp 0x07E0:0 ; Jump to the kernel's entry point

times 510 - ($ - $$) db 0 ; Pad the rest of the boot sector with zeros
dw 0xAA55 ; Boot signature