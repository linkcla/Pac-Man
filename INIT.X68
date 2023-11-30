; =============================================================================
; INIT GAME PROPERTIES
; =============================================================================

; ------------------------------------------------------------------------------
GAMEINIT
; INITIALIZE GAME
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        JSR     SCOINIT
        
        MOVE.L  #0,(PACPOSX)
        MOVE.L  #0,(PACPOSY)
        MOVE.L  #50,(INKPOSX) 
        MOVE.L  #50,(INKPOSY)
        MOVE.L  #100,(BLIPOSX) 
        MOVE.L  #100,(BLIPOSY)
        MOVE.L  #150,(PINPOSX) 
        MOVE.L  #150,(PINPOSY)
        MOVE.L  #200,(CLYPOSX) 
        MOVE.L  #200,(CLYPOSY)
        
        ;MOVEM.L A0-A1,-(A7)
        ; EL REGISTRO A1 LO USAR� COMO AUXILIAR 
        
        ; INIT ALLADGH (ALL ADRESS OF GHOSTS)
        ;LEA     ALLADGH,A0
        ;LEA     INKI,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     BLINKY,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     PINKY,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     CLYDE,A1
        ;MOVE.L  A1,(A0)

        ; INIT ALLGPOX (ALL GHOSTS POS X)
        ;LEA     ALLGPOX,A0
        ;LEA     INKPOSX,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     BLIPOSX,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     PINPOSX,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     CLYPOSX,A1
        ;MOVE.L  A1,(A0)
        ; INIT ALLGPOY (ALL GHOSTS POS Y)
        ;LEA     ALLGPOY,A0
        ;LEA     INKPOSY,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     BLIPOSY,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     PINPOSY,A1
        ;MOVE.L  A1,(A0)+
        ;LEA     CLYPOSY,A1
        ;MOVE.L  A1,(A0)
        
        ;MOVEM.L (A7)+,A0-A1
        RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
