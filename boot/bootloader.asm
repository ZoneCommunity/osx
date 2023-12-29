[bits 16] ; 16 bit (i think)
[org 0x7c00] ; nasm where code is or whatever

; need bios parameter path for real device i think


; idk what im doing lol, this is just 
; going to print something
; i'll make a term soon
mov si, 0 ; move 0 to the si register, counter to print
; the characters [hello]

print:                      ; print the characters
    mov ah, 0x0e            ; call to print characters
    mov al, [hello + si]    ; move hello in al
    int 0x10                ; trigger video inteurpt
    add si, 1               ; add 1 to si
    cmp byte [hello + si], 0     ; see if memory contains 0
    jne print               ; if it doesn't print next char

hello:                      ; string
    db "Hello, world!", 0   ; 0 bytes

times 510 - ($-$$) db 0 ; fills rest of program with 0's for sector
dw 0xAA55