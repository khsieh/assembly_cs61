; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment Lab 01
; Lab Section: 023
; TA: Aditya Tammewar
;
; I attest that this code was totally given to me 
; and that I didn't come up with any of it =P
; =======================================================================
; -----------------------------------------------------------------------
; REG VALUES          R0  R1  R2  R3  R4  R5  R6  R7
; -----------------------------------------------------------------------
;Pre-loop             0   6   12  0   0   0   0    x0490
;Iteration1           0   5   12  12  0   0   0    x0490
;Iteration2           0   4   12  24  0   0   0    x0490
;Iteration3           0   3   12  36  0   0   0    x0490
;Iteration4           0   2   12  48  0   0   0    x0490
;Iteration5           0   1   12  60  0   0   0    x0490
;End of Program       0   0   12  72  0   0   0    x0490   
;End of Program       0   0   12  72  0   0   0    x3007   
; -----------------------------------------------------------------------
                         .ORIG x3000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
; -----------------------------------------------------------------------
                         LD  R1, DEC_6            ;R1 <-- #6
                         LD  R2, DEC_12           ;R2 <--#12
                         LD  R3, DEC_0            ;R3 <-- #0
DO_WHILE_LOOP
                         ADD R3, R3, R2           ;R1 <-- R1 + R2
                         ADD R1, R1, #-1          ;R3 <-- R3 - #1
                         BRp DO_WHILE_LOOP        
                                            ;if (R3 > 0): go to DO_WHILE_LOOP
END_DO_WHILE_LOOP
                         HALT                     ;stops the program
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
DEC_0                    .FILL #0               ;Put value 0 into memory here
DEC_6                    .FILL #6               ;Put value 6 into memory here
DEC_12                   .FILL #12              ;Put value 12 into memory here
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
