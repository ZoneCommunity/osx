[bits 16]
[org 0x7c00]

section .text
    jmp start

cls:
    mov ah, 0x00
    mov al, 0x03           ; text mode 80x25 16 colors
    int 0x10
    ret

print:
    mov si, hello           ; Move the offset of hello to SI
    call print_loop
    ; Move to the next line
    mov ah, 2               ; Set cursor position function
    inc dh               ; Move to the next row   --- inc dh (no comma) to just go to the next line
    mov dl, 0               ; Column
    int 10h                 ; Call video interrupt
    mov si, hello2
    call print_loop
    mov ah, 2               ; Set cursor position function
    inc dh               ; Move to the next row   --- inc dh (no comma) to just go to the next line
    mov dl, 0               ; Column
    int 10h                 ; Call video interrupt

print_loop:
    mov ah, 0x0e            ; Function 0x0E - Teletype output
    mov al, [si]            ; Load the byte at address pointed by SI into AL
    int 0x10                ; Call video interrupt
    inc si                  ; Move to the next character

    cmp byte [si], 0        ; Check if the next character is the null terminator
    jne print_loop          ; If not, continue printing

    ret

keyboard:
    mov ah, 0               ; Function 0 - Read keyboard input
    int 0x16                ; Call keyboard interrupt
    mov ah, 0x0e            ; Function 0x0E - Teletype output
    int 0x10                ; Call video interrupt
    ret

start:
    call cls
    call print
    
input_loop:
    call keyboard           ; terminal, get keyboard input
    cmp al, 13              ; Check if Enter key is pressed
    je process_input
    jmp input_loop          ; Repeat the loop for other keys

process_input:
    ; Process the entered command (you can implement this part)
    ; The typed characters are stored in the buffer.

    ; For now, let's just print the typed characters.
    mov si, buffer
    call print_loop

    ; Move to the next line
    mov ah, 2               ; Set cursor position function
    inc dh                  ; Move to the next row
    mov dl, 0               ; Reset column to 0
    int 10h                 ; Call video interrupt

    ; Clear the buffer for the next input
    mov si, buffer
    xor cx, cx
    mov cx, buffer_size   ; Use buffer_size instead of a hard-coded value
    rep stosb


    jmp input_loop          ; Repeat the input loop



hello db "Hello, world! This is ZoneOS :)", 0
hello2 db "Type your command below!", 0
buffer db 0            ; Buffer to store typed characters
buffer_size equ 10     ; Size of the buffer

times 510 - ($-$$) db 0   ; Fill the rest of the sector with zeros
dw 0xAA55