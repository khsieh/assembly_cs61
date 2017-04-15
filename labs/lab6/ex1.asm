; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 06
; Lab Section: 023
; TA: Aditya Tammewar
;
; I herby certify that the contents of this file are ENTIRELY my own original
; work.
; =======================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_30000
; Input:         None.
; Postcondition: None.
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
; -----------------------------------------------------------------------
                         ;CALL SUBROUTINE TO GET NUMBER IN R1
                         JSR SR_STORE_NUM
                         ADD R1, R1, #1
                         JSR SR_PRINT_NUM
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                         

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3600
; Input:         A NUMBER IN THE RANGE OF [#-32768, #32767]
; Postcondition: R1 holds the vaule of the input with the correct Binary Rep.
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3400          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
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
                         LD  R1, ZERO             ;R1 <-- ZERO
                         LD  R2, RANGE_LOWER      ;R2 <-- RANGE_LOWER
                         LD  R3, RANGE_UPPER      ;R3 <-- RANGE_UPPER
                         LD  R6, ZERO             ;R6 <-- ZERO
                                                  ;R6=flag for neg num 
                         LEA R0, INST             ;R0 <-- INST
                         PUTS                     ;CONSOLE <-- mem[R0]
                         LEA R0, INST2            ;R0 <-- INST2
                         PUTS                     ;CONSOLE <-- mem[R0]
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
                         LD  R5, RESULT           ;R5 <-- RESULT
                         STR R1, R5, #0           ;R5 <-- mem[R1 + 0]
                         LD  R5, COUNTER          ;R5 <-- COUNTER
MULTIPLY_10                         
                         ADD R1, R0, R1           ;R1 <-- R0 + R1
                         ADD R5, R5, #-1          ;R5 <-- R5 + #-1
                         BRp MULTIPLY_10          ;if(R5 > 0) MULTIPLY_10
                         BR  INPUT_CHAR           ;JMP INPUT_CHAR
ERROR                    ;out puts error message, then restart program
                         LEA R0, ERR_MSG          ;R0 <-- ERR_MSG
                         PUTS                     ;CONSOLE <-- mem[R0]
                         BR  RESET                ;JMP RESET
SET_NEG                  ;setting neg falg to be 1, indicating neg result
                         ADD R6, R6, #1           ;R6 <-- R6 + #1
                         BR  INPUT_CHAR           ;JMP INPUT_CHAR
TWOS_COMP                ;make the result into a negative
                         NOT R1, R1               ;R1 <-- R1'
                         ADD R1, R1, #1           ;R1 <-- R1 + #1
                         BR  END                  ;JMP END
SIGN_CHECK               ;check for flag before ending program
                         LD  R5, RESULT           ;R5 <-- RESULT
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
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
ZERO                     .FILL #0
RANGE_LOWER              .FILL -x30
RANGE_UPPER              .FILL -x39
NEG_CHAR                 .FILL -x2D
POS_CHAR                 .FILL -x2B
ENTER_CHAR               .FILL -xA
COUNTER                  .FILL #9
RESULT                   .FILL x4000
BU2_STORE_SR             .BLKW #1
BU3_STORE_SR             .BLKW #1
BU4_STORE_SR             .BLKW #1
BU5_STORE_SR             .BLKW #1
BU6_STORE_SR             .BLKW #1
BU7_STORE_SR             .BLKW #1
INST                     .STRINGZ "\nPlease enter a positive or negative number"
INST2                    .STRINGZ " [#-32768,#32767], follow by an ENTER\n"
ERR_MSG                  .STRINGZ "\nInvalid input, restarting program...\n"

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================

;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3200
; Input:         A NUMBER IN THE RANGE OF [#-32768, #32767]
; Postcondition: PRINT OUT THE DEC NUMBER IN R1
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
SR_PRINT_NUM
;BACK UP REGISTERS
                         ST  R1, BU1_STORE_SR2
                         ST  R2, BU2_STORE_SR2
                         ST  R3, BU3_STORE_SR2
                         ST  R4, BU4_STORE_SR2
                         ST  R5, BU5_STORE_SR2
                         ST  R7, BU7_STORE_SR2
                         
                         LD  R5, CHAR_TO_DEC
                         LD  R3, DEC_TO_CHAR
                         LD  R2, TEN_THOUSAND
                         LD  R0, ZERO_SUB2
FIRST                    ;PRINT OUT 1ST DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp FIRST
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         LD  R1, BU1_STORE_SR2
                         ADD R0, R5, R0
GET_REMAIN1              ;REMOVED 1ST DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN1
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
                         
                         LD  R2, THOUSAND
                         LD  R0, ZERO_SUB2
SECOND                   ;PRINT OUT 2ND DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp SECOND
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         ADD R1, R4, #0           ;BACK UP FROM TEMP, 4 DIGITS
                         ADD R0, R5, R0
GET_REMAIN2              ;REMOVE 2ND DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN2
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
                         
                         LD  R2, HUNDRED
                         LD  R0, ZERO_SUB2
THIRD                    ;PRINT OUT 2ND DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp THIRD
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         ADD R1, R4, #0           ;BACK UP FROM TEMP, 4 DIGITS
                         ADD R0, R5, R0
GET_REMAIN3              ;REMOVE 2ND DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN3
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
                         
                         LD  R2, TEN
                         LD  R0, ZERO_SUB2
FOURTH                   ;PRINT OUT 3RD DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp FOURTH
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         ADD R1, R4, #0           ;BACK UP FROM TEMP, 4 DIGITS
                         ADD R0, R5, R0
GET_REMAIN4              ;REMOVE 4TH DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN4
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
                         
                         LD  R2, ONE_SUB2
                         LD  R0, ZERO_SUB2
FIFTH                    ;PRINT OUT 5TH DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp FIFTH
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
;RESTORE REGISTERS                         
END2                                                       
                         LD  R1, BU2_STORE_SR2
                         LD  R2, BU2_STORE_SR2
                         LD  R3, BU3_STORE_SR2
                         LD  R4, BU4_STORE_SR2
                         LD  R7, BU7_STORE_SR2
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
ZERO_SUB2                 .FILL x0
ONE_SUB2                  .FILL -x1
TEN                       .FILL -xA
HUNDRED                   .FILL -x64
THOUSAND                  .FILL -x3E8
TEN_THOUSAND              .FILL -x2710

DEC_TO_CHAR               .FILL x30
CHAR_TO_DEC               .FILL -x30

BU1_STORE_SR2             .BLKW #1
BU2_STORE_SR2             .BLKW #1
BU3_STORE_SR2             .BLKW #1
BU4_STORE_SR2             .BLKW #1
BU5_STORE_SR2             .BLKW #1
BU7_STORE_SR2             .BLKW #1

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
