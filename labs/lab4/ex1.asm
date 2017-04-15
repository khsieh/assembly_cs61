; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 04
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
                         LD  R0, DATA_PTR         ;R0 <-- DATA_PTR
                         LD  R1, ZERO             ;R1 <-- ZERO
                         LD  R3, COUNT            ;R3 <-- COUNT
STORE                         
                         STR R1, R0, #0           ;R0 <-- mem[R1]
                         ADD R0, R0, #1           ;R0 <-- R0 + #1
                         ADD R1, R1, #1           ;R1 <-- R1 + #1
                         ADD R3, R3, #-1          ;R3 <-- R3 + #-1
                         BRp STORE                ;if(R3 > 0) STORE
                         
                         LD  R0, DATA_PTR         ;R0 <-- DATA_PTR
                         LDR R2, R0, #6           ;R2 <-- mem[R0 + #6]
                         
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
DATA_PTR                 .FILL x4000
ZERO                     .FILL #0
COUNT                    .FILL #10
                         .ORIG x4000
                         .BLKW #10
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
