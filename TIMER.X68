
; -----------------------------------------------------------------------------
CLKINIT
; INIT THE GAME CLOCK VARIABLES AND OPENING THE FILE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
        MOVEM.L D0-D1/A1,-(SP)

        CLR.L   (STARTTIME)
        CLR.L   (STOPTIME)
        CLR.L   (RECRDTIME)

        ; LEEMOS EL TIEMPO RECORD DEL FICHERO Y LO GUARDAMOS EN RECRDTIME
        ; ABRIMOS EL FICHERO
        MOVE.B  #51,D0
        MOVE.L  #FILENAME,A1
        TRAP    #15
        CMP     #2,D0
        BNE     .FILEOK

        ; SI ESTAMOS AQUÍ HA HABIDO UN PROBLEMA AL ABRIR EL FICHERO
        ; MIRAMOS DE CREARLO
        MOVE.B  #52,D0
        MOVE.L  #FILENAME,A1
        TRAP    #15
        ; COMO CREAMOS UNO NUEVO PONDREMOS QUE EL RECORD DE TIEMPO HA SIDO 1111
        MOVE.L  #1111,(RECRDTIME)
        ; POSTERIORMENTE YA GUARDAREMOS EL NUEVO RECORD EN EL FICHERO
        BRA     .EXIT

.FILEOK
        ; LEEMOS
        MOVE.B  #53,D0
        MOVE.L  #RECRDTIME,A1   ;LA LECRURA LA GUARDAMOS EN RECRDTIME
        MOVE.L  #4,D2          ;LEEMOS 4BYTES QUE SON LOS QUE OCUPA RECRDTIME
        TRAP    #15

        MOVE.L  (RECRDTIME),D0
        BNE     .EXIT           ;SI EL RECORD ES DISTINTO DE 0 YA HAY UN RECORD
        MOVE.L  #1111,(RECRDTIME) ; SI NO HAY RECORD PONEMOS 1111

.EXIT   MOVEM.L (SP)+,D0-D1/A1
        RTS



; -----------------------------------------------------------------------------
CLKSTART
; START THE GAME CLOCK
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
        MOVEM.L D0-D1,-(SP)

        MOVE.B  #8,D0
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

        MOVE.B  #8,D0
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
        MOVE.B  #8,D0
        TRAP    #15
        
        ; PRINT SECOND LINE
        LEA     .TXT2,A1
        SUB.L   (STARTTIME),D1
        DIVU    #100,D1         ; DIVIDIMOS PARA TENER SEGUNDOS
        AND.L   #$0000FFFF,D1   ; NOS QUEDAMOS CON LA PARTE ENTERA
        MOVE.B  #17,D0
        TRAP    #15

        MOVEM.L (SP)+,D0-D1/A1
        RTS
.TXT1       DC.B    'RECORD : ',0
.TXT2       DC.B    'TIME   : ',0    

; -----------------------------------------------------------------------------
SAVETIME
; SAVES THE TIME PLAYED IF IT IS A NEW RECORD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------

        MOVEM.L D0-D1,-(SP)

        MOVE.L  (STOPTIME),D0
        SUB.L   (STARTTIME),D0

        DIVU    #100,D0         ; DIVIDIMOS PARA TENER SEGUNDOS
        AND.L   #$0000FFFF,D0   ; NOS QUEDAMOS CON LA PARTE ENTERA
        MOVE.L  D0,(TIMEPLAYED)
        CMP.L   (RECRDTIME),D0  ; COMPARAMOS CON EL RECORD
        BHI     .END            ; SI ES MAYOR NO GUARDAMOS EN EL FICHERO

        MOVE.L  D0,(RECRDTIME)
        ; GUARDAMOS EL NUEVO RECORD EN EL FICHERO

        ; SI ABRIMOS EL ARCHIVO CON LA TAREA 52 Y EL MISMO NOMBRE CONSEGUIMOS
        ; SOBREESCRIBIR EL ARCHIVO, QUE ES LO QUE QUEREMOS.
        MOVE.B  #52,D0
        MOVE.L  #FILENAME,A1
        TRAP    #15
        
        ; ESCRIBIMOS EL NUEVO RECORD
        MOVE.B  #54,D0
        MOVE.L  #RECRDTIME,A1
        MOVE.L  #4,D2
        TRAP    #15

        ; CERRAMOS EL FICHERO
        MOVE.B  #50,D0
        TRAP    #15

.END    MOVEM.L (SP)+,D0-D1
        RTS

*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~    