*-----------------------------------------------------------
* Title      : MAIN
* Written by : Jesus Castillo Benito, Marc Link Cladera
* Date       : 
* Description: Main file of the project.
*-----------------------------------------------------------
    		
            ORG    $1000
    		

    		INCLUDE "SYSTEM.X68"
    		INCLUDE "MAP.X68"
    		INCLUDE "SCORE.X68"
    		INCLUDE "CONST.X68"
            INCLUDE "VARS.X68"
            INCLUDE "INIT.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "PRINT-SPRITE.X68"
            INCLUDE "GHOSTS.X68"
            INCLUDE "PACMANS.X68"
            INCLUDE "MANHATTAN.X68"
            INCLUDE "MAIN-SCREEN.X68"
            INCLUDE "LOGO.X68"
            INCLUDE "PRINT-LOGO.X68"
            INCLUDE "WIN-SCREEN.X68"
            INCLUDE "LOSS-SCREEN.X68"

            
            
    		
    		
START:

; --- INITIALIZATION ----------------------------------------------------------  
        JSR     SYSINIT
        JSR     GAMEINIT
        JSR     STARTSCR
        JSR     DBUFF       ; ENABLE DOUBLE BUFFER

LOOP                   
; --- UPDATE ------------------------------------------------------------------
            
; READ INPUT DEVICES

        TRAP    #1

; UPDATE GAME LOGIC

        ; PLOT MAP
        JSR     MAPPLOT
        ; PLOT SCORE   
        JSR     SCOPLOT
        ; PLOT PACMAN
        JSR     PACPLOT
        ; PLOT GHOSTS
        JSR     GHPLOT
        
; --- SYNC --------------------------------------------------------------------
        ; DOBLE BUFFER AND CLEAR HIDDEN BUFFER    
        TRAP    #0
; --- PLOT --------------------------------------------------------------------
            
            BRA     LOOP
END
    		SIMHALT

    		END    START














































*~Font name~Courier New~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
