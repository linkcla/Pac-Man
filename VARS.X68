; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; STATS VARS

LIVES       DS.B    1 
            DS.W    1
POINTS      DS.W    1

; ---- CLOCK RELATED VARIABLES ----

STARTTIME   DS.L    1
STOPTIME    DS.L    1
TIMEPLAYED  DS.L    1
RECRDTIME   DS.L    1

; ---- PACMAN POSITION ----

PACPOSX     DS.L    1
PACPOSY     DS.L    1

; ------ PACMAN SPEED ------

PACSPED     DS.B    1
MOVPAC      DS.B    1
PACSPRI     DS.L    1

; --------- GHOST ---------
; MOVEMENT
GHSPED      DS.B    1
MOVGHI      DS.B    1       ; LA DIRECCION DEL FANTASMA INKI
MOVGHB      DS.B    1       ; LA DIRECCION DEL FANTASMA BLINKY
MOVGHP      DS.B    1       ; LA DIRECCION DEL FANTASMA PINKY
MOVGHC      DS.B    1       ; LA DIRECCION DEL FANTASMA CLYDE
            DS.W    1
GHOPTM      DS.L    1       ; LA DISTANCIA DEL CAMINO MAS OPTIMO

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
