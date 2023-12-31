bits 16
org 0x7c00

jmp main

Message db "Hello World!! THIS IS DOS!!!", 0x0
AnyKey db "Press any key to Shutdown", 0x0

Println:
	lodsb
	or al, al
	jz complete
	mov ah, 0x0e
	int 0x10
	jmp Println
complete:
	call PrintNwl

PrintNwl:
	mov al, 0
	stosb
	mov ah, 0x0E
	mov al, 0x0D
	int 0x10
	mov al, 0x0A
	int 0x10
		ret

Shutdown:
    mov ax, 0x1000
    mov ax, ss
    mov sp, 0xf000
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15
	ret
	
Boot:
    mov si, Message
    call Println
	mov si, AnyKey
	call Println

	call GetPressedKey
	
	call Println

GetPressedKey:
	mov ah, 01h
	int 0x16

	call Println
	ret

main:
	cli
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ss,ax
	sti

	call Boot

times 510 - ($-$$) db 0
dw 0xAA55