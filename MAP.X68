; ------------------------------------------------------------------------------
MAPPLOT
; PLOTS THE MAP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D7/A0,-(A7)
            
            LEA     MAPDAT2,A0
            MOVE.B  #87,D0
            CLR.W   D2
            MOVE.W  #TILESIZE,D4
            MOVE.W  #(SCRHEIGH/TILESIZE)-1,D6

.CLOOP      CLR.W   D1
            MOVE.W  #TILESIZE,D3
            MOVE.W  #(SCRWIDTH/TILESIZE)-1,D5
.RLOOP      
            MOVE.B  (A0)+,D7
            BTST    #0,D7
            BEQ     .CHKCIRS
            JSR     DWSQU
            BRA     .NEXT
            
.CHKCIRS    BTST    #1,D7
            BEQ     .CHKCIRB
            JSR     DWCIRS
            BRA     .NEXT
            
.CHKCIRB    BTST    #2,D7
            BEQ     .NEXT
            JSR     DWCIB       
                        
.NEXT       MOVE.W  D3,D1
            ADD.W   #TILESIZE,D3
            DBRA.W  D5,.RLOOP
            MOVE.W  D4,D2
            ADD.W   #TILESIZE,D4
            DBRA.W  D6,.CLOOP

            MOVEM.L (A7)+,D0-D7/A0
            
            RTS            
            
DWSQU
            MOVEM.L D0-D5,-(A7)
            
            MOVE.L  D1,D5
            ; set colors of the square
            MOVE.B  #80,D0
            MOVE.L  #$008C2378,D1
            TRAP    #15
            MOVE.B  #81,D0
            MOVE.L  #$008C2378,D1
            TRAP    #15
                        
            MOVE.B  #87,D0
            MOVE.L  D5,D1
            TRAP    #15
            
            MOVEM.L  (A7)+,D0-D5
            
            RTS
            
            
DWCIRS
            MOVEM.L D0-D5,-(A7)
            
            MOVE.L  D1,D5            
            ; set colors of the square
            MOVE.B  #80,D0
            MOVE.L  #$00FFFFFF,D1
            TRAP    #15
            MOVE.B  #81,D0
            MOVE.L  #$00FFFFFF,D1
            TRAP    #15
            
            MOVE.B  #88,D0
            MOVE.L  D5,D1
            ADD     #12,D1
            ADD     #12,D2
            SUB     #12,D3
            SUB     #12,D4
            TRAP    #15
            
            MOVEM.L  (A7)+,D0-D5
            
            RTS
            
            
DWCIB       
            MOVEM.L D0-D5,-(A7)
            
            MOVE.L  D1,D5                        
            ; set colors of the square
            MOVE.B  #80,D0
            MOVE.L  #$0000D7FF,D1
            TRAP    #15
            MOVE.B  #81,D0
            MOVE.L  #$0000D7FF,D1
            TRAP    #15
            
            MOVE.B  #88,D0
            MOVE.L  D5,D1
            ADD     #8,D1
            ADD     #8,D2
            SUB     #8,D3
            SUB     #8,D4
            TRAP    #15
            
            MOVEM.L  (A7)+,D0-D5
            
            RTS

; ------------------------------------------------------------------------------
GETINFO
; GET THE IFO ARROUND DE SPRITE OF 32X32 PIXELS.
; SOLO SE HA DE LLAMAR A LA RUTINA SI ESTA EN UNA POSICION X E Y MULTIPLO DE 32
; INPUT    : HAY QUE HACER EL PUSH DE LO SIGUIENTE EN EL SIGUIENTE ORDEN:
;        1o: EL CONTENIDO DE LA ETIQUETA DE XXXXXPOSY 
;        2o: EL CONTENIDO DE LA ETIQUETA DE XXXXXPOSX
; OUTPUT   : D7 CONTENDRÁ LO SIGUYIENTE:
;            00000000 00FBDRUL
;            FRUIT
;            BALL
;            DOWN
;            RIGHT
;            UP
;            LEFT
; MODIFIES : D7
; ------------------------------------------------------------------------------
;La formula para accdeder a la "casilla" del mapa es: ((row) * COLUMNS + column)
; en este caso:
;        -row = POSY/ROWS
;        -column = POSX/COLUMNS
;
; izq --> ((row) * COLUMNS + column) - 1
; arriba --> ((row) * COLUMNS + column) - COLUMNS
; derecha --> ((row) * COLUMNS + column) + 1
; abajo --> ((row) * COLUMNS + column) + COLUMNS
; centro --> ((row) * COLUMNS + column)
; si el valor no esta entre 0 y 1024 poner 0 //este caso sucedera en
; el momento que el pacman quiera ir por el tunel que cruza de lado
; a lado.
        
        MOVEM.L D0-D2/A0,-(A7)
        CLR.L   D2

        CLR.W   D7              ; EN D7 ESTARÁ LA INFO QUE VOY A DEVOLVER                         
        MOVE.L  20(SP),D0       ; POS X
        MOVE.L  24(SP),D1       ; POS Y

        ADD     #(TILESIZE/2),D0 ; SUMAMOS LA MITAD DEL TILE PARA QUE NO SE
                                ; QUEDE EN EL BORDE
        SUBQ    #1,D1           ; DE ESTA FORMA NOS SITUAMOS EN EL BLOQUE DE
                                ; ARRIBA DEL SPRITE

        ; OBTENEMOS EL VALOR DE COLUMN (EL DE LA EQUACIÓN)
        DIVU    #TILESIZE,D0     ; ahora necesitamos aplicar una mascara
        AND.L   #$000000FF,D0   ; ahora tenemos en D0 "column"

        ; OBTENEMOS EL VALOR DE ROW (EL DE LA EQUACIÓN)
        DIVU    #TILESIZE,D1    ;ahora necesitamos aplicar una mascara
        AND.L   #$000000FF,D1   ; ahora tenemos en D1 "row"

        ; BUSCAMOS EL VALOR QUE DEBEMOS SUMAR AL PC CUANDO ESTE APUNTANDO
        ; A LA DIRECCION DE MAPDATA, BUSCAREMOS CUANTAS "CASILLAS" DEBEMOS
        ; SALTAR PARA LLEGAR, DE ESTA FORMA EL VALOR QUE DEBEMOS SUMAR A 
        ; MAPDATA SERÁ EL VALOR ENCONTRADO
        ; GUARDAREMOS EL RESULTADO(VALOR ENCONTRADO) EN D0

        MULU.W  #COLUMNS,D1
        ADD.W   D1,D0

        MOVEA.L #MAPDAT2,A0
        ADDA.L  D0,A0
        
        MOVE.L  #COLUMNS,D1
        MOVE.B  (A0),D2         ; AHORA NOS ENCONTRAMOS EN LA CASILLA DE ARRIBA DEL SPRITE

        BTST    #0,D2
        BEQ     .RIGHT
        OR.W    #%0000000000000010,D7

.RIGHT  ADD.L   D1,A0
        ADDQ.W  #1,A0
        MOVE.B  (A0),D2
        BTST    #0,D2
        BEQ     .LEFT
        OR.W    #%0000000000000100,D7

.LEFT   SUBQ.W  #2,A0
        MOVE.B  (A0),D2
        BTST    #0,D2
        BEQ     .DOWN
        OR.W    #%0000000000000001,D7

.DOWN   ADD.L   D1,A0
        ADDQ.W  #1,A0
        MOVE.B  (A0),D2
        BTST    #0,D2
        BEQ     .CENTER
        OR.W    #%0000000000001000,D7

.CENTER  SUB.L   D1,A0
        MOVE.B  (A0),D2
        CMP     #4,D2
        BNE     .BALL
        OR.W    #%0000000000100000,D7
        BRA     .END

.BALL   CMP     #2,D2
        BNE     .END
        OR.W    #%0000000000010000,D7

.END
        MOVEM.L (A7)+,D0-D2/A0

        RTS


; --- DATA ---------------------------------------------------------------------

MAPDATA     DC.B    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
            DC.B    1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1
            DC.B    1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,1,0,1,0,1
            DC.B    1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
            DC.B    1,1,1,0,1,0,1,0,1,1,1,1,0,1,0,1,0,1,1,1
            DC.B    1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1
            DC.B    1,0,1,1,1,1,0,1,1,0,0,1,1,0,1,1,1,1,0,1
            DC.B    0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0
            DC.B    1,0,1,1,1,1,0,1,0,0,0,0,1,0,1,1,1,1,0,1
            DC.B    1,0,0,0,1,0,0,1,1,1,1,1,1,0,0,1,0,0,0,1
            DC.B    1,1,1,0,1,0,1,1,0,0,0,0,1,1,0,1,0,1,1,1
            DC.B    1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1
            DC.B    1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,1,0,1,0,1
            DC.B    1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1
            DC.B    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
            
            
MAPDAT2     DC.B    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
            DC.B    1,4,2,2,1,2,2,2,2,2,2,2,2,2,2,1,2,2,4,1
            DC.B    1,2,1,2,1,2,1,1,1,1,1,1,1,1,2,1,2,1,2,1
            DC.B    1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1
            DC.B    1,1,1,2,1,2,1,2,1,1,1,1,2,1,2,1,2,1,1,1
            DC.B    1,2,2,2,1,2,2,2,2,2,2,2,2,2,2,1,2,2,2,1
            DC.B    1,2,1,1,1,1,2,1,1,0,0,1,1,2,1,1,1,1,2,1
            DC.B    1,2,2,2,2,2,4,1,0,0,0,0,1,4,2,2,2,2,2,1
            DC.B    1,2,1,1,1,1,2,1,0,0,0,0,1,2,1,1,1,1,2,1
            DC.B    1,2,2,2,1,2,2,1,1,1,1,1,1,2,2,1,2,2,2,1
            DC.B    1,1,1,2,1,2,1,1,2,2,2,2,1,1,2,1,2,1,1,1
            DC.B    1,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,1
            DC.B    1,2,1,2,1,2,1,1,1,1,1,1,1,1,2,1,2,1,2,1
            DC.B    1,4,2,2,1,2,2,2,2,2,2,2,2,2,2,1,2,2,4,1
            DC.B    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
            









*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~
