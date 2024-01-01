; ------------------------------------------------------------------------------
STARTSCR
; UPDATE PACMAN POSITION
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        MOVE.L  #120,-(SP)
        MOVE.L  #170,-(SP)
        MOVE.L  #LOGO,-(SP)
        JSR     LOGOPL
        ADD     #12,SP
        
        
        MOVEM.L D0-D2/A1,-(A7)
        ; CONFIGURAR LAS PROPIEDADES DE LA FUENTE
        MOVE.B  #21,D0
        MOVE.L  #$00FFFFFF,D1
        MOVE.L  #$020F0001,D2
        TRAP    #15
        
        ; COLOCAR EL CURSOR EN LA POSICION CORRECTA
        MOVE.B  #11,D0
        MOVE.W  #$0514,D1
        TRAP    #15
        
        ; IMPRIMIR TEXTO
        MOVE.B  #14,D0
        LEA     .TEXT,A1
        TRAP    #15

        ; RESETEAR LAS PROPIEDADES DE LA FUENTE
        MOVE.B  #21,D0
        MOVE.L  #$00FFFFFF,D1
        MOVE.L  #$01090001,D2
        TRAP    #15
        
        
        
.LOOP
        TRAP    #1
        MOVE.B  (KBDVAL),D0
        BTST    #2,D0
        BNE     .END

        BRA     .LOOP

.END    MOVEM.L (A7)+,D0-D2/A1      
        RTS

.TEXT  DC.B    'APRIETA LA FLECHA DERECHA PARA EMPEZAR',0
       DC.B     0                 







*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~
