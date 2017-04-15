; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 03
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
                         LD  R5, DATA_PTR         ;R5 <-- MEM[DATA_PTR]
                         
                         LDR R3, R5, #0           ;R3 <-- MEM[ MEM[R5]+#0 ]
                         ;LDR R4, R5, #1           ;R4 <-- MEM[ MEM[R5]+#1 ]
                         ADD R5, R5, #1           ;R5 <-- R5 + #1
                         LDR R4, R5, #0           ;R4 <-- MEM[ MEM[R5]+#0 ]
                         
                         ADD R3, R3, #1           ;R3 <-- R3 + #1
                         ADD R4, R4, #1           ;R4 <-- R4 + #1
                         
                         LD  R5, DATA_PTR         ;R5 <-- MEM[DATA_PTR]
                         STR R3, R5, #0           ;MEM[ MEM[R5]+#0 ] <-- R3
                         STR R4, R5, #1           ;MEM[ MEM[R5]+#1 ] <-- R4
                         
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
DATA_PTR                 .FILL x4000

                         .ORIG x4000              ;REMOTE DATA
                         .FILL #65
                         .FILL x41                         
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
