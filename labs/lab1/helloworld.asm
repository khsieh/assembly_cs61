; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment Lab 01
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
                               ;R0 <-- the location of the label: MSG_TO_PRINT
                         LEA R0, MSG_TO_PRINT 
                                 ;prints string defined at MSG_TO_PRINT
                         PUTS                 
                         HALT                     ;terminate program
                         
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------
MSG_TO_PRINT .STRINGZ "Hello world!!!\n" ;store 'H' in an address labeled
                                         ;MSG_TO_PRINT and then each
                                         ;character ('e','l','l',...) in
                                         ;its own (consecutive) memory
                                         ;address, followed by zero at the
                                         ;end to mark the end of the
                                         ;string
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
