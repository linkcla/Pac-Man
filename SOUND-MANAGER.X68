DIRECTX         DS.B    1
MAINSCRMUS      DC.B    './music/game_start.wav', 0
EATBALL         DC.B    './music/munch.wav',0 
EATFRUIT        DC.B    './music/eat_fruit.wav',0 
DEATHSOUND      DC.B    './music/death.wav',0

                DC.W    0

; -----------------------------------------------------------------------------
SOUNDLD
; TRY TO LOAD BY DIRECTX, IF NOT USE THE STANDARD PLAYER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
.DIRECTX
        MOVEM.L D0-D1/A1, -(A7)

        ; TRY TO LOAD ON CHANEL 0
        MOVE.W  #74, D0
        MOVE.L  #MAINSCRMUS, A1
        MOVE.B  #0, D1
        TRAP    #15

        CMP.W   #0, D0
        BEQ     .NORMAL
        ; SI ESTA AQUI EL RESTO DE LOS SONIDOS YA SE PUEDEN CARGAR POR DIRECTX
        ; INDICAMOS QUE EL DIRECTX ESTA ACTIVO
        MOVE.B  #$FF, DIRECTX

        ; CARGAMOS EL RESTO DE LOS SONIDO POR DIRECTX
        MOVE.W  #74, D0
        MOVE.L  #EATBALL, A1
        MOVE.B  #1, D1
        TRAP    #15

        MOVE.W  #74, D0
        MOVE.L  #EATFRUIT, A1
        MOVE.B  #2, D1
        TRAP    #15

        MOVE.W  #74, D0
        MOVE.L  #DEATHSOUND, A1
        MOVE.B  #3, D1
        TRAP    #15


        BRA .END

.NORMAL:
        ; INDICAMOS QUE NO SE HA PODIDO CARGAR POR DIRECTX
        CLR.B   DIRECTX

        ; CARGAMOS LOS SONIDOS POR EL PLAYER NORMAL
        MOVE.W  #71, D0
        MOVE.L  #MAINSCRMUS, A1
        MOVE.B  #0, D1
        TRAP    #15

        MOVE.W  #71, D0
        MOVE.L  #EATBALL, A1
        MOVE.B  #1, D1
        TRAP    #15

        MOVE.W  #71, D0
        MOVE.L  #EATBALL, A1
        MOVE.B  #2, D1
        TRAP    #15

        MOVE.W  #71, D0
        MOVE.L  #DEATHSOUND, A1
        MOVE.B  #3, D1
        TRAP    #15

.END:
        MOVEM.L (A7)+, D0-D1/A1
        RTS

; -----------------------------------------------------------------------------
SOUNDPL 
; PLAY THE SOUND FROM THE DIRECTX PLAYER IF DIRECTX == FF ELSE PLAY THE SOUND
; USING STANDARD PLAYER
; INPUT    - FIRST PUSH SOUND MODE(L) THEN PUSH THE NUMBER OF THE CHANEL(W)
;            ON THE STACK
; OUTPUT   - NONE
; MODIFIES - NONE
;
;       SOUND MODE: 
;               - 0 --> SUENA UNA VEZ
;               - 1 --> SUENA EN BUCLE
;               - 2 --> PARA LA CANCION DEL CHANEL PASADO
;               - 3 --> PARA TODAS LAS CANCIONES
;
;       NUMBER OF CHANEL
;               - 0 --> CANCION PARA LA PANTALLA INICIAL
;               - 1 --> SONIDO AL COMER UNA PELOTA
;               - 2 --> SONIDO AL COMER UNA FRUTA
;               - 3 --> SONIDO MUERTE
;
; -----------------------------------------------------------------------------
        MOVEM.L D0-D1/A1, -(A7)
        CMP.W   #$00, DIRECTX
        BEQ     .NORMAL

        MOVE.W  #77, D0     ; PLAY SOUND
        BRA     .END
.NORMAL
        MOVE.W  #76, D0     ; PLAY SOUND
        BRA     .END
.END
        MOVE.W  16(SP), D1      ; CANAL
        MOVE.L  18(SP), D2      ; MODO
        TRAP    #15

        MOVEM.L (A7)+, D0-D1/A1
        RTS