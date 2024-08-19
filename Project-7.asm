; This program is used to calculate the product of two integers, using shifting and addition.
; Kylie Heiland
; 11 / 18 / 22


INCLUDE Irvine32.inc

.386
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
carriageReturn BYTE ' ', 13, 10, 0                ; Used as a new line to separate the random strings from one another.

temp DWORD ?                                      ; Holds the eax value.

; Displays a menu asking the user to make a selection.
menu BYTE "---- Bitwise Multiplication ----", 0
menu1 BYTE "Do you want to do a calculation? y/n (all lower case)", 0
firstMenuOption BYTE "y: Yes, multiply two integers", 0
secondMenuOption BYTE "n: No, exit program, please", 0 
enterChar BYTE "Enter your choice: ", 0

multiplier BYTE "Enter the 32-bit multiplier integer: ", 0
multiplicand BYTE "Enter the 32-bit multiplicand integer: ", 0
result BYTE "The product is: ", 0

;EXITPROGRAM
exitProgramMessage BYTE "Thank you for using this program. Goodbye!", 0

;WRONGANSWER
wrongAnswerMessage BYTE "Please choose y or n.", 0


i DWORD 0                                         ; Holds the product.

.code
    main proc
.REPEAT
    mov eax, 0                                    ; Makes the eax register 0.
    

    mov edx, OFFSET menu                          ; Prints "---- Bitwise Multiplication ----" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET menu1
    call WriteString

    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
  
    mov edx, OFFSET firstMenuOption               ; Prints "y: Yes, multiply two integers" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET secondMenuOption              ; Prints "n: No, exit program, please" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET enterChar                     ; Asks user to enter an integer.
    call WriteString
    call ReadChar
    call WriteChar
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString

    mov temp, eax                                 ; temp is set to whatever int the user chose.

    .IF (al == 'y')                               ; If eax equals 1. 
        call BitwiseMultiply
    .ELSEIF (al == 'n')                           ; If eax equals 2.
        call EXITPROGRAM
    .ELSEIF (al != 'y' && al != 'n')              ; If the user inputted an invalid integer.
        call WRONGANSWER
    .ENDIF
    
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString

    call WaitMsg
    call Clrscr
.UNTIL (al == 'n')
invoke ExitProcess, 0
main endp

BitwiseMultiply PROC
    mov edx, OFFSET multiplier                   ; Prompts user to enter a 32-bit multiplier integer.
    call WriteString                   
    call ReadDec                                 ; User inputs 32-bit multiplier integer.
    mov ebx, eax                                 ; Moves multiplier integer to ebx.

    mov edx, OFFSET multiplicand                 ; Prompts user to enter a 32-bit multiplicand integer.
    call WriteString
    call ReadDec                                 ; User inputs 32-bit multiplicand integer.

    mov ecx, 16                                  ; Loops through each of the multiplicand's bits.
    mov i, 0                                     ; Holds the product.
LOOP1:                       
    test ebx, 01                                 ; Determines whether the LSB is 1 or 0.
    jz jump1                                     ; If the bit contains a 1.
    add i, eax
    JUMP1:
        shl eax, 1                               ; Shifts the multiplier to the right.
        shr ebx, 1                               ; Shifts the multiplicand to the left
loop LOOP1
    mov eax, i

    mov edx, OFFSET result                       ; Prints the result of the multiplication between the two integers.
    call WriteString
    call WriteDec
    ret
BitwiseMultiply ENDP                   

EXITPROGRAM PROC
    mov edx, OFFSET exitProgramMessage           ; Tells the user goodbye.
    call WriteString
    ret
EXITPROGRAM ENDP

WRONGANSWER PROC
    mov edx, OFFSET wrongAnswerMessage          ; Tells the user they entered the wrong message.
    call WriteString
    mov edx, OFFSET carriageReturn              ; New line is made
    call WriteString
    ret
WRONGANSWER ENDP
end main
