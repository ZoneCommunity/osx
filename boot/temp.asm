[bits 16]
[org 0x7c00]

; bios parameter block needed
call cls
call print
call keyboard ; terminal, get keyboard input

jmp $

; I have no idea why this works or whatever but it does

cls:
    mov ah, 0x00
    mov al, 0x03       ; text mode 80x25 16 colors
    int 0x10
    ret
print:
    mov si, hello ; Move the offset of hello to SI
    call print_loop
    ; Move to the next line
    mov ah, 2         ; Set cursor position function
    mov dh, 1         ; Move to the next row
    mov dl, 0         ; Column
    int 10h           ; Call video interrupt
    mov si, hello2
    call print_loop

print_loop:
    mov ah, 0x0e       ; Function 0x0E - Teletype output
    mov al, [si]       ; Load the byte at address pointed by SI into AL
    int 0x10           ; Call video interrupt
    inc si             ; Move to the next character

    cmp byte [si], 0   ; Check if the next character is the null terminator
    jne print_loop     ; If not, continue printing

    ret

keyboard:
    mov ah, 0       ; Function 0 - Read keyboard input
    int 0x16        ; Call keyboard interrupt
    mov ah, 0x0e     ; Function 0x0E - Teletype output
    int 0x10        ; Call video interrupt

; hello:                 ; String
;    db "Hello, world! This is ZoneOS :)", 0   ; Null-terminated string

;temp
hello db "Hello, world! This is ZoneOS :)", 0
hello2 db "Type your command below!", 0

times 510 - ($-$$) db 0 ; Fill the rest of the sector with zeros
dw 0xAA55
