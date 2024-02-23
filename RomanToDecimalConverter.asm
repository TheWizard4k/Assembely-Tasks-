
include Irvine32.inc

    .data
msg1 BYTE "Enter a Roman Numeral (up to 10 characters): ", 0
msg2 BYTE "Decimal Value: ", 0

    .code
main PROC
    mov edx, OFFSET msg1
    call WriteString

    ; Get user input
    mov edx, OFFSET input
    mov ecx, SIZEOF input
    call ReadString

    ; Convert Roman Numeral to Decimal
    mov esi, OFFSET input
    mov eax, 0

convert_loop:
    mov bl, [esi] ; get current character
    cmp bl, 0 ; check for null terminator
    je done

    ; calculate decimal value based on Roman Numeral character
    cmp bl, 'M'
    je  add_1000
    cmp bl, 'D'
    je  add_500
    cmp bl, 'C'
    je  add_100
    cmp bl, 'L'
    je  add_50
    cmp bl, 'X'
    je  add_10
    cmp bl, 'V'
    je  add_5
    cmp bl, 'I'
    je  add_1

    ; invalid character, so exit with 0
    xor eax, eax
    jmp done

add_1000:
    add eax, 1000
    jmp next_char

add_500:
    add eax, 500
    jmp next_char

add_100:
    mov bl, [esi+1] ; get next character
    cmp bl, 'M'
    je  sub_100
    cmp bl, 'D'
    je  sub_100
    add eax, 100
    jmp next_char

sub_100:
    sub eax, 100
    add eax, 900
    add esi, 1 ; skip over next character
    jmp next_char

add_50:
    add eax, 50
    jmp next_char

add_10:
    mov bl, [esi+1] ; get next character
    cmp bl, 'C'
    je  sub_10
    cmp bl, 'L'
    je  sub_10
    add eax, 10
    jmp next_char

sub_10:
    sub eax, 10
    add eax, 40
    add esi, 1 ; skip over next character
    jmp next_char

add_5:
    add eax, 5
    jmp next_char

add_1:
    mov bl, [esi+1] ; get next character
    cmp bl, 'X'
    je  sub_1
    cmp bl, 'V'
    je  sub_1
    add eax, 1
    jmp next_char

sub_1:
    sub eax, 1
    add eax, 4
    add esi, 1 ; skip over next character

next_char:
    add esi, 1 ; move to next character
    jmp convert_loop

done:
    mov edx, OFFSET msg2
    call WriteString
    call WriteDec
    exit
main ENDP

    .data
input   BYTE    11 DUP(0) ; buffer for user input, up to 10 characters

END main