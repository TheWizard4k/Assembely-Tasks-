INCLUDE Irvine32.inc

.data
    prompt BYTE "Enter a string: ", 0
    input BYTE 100 DUP(0)
    vowels BYTE "aeiouAEIOU", 0
    vowelCount DWORD 0
    consonantCount DWORD 0

.code
main PROC
    ; Display prompt and get input
    mov edx, OFFSET prompt
    call WriteString
    mov edx, OFFSET input
    mov ecx, SIZEOF input
    call ReadString

    ; Count vowels and consonants
    mov esi, OFFSET input ; set index to the start of the input string
    mov ecx, 0 ; clear the vowel count
    mov edx, 0 ; clear the consonant count

L1:
    mov al, [esi] ; load a byte from [esi] into al
    cmp al, 0 ; check for end of string
    je L2 ; if end of string, jump to L2

    ; Check if character is a vowel
    mov edi, OFFSET vowels ; set index to the start of the vowels string
    mov ecx, LENGTHOF vowels ; set loop counter to length of vowels string
    cld ; set direction forward

    repne scasb ; scan for a byte that matches al
    jnz VowelNotFound ; if no match found, jump to VowelNotFound

    inc vowelCount ; increment vowel count
    jmp NextCharacter

VowelNotFound:
    inc consonantCount ; increment consonant count

NextCharacter:
    inc esi ; increment index
    jmp L1 ; jump back to L1

L2:
    ; Display results
    mov eax, vowelCount
    call WriteDec
    call Crlf

    mov eax, consonantCount
    call WriteDec
    call Crlf

    exit
main ENDP

END main