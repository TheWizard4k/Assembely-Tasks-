include Irvine32.inc

.data
prompt1 db "Enter the number of rows for Matrix A: ", 0
prompt2 db "Enter the number of columns for Matrix A: ", 0
prompt3 db "Enter the number of rows for Matrix B: ", 0
prompt4 db "Enter the number of columns for Matrix B: ", 0

matrixA db ?
matrixB db ?
rowsA dw ?
colsA dw ?
rowsB dw ?
colsB dw ?

.code
main proc
    mov edx, OFFSET prompt1
    call WriteString
    call ReadInt
    mov rowsA, ax

    mov edx, OFFSET prompt2
    call WriteString
    call ReadInt
    mov colsA, ax

    mov edx, OFFSET prompt3
    call WriteString
    call ReadInt
    mov rowsB, ax

    mov edx, OFFSET prompt4
    call WriteString
    call ReadInt
    mov colsB, ax

    ; You can now use the values of rowsA, colsA, rowsB, and colsB for further processing
    
    exit
main endp

end main