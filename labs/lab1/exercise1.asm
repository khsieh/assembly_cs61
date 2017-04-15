; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment Lab 01
; Lab Section: 
; TA: Aditya Tammewar
;
; I herby certify that the contents of this file are ENTIRELY my own original
; work.
; =======================================================================
                         .ORIG x3000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
; -----------------------------------------------------------------------                      
                         LD  R1, DEC_0            ;R1 <-- #0
                         LD  R2, DEC_12           ;R2 <--#12
                         LD  R3, DEC_6            ;R3 <-- #6
DO_WHILE_LOOP
                         ADD R1, R1, R2           ;R1 <-- R1 + R2
                         ADD R3, R3, #-1          ;R3 <-- R3 - #1
                         BRp DO_WHILE_LOOP        
                                            ;if (R3 > 0): go to DO_WHILE_LOOP
END_DO_WHILE_LOOP
                         HALT                     ;terminate program
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
DEC_0                    .FILL #0
DEC_12                   .FILL #12
DEC_6                    .FILL #6
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
