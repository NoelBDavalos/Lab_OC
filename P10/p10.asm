global suma
global strlenn
global getBit

section .data

section .text

suma:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    add eax, [ebp+12]

    pop ebp
    ret

strlenn:
    push ebp
    mov ebp, esp

    mov edx, [ebp+8]
    mov ecx, 0
    .contar:
        cmp Byte[edx], 0
        je fin
        inc edx
        inc ecx
        jmp .contar
    fin:
    pop ebp
    ret
