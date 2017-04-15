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
                         ;CALL SUBROUTINE TO PRINT_OPCODES
                         JSR PRINT_OPCODES
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                        

; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_3200
; Input:         String of characters
; Postcondition: store the string in remote addr stored in R0
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
PRINT_OPCODES
;BACK UP REGISTERS

                         ST  R7, BU7_STORE_SR
                         
                         LD  R3, ADDR1
                         LD  R2, ADDR2
PRINT_CHAR                         
                         LDR R1, R3, #0
                         LDR R0, R2, #0
                         OUT
                         BRz PRINT_BINARY
                         BRn DONE
                         ADD R2, R2, #1
                         BR  PRINT_CHAR
PRINT_BINARY 
                         ADD R2,R2, #1
                         ADD R3, R3, #1
                         LD R0, SPACE_CHAR2
                         OUT 
                         LD R0, EQUAL_CHAR            
                         OUT 
                         LD R0, SPACE_CHAR2
                         OUT 
                         
                         JSR PRINT_BIN
                         BR PRINT_CHAR
DONE                                                       
                         LD  R7, BU7_STORE_SR
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
ADDR1                    .FILL x3800
ADDR2                    .FILL x4000
BU7_STORE_SR             .BLKW #1
END_CHECK                .FILL #1
EQUAL_CHAR               .FILL x3D
SPACE_CHAR2              .FILL x20
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_30000
; Input:         A NUMBER IN THE RANGE OF [#-32768, #32767]
; Postcondition: OUT PUT BINARY REPRESENTATION OF THE INPUT TO CONSOLE
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3400          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
PRINT_BIN
                         ST  R7,BU_SR
                         ST  R2, BU_SR2
                         ST  R3, BU_SR3
                         LD  R2, EMPTY_COUNTER    ;R2 <-- MEM[COUNTER]
                         LD  R3, SPACE_COUNT      ;R3 <-- MEM[SPACE_COUNT]
                         ;FIRST CHECK
                         ;~ ADD R1, R1, #0           ;CHECK R1
                         ;~ BRn PRINT_1
                         ;~ BR  PRINT_0
;AFTER 1ST CHECK, SHIFT THE BITS                         
SHIFT
                         ADD R2, R2, #-1          ;R2 <-- R2 + #-1
                         BRn PRINT_SHIFT          ;if(R2 == 0) END
                         
                         ADD R1, R1, R1           ;R1 <-- R1 + R1 //LEFT SHIFT
                         BR SHIFT
                         
PRINT_SHIFT 
                         LD  R2, COUNTER
                         ADD R1, R1, #0
                         BRn PRINT_1
                         BR  PRINT_0
SHIFT_LOOP                         
                         ADD R2, R2, #-1
                         BRz END
                         
                         ADD R1, R1, R1
                         BRn PRINT_1              ;if(R1 < 0) PRINT_1
                         BR  PRINT_0              ;else PRINT_0
PRINT_0
                         LD  R0, ZERO_CHAR        ;R0 <-- MEM[ZERO_CHAR]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R3, R3, #-1          ;R3 <-- R3 + #-1
                         BRz PRINT_SPACE          ;if(R3 == 0) PRINT_SPACE
                         BR  SHIFT_LOOP                ;else SHIFT
PRINT_1
                         LD  R0, ONE_CHAR         ;R0 <-- MEM[ONE_CHAR]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R3, R3, #-1          ;;R3 <-- R3 + #-1
                         BRz PRINT_SPACE          ;if(R3 == 0) PRINT_SPACE
                         BR  SHIFT_LOOP                ;else SHIFT
                         
PRINT_SPACE
                         LD  R3, SPACE_COUNT      ;R3 <-- MEM[SPACE_COUNT]
                         LD  R0, SPACE_CHAR       ;R0 <-- MEM[SPACE_CHAR] 
                         OUT                      ;CONSOLE <-- MEM[R0]
                         BR  SHIFT_LOOP                ;JUMP TO SHIFT
END                         
                         LD  R0, NEW_LINE         ;R0 <-- MEM[NEW_LINE]
                         OUT                      ;CONSOLE <-- MEM[R0]

                         LD  R7, BU_SR
                         LD  R2, BU_SR2
                         LD  R3, BU_SR3
                         RET

; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3400
; -----------------------------------------------------------------------
BU_SR                    .BLKW #1
BU_SR2                   .BLKW #1
BU_SR3                   .BLKW #1
COUNTER                  .FILL #4
EMPTY_COUNTER            .FILL #12
SPACE_CHAR               .FILL x20
SPACE_COUNT              .FILL #4
ZERO_CHAR                .FILL x30
ONE_CHAR                 .FILL x31
NEW_LINE                 .FILL xA
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
.ORIG x3800
.FILL #1 ;ADD
.FILL #5 ;AND
.FILL #0 ;BR
.FILL #12;JMP
.FILL #4 ;JSR
.FILL #4 ;JSRR
.FILL #2 ;LD
.FILL #10;LDI
.FILL #6 ;LDR
.FILL #14;LEA
.FILL #9 ;NOT
.FILL #12;RET
.FILL #8 ;RTI
.FILL #3 ;ST
.FILL #11;STI
.FILL #7 ;STR
.FILL #15;TRAP

.ORIG x4000
.STRINGZ "ADD"
.STRINGZ "AND"
.STRINGZ "BR"
.STRINGZ "JMP"
.STRINGZ "JSR"
.STRINGZ "JSRR"
.STRINGZ "LD"
.STRINGZ "LDI"
.STRINGZ "LDR"
.STRINGZ "LEA"
.STRINGZ "NOT"
.STRINGZ "RET"
.STRINGZ "RTI"
.STRINGZ "ST"
.STRINGZ "STI"
.STRINGZ "STR"
.STRINGZ "TRAP"
.FILL #-1
