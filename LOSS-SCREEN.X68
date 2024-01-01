; ------------------------------------------------------------------------------
LOSS
; ENABLE DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        MOVEM.L D0-D2/A1,-(A7)

        ; CONFIGURAR LAS PROPIEDADES DE LA FUENTE
.LOOP   MOVE.B  #21,D0
        MOVE.L  #$00FFFFFF,D1
        MOVE.L  #$020F0001,D2
        TRAP    #15
        
        ; COLOCAR EL CURSOR EN LA POSICION CORRECTA
        MOVE.B  #11,D0
        MOVE.W  #$120B,D1
        TRAP    #15
        
        ; IMPRIMIR TEXTO
        MOVE    #1,D1       ; PARA QUE LIMPIE LA EL FONDO(MAPA) CORRECTAMENTE
        MOVE.B  #14,D0
        LEA     .TEXT,A1
        TRAP    #15
        
        TRAP    #0          ; DOBLE BUFFER AND CLEAR HIDDEN BUFFER
        DBRA    D1,.LOOP 
        BRA     END

        MOVEM.L (A7)+,D0-D2/A1      
        RTS

.TEXT   DC.B    'YOU HAVE LOST',0
        DS.W    0

*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~ 