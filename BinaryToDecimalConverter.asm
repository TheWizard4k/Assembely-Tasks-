INCLUDE Irvine32.inc

.data
    binaryInput BYTE 33 DUP(?)    ; Buffer to store the user's binary input
    promptMsg BYTE "Enter a binary number: ", 0
    decimalMsg BYTE "Decimal equivalent: ", 0
    invalidMsg BYTE "Invalid input! Please enter a valid binary number.", 0

.code
main PROC
    ; Display prompt and read binary input from the user
    mov edx, OFFSET promptMsg
    call WriteString
    mov edx, OFFSET binaryInput
    mov ecx, SIZEOF binaryInput
    call ReadString

    ; Loop to validate binary input and prompt user to re-enter if invalid
validateInput:
    mov esi, OFFSET binaryInput
    call ValidateBinaryInput
    jc invalidInput

    ; Convert binary string to decimal value
    mov esi, OFFSET binaryInput
    call BinaryToDecimal

    ; Display the decimal equivalent
    mov edx, OFFSET decimalMsg
    call WriteString
    mov eax, ebx
    call WriteDec

    jmp exitProgram

invalidInput:
    ; Display invalid input message
    mov edx, OFFSET invalidMsg
    call WriteString

    ; Prompt user to enter binary number again
    call Crlf
    jmp main

exitProgram:
    exit
main ENDP

BinaryToDecimal PROC
    xor ebx, ebx        ; Clear EBX (decimal result)
    mov ecx, 0          ; Bit position counter

convertLoop:
    mov al, byte ptr [esi]
    cmp al, '0'
    jl exitLoop          ; Jump if a non-numeric character is encountered
    cmp al, '1'
    jg exitLoop          ; Jump if a non-numeric character is encountered

    shl ebx, 1          ; Shift EBX left
    sub al, '0'
    add ebx, eax        ; Add the binary digit to EBX

    inc esi             ; Move to the next character
    cmp byte ptr [esi], 0   ; Check if end of string reached
    jne convertLoop

exitLoop:
    ret
BinaryToDecimal ENDP

ValidateBinaryInput PROC
    push esi            ; Save the current value of ESI
    mov esi, OFFSET binaryInput

validateLoop:
    mov al, byte ptr [esi]
    cmp al, '0'
    jl invalidInput      ; Jump if a non-numeric character is encountered
    cmp al, '1'
    jg invalidInput      ; Jump if a non-numeric character is encountered

    inc esi             ; Move to the next character
    cmp byte ptr [esi], 0   ; Check if end of string reached
    jne validateLoop

    jmp validInput      ; Jump to validInput block

invalidInput:
    pop esi             ; Restore the value of ESI
    stc                 ; Set carry flag to indicate invalid input
    ret

validInput:
    pop esi             ; Restore the value of ESI
    ret
ValidateBinaryInput ENDP 
END main