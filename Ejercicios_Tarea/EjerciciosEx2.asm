%include "../LIB/pc_iox.inc" 

extern pBin_b

section .data
    cadena db "12345", 0
    N db 1

section .text
global _start

_start:
    mov ebx, cadena
    call PrintStr

    call InvertirStr
    call PrintStr

    mov al, 11001010b
    mov cl, [N]
    call TestBit
    pushf
    pop ax
    call pBin_b
    call Salto_Linea

    mov edx, 11
    call esPar
    add al, 0x30
    call putchar
    call Salto_Linea

    mov eax, 1
    int 0x80

;esPar:
;    mov eax, edx
;    and eax, 1
;    xor eax, 1
;    ret

esPar:
    push edx
    push ecx

    mov eax, edx
    mov edx, 0
    mov ecx, 2
    div ecx
    cmp edx, 0
    jz par
    mov al, 0
    jmp finPar
    par:
    mov al, 1

    finPar:
    pop ecx
    pop edx
    ret

TestBit:
    push eax
    
    cmp cl, 7
    ja terminar_testBit

    mov ah, al
    inc cl
    shr ah, cl

    terminar_testBit:
    pop eax
    ret

PrintStr:
    push ebx
    push eax

    imprime_caracter:
        cmp byte[ebx], 0
        je terminar_imprimir
        mov al, [ebx]
        call putchar
        inc ebx
        jmp imprime_caracter

    terminar_imprimir:
    call Salto_Linea

    pop eax
    pop ebx
    ret

;version optimizada:
InvertirStr:
    push esi
    push edi
    push eax

    mov esi, ebx
    mov edi, ebx

    Buscar_Final:
        cmp byte[edi], 0
        je Invertir
        inc edi
        jmp Buscar_Final

    Invertir:
        dec edi

    ciclo_intercambio:
        cmp esi, edi
        jae terminar_invertir
        mov al, [edi]
        mov ah, [esi]
        mov [edi], ah
        mov [esi], al
        inc esi
        dec edi
        jmp ciclo_intercambio

    terminar_invertir:
    pop eax
    pop edi
    pop esi
    ret

;originalmente hice esto:
;InvertirStr:
;    push esi
;    push edi
;    push eax
;
;    mov esi, ebx
;    mov edi, ebx
;
;    Buscar_Final:
;        cmp byte[edi], 0
;        je Invertir
;        inc edi
;        jmp Buscar_Final
;
;    Invertir:
;        dec edi
;
;    ciclo_intercambio:
;        cmp edi, esi
;        jae terminar_invertir
;        mov al, [edi]
;        mov ah, [esi]
;        mov [edi], ah
;        mov [esi], al
;        inc esi
;        dec edi
;        jmp ciclo_intercambio
;
;    terminar_invertir:
;    pop eax
;    pop edi
;    pop esi
;    ret

Salto_Linea:
    push eax
    mov al, 10
    call putchar
    pop eax
    ret

