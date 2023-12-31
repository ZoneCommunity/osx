[bits 32]
[org 0x8000]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; Load character from memory into AL
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je print_string_pm_done

    mov [edx], ax ; Store character and attribute in video memory
    add ebx, 1
    add edx, 2

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret

start:
    ; Set up the stack
    mov ax, 0x7C0
    add ax, 288
    mov ss, ax
    mov sp, 4096

    mov ebx, hello_string
    call print_string_pm

    hlt

hello_string db 'Hello, World!', 0

times 510 - ($ - $$) db 0
dw 0xAA55
