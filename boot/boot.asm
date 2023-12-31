; boot.asm - 64-bit bootloader
section .text
    global _start

_start:
    ; Set up the stack pointer
    mov rsp, stack

    ; Load the kernel into memory
    mov dl, 0    ; Drive number (0 for floppy, 80h for hard drive)
    call load_kernel

    ; Jump to the kernel
    jmp kernel

load_kernel:
    ; Set up disk read parameters
    mov ah, 2        ; BIOS read sector function
    mov al, 1        ; Number of sectors to read
    mov ch, 0        ; Cylinder number
    mov dh, 0        ; Head number
    mov cl, 2        ; Sector number
    mov bx, kernel   ; Buffer address

    ; Int 13h BIOS interrupt for disk I/O
    int 0x13

    ; Check if read was successful (AH should be 0)
    cmp ah, 0
    jne load_kernel   ; If not, try again

    ret

section .bss
    stack resb 4096   ; 4 KB stack

section .data
    kernel db 512     ; Buffer for the kernel
