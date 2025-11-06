%include "../LIB/pc_iox.inc"

N equ 5

section .data
    V1 db 1,2,3,4,5
    V2 db 1,2,3,4,5
    P_Escalar dw 0

section .text
    global _start

_start:
    mov ecx, N
    mov ebx, V1
    call Capturar

    mov ecx, N
    mov ebx, V2
    call Capturar

    mov ecx, N
    mov ebx, V1
    mov edx, V2
    .loop_P_Escalar:
        mov al, [ebx]
        mul al, [edx]
        add al, [P_Escalar]
        mov [P_Escalar], ax
        inc ebx
        inc edx 

    mov ecx, N
    mov ebx, V1
    mov edx, V2
    call Sumar

    mov ecx, N
    mov ebx, V1
    call Desplegar

    ; Fin del programa
    mov eax, 1              ;system call number (sys_exit) -- fin del programa
	int 0x80                ;call kernel

Capturar:
    ;Validar que ecx no sea mayor a N
    cmp ecx, N
    ja .Fin_Capturar
    .loop_Capturar:
        ;Capturar dato
        call getch

        ;Validar que el caracter sea un numero
        cmp al, 30h
        jb .loop_Capturar
        cmp al, 39h
        ja .loop_Capturar

        ;Mostrar y Guardar dato
        call putchar
        sub al, 30h
        mov [ebx], al
        inc ebx
        mov al, ' '
        call putchar
        loop .loop_Capturar
        call C_Linea
        .Fin_Capturar:
        ret

Desplegar:
    ;Validar que ecx no sea mayor a N
    cmp ecx, N
    ja .Fin_Desplegar

    .loop_Desplegar:
        mov al, [ebx]
        call pHex_b
        inc ebx
        mov al, ' '
        call putchar
        loop .loop_Desplegar
        call C_Linea
        .Fin_Desplegar:
        ret

Sumar:
    ;Validar que ecx no sea mayor a N
    cmp ecx, N
    ja .Fin_Sumar
    .loop_Sumar:
        mov al, [ebx]
        add al, [edx]
        mov [ebx], al
        inc ebx
        inc edx
        loop .loop_Sumar
        .Fin_Sumar:
        ret


C_Linea:
    push eax
    mov al, 10
    call putchar
    pop eax
    ret