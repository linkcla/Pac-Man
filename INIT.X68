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

        JSR     CLKINIT
        JSR     SOUNDLD
        JSR     SCOINIT
        JSR     PACINIT
        JSR     GHINIT

        RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
