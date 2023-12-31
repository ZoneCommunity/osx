[bits 32]
[org 0x8000]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

start:
    ; Set up the stack
    mov ax, 0x7C0
    add ax, 288
    mov ss, ax
    mov sp, 4096

    hlt

hello_string db 'Hello, World!', 0

times 510 - ($ - $$) db 0
dw 0xAA55
