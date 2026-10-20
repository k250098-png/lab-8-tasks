INCLUDE Irvine32.inc

.data
    readings DWORD 30, 45, 38, 52, 29, 41, 33
    total DWORD ?
    average DWORD ?
    highDays DWORD ?
    adjustment DWORD 0
    msgTotal BYTE "Total consumption: ",0
    msgAvg BYTE "Average daily consumption: ",0
    msgHigh BYTE "Days above 30 units: ",0
    msgAdj BYTE "Final bill adjustment: ",0

.code
main PROC
    mov esi, OFFSET readings
    mov ecx, LENGTHOF readings
    mov eax, 0
    mov ebx, 0

L1:
    add eax, [esi]
    cmp DWORD PTR [esi], 30
    jbe NotHigh
    inc ebx
NotHigh:
    add esi, TYPE readings
    loop L1

    mov total, eax
    mov highDays, ebx

    xor edx, edx
    mov ecx, LENGTHOF readings
    div ecx
    mov average, eax

    mov eax, total
    cmp eax, 200
    jbe Display

    sub eax, 200
    xor edx, edx
    mov ebx, 50
    div ebx
    imul eax, 15
    mov ebx, eax
    imul eax, 15
    xor edx, edx
    mov ecx, 100
    div ecx
    add eax, ebx
    mov adjustment, eax

Display:
    mov edx, OFFSET msgTotal
    call WriteString
    mov eax, total
    call WriteDec
    call Crlf

    mov edx, OFFSET msgAvg
    call WriteString
    mov eax, average
    call WriteDec
    call Crlf

    mov edx, OFFSET msgHigh
    call WriteString
    mov eax, highDays
    call WriteDec
    call Crlf

    mov edx, OFFSET msgAdj
    call WriteString
    mov eax, adjustment
    call WriteDec
    call Crlf

    exit
main ENDP
END main
