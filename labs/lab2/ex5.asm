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
                         IN                       
                                            ;DOES GETC WITH A PROMPT TO USER
                                            ;AND ECHO THE USER INPUT
                         LEA  R0, STRING    ;LOAD STRING STARTING MEM[STRING]
                         PUTS               ;CONSOLE <-- MEM[R0]
                         HALT               ;STOP PROGRAM
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
STRING                   .STRINGZ "THIS IS A TEST~\n"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
