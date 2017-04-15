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
                         
                         LD R1, TEST_VAL                         
                         JSR RIGHT_SHIFT
                         
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                         
TEST_VAL                 .FILL x1234
TEST_VAL2                .FILL #-1234
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code

;========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3200
; Input:         the number to be right shifted
; Postcondition: the value in R1 should be divided by 2
; Return Value:  result of right shifted number
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
RIGHT_SHIFT
                         ST R7, R7_BU
                         LD R2, SHIFT_COUNT
CHECK                         
                         ADD R1, R1, #0 ;test R1
                         BRp LEFT_SHIFT
                         BRn TWO_COMP
                         BRz RESTORE
TWO_COMP                         
                         NOT R1,R1
                         ADD R1, R1, #1
                         ADD R4, R4, #1 ;flag for neg number
                         BR CHECK
LEFT_SHIFT
                         ADD R2, R2, #-1 
                         BRz CHECK_RESULT
                         ADD R1, R1, R1
                         BRzp LEFT_SHIFT
                         BR LEFT_SHIFT_ADD1
LEFT_SHIFT_ADD1          
                         ADD R2, R2, #-1
                         BRz CHECK_RESULT
                         ADD R1, R1, R1
                         ADD R1, R1, #1
                         BRzp LEFT_SHIFT
                         BR LEFT_SHIFT_ADD1
CHECK_RESULT                         
                         ADD R4, R4, #0
                         BRp TWOS_COMP_RESULT
                         BR  RESTORE

TWOS_COMP_RESULT
                         NOT R1, R1
                         ADD R1, R1, #1                         
RESTORE                   
                         
                         LD R7, R7_BU                                                  
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------                         
R7_BU                    .BLKW #1
SHIFT_COUNT              .FILL #16

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
