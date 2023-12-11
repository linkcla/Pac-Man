; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; STATS VARS

LIVES       DC.B    3 
POINTS      DC.L    0

; ---- PACMAN POSITION ----

PACPOSX     DS.L    1
PACPOSY     DS.L    1

; ------ PACMAN SPEED ------

PACSPED     DS.B    1
            DS.W    0

; ------ GHOST ADRESS ------

; SCARED GHOST
SCAPOSX     DS.L    1
SCAPOSY     DS.L    1

; INKI GHOST
INKPOSX     DS.L    1
INKPOSY     DS.L    1

; BLINKY GHOST
BLIPOSX     DS.L    1
BLIPOSY     DS.L    1

; PINKY GHOST
PINPOSX     DS.L    1
PINPOSY     DS.L    1

; CLYDE GHOST
CLYPOSX     DS.L    1
CLYPOSY     DS.L    1


*~Font name~Courier New~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
