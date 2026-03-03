section .data
    num1    dd 5
    num2    dd 10
    msg     db "Result = ", 0
    newline db 10, 0

section .bss
    result  resd 1
    buffer  resb 16

section .text
    global _start

_start:

    ; Use EAX and EBX
    mov eax, [num1]
    mov ebx, [num2]
    add eax, ebx

    ; Use ECX
    mov ecx, 2
    mul ecx

    ; Use EDX
    mov edx, 0

    ; Use ESI
    mov esi, num1
    add eax, [esi]

    ; Use EDI
    mov edi, num2
    add eax, [edi]

    mov [result], eax

    ; Print message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 9
    int 0x80

    ; Convert number to string
    mov eax, [result]
    mov esi, buffer
    call int_to_string

    ; Print number
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 16
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80


; -------- Integer to String --------
int_to_string:
    mov ecx, 10
    mov edi, esi
    add edi, 15
    mov byte [edi], 0

convert:
    dec edi
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz convert

    mov esi, edi
    ret