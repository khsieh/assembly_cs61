; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 05
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
                         LD R3, BINARY_COUNT      ;R3 <-- BINARY_COUNT
                         LD R1, CHAR_TO_DEC       ;R1 <-- CHAR_TO_DEC
                         ;get 'b'
                         GETC                     ;INPUT  R0
                         OUT                      ;OUTPUT R0
                         
GET_BITS
                         GETC                     ;INPUT  R0
                         OUT                      ;OUTPUT R0
                         ADD R0, R0, R1           ;R0 <-- R0 + R1
                         ADD R2, R2, R2           ;R2 <-- R2 + R2
                         ADD R2, R2, R0           ;R2 <-- R2 + R0
                         ADD R3, R3, #-1
                         BRp GET_BITS
                         
                         LD  R0, LF_CHAR
                         OUT 
                         JSR PRINT_BINARY
                         
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                         
LF_CHAR                  .FILL xA
BINARY_COUNT             .FILL #16
CHAR_TO_DEC              .FILL -x30

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3200
; Input:         None.
; Postcondition: None.
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3200
;--------------------------------------------------------------------------
; ASSIGNMENT #3                         
;--------------------------------------------------------------------------                         
PRINT_BINARY                         
                         ;BACK UP R7
                         ST  R7, R7_BU
                         ST  R2, R2_BU
                         LD  R1, COUNTER          ;R2 <-- MEM[COUNTER]
                         LD  R3, SPACE_COUNT      ;R3 <-- MEM[SPACE_COUNT]
                         ;FIRST CHECK
                         ADD R2, R2, #0           ;CHECK R1
                         BRn PRINT_1
                         BR  PRINT_0
;AFTER 1ST CHECK, SHIFT THE BITS                         
SHIFT
                         ADD R1, R1, #-1          ;R2 <-- R2 + #-1
                         BRz END                  ;if(R2 == 0) END
                         
                         ADD R2, R2, R2           ;R1 <-- R1 + R1 //LEFT SHIFT
                         BRn PRINT_1              ;if(R1 < 0) PRINT_1
                         BR  PRINT_0              ;else PRINT_0
PRINT_0
                         LD  R0, ZERO_CHAR        ;R0 <-- MEM[ZERO_CHAR]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R3, R3, #-1          ;R3 <-- R3 + #-1
                         BRz PRINT_SPACE          ;if(R3 == 0) PRINT_SPACE
                         BR  SHIFT                ;else SHIFT
PRINT_1
                         LD  R0, ONE_CHAR         ;R0 <-- MEM[ONE_CHAR]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R3, R3, #-1          ;;R3 <-- R3 + #-1
                         BRz PRINT_SPACE          ;if(R3 == 0) PRINT_SPACE
                         BR  SHIFT                ;else SHIFT
                         
PRINT_SPACE
                         LD  R3, SPACE_COUNT      ;R3 <-- MEM[SPACE_COUNT]
                         LD  R0, SPACE_CHAR       ;R0 <-- MEM[SPACE_CHAR] 
                         OUT                      ;CONSOLE <-- MEM[R0]
                         BR  SHIFT                ;JUMP TO SHIFT
END                         
                         LD  R0, NEW_LINE         ;R0 <-- MEM[NEW_LINE]
                         OUT                      ;CONSOLE <-- MEM[R0]

;RESTORE BACKUP
                         LD  R7, R7_BU
                         LD  R2, R2_BU
                         RET 
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
R7_BU                    .BLKW #1
R2_BU                    .BLKW #1
COUNTER                  .FILL #16
SPACE_CHAR               .FILL x20
SPACE_COUNT              .FILL #4
ZERO_CHAR                .FILL x30
ONE_CHAR                 .FILL x31
NEW_LINE                 .FILL xA
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; ----------------------------------------------------------------------
