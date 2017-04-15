; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: assn07
; Lab Section: 023
; TA: Aditya Tammewar
;
; I herby certify that the contents of this file are ENTIRELY my own original
; work.
; =======================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_30000
; Input:         
; Postcondition: 
; Return Value:  
; -----------------------------------------------------------------------
                         .ORIG x3000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
PROG_START
                         LD  R1, STRING_ADDR
                         LEA R0, MAIN_PROMPT
                         PUTS
                         LEA R0, MAIN_PROMPT2
                         PUTS
                         JSR INPUT_SENTECE
                         JSR FIND_LONGEST
                         LD  R6, ANALYSIS_SR
                         JSRR R6
                         HALT                     ;stops the program
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
STRING_ADDR              .FILL x4000
RSULT                    .FILL x5000
ANALYSIS_SR              .FILL x3600
MAIN_PROMPT              .STRINGZ "Please ente a sentence to find"
MAIN_PROMPT2             .STRINGZ " the Longest Word(s): "
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: INPUT_SENTENCE
; Input (R1): The address of where to store the array of words
; Postcondition: The subroutine has collected an ENTER-terminated string 
;      of words from the user and stored them in consecutive memory locations, 
;      starting at (R1).
; Return Value: None
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
INPUT_SENTECE
;BACK UP REGISTERS
                         ST  R7, BU7_SR
                         ST  R1, SENT_ADDR
                         
TAKE_CHAR
                         GETC
                         OUT
                         LD  R3, ENTER_CHAR_CK
                         ADD R3, R3, R0
                         BRz END_SENT_SR
                         LD  R3, SPACE_CHAR_CK
                         ADD R3, R3, R0
                         BRz ADD_NULL
                         STR R0, R1, #0
                         ADD R1, R1, #1
                         BR  TAKE_CHAR

ADD_NULL                         
                         LD  R0, NULL_CHAR
                         STR R0, R1, #0
                         ADD R1, R1, #1
                         BR  TAKE_CHAR
END_SENT_SR                                                      
                         LD  R0, NULL_CHAR
                         STR R0, R1, #0
                         ADD R1, R1, #1
                         STR R0, R1, #0
                         
                         LD  R7, BU7_SR
                         LD  R1, SENT_ADDR
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
SENT_ADDR                .BLKW #1
BU7_SR                   .BLKW #1
ENTER_CHAR_CK            .FILL -xA
SPACE_CHAR_CK            .FILL -x20
NULL_CHAR                .FILL x0
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3400
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: FIND_LONGEST_WORD
; Input (R1): The address of the array of words
; Postcondition: The subroutine has located the longest word
; Return value (R2): The address of the beginning of the longest word
; -----------------------------------------------------------------------
                         .ORIG x3400          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
FIND_LONGEST
;BACK UP REGISTERS
                         ST  R7, REG7_BU
                         ST  R1, SAVE_SENT_ADDR
                         
                         LD  R3, RESET_ZERO
                         LD  R2, RESULT_ADDR
COUNT_LEN                         
                         LDR R0, R1, #0
                         BRz CHECK_MAX
                         ADD R3, R3, #1
                         ADD R1, R1 ,#1
                         BR  COUNT_LEN
CHECK_MAX                         
                         ADD R3, R3, #0
                         BRz STORE_RESULTS
                         ADD R1, R1, #1
                         LD  R4, MAX_LEN
                         NOT R4, R4
                         ADD R4, R4, #1
                         ADD R4, R3, R4
                         BRp UPDATE_LONGEST
                         LD  R3, RESET_ZERO
                         BR  COUNT_LEN
UPDATE_LONGEST
                         ST  R3, MAX_LEN
                         LD  R3, RESET_ZERO
                         BR  COUNT_LEN
STORE_RESULTS                         
                         LD  R4, MAX_LEN
                         NOT R4, R4
                         ADD R4, R4, #1
                         ST  R4, MAX_LEN_NEG
                         LD  R1, SAVE_SENT_ADDR
RESET                         
                         LD  R3, RESET_ZERO
                         LD  R5, TEMP_STR
                         LD  R4, MAX_LEN_NEG
CHECK_CUR_WORD                         
                         LDR R0, R1, #0
                         STR R0, R5, #0
                         ADD R0, R0, #0
                         BRz CHECK_NEXT
                         ADD R5, R5, #1
                         ADD R1, R1, #1
                         ADD R3, R3, #1
                         BR  CHECK_CUR_WORD
CHECK_NEXT
                         LD  R5, TEMP_STR
                         ADD R4, R4, R3
                         BRz SAVE_RESULTS
                         LD  R3, RESET_ZERO
                         BR  CHECK_END_STR
SAVE_RESULTS
                         LDR R0, R5, #0
                         STR R0, R2, #0
                         ADD R2, R2, #1
                         ADD R5, R5, #1
                         ADD R0, R0, #0
                         BRz CHECK_END_STR
                         BR  SAVE_RESULTS
CHECK_END_STR                         
                         ADD R1, R1, #1
                         LDR R0, R1, #0
                         BRz DONE
                         BR  RESET
DONE
                         LD  R7, REG7_BU
                         LD  R1, SAVE_SENT_ADDR
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
REG7_BU                  .BLKW #1
SAVE_SENT_ADDR           .BLKW #1
MAX_LEN                  .BLKW #1
MAX_LEN_NEG              .BLKW #1
RESET_ZERO               .FILL #0
RESULT_ADDR              .FILL x4200
TEMP_STR                 .FILL x3800
NULL_CHAR_SR2            .FILL x0

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3400
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: PRINT_ANALYSIS
; Input (R1): The address of the beginning of the array of words
; Input (R2): The address of the longest word
; Postcondition: The subroutine has printed out a list of all the words 
;                 entered as well as the longest word(s) in the sentence.
; Return Value: None-
; -----------------------------------------------------------------------
                         .ORIG x3600          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3600
; -----------------------------------------------------------------------
PRINT_ANALYSIS_SR
;BACK UP REGISTERS
                         ST  R7, BACKUP7
                         LD  R2, RESULTS
                         
                         LEA R0, RESULT_PROMPT
                         PUTS
                         
QUOTING
                         LD  R0, DOUBLE_QUOTE
                         OUT
PRINT_ANALYSIS                         
                         LDR R0, R2, #0
                         OUT
                         ADD R0, R0, #0
                         BRz PRINT_NEXT
                         ADD R2, R2, #1
                         BR PRINT_ANALYSIS
PRINT_NEXT               
                         LD  R0, DOUBLE_QUOTE
                         OUT
                         ADD R2, R2, #1
                         LDR R3, R2, #0
                         ADD R3, R3, #0
                         BRz END_PRINT
                         
                         LD R0, COMMA
                         OUT
                         LD R0, SPACE
                         OUT
                         BR QUOTING                 
END_PRINT
                         LEA R0, RESULT_PROMPT2
                         PUTS
                         
                         LD  R7, BACKUP7
                         LD  R2, RESULTS
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3600
; -----------------------------------------------------------------------
;~ BACKUP2                  .BLKW #1
BACKUP7                  .BLKW #1
RESULTS                  .FILL x4200

COMMA                    .FILL x2C
DOUBLE_QUOTE             .FILL x22
SPACE                    .FILL x20
RESULT_PROMPT            .STRINGZ "The Longest Words are: {"
RESULT_PROMPT2           .STRINGZ "}\n"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3600
; -----------------------------------------------------------------------
;=========================================================================

