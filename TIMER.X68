; -----------------------------------------------------------------------------
CLKINIT
; INIT THE GAME CLOCK VARIABLES
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
        CLR.L   (STARTTIME)
        CLR.L   (STOPTIME)
        CLR.L   (RECRDTIME)

        ; LEEMOS EL TIEMPO RECORD DEL FICHERO Y LO GUARDAMOS EN RECRDTIME
        ; TODO


        RTS
; -----------------------------------------------------------------------------
CLKSTART
; START THE GAME CLOCK
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
        MOVEM.L D0-D1,-(SP)

        MOVE.B  #0,D0
        MOVE.B  #1,D1
        TRAP    #15

        MOVE.L  D1,(STARTTIME)

        MOVEM.L (SP)+,D0-D1
        RTS
; -----------------------------------------------------------------------------
CLKSTOP
; STOP THE GAME CLOCK
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
        MOVEM.L D0-D1,-(SP)

        MOVE.B  #0,D0
        MOVE.B  #1,D1
        TRAP    #15

        MOVE.L  D1,(STOPTIME)

        MOVEM.L (SP)+,D0-D1
        RTS

; -----------------------------------------------------------------------------
CLKPLOT
; STOP THE GAME CLOCK
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
        MOVEM.L D0-D1/A1,-(SP)

        ; SET BACKGROUND COLOR
        MOVE.B  #81,D0
        MOVE.L  #TIMECOL,D1
        TRAP    #15
        
        ; SET FIRST LINE POSITION
        MOVE.B  #11,D0
        MOVE.W  #TIMELINE1,D1
        TRAP    #15

        ; PRINT FIRST LINE
        LEA     .TXT1,A1
        MOVE.L  (RECRDTIME),D1
        MOVE.B  #17,D0
        TRAP    #15

        ; SET SECOND LINE POSITION
        MOVE.B  #11,D0
        MOVE.W  #TIMELINE2,D1
        TRAP    #15


        ; GET TIME
        MOVE.B  #0,D0
        MOVE.B  #1,D1
        TRAP    #15
        
        ; PRINT SECOND LINE
        LEA     .TXT2,A1
        SUB.L   (STARTTIME),D1
        MOVE.B  #17,D0
        TRAP    #15

        MOVEM.L (SP)+,D0-D1/A1
        RTS
.TXT1       DC.B    'RECORD :',0
.TXT2       DC.B    'TIME   :',0    

; -----------------------------------------------------------------------------
SAVETIME
; SAVES THE TIME PLAYED IF IT IS A NEW RECORD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------


        RTS

*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~    