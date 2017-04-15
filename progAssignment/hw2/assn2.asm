; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: assn02
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
                         
                         LEA R0, INST
                         PUTS
                         
                         ;GET FIRST INPUT AND STORE IN R1
                         GETC                     ;R0 <-- input
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R1, R0, #0           ;R1 <-- R0
                         
                         ;PRINT " + "
                         LD  R0, SPACE_CHAR
                         OUT
                         LD  R0, MINUS_CHAR
                         OUT
                         LD  R0, SPACE_CHAR
                         OUT
                         
                         ;GET SECOND INPUT AND STORE IN R2
                         GETC                     ;R0 <-- input
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R2, R0, #0           ;R2 <-- R0
                         
                         ;PRINT " = "
                         LD  R0, SPACE_CHAR
                         OUT
                         LD  R0, EQUAL_CHAR
                         OUT
                         LD  R0, SPACE_CHAR
                         OUT
                         
                         ;CHANGE CHAR TO DEC
                         LD  R3, CHAR_TO_DEC      ;R3 <-- MEM[CHAR_TO_DEC]
                         ADD R1, R1, R3           ;R1 <-- R1 + R3
                         ADD R2, R2, R3           ;R2 <-- R2 + R3
                         
                         ;CASES:
                           ;IF R2 > R1 RESULT IS NEG
                           ;IF R2 < R1 RESULT IS POS
                           ;IF R2 = R1 RESULT IS ZERO
                         NOT R2, R2               ;R2 <-- NEGATE MEM[R2]
                         ADD R2, R2, #1           ;R2 <-- R2 + #1
                         
                         ADD R0, R1, R2           ;R0 <-- R1 + R2
                         BRn NEG_SIGN             ;IF RESULT IS NEG, 
                                                  ;   PRINT NEG_SIGN
PRINT_NUM                                                                  
                         LD  R3, DEC_TO_CHAR      ;R3 <-- MEM[DEC_TO_CHAR]
                         ADD R0, R0, R3           ;R0 <-- R0 + R3
                         OUT                      ;CONSOLE <-- MEM[R0]
                         LD  R0, NEW_LINE
                         OUT
                         BR  END_PROGRAM          ;BRANCH TO END_PROGRAM
                         
NEG_SIGN                 
                         LD  R0, NEG_CHAR         ;R0 <-- MEM[NEG_CHAR]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R0, R1, R2           ;R0 <-- R1 + R2
                         NOT R0, R0
                         ADD R0, R0, #1
                         BR  PRINT_NUM            ;BRANCH TO PRINT_NUM
END_PROGRAM
                         HALT                     ;stops the program
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
CHAR_TO_DEC              .FILL #-48
DEC_TO_CHAR              .FILL #48
NEG_CHAR                 .FILL x2D
SPACE_CHAR               .FILL x20
MINUS_CHAR               .FILL x2D
EQUAL_CHAR               .FILL x3D
NEW_LINE                 .FILL xA
INST            .STRINGZ "PLEASE ENTER TWO SINGLE DIGIT NUMBER TO SUBTRACT\n>"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
