INCLUDE Irvine32.inc

.data
matrixA BYTE 4 dup(0)
matrixB BYTE 4 dup(0)
matrixC BYTE 4 dup(0)

promptA BYTE "Enter elements for Matrix A (row-wise):", 0
promptB BYTE "Enter elements for Matrix B (row-wise):", 0
resultPrompt BYTE "Resultant Matrix:", 0
newline BYTE 13, 10, 0
spaceChar db ' ', 0  ; Define a buffer containing a single space character

.code
main PROC
    ; Read Matrix A elements
    mov edx, OFFSET promptA
    call WriteString
    call Crlf
    mov ecx, 4
    lea edi, [matrixA]
read_matrixA:
    call ReadInt
    mov [edi], al
    inc edi
    loop read_matrixA

    ; Read Matrix B elements
    mov edx, OFFSET promptB
    call WriteString
    call Crlf
    mov ecx, 4
    lea edi, [matrixB]
read_matrixB:
    call ReadInt
    mov [edi], al
    inc edi
    loop read_matrixB

    ; Perform matrix multiplication
    mov ecx, 2
    xor esi, esi
multiply_matrices:
    push ecx
    mov ecx, 2
    xor edi, edi
multiply_matrices_row:
    push ecx
    mov ecx, 2
    xor ebx, ebx
multiply_matrices_col:
    mov al, matrixA[esi * 2 + ebx]
    mov dl, matrixB[ebx * 2 + edi]
    movzx dx, dl  ; Move the value in dl to dx
    imul ax, dx
    add matrixC[esi * 2 + edi], al
    inc ebx
    loop multiply_matrices_col
    inc edi
    pop ecx
    loop multiply_matrices_row
    inc esi
    pop ecx
    loop multiply_matrices

    ; Display Resultant Matrix
    mov edx, OFFSET resultPrompt
    call WriteString
    call Crlf
    mov ecx, 2
    mov esi, 0
display_matrixC:
    push ecx
    mov ecx, 2
    mov edi, 0
display_matrixC_row:
    movzx eax, matrixC[esi * 2 + edi]
    call WriteDec
    mov edx, OFFSET spaceChar
    call WriteString
    inc edi
    loop display_matrixC_row
    call Crlf
    inc esi
    pop ecx
    loop display_matrixC

    exit
main ENDP

END main