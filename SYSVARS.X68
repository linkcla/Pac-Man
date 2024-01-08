; ==============================================================================
; SYSTEM VARIABLES
; ==============================================================================

;--- KEYBOARD RELATED VARIABLES ------------------------------------------------
KBDVAL      DS.B        1       ; KEY STATE
            DS.W        1

; --- PRINT RELATED VARIABLES --------------------------------------------------
LASTCOLOR   DS.L        1       ; LAST COLOR USED

; --- FILE REELATED VARIABLES --------------------------------------------------
FILENAME    DC.B    './record',0
            DS.W    0
*~Font name~Courier New~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
