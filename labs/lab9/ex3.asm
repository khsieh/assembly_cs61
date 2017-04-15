; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 07
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
                         LD  R1, STACK_ADDR
                         LD  R2, STACK_ADDR
                         LD  R3, STACK_CAP
                         
                         GETC
                         OUT
                         LD  R4, CHAR_TO_DEC_MAIN
                         ADD R0, R4, R0
                         JSR STACK_PUSH
                         ;~ JSR STACK_POP
                         
                         GETC
                         OUT
                         LD  R4, CHAR_TO_DEC_MAIN
                         ADD R0, R4, R0
                         JSR STACK_PUSH
                         ;~ JSR STACK_POP
                         
                         GETC
                         OUT
                         
                         JSR SUB_RPN_MULTIPLY
                         
                         LDR R0, R2, #-1
                         LD  R6, PRINT_NUM_ADDR
                         JSRR R6
                         ;~ JSR SR_PRINT_NUM
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                         
PRINT_NUM_ADDR           .FILL x3600
TEST_NUM                 .FILL #10
TEST_NUM2                .FILL #5
CHAR_TO_DEC_MAIN              .FILL -x30
DEC_TO_CHAR_MAIN              .FILL x20
STACK_ADDR               .FILL x4000
STACK_CAP                .FILL #20  
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the next place to PUSH an item
; Parameter (R3): capacity: The number of additional items the stack can hold
; Postcondition: The subroutine has pushed (R0) onto the stack. If an overflow
;                occurred, the subroutine has printed an overflow error message
;                and terminated.
; Return Value: R2 <- updated top value
;               R3 <- updated capacity value
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
STACK_PUSH
;BACK UP REGISTERS
                         ST  R7, BU7_SR
                         
                         ADD R3, R3, #0
                         BRz STACK_OVERFLOW_ERR
                         
                         ;~ NOT R4, R2
                         ;~ ADD R4, R4, #1
                         ;~ ADD R4, R4, R1
                         ;~ BRnz PUSH_VAL
                         
;~ PUSH_VAL                         
                         STR R0, R2, #0
                         ADD R3, R3, #-1
                         ADD R2, R2, #1
                         BR  DONE
                         
STACK_OVERFLOW_ERR
                         LEA R0, STACK_OF_MSG
                         PUTS
DONE                                                       
                         LD  R7, BU7_SR
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
BU7_SR             .BLKW #1
ST_ADDR_SR               .BLKW #1
STACK_OF_MSG             .STRINGZ "\nSTACK OVERFLOW!\n"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the item to POP
; Parameter (R3): capacity: The # of additional items the stack can hold
; Postcondition: The subroutine has popped MEM[top] off of the stack.
;                If an underflow occurred, the subroutine has printed an
;                underflow error message and terminated.
; Return Value: R0 <- value popped off of the stack
;               R2 <- updated top value
;               R3 <- updated capacity value
; -----------------------------------------------------------------------
                         .ORIG x3300          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
STACK_POP
;BACK UP REGISTERS
                         ST  R7, BU7_SR2
                         
                         LD R4, STACK_CAP_CHECK
                         
                         ADD R4, R3, R4
                         BRz STACK_UNDERFLOW_ERR
                         
                         ADD R2, R2, #-1
                         ADD R3, R3, #1
                         BR  DONE_SR
                         
STACK_UNDERFLOW_ERR
                         LEA R0, STACK_UF_MSG
                         PUTS
DONE_SR                                                       
                         LD  R7, BU7_SR2
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
BU7_SR2            .BLKW #1
STACK_CAP_CHECK          .FILL #-20
STACK_UF_MSG             .STRINGZ "\nSTACK UNDERFLOW!\n"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
;----------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R1): stack_addr
; Parameter (R2): top
; Parameter (R3): capacity
; Postcondition: The subroutine has popped off the top two values of the stack,
;               multiplied them together, and pushed the resulting value back
;               onto the stack.
; Return Value: R2 <- updated top value
;               R3 <- updated capacity value
;----------------------------------------------------------------------------
                         .ORIG x3400          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
SUB_RPN_MULTIPLY
;BACK UP REGISTERS
                         ST  R7, BU_REG7
                         LDR R0, R2, #-1
                         ST  R0, FIRST_MULTIPLICAND
                         JSR STACK_POP
                         
                         LDR R0, R2, #-1
                         ST  R0, SECOND_MULTIPLICAND
                         JSR STACK_POP
                         
                         LD  R4, FIRST_MULTIPLICAND
                         LD  R5, SECOND_MULTIPLICAND
                         LD  R0, RESET
MULTIPLY
                         
                         ADD R0, R0, R4
                         ADD R5, R5, #-1
                         BRz FINISH_MULTI
                         BR  MULTIPLY
                         
FINISH_MULTI                              
                         JSR STACK_PUSH
                         
DONE_RPN
                         LD  R7, BU_REG7
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3400
; -----------------------------------------------------------------------

BU_REG7                  .BLKW #1
RESET                    .FILL #0
FIRST_MULTIPLICAND       .BLKW #1
SECOND_MULTIPLICAND      .BLKW #1
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3400
; -----------------------------------------------------------------------
;=========================================================================
; Subroutine:    SUB_MAIN_3400
; Input:         A NUMBER IN THE RANGE OF [#-32768, #32767]
; Postcondition: R1 holds the vaule to be print
; Return Value:  print the dec value of R1 onto console
; -----------------------------------------------------------------------
                         .ORIG x3600          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
SR_PRINT_NUM
;BACK UP REGISTERS
                         ST  R0, BU0_STORE_SR2
                         ST  R1, BU1_STORE_SR2
                         ST  R2, BU2_STORE_SR2
                         ST  R3, BU3_STORE_SR2
                         ST  R4, BU4_STORE_SR2
                         ST  R5, BU5_STORE_SR2
                         ST  R7, BU7_STORE_SR2
                         
                         
                         LD  R1, BU0_STORE_SR2
                         LD  R5, CHAR_TO_DEC
                         LD  R3, DEC_TO_CHAR
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
DEC_TO_CHAR               .FILL x30
CHAR_TO_DEC               .FILL -x30

BU0_STORE_SR2             .BLKW #1
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
