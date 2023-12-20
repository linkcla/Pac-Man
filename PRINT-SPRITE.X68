; ------------------------------------------------------------------------------
SPRAYPL
; PLOTS THE SPRAY (32x32 PIXELS)
; INPUT    : HAY QUE HACER EL PUSH DE LO SIGUIENTE EN EL SIGUIENTE ORDEN:
;        1o: EL CONTENIDO DE LA ETIQUETA DE XXXXXPOSY 
;        2o: EL CONTENIDO DE LA ETIQUETA DE XXXXXPOSX
;        3o: LEA DE LA DIRECCION DE LA IMAGEN
;        A CADA NUMERO X(SP) HAY QUE HACER X + 6*4 --> X + 24
;        12(SP)  LONG ->POXY
;        8(SP)  LONG ->POSX
;        4(SP)  LONG -> IMAGEN
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        MOVEM.L     D0-D4/A0,-(A7)
        
        MOVEA.L     28(SP),A0   ; IMAGEN
        
        ; PREPARAMOS LAS ITERACIONES DEL BUCLE
        MOVE.L      32(SP),D3   ; XXXXXPOSX
        ADD.L       #31,D3
        MOVE.L      36(SP),D4   ; XXXXXPOSY 
        ADD.L       #31,D4

        ;D1 = X
        ;D2 = Y
        MOVE.L      36(SP),D2   ; XXXXXPOSY 
        
.LOOP1  
        MOVE.L      32(SP),D1   ; XXXXXPOSX
.LOOP2  
        MOVEM.L     D1,-(A7)      
        MOVE.B      #80,D0
        MOVE.L      (A0)+,D1
        CMP         #$00000000,D1
        BEQ         .AUX
        TRAP        #15
        MOVEM.L     (A7)+,D1
        
        MOVE.B      #82,D0
        TRAP        #15  
        BRA        .AUX1

.AUX    MOVEM.L     (A7)+,D1   
.AUX1    
        ADDQ.L      #1,D1
        CMP         D3,D1
        BLS         .LOOP2
        ADDQ.L      #1,D2
        CMP         D4,D2
        BLS         .LOOP1
        
        MOVEM.L     (A7)+,D0-D4/A0        
        RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
