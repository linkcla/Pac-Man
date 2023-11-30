*-----------------------------------------------------------
* Title      : SYSTEM
* Written by : Jesus Castillo Benito, Marc Link Cladera
* Date       : 31/10/2023
* Description: 
*-----------------------------------------------------------

; -----------------------------------------------------------------------------
SYSINIT
; INIT SYSTEM: SET SCREEN RESOLUTION AND WINDOWED MODE, CLEAR SCREEN, ENABLE
; DOUBLE BUFFER, INSTALL SCREEN UPDATE AND MOUSE READ TRAPS AND SWITCH TO USER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------

            MOVEM.L D0-D1,-(A7)

            ; SET SCREEN RESOLUTION
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15

            ; SET WINDOWED MODE
            MOVE.L  #1,D1
            TRAP    #15

            ; CLEAR SCREEN
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15

            ; ENABLE DOUBLE BUFFER
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15

            ; INSTALL SCREEN PLOT TRAP
            MOVE.L  #SCRPLOT,($80)
            
            ; INSTALL KBD READ TRAP
            MOVE.L  #KBDREAD,($84)

            MOVEM.L (A7)+,D0-D1

            ; SWITCH TO USER
            MOVE.W  SR,-(A7)
            AND.W   #$DFFF,(A7)

            RTE
            

KBDREAD
; READS KEYBOARD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D1,-(A7)
            MOVE.B  #19,D0
            MOVE.L  #'W'<<24+'S'<<16+'A'<<8+'D',D1
            TRAP    #15
            MOVE.L  D1,(KBDSTAT)
            MOVEM.L (A7)+,D0-D1
            RTE



SCRPLOT
; TRAP SERVICE ROUTINE TO SWITCH GRAPHIC BUFFERS AND CLEAN HIDDEN BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.W D0-D1,-(A7)

            ; SWITCH BUFFERS
            MOVE.B  #94,D0
            TRAP    #15

            ; CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15

            MOVEM.W (A7)+,D0-D1
            RTE












*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~
