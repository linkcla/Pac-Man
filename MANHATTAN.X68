; ------------------------------------------------------------------------------
DISTMANH
; RETURN THE MANHATTAN DISTANCE BETWEEN PACMAN AND X,Y COORDINATES IN (SP)
; INPUT    : (SP) = X,Y COORDINATES
;            FIRST PUSH Y, THEN X
; OUTPUT   : THE MANHATTAN DISTANCE IN D7
; MODIFIES : D7
; ------------------------------------------------------------------------------
        ; EJEMPLO DE USO
        ; MOVE.L  #128,-(SP)
        ; MOVE.L  #78,-(SP)
        ; JSR     DISTMANH
        ; ADD.W   #12,SP
        
        MOVEM.L D0-D1,-(SP) ; SAVE REGISTERS

        MOVE.L  12(SP),D0     ; D0 = X
        MOVE.L  16(SP),D1    ; D1 = Y

        SUB.L   (PACPOSX),D0 ; D0 = X - PACPOSX
        BPL     .POS1       ; ABS(D0)
        NEG.L   D0          
.POS1

        SUB.L   (PACPOSY),D1 ; D1 = Y - PACPOSY
        BPL     .POS2       ; ABS(D1)
        NEG.L   D1
.POS2

        ADD.L   D1,D0 
        CLR.L   D7      
        MOVE.L  D0,D7

        MOVEM.L (SP)+,D0-D1 ; RESTORE REGISTERS
        RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
