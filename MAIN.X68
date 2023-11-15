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
            INCLUDE "SYSVARS.X68"
    		
    		
START:

; --- INITIALIZATION ----------------------------------------------------------
            
            
            JSR     SYSINIT
            JSR     SCOINIT     
LOOP       

            
            
; --- UPDATE ------------------------------------------------------------------
            
; READ INPUT DEVICES
            

; UPDATE GAME LOGIC

        ; PLOT MAP
        JSR     MAPPLOT
        ; PLOT SCORE   
        JSR     SCOPLOT
; --- SYNC --------------------------------------------------------------------
        ; DOBLE BUFFER AND CLEAR HIDDEN BUFFER    
        TRAP    #0
; --- PLOT --------------------------------------------------------------------
            
            BRA     LOOP

    		SIMHALT
    		
    		;INCLUDE "VARS.X68"
    		;INCLUDE "SYSVARS.X68"

    		END    START









*~Font name~Courier New~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
