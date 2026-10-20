INCLUDE Irvine32.inc

.data
    packetHeader DWORD 1000000Fh
    packetId DWORD 1500
    msgLow BYTE "LOW PRIORITY",0
    msgStd BYTE "STANDARD PRIORITY",0
    msgHigh BYTE "HIGH PRIORITY",0
    msgWarn BYTE "WARNING: a warning bit is set",0
    msgHdr BYTE "Final packet header (hex): ",0

.code
main PROC
    and packetHeader, 0FFFFFFFAh
    or packetHeader, 00000020h
    xor packetHeader, 00000040h

    mov bl, 0
    test packetHeader, 0000000Ah
    jz NoWarn
    mov bl, 1
NoWarn:

    mov eax, packetId
    cmp eax, 1000
    jb LowPri
    je StdPri
    mov edx, OFFSET msgHigh
    jmp ShowPri

LowPri:
    mov edx, OFFSET msgLow
    jmp ShowPri

StdPri:
    mov edx, OFFSET msgStd

ShowPri:
    call WriteString
    call Crlf

    cmp bl, 1
    jne ShowHeader
    mov edx, OFFSET msgWarn
    call WriteString
    call Crlf

ShowHeader:
    mov edx, OFFSET msgHdr
    call WriteString
    mov eax, packetHeader
    call WriteHex
    call Crlf

    exit
main ENDP
END main
