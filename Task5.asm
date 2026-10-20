INCLUDE Irvine32.inc

.data
    openingStock DWORD 50, 20, 8, 100, 5
    receivedStock DWORD 10, 5, 3, 0, 2
    dispatchedStock DWORD 30, 40, 5, 60, 10
    closingStock DWORD 5 DUP(0)
    invalidFlag DWORD 5 DUP(0)
    lowCount DWORD 0
    maxClosing DWORD 0
    maxProduct DWORD 0
    totalReceived DWORD 0
    totalDispatched DWORD 0
    msgProd BYTE "Product ",0
    msgClose BYTE ": closing stock = ",0
    msgInvalid BYTE "  [INVALID TRANSACTION]",0
    msgLow BYTE "Products with closing stock below 10: ",0
    msgMax BYTE "Product with highest valid closing stock: ",0
    msgMaxVal BYTE "Highest valid closing stock: ",0
    msgRec BYTE "Total quantity received: ",0
    msgDis BYTE "Total quantity dispatched: ",0

.code
main PROC
    xor esi, esi
    mov edi, 1

Calc:
    cmp esi, SIZEOF openingStock
    jae Report

    mov eax, [openingStock + esi]
    add eax, [receivedStock + esi]
    mov ebx, [dispatchedStock + esi]

    mov edx, [receivedStock + esi]
    add totalReceived, edx
    add totalDispatched, ebx

    cmp ebx, eax
    ja Invalid

    sub eax, ebx
    mov [closingStock + esi], eax

    cmp eax, maxClosing
    jbe CheckLow
    mov maxClosing, eax
    mov maxProduct, edi

CheckLow:
    cmp eax, 10
    jae NextItem
    inc lowCount
    jmp NextItem

Invalid:
    mov DWORD PTR [closingStock + esi], 0
    mov DWORD PTR [invalidFlag + esi], 1
    inc lowCount

NextItem:
    add esi, TYPE openingStock
    inc edi
    jmp Calc

Report:
    xor esi, esi
    mov edi, 1

Print:
    cmp esi, SIZEOF closingStock
    jae Summary

    mov edx, OFFSET msgProd
    call WriteString
    mov eax, edi
    call WriteDec
    mov edx, OFFSET msgClose
    call WriteString
    mov eax, [closingStock + esi]
    call WriteDec

    cmp DWORD PTR [invalidFlag + esi], 1
    jne EndLine
    mov edx, OFFSET msgInvalid
    call WriteString

EndLine:
    call Crlf
    add esi, TYPE closingStock
    inc edi
    jmp Print

Summary:
    mov edx, OFFSET msgLow
    call WriteString
    mov eax, lowCount
    call WriteDec
    call Crlf

    mov edx, OFFSET msgMax
    call WriteString
    mov eax, maxProduct
    call WriteDec
    call Crlf

    mov edx, OFFSET msgMaxVal
    call WriteString
    mov eax, maxClosing
    call WriteDec
    call Crlf

    mov edx, OFFSET msgRec
    call WriteString
    mov eax, totalReceived
    call WriteDec
    call Crlf

    mov edx, OFFSET msgDis
    call WriteString
    mov eax, totalDispatched
    call WriteDec
    call Crlf

    exit
main ENDP
END main
