%include "../LIB/pc_iox.inc"

section .text
    global _start

_start:

.incisoA:
    call getche
    mov bl, al
    mov al, 10              ;cambio de linea
    call putchar
    cmp bl, 'a'             ;comparar caracter con 'a'
    jb .A_no_en_rango
    cmp bl, 'z'             ;comparar caracter con 'z'
    ja .A_no_en_rango
    cmp bl, 'm'             ;comparar caracter con 'm'
    jb .menor_que_M
    jmp .incisoB

    .A_no_en_rango:
        mov edx, A_MsgError
        call puts
        jmp .incisoB

    .menor_que_M:
        mov edx, A_MsgMenor
        call puts

.incisoB:
    call getche
    mov bl, al
    mov al, 10              ;cambio de linea
    call putchar
    cmp bl, '0'             ;comparar caracter con 0
    jb .B_no_en_rango
    cmp bl, '9'             ;comparar caracter con 9
    jbe .B_es_numero
    cmp bl, 'A'             ;comparar caracter con A
    jb .B_no_en_rango
    cmp bl, 'Z'             ;comparar caracter con Z
    jbe .B_es_letra
    jmp .B_no_en_rango

    .B_es_letra:
        mov edx, B_es_letra
        call puts
        jmp .incisoC

    .B_es_numero:
        mov edx, B_es_numero
        call puts
        jmp .incisoC

    .B_no_en_rango:
        mov edx, B_no_en_rango
        call puts

.incisoC:
    mov CX, 4
    .C_loop_i:
        mov BX, CX
        .C_loop_j:
        mov AL, '*'
        call putchar
        dec BX
        cmp BX, 0
        ja .C_loop_j
        mov AL, 10
        call putchar
        dec CX
        cmp CX, 0
        ja .C_loop_i

.incisoD:
    mov CX, 10
    .D

; Fin del programa

    mov eax, 1              ;system call number (sys_exit) -- fin del programa
	int 0x80                ;call kernel

section .data
A_MsgError db 'El caracter tiene que estar en rango a-z',0xa,0
A_MsgMenor db 'El caracter es menor que m',0xa,0
B_es_letra db 'El caracter es una letra',0xa,0
B_es_numero db 'El caracter es un numero',0xa,0
B_no_en_rango db 'El caracter debe estar en rango [0-9] o [A-Z]',0xa,0