%include "../LIB/pc_iox.inc"

section .text
    global _start
    extern pBin_dw
    extern pBin_w
    extern pBin_b

_start:
    call clrscr

; a EAX = 0x22446688 → rotar para obtener 0x82244668

    mov eax, 0x22446688
    ror eax, 4              ; rotación a la derecha de 1 byte (4 bits)
    call pHex_dw
    mov al, 10              ;cambio de linea
    call putchar

; b CX = 0x3F48 → obtener 0xFA40 con corrimientos

    mov cx, 0x3F48
    shl cx, 3               ; desplazamiento a la izquierda 2 bits (×4)
    mov ax, cx
    call pHex_w
    mov al, 10              ;cambio de linea
    call putchar

; c ESI = 0x20D685F3 → invertir bits 0,5,13,18,30

    mov esi, 0x20D685F3
    xor esi, 0x40042021     ; máscara (bits 0,5,13,18,30)
    mov eax, esi
    call pBin_dw
    mov al, 10
    call putchar
    call pHex_dw
    mov al, 10
    call putchar

; d Guardar ESI en la pila

    push esi

; e CH = 0xA7 → activar bits 3 y 6

    mov ch, 0xA7
    or ch, 0x48             ; activar bits 3 y 6
    mov al, ch
    call pBin_b
    mov al, 10
    call putchar

; f BP = 0x67DA → desactivar bits 1,4,6,10,14

    mov bp, 0x67DA
    and bp, 1011101110101101b          ; máscara de bits a apagar
    mov ax, bp
    call pBin_w
    mov al, 10
    call putchar

; g Dividir BP entre 8 (shift right 3 bits)

    shr bp, 3
    mov ax, bp
    call pBin_w
    mov al, 10
    call putchar

; h Dividir EBX entre 32 (→ shift right 5 bits)

    mov ebx, 0xABCDEFAB     ;ejemplo
    mov eax, ebx
    call pBin_dw            ;imprimir ejemplo
    mov al, 10
    call putchar
    shr ebx, 5
    mov eax, ebx
    call pBin_dw            ;imprimir resultado
    mov al, 10
    call putchar

; i Multiplicar CX por 8 (→ shift left 3 bits)

    shl cx, 3
    mov ax, cx
    call pBin_w
    mov al, 10              ;cambio de linea
    call putchar

; j Sacar valor de la pila → ESI

    pop esi
    mov eax, esi
    call pHex_dw
    mov al, 10
    call putchar

; k Multiplicar ESI por 10 → (ESI * 8) + (ESI * 2)

    mov eax, esi
    shl esi, 3              ; ESI * 8
    shl eax, 1              ; EAX * 2
    add eax, esi
    call pHex_dw
    mov al, 10              ;cambio de linea
    call putchar

; Fin del programa

    mov eax, 1              ;system call number (sys_exit) -- fin del programa
	int 0x80                ;call kernel

section .data
