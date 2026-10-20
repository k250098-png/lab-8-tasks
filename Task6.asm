INCLUDE Irvine32.inc

.data
    distances DWORD 15, 25, 0, 30, 22, 18
    charges DWORD 40, 60, 500, 80, 50, 30
    totalDist DWORD 0
    totalCharges DWORD 0
    validCount DWORD 0
    surcharge DWORD 0
    discount DWORD 0
    finalCharges SDWORD 0
    msgSeg BYTE "Total segments: ",0
    msgDist BYTE "Total distance: ",0
    msgValid BYTE "Valid segment count: ",0
    msgSur BYTE "Surcharge: ",0
    msgDisc BYTE "Discount: ",0
    msgFinal BYTE "Final charges: ",0

.code
main PROC
    xor esi, esi

Scan:
    cmp esi, SIZEOF distances
    jae AfterScan

    mov eax, [distances + esi]
    add totalDist, eax

    cmp eax, 0
    je NextSeg

    inc validCount
    mov ebx, [charges + esi]
    add totalCharges, ebx

    cmp eax, 20
    jbe NextSeg
    add surcharge, 100

NextSeg:
    add esi, TYPE distances
    jmp Scan

AfterScan:
    cmp totalDist, 100
    jbe NoDiscount
    mov discount, 250

NoDiscount:
    mov eax, totalCharges
    add eax, surcharge
    sub eax, discount
    mov finalCharges, eax

    cmp finalCharges, 0
    jge Display
    mov finalCharges, 0

Display:
    mov edx, OFFSET msgSeg
    call WriteString
    mov eax, LENGTHOF distances
    call WriteDec
    call Crlf

    mov edx, OFFSET msgDist
    call WriteString
    mov eax, totalDist
    call WriteDec
    call Crlf

    mov edx, OFFSET msgValid
    call WriteString
    mov eax, validCount
    call WriteDec
    call Crlf

    mov edx, OFFSET msgSur
    call WriteString
    mov eax, surcharge
    call WriteDec
    call Crlf

    mov edx, OFFSET msgDisc
    call WriteString
    mov eax, discount
    call WriteDec
    call Crlf

    mov edx, OFFSET msgFinal
    call WriteString
    mov eax, finalCharges
    call WriteInt
    call Crlf

    exit
main ENDP
END main
