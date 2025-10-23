%include "../LIB/pc_iox.inc"

section .text

    global _start

_start:
    mov ebx, 0x5C4B2A60
    mov eax, ebx
    call pHex_dw            ;imprime hex base
    mov al, 10              ;cambio de linea
    call putchar

    add ebx, 0x2208409      ;sumar matricula a ebx
    mov eax, ebx
    call pHex_dw            ;imprime inciso a (imprime ebx)
    mov al, 10              ;cambio de linea
    call putchar

    push bx                 ;mover bx a pila
    mov ax, [esp]
    call pHex_w             ;imrpime inciso b (imprime [esp], valor en pila)
    mov al, 10              ;cambio de linea
    call putchar

    mov al, 8
    mul bl                  ;multiplica el valor en n (8) por bl
    mov [n], ax             ;guardar resultado en n
    call pHex_w             ;imrpime inciso c (valor guardado en n)
    mov al, 10              ;cambio de linea
    call putchar

    inc word[n]             ;incrementar en 1 el valor guardado en n
    mov ax, word[n]         ;guardar n en ax para imprimir
    call pHex_w             ;imrpime inciso d (n incrementado en 1)
    mov al, 10              ;cambio de linea
    call putchar

    mov ax, bx              ;mover BX a AX (dividendo)
    mov bl, 0xFF            ;divisor
    div bl                  ;AX / BL → AL = cociente, AH = residuo
    call pHex_b             ;imrpime inciso e (Cociente guardado en AL)
    mov al, 10              ;cambio de linea
    call putchar
    mov al, AH              ;mueve ah a al para imprimir el residuo
    call pHex_b             ;imprime inciso e (Residuo que se guardó en AH)
    mov al, 10              ;cambio de linea
    call putchar

    mov ax, [n]             ; cargar valor de N (16 bits)
    mov bl, al              ; cargar residuo (8 bits)
    mov bh, 0               ; limpiar parte alta de BX
    add ax, bx              ; AX = N + residuo
    call pHex_w             ; imprimir inciso f(resultado de la suma)
    mov al, 10              ;cambio de linea
    call putchar

    mov word[n], ax         ;guardar el valor en N
    dec word[n]             ;decrementar el valor en n
    mov ax, word[n]         ;cargar n para imprimir
    call pHex_w             ;imprimir n
    mov al, 10              ;cambio de linea
    call putchar
    pushf                   ;empuja las banderas a la pila
    pop ax                  ;saca las banderas a AX
    call pHex_w             ; imprimir inciso g(valor de AX (FLAGS))
    mov al, 10
    call putchar

    pop ax                  ; saca el valor de la pila a AX
    call pHex_w             ; imprime el valor sacado
    mov al, 10
    call putchar

    mov eax, 1              ;system call number (sys_exit) -- fin del programa
	int 0x80                ;call kernel

section .data

    n dw 0                  ;declarar variable de 2 bytes  
