INCLUDE Irvine32.inc

.data
    permCode BYTE ?
    prompt BYTE "Enter permission code in hex (00-FF): ",0
    msgSusp BYTE "ACCESS DENIED: account is suspended",0
    msgDenied BYTE "ACCESS DENIED: general and laboratory access required",0
    msgGranted BYTE "ACCESS GRANTED",0
    msgAdmin BYTE "Administrator access enabled",0
    msgUpdated BYTE "Updated permission code (hex): ",0

.code
main PROC
    mov edx, OFFSET prompt
    call WriteString
    call ReadHex
    mov permCode, al

    test permCode, 10000000b
    jnz Suspended

    mov al, permCode
    and al, 00000101b
    cmp al, 00000101b
    jne Denied

    mov edx, OFFSET msgGranted
    call WriteString
    call Crlf

    test permCode, 00010000b
    jz Finish
    mov edx, OFFSET msgAdmin
    call WriteString
    call Crlf
    jmp Finish

Suspended:
    mov edx, OFFSET msgSusp
    call WriteString
    call Crlf
    jmp Finish

Denied:
    mov edx, OFFSET msgDenied
    call WriteString
    call Crlf

Finish:
    or permCode, 00000100b
    mov edx, OFFSET msgUpdated
    call WriteString
    movzx eax, permCode
    mov ebx, TYPE permCode
    call WriteHexB
    call Crlf

    exit
main ENDP
END main
