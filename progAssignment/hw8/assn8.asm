; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: assn08
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
                         ;MENU_SUB
                         LD  R6, MENU_ADDR
                         JSRR R6
                         ;CHECK RETURN VALUE (R1)
                         ;CALL APPROPRIATE SUBROUTINE
                         ADD R6, R1, #-1
                         BRz CALL_ALL_BUSY
                         
                         ADD R6, R1, #-2
                         BRz CALL_ALL_FREE
                         
                         ADD R6, R1, #-3
                         BRz CALL_NUM_BUSY
                         
                         ADD R6, R1, #-4
                         BRz CALL_NUM_FREE
                         
                         ADD R6, R1, #-5
                         BRz CALL_MACHINE_STAT
                         
                         ADD R6, R1, #-6
                         BRz CALL_FIRST_FREE
                         
                         ADD R6, R1, #-7
                         BRz QUIT_PROG
                         ;JMP TO PROG_START
                         BR  PROG_START
                         
CALL_ALL_BUSY
                         LD  R6, ALL_BUSY_ADDR
                         JSRR R6
                         ADD R2, R2, #0
                         BRz PRINT_ALL_NOT_BUSY
                         LEA R0, RESPOND1B
                         PUTS
                         BR  PROG_START
PRINT_ALL_NOT_BUSY                        
                         LEA R0, RESPOND1A
                         PUTS
                         BR  PROG_START
CALL_ALL_FREE
                         LD  R6, ALL_FREE_ADDR
                         JSRR R6
                         ADD R2, R2, #0
                         BRz PRINT_ALL_NOT_FREE
                         LEA R0, RESPOND2B
                         BR  PROG_START
PRINT_ALL_NOT_FREE                         
                         LEA R0, RESPOND2A
                         PUTS
                         BR PROG_START
CALL_NUM_BUSY
                         LD  R6, NUM_BUSY_ADDR
                         JSRR R6
                         LEA R0, RESPOND3A
                         PUTS
                         ;SUBROUTINE TO PRINT R2 DEC
                         ST  R1, TEMP1
                         ST  R2, TEMP2
                         ADD R1, R2, #0
                         LD  R6, PRINT_DEC_SR
                         JSRR R6
                         LD  R1, TEMP1
                         LD  R2, TEMP2
                         
                         LEA R0, RESPOND3B
                         PUTS
                         BR  PROG_START
CALL_NUM_FREE
                         LD  R6, NUM_FREE_ADDR
                         JSRR R6
                         LEA R0, RESPOND3A
                         PUTS
                         ;SUBROUTINE TO PRINT R2 DEC
                         ST  R1, TEMP1
                         ST  R2, TEMP2
                         ADD R1, R2, #0
                         LD  R6, PRINT_DEC_SR
                         JSRR R6
                         LD  R1, TEMP1
                         LD  R2, TEMP2
                         
                         LEA R0, RESPOND4
                         PUTS
                         BR  PROG_START
CALL_MACHINE_STAT
                         LD  R6, MACHINE_STAT_ADDR
                         JSRR R6
                         LEA R0, RESPOND5A
                         PUTS
                         ;SUBROUTINE TO PRINT R1 DEC
                         ST  R1, TEMP1
                         ST  R2, TEMP2
                         LD  R6, PRINT_DEC_SR
                         JSRR R6
                         LD  R1, TEMP1
                         LD  R2, TEMP2
                         
                         ADD R2, R2, #0
                         BRz PRINT_MACHINE_ISFREE
                         LEA R0, RESPOND5B
                         PUTS
                         BR  PROG_START
PRINT_MACHINE_ISFREE                         
                         LEA R0, RESPOND5C
                         PUTS
                         BR  PROG_START
CALL_FIRST_FREE
                         LD  R6, FIRST_FREE_ADDR
                         JSRR R6
                         LEA R0, RESPOND6
                         PUTS
                         ;SUBROUTINE TO PRINT R2 DEC
                         ST  R1, TEMP1
                         ST  R2, TEMP2
                         ADD R1, R2, #0
                         LD  R6, PRINT_DEC_SR
                         JSRR R6
                         LD  R1, TEMP1
                         LD  R2, TEMP2
                         BR  PROG_START
QUIT_PROG                         
                         LEA R0, RESPOND7
                         PUTS
                         
                         HALT                     ;stops the program
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
TEMP1                    .BLKW #1
TEMP2                    .BLKW #1
PRINT_DEC_SR             .FILL x6000
MENU_ADDR                .FILL x4000
ALL_BUSY_ADDR            .FILL x31D0
ALL_FREE_ADDR            .FILL x3200
NUM_BUSY_ADDR            .FILL x3300
NUM_FREE_ADDR            .FILL x3400
MACHINE_STAT_ADDR        .FILL x3600
FIRST_FREE_ADDR          .FILL x3500
RESPOND1A                .STRINGZ "\nALL MACHINES ARE NOT BUSY"
RESPOND1B                .STRINGZ "\nALL MACHINES ARE BUSY"
RESPOND2A                .STRINGZ "\nALL MACHINES ARE NOT FREE"
RESPOND2B                .STRINGZ "\nALL MACHINES ARE FREE"
RESPOND3A                .STRINGZ "\nTHERE ARE "
RESPOND3B                .STRINGZ " BUSY MACHINES"
RESPOND4                 .STRINGZ " FREE MACHINES"
RESPOND5A                .STRINGZ "\nMACHINE "
RESPOND5B                .STRINGZ " IS BUSY"
RESPOND5C                .STRINGZ " IS FREE"
RESPOND6                 .STRINGZ "\nTHE FIRST AVAILABLE MACHINE IS NUMBER "
RESPOND7                 .STRINGZ "\nGOODBYE!"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition:The subroutine has printed out a menu with numerical options,
;       allowed the user to select an option, and returned the selected option.
; Return(R1):   The option selected: #1, #2, #3, #4, #5, #6 or #7
; -----------------------------------------------------------------------
                         .ORIG x4000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
MENU
;BACK UP REGISTERS
                         ST  R7, BU7_MENU
                         LEA R0, PROMPT1
                         PUTS
                         LEA R0, PROMPT2
                         PUTS
                         LEA R0, PROMPT3
                         PUTS
                         LEA R0, PROMPT4
                         PUTS
                         LD  R0, STR_5
                         PUTS
                         LD  R0, STR_6
                         PUTS
                         LD  R0, STR_7
                         PUTS
                         LD  R0, STR_8
                         PUTS
                         LD  R0, STR_9
                         PUTS
                         LD  R0, STR_10
                         PUTS
GET_INPUT                         
                         GETC
                         OUT
                         BR  INPUT_VALIDATION
INPUT_ERROR
                         LEA R0, INPUT_ERR_MSG
                         PUTS
                         BR  GET_INPUT
INPUT_VALIDATION                         
                         LD  R1, CHAR_TO_DEC
                         ADD R1, R0, R1
                         ;add input validation
                         LD  R6, INPUT_LOWER_BOUND
                         ADD R6, R6, R1
                         BRn INPUT_ERROR
                         LD  R6, INPUT_UPPER_BOUND
                         ADD R6, R6, R1
                         BRp INPUT_ERROR
                         
END_SR_MENU                         
                         LD  R7, BU7_MENU
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
BU7_MENU                 .BLKW #1
INPUT_LOWER_BOUND        .FILL #-1
INPUT_UPPER_BOUND        .FILL #-7
CHAR_TO_DEC              .FILL -x30
STR_5                    .FILL x4100
STR_6                    .FILL x41C0
STR_7                    .FILL x4200
STR_8                    .FILL x42C0
STR_9                    .FILL x4300
STR_10                   .FILL x43C0
INPUT_ERR_MSG            .STRINGZ "\nINVALID INPUT PLEASE ENTER #1-#7\n>"
PROMPT1                  .STRINGZ "\n**********************\n"
PROMPT2                  .STRINGZ "* The Busyness Server *\n"
PROMPT3                  .STRINGZ "**********************\n"
PROMPT4                  .STRINGZ "1. Check to see whether all machines are busy\n"
                         .ORIG x4100
PROMPT5                  .STRINGZ "2. Check to see whether all machines are free\n"
                         .ORIG x41C0
PROMPT6                  .STRINGZ "3. Report the number of busy machines\n"
                         .ORIG x4200
PROMPT7                  .STRINGZ "4. Report the number of free machines\n"
                         .ORIG x42C0
PROMPT8                  .STRINGZ "5. Report the status of machine n\n"
                         .ORIG x4300
PROMPT9                  .STRINGZ "6. Report the number of the first available machine\n"
                         .ORIG x43C0
PROMPT10                 .STRINGZ "7. Quit\n>"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:       ALL_MACHINES_BUSY
; Inputs:           None
; Postcondition:    The subroutine has returned a value indicating whether all
;                   machines are busy
; Return (R2):      1 if all machines are busy, 0 otherwise
; -----------------------------------------------------------------------
                         .ORIG x31D0          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_31D0
; -----------------------------------------------------------------------
SUBR_ALL_BUSY
;BACK UP REGISTERS
                         ST  R7, BU7_ALL_BUSY
                         LD  R4, MACHINE_COUNT1
                         LDI  R3, BUSY_ADDR1
                         
                         ADD R3, R3, #0
                         BRzp NOT_BUSY
SHIFT_AB                         
                         ADD R3, R3, R3
                         BRzp NOT_BUSY
                         ADD R4, R4, #-1
                         BRz ALL_BUSY
                         BR  SHIFT_AB
ALL_BUSY
                         LD  R2, FLAG_ALL_BUSY
                         BR  END_SR_ALL_BUSY                        
NOT_BUSY
                         LD  R2, FLAG_NOT_BUSY
END_SR_ALL_BUSY                         
                         LD  R7, BU7_ALL_BUSY
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_31D0
; -----------------------------------------------------------------------
BU7_ALL_BUSY             .BLKW #1
FLAG_NOT_BUSY            .FILL #0
FLAG_ALL_BUSY            .FILL #1
MACHINE_COUNT1           .FILL #15
BUSY_ADDR1               .FILL x5000
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_31D0
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:       ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether 
;                 all machines are free
; Return(R2):    1 if all machines are free, 0 otherwise
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
SUBR_ALL_FREE ;FIXXXXXXXXXXXXXXXXXXXXXXX
;BACK UP REGISTERS
                         ST  R7, BU7_ALL_FREE
                         LD  R4, MACHINE_COUNT3
                         LDI R3, BUSY_ADDR5
                         
                         ADD R3, R3, #0
                         BRn NOT_FREE
SHIFT_AF                         
                         ADD R3, R3, R3
                         BRn NOT_FREE
                         ADD R4, R4, #-1
                         BRz ALL_FREE
                         BR  SHIFT_AF
ALL_FREE                         
                         LD  R2, FLAG_ALL_FREE
                         BR  END_SR_ALL_FREE
NOT_FREE                         
                         LD  R2, FLAG_NOT_FREE
END_SR_ALL_FREE                         
                         LD  R7, BU7_ALL_FREE
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
BU7_ALL_FREE            .BLKW #1
BUSY_ADDR5              .FILL x5000
MACHINE_COUNT3          .FILL #15
FLAG_NOT_FREE           .FILL #0
FLAG_ALL_FREE           .FILL #1

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
; -----------------------------------------------------------------------
                         .ORIG x3300          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3300
; -----------------------------------------------------------------------
SUBR_NUM_BUSY
;BACK UP REGISTERS
                         ST  R7, BU7_NUM_BUSY
                         LD  R2, MACHINE_COUNT_SET0
                         LD  R4, MACHINE_COUNT2
                         LDI R3, BUSY_ADDR2
                         
COUNT_ONES                         
                         ADD R3, R3, #0
                         BRn ADD_BUSY
                         ADD R3, R3, R3
                         ADD R4, R4, #-1
                         BRz END_SR_NUM_BUSY
                         BR  COUNT_ONES
ADD_BUSY
                         ADD R3, R3, R3
                         ADD R2, R2, #1                         
                         ADD R4, R4, #-1
                         BRz END_SR_NUM_BUSY
                         BR  COUNT_ONES                    
END_SR_NUM_BUSY                         
                         LD  R7, BU7_NUM_BUSY
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3300
; -----------------------------------------------------------------------
BU7_NUM_BUSY             .BLKW #1
MACHINE_COUNT_SET0       .FILL #0
MACHINE_COUNT2           .FILL #16
BUSY_ADDR2               .FILL x5000
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3300
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free
; -----------------------------------------------------------------------
                         .ORIG x3400          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
SUBR_NUM_FREE
;BACK UP REGISTERS
                         ST  R7, BU7_NUM_FREE
                         JSR SUBR_NUM_BUSY
                         
                         NOT R2, R2
                         ADD R2, R2, #1
                         LD  R3, NOT_FREE_MACHINE_COUNT
                         ADD R2, R2, R3
                                         
END_SR_NUM_FREE                         
                         LD  R7, BU7_NUM_FREE
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
BU7_NUM_FREE             .BLKW #1
NOT_FREE_MACHINE_COUNT   .FILL #16
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3400
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest 
;                numbered free machine
; Return Value (R2): the number of the free machine
; -----------------------------------------------------------------------
                         .ORIG x3500          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3500
; -----------------------------------------------------------------------
SUBR_FIRST_FREE
;BACK UP REGISTERS
                         ST  R7, BU7_FIRST_FREE
                         LD  R2, MACHINE_PTR
                         LDI R3, BUSY_ADDR3
SHIFT_FF                         
                         ADD R3, R3, #0
                         BRn CHECK_NEXT_MACHINE
                         BR  END_SR_FIRST_FREE
CHECK_NEXT_MACHINE
                         ADD R2, R2, #1
                         ADD R3, R3, R3
                         BR  SHIFT_FF                         
END_SR_FIRST_FREE                         
                         LD  R7, BU7_FIRST_FREE
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3500
; -----------------------------------------------------------------------
BU7_FIRST_FREE           .BLKW #1
MACHINE_PTR              .FILL #0
BUSY_ADDR3               .FILL x5000
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3500
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the 
;                 machine indicated by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
; -----------------------------------------------------------------------
                         .ORIG x3600          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3600
; -----------------------------------------------------------------------
SUBR_MACHINE_STAT
;BACK UP REGISTERS
                         ST  R7, BU7_MACHINE_STAT
                         
                         LD  R6, USER_INPUT_MACHINE_ADDR
                         JSRR R6
                         
                         LDI R3, BUSY_ADDR4
                         
                         ST  R1, MACHINE_NUM_TO_CHECK
SHIFT_MS                         
                         ADD R3, R3, R3
                         ADD R1, R1, #-1
                         BRz CHECK_THIS_MACHINE
                         BR  SHIFT_MS
                         
CHECK_THIS_MACHINE                         
                         ADD R3, R3, #0
                         BRn THIS_MACH_BUSY
                         LD  R2, SINGLE_MACHINE_FREE
                         BR  END_SR_MACHINE_STAT
THIS_MACH_BUSY                         
                         LD  R2, SINGLE_MACHINE_BUSY
END_SR_MACHINE_STAT                         
                         LD  R7, BU7_MACHINE_STAT
                         LD  R1, MACHINE_NUM_TO_CHECK
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3600
; -----------------------------------------------------------------------
BU7_MACHINE_STAT         .BLKW #1
MACHINE_NUM_TO_CHECK     .BLKW #1
SINGLE_MACHINE_BUSY      .FILL #1
SINGLE_MACHINE_FREE      .FILL #0
BUSY_ADDR4               .FILL x5000
USER_INPUT_MACHINE_ADDR  .FILL x4500
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3600
; -----------------------------------------------------------------------
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: USER_INPUT_MACHINE
; Input (R1): Which machine to check
; Postcondition: R1 holds the machine number to check for busyness
; Return Value (R1): the machine number to check for busyness
; -----------------------------------------------------------------------
                         .ORIG x4500          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_4500
; -----------------------------------------------------------------------
USER_INPUT_MACHINE
;BACK UP REGISTERS
                         ST  R7, BU7_MACHINE_INPUT
                         ST  R3, BU3_MACHINE_INPUT
                         ST  R4, BU4_MACHINE_INPUT
                         
                         
                         LEA R0, MACHINE_NUM_PROMPT
                         PUTS
TAKE_MACHINE_NUM                         
                         LD  R1, RESET_R1
                         GETC
                         OUT
                        
                         LD  R4, CHAR_TO_DEC2
                         ADD R0, R4, R0
                         ADD R4, R0, #0
                         LD  R3, TEN_COUNT
TIMES_TEN                         
                         ADD R0, R4, R0
                         ADD R3, R3, #-1
                         BRz SECOND_DIGIT
                         ADD R1, R0, #0
                         BR  TIMES_TEN
                         
SECOND_DIGIT                         
                         GETC
                         OUT
                         LD  R4, CHAR_TO_DEC2
                         ADD R4, R0, R4
                         ADD R1, R4, R1
                         
                         ADD R1, R1, #0
                         BRn ERROR_INPUT
                         LD  R4, MACHINE_UPPER_BOUND
                         ADD R4, R4, R1
                         BRp ERROR_INPUT
                         BR  END_SR_MACHINE_INPUT
ERROR_INPUT
                         LEA R0, MACHINE_NUM_ERR
                         PUTS
                         BR  TAKE_MACHINE_NUM                         
END_SR_MACHINE_INPUT                         
                         LD  R3, BU3_MACHINE_INPUT
                         LD  R4, BU4_MACHINE_INPUT
                         LD  R7, BU7_MACHINE_INPUT
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_4500
; -----------------------------------------------------------------------
BU3_MACHINE_INPUT         .BLKW #1
BU4_MACHINE_INPUT         .BLKW #1
BU7_MACHINE_INPUT         .BLKW #1
RESET_R1                  .FILL #0
TEN_COUNT                 .FILL #10
MACHINE_UPPER_BOUND       .FILL #-15
CHAR_TO_DEC2              .FILL -x30
MACHINE_NUM_PROMPT        .STRINGZ "\nWhich Machine?(#00-#15)"
MACHINE_NUM_ERR           .STRINGZ "\nINVALID MACHINE NUMBER,#0 to #15 only\n"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_4500
; -----------------------------------------------------------------------
;=========================================================================


;=========================================================================
; Subroutine:    SUB_MAIN_3400
; Input:         A NUMBER IN THE RANGE OF [#-32768, #32767]
; Postcondition: R1 holds the vaule to be print
; Return Value:  print the dec value of R1 onto console
; -----------------------------------------------------------------------
                         .ORIG x6000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
SR_PRINT_NUM
;BACK UP REGISTERS
                         ST  R1, BU1_STORE_SR2
                         ST  R2, BU2_STORE_SR2
                         ST  R3, BU3_STORE_SR2
                         ST  R4, BU4_STORE_SR2
                         ST  R5, BU5_STORE_SR2
                         ST  R7, BU7_STORE_SR2
                         
                         LD  R5, CHAR_TO_DEC_SR
                         LD  R3, DEC_TO_CHAR_SR
                         ;SIGN CHECK
                         ADD R1, R1, #0
                         BRn PRINT_NEG
                         BRz PRINT_ZERO
                         LD  R0, PLUS_CHAR
                         OUT
DIGIT_CHECK                         
                         ADD R4, R1, #0
                         LD  R2, TEN_THOUSAND
                         ADD R0, R1, R2
                         BRzp START_FIRST
                         
                         LD  R2, THOUSAND
                         ADD R0, R1, R2
                         BRzp START_SECOND
                         
                         LD  R2, HUNDRED
                         ADD R0, R1, R2
                         BRzp START_THIRD
                         
                         LD  R2, TEN
                         ADD R0, R1, R2
                         BRzp START_FOURTH
                         
                         LD  R2, ONE_SUB2
                         ADD R0, R1, R2
                         BRzp START_FIFTH
                         
                         
START_FIRST                         
                         LD  R2, TEN_THOUSAND
                         LD  R0, ZERO_SUB2
FIRST                    ;PRINT OUT 1ST DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp FIRST
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         ADD R1, R4, #0
                         ADD R0, R5, R0
                         ADD R0, R0, #0
                         BRz START_SECOND
GET_REMAIN1              ;REMOVED 1ST DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN1
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
START_SECOND                         
                         LD  R2, THOUSAND
                         LD  R0, ZERO_SUB2
SECOND                   ;PRINT OUT 2ND DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp SECOND
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         ADD R1, R4, #0           ;BACK UP FROM TEMP, 4 DIGITS
                         ADD R0, R5, R0
                         ADD R0, R0, #0
                         BRz START_THIRD
GET_REMAIN2              ;REMOVE 2ND DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN2
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
START_THIRD                         
                         LD  R2, HUNDRED
                         LD  R0, ZERO_SUB2
THIRD                    ;PRINT OUT 2ND DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp THIRD
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         ADD R1, R4, #0           ;BACK UP FROM TEMP, 4 DIGITS
                         ADD R0, R5, R0
                         ADD R0, R0, #0
                         BRz START_FOURTH
GET_REMAIN3              ;REMOVE 2ND DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN3
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
START_FOURTH                         
                         LD  R2, TEN
                         LD  R0, ZERO_SUB2
FOURTH                   ;PRINT OUT 3RD DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRp FOURTH
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         
                         ADD R1, R4, #0           ;BACK UP FROM TEMP, 4 DIGITS
                         ADD R0, R5, R0
                         ADD R0, R0, #0
                         BRz START_FIFTH
GET_REMAIN4              ;REMOVE 4TH DIGIT
                         ADD R1, R1, R2
                         ADD R0, R0, #-1
                         BRp GET_REMAIN4
                         ADD R4, R1, #0           ;TEMP SAVE mem[R1] IN R4
START_FIFTH                         
                         LD  R2, ONE_SUB2
                         LD  R0, ZERO_SUB2
FIFTH                    ;PRINT OUT 5TH DIGIT
                         ADD R0, R0, #1
                         ADD R1, R1, R2
                         BRzp FIFTH
                         ADD R0, R0, #-1
                         ADD R0, R3, R0
                         OUT
                         BR END_PRINT
PRINT_NEG
                         LD  R0, NEG_CHAR_SR
                         OUT
                         NOT R1, R1
                         ADD R1, R1, #1
                         BR  DIGIT_CHECK
PRINT_ZERO
                         LD  R0, PLUS_CHAR
                         OUT
                         LD  R0, ZERO_CHAR
                         OUT
                         BR  END_PRINT
;RESTORE REGISTERS                         
END_PRINT                                                       
                         LD  R1, BU2_STORE_SR2
                         LD  R2, BU2_STORE_SR2
                         LD  R3, BU3_STORE_SR2
                         LD  R4, BU4_STORE_SR2
                         LD  R7, BU7_STORE_SR2
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
ZERO_SUB2                 .FILL x0
ONE_SUB2                  .FILL -x1
TEN                       .FILL -xA
HUNDRED                   .FILL -x64
THOUSAND                  .FILL -x3E8
TEN_THOUSAND              .FILL -x2710
PLUS_CHAR                 .FILL x2B
ZERO_CHAR                 .FILL x30
NEG_CHAR_SR               .FILL x2D
DEC_TO_CHAR_SR            .FILL x30
CHAR_TO_DEC_SR            .FILL -x30

BU1_STORE_SR2             .BLKW #1
BU2_STORE_SR2             .BLKW #1
BU3_STORE_SR2             .BLKW #1
BU4_STORE_SR2             .BLKW #1
BU5_STORE_SR2             .BLKW #1
BU7_STORE_SR2             .BLKW #1
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3400
; -----------------------------------------------------------------------
;=========================================================================


;**************BUSYNESS VECTOR HERE!***********************
                         .ORIG x5000
BUSYNESS                 .FILL x0FF0
;**************BUSYNESS VECTOR HERE!***********************
