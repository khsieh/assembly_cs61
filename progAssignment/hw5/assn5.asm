; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: assn05
; Lab Section: 023
; TA: Aditya Tammewar
;
; I herby certify that the contents of this file are ENTIRELY my own original
; work.
; =======================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_30000
; Input:         TWO NUMBERS IN THE RANGE OF [#-32768, #32767]
; Postcondition: CALCULATE THE PRODUCT AND PRINT IT TO CONSOLE
; Return Value:  PRODUCT OF THE TWO MULTIPLICANDS 
; -----------------------------------------------------------------------
                         .ORIG x3000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
; -----------------------------------------------------------------------
PROG_START
                         LEA R0, INST
                         PUTS
                         LEA R0, INST2
                         PUTS
                         ;call Store subroutine
                         JSR SR_STORE_NUM
                         ST  R1, MULTIPLICAND1
                         ;call Store subroutine
                         JSR SR_STORE_NUM
                         ST  R1, MULTIPLICAND2
                         
                         LD  R2, MULTIPLICAND1
                         LD  R6, CALC_SR
                         JSRR R6
                         ST  R0, RESULT_MAIN
                         ;PRINT MULTIPLICAND1
                         LD  R1, MULTIPLICAND1
                         LD  R6, PRINT_SR
                         JSRR R6
                         ;PRINT " * "
                         LD  R0, SPACE_CHAR
                         OUT
                         LD  R0, MULTI_CHAR
                         OUT
                         LD  R0, SPACE_CHAR
                         OUT
                         ;PRINT MUILTIPLICAND 2
                         LD  R1, MULTIPLICAND2
                         ;~ LD  R6, PRINT_SR
                         JSRR R6
                         ;PRINT " = "
                         LD  R0, SPACE_CHAR
                         OUT
                         LD  R0, EQUAL_CHAR
                         OUT
                         LD  R0, SPACE_CHAR
                         OUT
                         
                         LD  R1, RESULT_MAIN
                         JSRR R6
END                                                       
                         HALT                     ;stops the program
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
MULTIPLICAND1            .BLKW #1
MULTIPLICAND2            .BLKW #1
RESULT_MAIN              .BLKW #1
PRINT_SR                 .FILL x3400
CALC_SR                  .FILL x3600
MULTI_CHAR               .FILL x2A
SPACE_CHAR               .FILL x20
EQUAL_CHAR               .FILL x3D
INST                     .STRINGZ "\nEnter two number you wish to multiply "
INST2                    .STRINGZ "(within the range of [-32767,+32767])\n"
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
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
;=========================================================================
; Subroutine:    SUB_MAIN_3400
; Input:         A NUMBER IN THE RANGE OF [#-32768, #32767]
; Postcondition: R1 holds the vaule to be print
; Return Value:  print the dec value of R1 onto console
; -----------------------------------------------------------------------
                         .ORIG x3400          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3400
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
                         ;SIGN CHECK
                         ADD R1, R1, #0
                         BRn PRINT_NEG
                         BRz PRINT_ZERO
                         LD  R0, PLUS_CHAR
                         OUT
DIGIT_CHECK                         
                         ADD R4, R1, #0
                         LD  R2, TEN_THOUSAND
                         ADD R0, R1, R2
                         BRzp START_FIRST
                         
                         LD  R2, THOUSAND
                         ADD R0, R1, R2
                         BRzp START_SECOND
                         
                         LD  R2, HUNDRED
                         ADD R0, R1, R2
                         BRzp START_THIRD
                         
                         LD  R2, TEN
                         ADD R0, R1, R2
                         BRzp START_FOURTH
                         
                         LD  R2, ONE_SUB2
                         ADD R0, R1, R2
                         BRzp START_FIFTH
                         
                         
START_FIRST                         
                         LD  R2, TEN_THOUSAND
                         LD  R0, ZERO_SUB2
FIRST                    ;PRINT OUT 1ST DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp FIRST
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         ADD R1, R4, #0
                         ADD R0, R5, R0
                         ADD R0, R0, #0
                         BRz START_SECOND
GET_REMAIN1              ;REMOVED 1ST DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN1
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
START_SECOND                         
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
                         ADD R0, R0, #0
                         BRz START_THIRD
GET_REMAIN2              ;REMOVE 2ND DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN2
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
START_THIRD                         
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
                         ADD R0, R0, #0
                         BRz START_FOURTH
GET_REMAIN3              ;REMOVE 2ND DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN3
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
START_FOURTH                         
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
                         ADD R0, R0, #0
                         BRz START_FIFTH
GET_REMAIN4              ;REMOVE 4TH DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN4
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
START_FIFTH                         
                         LD  R2, ONE_SUB2
                         LD  R0, ZERO_SUB2
FIFTH                    ;PRINT OUT 5TH DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRzp FIFTH
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         BR END_PRINT
PRINT_NEG
                         LD  R0, NEG_CHAR_SR
                         OUT
                         NOT R1, R1
                         ADD R1, R1, #1
                         BR  DIGIT_CHECK
PRINT_ZERO
                         LD  R0, PLUS_CHAR
                         OUT
                         LD  R0, ZERO_CHAR
                         OUT
                         BR  END_PRINT
;RESTORE REGISTERS                         
END_PRINT                                                       
                         LD  R1, BU2_STORE_SR2
                         LD  R2, BU2_STORE_SR2
                         LD  R3, BU3_STORE_SR2
                         LD  R4, BU4_STORE_SR2
                         LD  R7, BU7_STORE_SR2
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
ZERO_SUB2                 .FILL x0
ONE_SUB2                  .FILL -x1
TEN                       .FILL -xA
HUNDRED                   .FILL -x64
THOUSAND                  .FILL -x3E8
TEN_THOUSAND              .FILL -x2710
PLUS_CHAR                 .FILL x2B
ZERO_CHAR                 .FILL x30
NEG_CHAR_SR               .FILL x2D
DEC_TO_CHAR               .FILL x30
CHAR_TO_DEC               .FILL -x30

BU1_STORE_SR2             .BLKW #1
BU2_STORE_SR2             .BLKW #1
BU3_STORE_SR2             .BLKW #1
BU4_STORE_SR2             .BLKW #1
BU5_STORE_SR2             .BLKW #1
BU7_STORE_SR2             .BLKW #1
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3400
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3600
; Input:         R1 & R2 HOLD THE MITIPLICANDS TO BE CALCULATE
; Postcondition: R0 HOLDS THE PRODCUTS OF THE MULTIPLCANDS
; Return Value:  PRODUCT OF R1 AND R2
; -----------------------------------------------------------------------
                         .ORIG x3600          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3600
; -----------------------------------------------------------------------
CALCULATE_PRODUCT
;BACK UP REGISTERS
                         ST  R1, BU1_STORE_SR3
                         ST  R2, BU2_STORE_SR3
                         ST  R7, BU7_STORE_SR3
                         
                         LD  R6, RESET_ZERO
                         
                         ;check if product is zero
                         ADD R1, R1, #0
                         BRz ZERO_PRODUCT
                         ADD R2, R2, #0                         
                         BRz ZERO_PRODUCT
                         ;check for negative product
                         ADD R1, R1, #0
                         BRn CHECK_R2_NEG
                         BRp CHECK_R2_POS
CHECK_R2_NEG
                         ADD R2, R2, #0
                         BRn POS_PRODUCT
                         BRp NEG_PRODUCT
CHECK_R2_POS             
                         ADD R2, R2, #0
                         BRn NEG_PRODUCT
                         BRp POS_PRODUCT

POS_PRODUCT                         
                         LD  R6, POS_FLAG
                         BR  CHANGE_SGIN1
NEG_PRODUCT
                         LD  R6, NEG_FLAG

CHANGE_SGIN1
                         ADD R1, R1, #0
                         BRzp CHANGE_SGIN2
                         NOT R1, R1
                         ADD R1, R1, #1

CHANGE_SGIN2
                         ADD R2, R2, #0
                         BRzp DETERMIND_COUNTER
                         NOT R2, R2
                         ADD R2, R2, #1
                         
DETERMIND_COUNTER
                         ST  R1, MULTIPLICAND1_SR
                         ST  R2, MULTIPLICAND2_SR
                         NOT R2, R2
                         ADD R2, R2, #1
                         ADD R3, R2, R1
                         BRn SWITCH_MULTIPLICAND
                         LD  R2, MULTIPLICAND2_SR
                         BR  PRODUCT_VAL

SWITCH_MULTIPLICAND      
                         LD  R1, MULTIPLICAND2_SR
                         LD  R2, MULTIPLICAND1_SR         

PRODUCT_VAL
                         LD  R0, RESET_ZERO
MULTI_LOOP
                         ADD R0, R0, R1
                         BRn FLOW_ERROR
                         ADD R2, R2, #-1
                         BRp MULTI_LOOP
                         BRnz GET_SIGN
FLOW_ERROR               ;over/underflow error checks
                         ADD R6, R6, #0
                         BRn UNDERFLOW
                         BRp OVERFLOW                     
OVERFLOW
                         LEA R0, OF_ERR_MSG
                         PUTS
                         LD  R5, PROGRAM_RESTART
                         JSRR R5
UNDERFLOW                
                         LEA R0, UF_ERR_MSG
                         PUTS
                         LD  R5, PROGRAM_RESTART
                         JSRR R5
GET_SIGN
                         ADD R6, R6, #0
                         BRzp END_CALCULATE
                         NOT R0, R0
                         ADD R0, R0, #1
                         BR END_CALCULATE
ZERO_PRODUCT
                         LD  R0, RESET_ZERO
END_CALCULATE                                                      
                         LD  R1, BU1_STORE_SR3
                         LD  R2, BU2_STORE_SR3
                         LD  R7, BU7_STORE_SR3
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3600
; -----------------------------------------------------------------------
PROGRAM_RESTART          .FILL x3000
BU1_STORE_SR3            .BLKW #1
BU2_STORE_SR3            .BLKW #1
BU7_STORE_SR3            .BLKW #1
MULTIPLICAND1_SR         .BLKW #1
MULTIPLICAND2_SR         .BLKW #1
RESET_ZERO               .FILL #0
NEG_FLAG                 .FILL #-1
POS_FLAG                 .FILL #1
UF_ERR_MSG               .STRINGZ "\nWoahs! Underflows\nRestarting Program..."
OF_ERR_MSG               .STRINGZ "\nWoes! Overflows!\nRestarting Program..."
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3600
; -----------------------------------------------------------------------
;=========================================================================
