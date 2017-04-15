; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: assn06
; Lab Section: 023
; TA: Aditya Tammewar
;
; I herby certify that the contents of this file are ENTIRELY my own original
; work.
; =======================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_30000
; Input:         ONE NUMBER IN THE RANGE OF [0,65535]
; Postcondition: PRINT THE HEX PRESENTATION OF THE INPUT
; Return Value:  HEX VALUE OF INPUT ONTO CONSOLE
; -----------------------------------------------------------------------
                         .ORIG x3000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
; -----------------------------------------------------------------------
PROG_START
                         LEA R0, INST
                         PUTS
                         ;subroutine take binary
                         JSR SR_STORE_NUM
                         
                         LEA R0, INST2
                         PUTS
                         ;subroutine convert to hex/pint on the go
                         JSR PRINT_HEX
END                                                       
                         HALT                     ;stops the program
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
INST                     .STRINGZ"ENTER A NUMBER IN THE RANGE OF [0,65535]: "
INST2                    .STRINGZ "THE HEX REPRESENTATION IS: "
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3200
; Input:         A NUMBER IN THE RANGE OF [#-32768, #32767]
; Postcondition: R1 holds the vaule of the input with the correct Binary Rep.
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
SR_STORE_NUM
;BACK UP REGISTERS
                         ST  R2, BU2_STORE_SR
                         ST  R3, BU3_STORE_SR
                         ST  R4, BU4_STORE_SR
                         ST  R5, BU5_STORE_SR
                         ST  R6, BU6_STORE_SR
                         ST  R7, BU7_STORE_SR
RESET                      
                         LD  R1, ZERO_SR          ;R1 <-- ZERO
                         LD  R2, RANGE_LOWER      ;R2 <-- RANGE_LOWER
                         LD  R3, RANGE_UPPER      ;R3 <-- RANGE_UPPER
                         LD  R6, ZERO_SR          ;R6 <-- ZERO
                                                  ;R6=flag for neg num 
FIRST                    ;where '-' and '+' is valid input
                         GETC                     ;R0 <-- INPUT
                         OUT                      ;CONSOLE <-- mem[R0]
                         ;check for '-' 
                         LD  R4, NEG_CHAR         ;R4 <-- NEG_CHAR
                         ADD R4, R4, R0           ;R4 <-- R4 + R0
                         BRz SET_NEG              ;if(R4 == 0) SET_NEG
                         ;check for '+'
                         LD  R4, POS_CHAR         ;R4 <-- POS_CHAR
                         ADD R4, R4, R0           ;R4 <-- R4 + R0
                         BRz INPUT_CHAR           ;if(R4 == 0) INPUT_CHAR
                         ;boundaries check
                         ADD R5, R0, R2           ;R5 <-- R0 + R2
                         BRn ERROR                ;if(R5 < 0) ERROR
                         ADD R5, R0, R3           ;R5 <-- R0 + R3
                         BRp ERROR                ;if(R5 > 0) ERROR
                         BR  STORE_NUM            ;JMP STORE_NUM
                         
INPUT_CHAR               ;proceed toX get input, '-','+' are invalid
                         GETC                     ;R0 <-- INPUT
                         OUT                      ;CONSOLE <-- mem[R0]
                         ;check for enter
                         LD  R4, ENTER_CHAR       ;R4 <-- ENTER_CHAR
                         ADD R5, R4, R0           ;R5 <-- R4 + R0
                         BRz SIGN_CHECK           ;if(R4 == 0) SIGN_CHECK
                         ;boundaries check
                         ADD R5, R0, R2           ;R5 <-- R0 + R2
                         BRn ERROR                ;if(R5 < 0) ERROR
                         ADD R5, R0, R3           ;R5 <-- R0 + R3
                         BRp ERROR                ;if(R5 > 0) ERROR
                         
STORE_NUM                ;convert char to num, multiply by 10
                         ADD R0, R0, R2           ;R0 <-- R0 + R2
                         ADD R1, R0, R1           ;R1 <-- R0 + #0
                         ADD R0, R1, #0           ;R0 <-- R1
                         LD  R5, RESULT_SR        ;R5 <-- RESULT
                         STR R1, R5, #0           ;R5 <-- mem[R1 + 0]
                         LD  R5, COUNTER_SR       ;R5 <-- COUNTER
MULTIPLY_10                         
                         ADD R1, R0, R1           ;R1 <-- R0 + R1
                         ADD R5, R5, #-1          ;R5 <-- R5 + #-1
                         BRp MULTIPLY_10          ;if(R5 > 0) MULTIPLY_10
                         BR  INPUT_CHAR           ;JMP INPUT_CHAR
ERROR                    ;out puts error message, then restart program
                         LEA R0, ERR_MSG          ;R0 <-- ERR_MSG
                         PUTS                     ;CONSOLE <-- mem[R0]
                         JSR PROG_START           ;PC <-- PROG_START
SET_NEG                  ;setting neg falg to be 1, indicating neg result
                         ADD R6, R6, #1           ;R6 <-- R6 + #1
                         BR  INPUT_CHAR           ;JMP INPUT_CHAR
TWOS_COMP                ;make the result into a negative
                         NOT R1, R1               ;R1 <-- R1'
                         ADD R1, R1, #1           ;R1 <-- R1 + #1
                         BR  END                  ;JMP END
SIGN_CHECK               ;check for flag before ending program
                         LD  R5, RESULT_SR        ;R5 <-- RESULT
                         LDR R1, R5, #0           ;R1 <-- mem[R5 + 0]
                         ADD R6, R6, #0           ;CHECK R6
                         BRp TWOS_COMP            ;if(R6 > 0) TWOS_COMP
END                                                       
                         LD  R2, BU2_STORE_SR
                         LD  R3, BU3_STORE_SR
                         LD  R4, BU4_STORE_SR
                         LD  R5, BU5_STORE_SR
                         LD  R6, BU6_STORE_SR
                         LD  R7, BU7_STORE_SR
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
ZERO_SR                  .FILL #0
RANGE_LOWER              .FILL -x30
RANGE_UPPER              .FILL -x39
NEG_CHAR                 .FILL -x2D
POS_CHAR                 .FILL -x2B
ENTER_CHAR               .FILL -xA
COUNTER_SR               .FILL #9
RESULT_SR                .FILL x4000
BU2_STORE_SR             .BLKW #1
BU3_STORE_SR             .BLKW #1
BU4_STORE_SR             .BLKW #1
BU5_STORE_SR             .BLKW #1
BU6_STORE_SR             .BLKW #1
BU7_STORE_SR             .BLKW #1
ERR_MSG                  .STRINGZ "\nInvalid input, restarting program...\n"

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3400
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN3400
; Input:         R1 HOLDING THE VALUE TO PRINT
; Postcondition: PRINT OUT HEX REPRESENTATION OF THE VALUE IN R1
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3400          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
PRINT_HEX
;BACK UP REGISTERS
            
                         ST  R1, VALUE
                         ST  R7, REG7_BU
                         
                         LD  R0, X_CHAR
                         OUT
                         
                         LD  R0, RESET_0
                         LD  R2, HEX_COUNT
                         LD  R3, HEX_COUNT
                         LD  R4, DEC_TO_CHAR
                         LD  R5, AF_CHECK
                         
CHECK_BIN                         
                         ADD R1, R1, #0
                         BRzp ZERO
                         BRn  ONE
                         
ONE
                         ADD R0, R0, R0
                         ADD R1, R1, R1
                         ADD R0, R0, #1
                         ADD R2, R2, #-1
                         BRz OUT_HEX
                         BR  CHECK_BIN
ZERO
                         ADD R0, R0, R0
                         ADD R1, R1, R1
                         ADD R2, R2, #-1
                         BRz OUT_HEX
                         BR  CHECK_BIN
OUT_HEX
                         ADD R0, R0, R4
                         LD  R5, AF_CHECK
                         ADD R5, R0, R5
                         BRzp TO_AF
PRINT_CHAR                         
                         OUT
                         LD  R0, RESET_0
                         LD  R2, HEX_COUNT
                         ADD R3, R3, #-1
                         BRp CHECK_BIN
                         BR  END_PRINT_HEX
TO_AF
                         ADD R0, R0, #7
                         BR  PRINT_CHAR                                     
END_PRINT_HEX                                                       
                         LD  R0, LF_CHAR
                         OUT 
                         
                         LD  R1, VALUE
                         LD  R7, REG7_BU
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
X_CHAR                   .FILL x78
LF_CHAR                  .FILL xA
REG7_BU                  .BLKW #1
VALUE                    .BLKW #1
HEX_COUNT                .FILL #4
DEC_TO_CHAR              .FILL x30
RESET_0                  .FILL x0
AF_CHECK                 .FILL -x3A
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3400
; -----------------------------------------------------------------------
;=========================================================================
