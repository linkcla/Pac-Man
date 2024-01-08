; ------------------------------------------------------------------------------
WIN
; ENABLE DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        MOVEM.L D0-D2/A1,-(A7)

        ; CONFIGURAR LAS PROPIEDADES DE LA FUENTE
        MOVE.B  #21,D0
        MOVE.L  #$00FFFFFF,D1
        MOVE.L  #$020F0001,D2
        TRAP    #15
        
        ; COLOCAR EL CURSOR EN LA POSICION CORRECTA(PARA: YOU HAVE WON)
        MOVE.B  #11,D0
        MOVE.W  #$120B,D1
        TRAP    #15
        
        ; IMPRIMIR TEXTO
        MOVE    #1,D1       
        MOVE.B  #14,D0
        LEA     .TEXT1,A1
        TRAP    #15


        ; CONFIGURAR LAS PROPIEDADES DE LA FUENTE
        MOVE.B  #21,D0
        MOVE.L  #$00FFFFFF,D1
        MOVE.L  #$020C0000,D2
        TRAP    #15
        ; COLOCAR EL CURSOR EN LA POSICION CORRECTA(PARA EL TIEMPO )
        MOVE.B  #11,D0
        MOVE.W  #$1910,D1
        TRAP    #15
        
        ; IMPRIMIR TEXTO
        LEA     .TEXT2,A1
        MOVE.L  (TIMEPLAYED),D1   ; NOS QUEDAMOS CON LA PARTE ENTERA
        MOVE.B  #17,D0
        TRAP    #15
        
        TRAP    #0          ; DOBLE BUFFER AND CLEAR HIDDEN BUFFER

        BRA     END

        MOVEM.L (A7)+,D0-D2/A1      
        RTS

.TEXT1  DC.B    'YOU HAVE WON',0
        DS.W    0

.TEXT2  DC.B    'THE GAME TIME WAS: ',0
        DS.W    0

*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~        