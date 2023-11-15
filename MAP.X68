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
            DC.B    1,2,2,2,1,2,2,2,2,2,2,2,2,2,4,1,2,2,2,1
            DC.B    1,2,1,4,1,2,1,1,1,1,1,1,1,1,2,1,2,1,2,1
            DC.B    1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1
            DC.B    1,1,1,2,1,2,1,2,1,1,1,1,4,1,2,1,2,1,1,1
            DC.B    1,2,2,4,1,2,2,2,2,2,2,2,2,2,2,1,2,2,2,1
            DC.B    1,2,1,1,1,1,4,1,1,2,2,1,1,2,1,1,1,1,2,1
            DC.B    2,2,2,2,2,2,2,1,0,0,0,0,1,2,2,2,2,2,2,2
            DC.B    1,2,1,1,1,1,2,1,0,0,0,0,1,2,1,1,1,1,2,1
            DC.B    1,2,2,2,1,2,2,1,1,1,1,1,1,2,2,1,2,2,2,1
            DC.B    1,1,1,2,1,2,1,1,2,2,2,2,1,1,2,1,2,1,1,1
            DC.B    1,2,2,2,0,2,2,2,2,1,1,2,2,2,2,2,4,2,2,1
            DC.B    1,4,1,2,1,2,1,1,1,1,1,1,1,1,2,1,2,1,2,1
            DC.B    1,2,2,2,1,2,2,2,2,2,2,4,2,2,2,1,2,2,2,1
            DC.B    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
            






*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~
