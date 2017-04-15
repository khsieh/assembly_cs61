; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 06
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
                         LEA R0, INST
                         PUTS
                         
                         GETC
                         OUT
                         
                         ADD R1, R0, #0
                         JSR COUNT_ONES
                         
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                         
INST                     .STRINGZ "Please enter a character: "
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_30000
; Input:         None.
; Postcondition: None.
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3200       
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
COUNT_ONES
;backup necessary registers                         
                         ST R1, R1_BU
                         ST R7, R7_BU
                         
                         LD R2, ZERO
                         LD R3, BIT_COUNT
                         LD R4, DEC_TO_CHAR
                         ADD R1, R1, #0
                         BRn ONE_INC
COUNTING                         
                         ADD R1, R1, R1
                         ADD R1, R1, #0
                         BRn ONE_INC
                         ADD R3, R3, #-1
                         BRp COUNTING
                         BR  PRINT
                         
ONE_INC                         
                         ADD R2, R2, #1
                         ADD R3, R3, #-1
                         BR COUNTING

PRINT                         
                         ADD R4, R2, R4
                         LEA R0, PROMPT
                         PUTS
                         ADD R0, R4, #0
                         OUT
                         
;restore necessary registers
                         LD R7, R7_BU
                         LD R7, R7_BU
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
R1_BU                    .BLKW #1
R7_BU                    .BLKW #1
ZERO                     .FILL #0
DEC_TO_CHAR              .FILL x30
BIT_COUNT                .FILL #16
PROMPT                   .STRINGZ "\nTHE NUMBER OF ONE's IS: "   
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                
