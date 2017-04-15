; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 03
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

                         LD  R1, ARRAY_PTR        ;R1 <-- MEM[ARRAY_PTR]
                         LD  R2, ZERO             ;R2 <-- MEM[ZERO]
                         
                         LEA R0, INST             ;R0 <-- MEM[INST]
                         PUTS                     ;CONSOLE <-- MEM[R0]
TAKE_CHAR                         
                         GETC                     ;R0 <-- INPUT
                         OUT                      ;CONSOLE <-- MEM[R0]
                         
                         STR R0, R1, #0           ;MEM[R1 + #0] <-- R0
                         ADD R1, R1, #1           ;R1 <-- R1 + #1
                         ADD R2, R2, #1           ;R2 <-- R2 + #1
                         ADD R0, R0, #-10         ;R0 <-- R0 + #-10
                         BRnp TAKE_CHAR           ;if(R0 = 0) BREAK;
                         
                         LD  R1, ARRAY_PTR        ;R1 <-- MEM[ARRAY_PTR]
                         
OUTPUT_CHAR
                         LDR R0, R1, #0           ;R0 <-- MEM[ MEM[R1+#0] ]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R1, R1, #1           ;R1 <-- R1 + #1
                         
                         ADD R2, R2, #-1          ;R2 <-- R2 + #-1
                         BRp OUTPUT_CHAR          ;if(R2 > 0) OUTPUT_CHAR
                                                                           
                         HALT                     ;STOP PROGRAM
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
SIZE                     .FILL #10
ZERO                     .FILL #0
INST                     .STRINGZ "INPUT A STRING (terminate by enter): "
ARRAY_PTR                .FILL x4000
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
