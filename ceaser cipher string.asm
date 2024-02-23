INCLUDE Irvine32.inc

.data
inputString BYTE 100 DUP(0)
encryptedString BYTE 100 DUP(0)
decryptedString BYTE 100 DUP(0)
shiftAmount BYTE ?
message BYTE "Enter a string: ", 0
encryptedMessage BYTE "Encrypted string: ", 0
decryptedMessage BYTE "Decrypted string: ", 0
prompt BYTE "Enter the shift amount (1-25): ", 0

.code
main PROC
    mov edx, OFFSET message
    call WriteString
    
    mov edx, OFFSET inputString
    mov ecx, SIZEOF inputString
    call ReadString
    
    mov edx, OFFSET prompt
    call WriteString
    
    call ReadInt
    mov shiftAmount, al
    
    mov edx, OFFSET encryptedMessage
    call WriteString
    
    mov esi, OFFSET inputString
    mov edi, OFFSET encryptedString
    call EncryptString
    
    mov edx, OFFSET encryptedString
    call WriteString
    
    mov edx, OFFSET decryptedMessage
    call WriteString
    
    mov esi, OFFSET encryptedString
    mov edi, OFFSET decryptedString
    call DecryptString
    
    mov edx, OFFSET decryptedString
    call WriteString
    
    call Crlf
    exit
main ENDP

EncryptString PROC
    mov al, shiftAmount
    xor ah, ah
    
    mov ecx, 0
    @@loop:
        mov bl, [esi+ecx]
        cmp bl, 0
        je @@end
        
        add bl, al
        cmp bl, 'z'
        jbe @@skip
        
        sub bl, 26
    @@skip:
        mov [edi+ecx], bl
        
        inc ecx
        jmp @@loop
    @@end:
    ret
EncryptString ENDP

DecryptString PROC
    mov al, shiftAmount
    xor ah, ah
    
    mov ecx, 0
    @@loop:
        mov bl, [esi+ecx]
        cmp bl, 0
        je @@end
        
        sub bl, al
        cmp bl, 'a'
        jae @@skip
        
        add bl, 26
    @@skip:
        mov [edi+ecx], bl
        
        inc ecx
        jmp @@loop
    @@end:
    ret
DecryptString ENDP

END main