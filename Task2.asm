INCLUDE Irvine32.inc

.data
    promptMarks BYTE "Enter marks: ",0
    promptAtt BYTE "Enter attendance percentage: ",0
    promptDisc BYTE "Active disciplinary restriction? (1 = Yes, 0 = No): ",0
    msgMerit BYTE "Category: MERIT SCHOLARSHIP",0
    msgNeed BYTE "Category: NEED-BASED REVIEW",0
    msgNot BYTE "Category: NOT ELIGIBLE",0

.code
main PROC
    mov edx, OFFSET promptMarks
    call WriteString
    call ReadInt
    mov ebx, eax

    mov edx, OFFSET promptAtt
    call WriteString
    call ReadInt
    mov ecx, eax

    mov edx, OFFSET promptDisc
    call WriteString
    call ReadInt
    mov esi, eax

    cmp esi, 0
    jne NotEligible

    cmp ebx, 85
    jl CheckNeed
    cmp ecx, 80
    jl CheckNeed
    mov edx, OFFSET msgMerit
    jmp Show

CheckNeed:
    cmp ebx, 70
    jl NotEligible
    cmp ecx, 75
    jl NotEligible
    mov edx, OFFSET msgNeed
    jmp Show

NotEligible:
    mov edx, OFFSET msgNot

Show:
    call WriteString
    call Crlf

    exit
main ENDP
END main
