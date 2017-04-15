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
                         STR R0, R1, #0
                         ADD R1, R1, #1
                         BR  TAKE_CHAR
                         
DONE                                                       
                         LD  R0, STRING_ADDR
                         LD  R7, BU7_STORE_SR
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
STRING_ADDR              .BLKW #1
BU7_STORE_SR             .BLKW #1
CHECK_ENTER              .FILL -xA

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
