[bits 16]
[org 0x7c00]

start:
    ; Set up the stack
    mov ax, 0x7C0
    add ax, 288
    mov ss, ax
    mov sp, 4096

    ; Clear the screen
    mov ah, 0x00 ; Video BIOS - Set Video Mode
    mov al, 0x03 ; Video Mode 3 (80x25 text mode)
    int 0x10 ; BIOS interrupt for video services

    ; Load the GDT
    lgdt [gdt_descriptor]

    ; Enable protected mode
    cli
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    ; Jump to protected mode
    jmp 0x08:init_protected_mode

[bits 32]
init_protected_mode:
    ; Set up data segment
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Use the Multiboot header to get the kernel address
    mov ebx, 0x8000 ; The address where GRUB loads the Multiboot information
    mov eax, [ebx+8] ; Get the address of the module structure
    mov ebx, [eax+4] ; Get the starting address of the module (kernel)

    ; Jump to the loaded kernel
    jmp ebx ; Jump to the kernel's entry point

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; Size of the GDT
    dd gdt_start ; Address of the GDT

gdt_start:
    ; Null descriptor
    dd 0
    dd 0

    ; Code segment descriptor
    dw 0xFFFF ; Limit low (0-15)
    dw 0 ; Base low (0-15)
    db 0 ; Base middle (16-23)
    db 10011010b ; Access byte: present, ring 0, code, readable
    db 11001111b ; Granularity byte: 32-bit, 4K

    ; Data segment descriptor
    dw 0xFFFF ; Limit low (0-15)
    dw 0 ; Base low (0-15)
    db 0 ; Base middle (16-23)
    db 10010010b ; Access byte: present, ring 0, data, expand-down
    db 11001111b ; Granularity byte: 32-bit, 4K

gdt_end:

times 510 - ($ - $$) db 0 ; Pad the rest of the sector with zeros
dw 0xAA55 ; Boot signature
