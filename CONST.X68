; =============================================================================
; CONSTANTS
; =============================================================================

TILESIZE    EQU     32
SCRHEIGH    EQU     480
SCRWIDTH    EQU     640
COLUMNS     EQU     20                      ; SCRWIDTH/TILESIZE = 640/32
ROWS        EQU     15                      ; SCRHEIGH/TILESIZE = 480/32

; --- SCORE RELATED CONSTANTS -------------------------------------------------
SCOFCOL     EQU     $00000000               ; TEXT BACKGROUND COLOR
SCOLINE1    EQU     $0000                   ; FIRST TEXT LINE COORDINATES
SCOLINE2    EQU     $0001                   ; SECOND TEXT LINE COORDINATES

; --- TIME RELATED CONSTANTS --------------------------------------------------
TIMECOL     EQU     $00000000               ; TEXT BACKGROUND COLOR
TIMELINE1   EQU     $1D10                   ; FIRST TEXT LINE COORDINATES
TIMELINE2   EQU     $1D11                   ; SECOND TEXT LINE COORDINATES

; --- KEY CODES ---------------------------------------------------------------
KBDLEFT     EQU     $25
KBDUP       EQU     $26
KBDRIGHT    EQU     $27
KBDDOWN     EQU     $28




*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~
