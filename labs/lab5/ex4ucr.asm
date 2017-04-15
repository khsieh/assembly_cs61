; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 05
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
;BACK UP REGISTERS                         
                         ST  R7, BACK_UP_R7       ;BACK_UP_R7 <-- mem[R7]
;SUBROUTINE INSTRUCTIONS                         
                         LD  R1, CHAR_TO_DEC      ;R1 <-- CHAR_TO_DEC
                         LD  R2, ZERO             ;R2 <-- ZERO
                         LD  R3, MULTI_COUNT      ;R3 <-- MULTI_COUNT
                         LD  R5, DIGIT_COUNT      ;R5 <-- DIGIT_COUNT
                         LEA R0, INST             ;R0 <-- INST
                         PUTS                     ;OUTPUTS R0
GET_NUM_CHAR                          
                         GETC                     ;INPUT R0
                         OUT                      ;OUTPUT R0
                         ADD R0, R1, R0           ;R0 <-- R1 + R0
                         ADD R4, R0, #0           ;R4 <-- R0 + #0
MULTI_10                                          
                         ADD R2, R2, R4           ;R2 <-- R2 + R4
                         ADD R3, R3, #-1          ;R3 <-- R3 + #-1 
                         BRp MULTI_10             ;if(R3 > 0) MULTI_10
                         
                         ADD R5, R5, #-1          ;R5 <-- R5 + #-1
                         BRp GET_NUM_CHAR         ;if(R5 > 0) GET_NUM_CHAR
                         
                         
;RESTORE REGISTERS                         
                         LD  R7, BACK_UP_R7       ;R7 <-- BACK_UP_R7
                         ;~ RET
                         HALT                     ;STOP PROGRAM
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                         
BACK_UP_R7               .BLKW #1
CHAR_TO_DEC              .FILL -x30
ZERO                     .FILL #0
MULTI_COUNT              .FILL #10
DIGIT_COUNT              .FILL #2
INST                     .STRINGZ "PLEASE ENTER A TWO DIGIT NUMBER\n"                         
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
