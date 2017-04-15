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
                         LD  R0, DATA_VAL         ;R0 <-- MEM[DATA_VAL]
                         LD  R1, COUNTER          ;R1 <-- MEM[COUNTER]
                         
LOOP                         
                         OUT
                         ADD R0, R0, #1
                         ADD R1, R1, #-1
                         BRp LOOP
                         
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
DATA_VAL                 .FILL x61
COUNTER                  .FILL x1A
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
