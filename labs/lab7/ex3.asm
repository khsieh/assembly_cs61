; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 07
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
                         LD  R0, STR_ADDR
                         ;CALL SUBROUTINE TO GET STRING FROM USER
                         JSR GET_STRING
                         JSR CHECK_PALINDROME
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                         
STR_ADDR                 .FILL x4000
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3200
; Input:         String of characters
; Postcondition: store the string in remote addr stored in R0
;                store the size of string in R5
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
GET_STRING
;BACK UP REGISTERS
                         ST  R0, STRING_ADDR
                         ST  R7, BU7_STORE_SR
                         LD  R1, STRING_ADDR
                         LD  R2, CHECK_ENTER
TAKE_CHAR                         
                         GETC
                         OUT
                         ADD R3, R2, R0
                         BRz DONE
CHECK_UPPER
                         LD  R4, A_UPPER_RANGE
                         ADD R4, R4, R0
                         BRn TAKE_CHAR
                         LD  R4, Z_LOWER_RANGE
                         ADD R4, R4, R0
                         BRp CHECK_LOWER
                         BR  TO_LOWER
CHECK_LOWER
                         LD  R4, UPPER_RANGE
                         ADD R4, R4, R0
                         BRn TAKE_CHAR
                         LD  R4, LOWER_RANGE
                         ADD R4, R4, R0
                         BRp TAKE_CHAR
NEXT                         
                         STR R0, R1, #0
                         ADD R1, R1, #1
                         BR  TAKE_CHAR
TO_LOWER
                         LD  R4, TO_LOWER_BIT
                         ADD R0, R0, R4
                         BR  CHECK_LOWER
DONE                                                       
                         ADD R1, R1, #-1
                         LD  R0, STRING_ADDR
                         LD  R7, BU7_STORE_SR
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
STRING_ADDR              .BLKW #1
BU7_STORE_SR             .BLKW #1
CHECK_ENTER              .FILL -xA
TO_LOWER_BIT             .FILL x20
A_UPPER_RANGE            .FILL -x41
Z_LOWER_RANGE            .FILL -x5A
UPPER_RANGE              .FILL -x61
LOWER_RANGE              .FILL -x7A
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
                         
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3300
; Input:         
; Postcondition: 
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3300          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
CHECK_PALINDROME
;BACK UP REGISTERS
                         ST  R0, STRING_ADDR_SR
                         ST  R1, STRING_END_ADDR
                         ST  R7, BU7_SR

CHECK_CHAR                         
                         LDR R3, R0, #0
                         LDR R4, R1, #0
                         NOT R5, R4
                         ADD R5, R5, #1
                         
                         ADD R5, R5, R3
                         BRnp NOT_PALIND
                         ;check position, if at the middle => done SR
                         ;even string
                         NOT R5, R0
                         ADD R5, R5, #1
                         ADD R6, R5, R1
                         ADD R6, R6, #-1
                         BRz IS_PALIND
                         ;uneven string
                         ADD R6, R5, R1
                         ADD R6, R6, #-2
                         BRz IS_PALIND
                         
                         ADD R1, R1, #-1
                         ADD R0, R0, #1
                         BR  CHECK_CHAR
NOT_PALIND
                         LEA R0, NOT_PALIND_MSG                         
                         PUTS
                         BR END_SR
IS_PALIND
                         LEA R0, PALIND_MSG
                         PUTS
END_SR                                                       
                         LD  R0, STRING_ADDR_SR
                         LD  R1, STRING_END_ADDR
                         LD  R7, BU7_SR
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3300
; -----------------------------------------------------------------------
BU7_SR                   .BLKW #1
STRING_ADDR_SR           .BLKW #1
STRING_END_ADDR          .BLKW #1
PALIND_MSG               .STRINGZ "THIS IS A PALINDROME\n"
NOT_PALIND_MSG           .STRINGZ "THIS IS NOT A PALINDROME\n"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3300
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
