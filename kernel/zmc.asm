[bits 16]
[org 0x7E00]

start:
    ; Clear the screen
    mov ah, 0x00 ; Video BIOS - Set Video Mode
    mov al, 0x03 ; Video Mode 3 (80x25 text mode)
    int 0x10 ; BIOS interrupt for video services

    mov si, hello_string ; Load the address of the string into SI register

print_loop:
    ; Print the character at the current SI address
    mov ah, 0x0E ; Video BIOS - Teletype Output
    mov al, [si] ; Load the character from the address pointed by SI
    cmp al, 0 ; Check if it's the null terminator (end of string)
    je end_print ; If yes, jump to the end of printing
    int 0x10 ; Print character

    ; Move to the next character in the string
    inc si

    ; Jump back to the start of the loop
    jmp print_loop

end_print:

hello_string db 'Hello World!', 0

times 510 - ($ - $$) db 0 ; Pad the rest of the sector with zeros
dw 0xAA55 ; Boot signature
