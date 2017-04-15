; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 02
; Lab Section: 023
; TA: Aditya Tammewar
;
; I herby certify that the contents of this file are ENTIRELY my own original
; work.
; =======================================================================
                         .ORIG x3000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
; -----------------------------------------------------------------------
                         LD  R5, DEC_65           ;R5 <-- MEM[DEC_65]
                         LD  R6, HEX_41           ;R6 <-- MEM[HEX_41]
                         
                         LDR R3, R5, #0           ;R3 <-- MEM[MEM[R5 + #0]]
                         LDR R4, R6, #0           ;R4 <-- MEM[MEM[R6 + #0]]
                         
                         ADD R3, R3, #1           ;R3 <-- R3 + #1
                         ADD R4, R4, #1           ;R4 <-- R4 + #1
                         
                         STR R3, R5, #0           ;MEM[MEM[R5 + #0]] <-- R3
                         STR R4, R6, #0           ;MEM[MEM[R6 + #0]] <-- R4
                         
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
DEC_65                   .FILL x4000
HEX_41                   .FILL x4001

                         .ORIG x4000              ;REMOTE DATA
                         .FILL #65
                         .FILL x41                         
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
