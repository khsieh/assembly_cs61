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
                         LDI R3, DEC_65           ;R3 <-- mem[DEC_65]
                         LDI R4, HEX_41           ;R4 <-- mem[HEX41]
                         
                         ADD R3, R3, #1           ;R3 <-- R3 + #1
                         ADD R4, R4, #1           ;R4 <-- R4 + #1
                         
                         STI R3, DEC_65           ;MEM[NEW_DEC_65] <-- R3
                         STI R4, HEX_41           ;MEM[NEW_HEX_41] <-- R4
                         
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
