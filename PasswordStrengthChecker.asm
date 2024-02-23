.386
.model flat, stdcall
.stack 4096
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
ExitProcess PROTO, dwExitCode:DWORD
.data
inputStr BYTE 100 DUP (?)
strLen DWORD ?
isStrong BYTE ?
weakStr BYTE "Password is weak. Please improve by adding at least one uppercase
letter, one lowercase letter, one number, one special character, and ensuring a
minimum length of 8 characters.",0
strongStr BYTE "Password is strong!",0
promptStr BYTE "Enter a password: ",0
.code
main PROC
 ; prompt user for password
 mov edx, OFFSET promptStr
 call WriteString
 mov edx, OFFSET inputStr
 mov ecx, 100
 call ReadString
 ; get length of input password
 mov esi, OFFSET inputStr
 mov edi, esi
 mov ecx, 0
 cld
 repne scasb
 sub edi, OFFSET inputStr
 dec edi
 mov strLen, edi

 ; check password strength
 mov ebx, OFFSET inputStr
 mov isStrong, 0
 xor eax, eax ; clear eax register
checkStrength:
 mov al, BYTE PTR [ebx]
 cmp al, 'A'
 jl noUppercase
 cmp al, 'Z'
 jle hasUppercase
noUppercase:
 cmp al, 'a'
 jl noLowercase
 cmp al, 'z'
 jle hasLowercase
noLowercase:
 cmp al, '0'
 jl noNumber
 cmp al, '9'
 jle hasNumber
noNumber:
 cmp al, '!'
 jl passwordWeak ; if no special characters found, password is weak
 cmp al, '/'
 jle passwordStrong ; if special character found, password is strong
 cmp al, ':'
 jl passwordWeak ; if no special characters found, password is weak
 cmp al, '@'
 jle passwordStrong ; if special character found, password is strong
 cmp al, '['
 jl passwordWeak ; if no special characters found, password is weak
 cmp al, '`'
 jle passwordStrong ; if special character found, password is strong
 cmp al, '{'
 jl passwordWeak ; if no special characters found, password is weak
 cmp al, '~'
 jle passwordStrong ; if special character found, password is strong
hasNumber:
 or eax, 1 ; set lowest bit to 1 to indicate number found
 jmp nextChar
hasUppercase:
 or eax, 2 ; set second lowest bit to 1 to indicate uppercase letter found
 jmp nextChar
hasLowercase:
 or eax, 4 ; set third lowest bit to 1 to indicate lowercase letter found
 jmp nextChar
hasSpecial:
 or eax, 8 ; set fourth lowest bit to 1 to indicate special character found
nextChar:
 inc ebx
 loop checkStrength

 ; check if password is strong
 mov edx, 0
 test al, 0Fh ; check if all four bits are set (i.e., all required characters
found)
 jnz checkLength
 jmp passwordWeak
checkLength:
 cmp strLen, 8 ; check if password length is at least 8 characters
 jge passwordStrong ; if password length is greater than or equal to 8, password
is strong
 jmp passwordWeak
passwordWeak:
 mov edx, OFFSET weakStr ; load address of string to print
 jmp printStr
passwordStrong:
 mov isStrong, 1
 mov edx, OFFSET strongStr ; load address of string to print
 jmp printStr
printStr:
 push edx ; push address of string onto stack
 call WriteString ; call WriteString function to print string
 add esp, 4 ; clean up stack
 INVOKE ExitProcess, 0
main ENDP
END main