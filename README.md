# Pac Man

## Como jugar:
Al iniciar el juego nos encontramos con la pantalla de inicio, una vez queramos jugar apretaremos la flecha derecha para iniciar el juego. 
Una vez iniciado podremos mover el Pac-Man con las flechas del teclado. El objetivo del juego es conseguir tomar todas las frutas y todas las pelotitas que están repartidas por el mapa antes de morir 3 veces a manos de los fantasmas. Para ello habrá que ir esquivando los cuatro fantasmas. 
Tanto si ganas consiguiendo todos los puntos como si pierdes porque te han matado 3 veces te llevará a una pantalla final indicándote si has ganado o perdido. Al llegar a esta pantalla el juego se acaba. 
Si se quiere volver a jugar una partida nueva se deberá cerra la ventana de ejecución de Easy68K y volver a compilar.

## Estructura del código:
### Archivos con los que nos encontramos:
- **MAIN.X68**
En este archivo encontramos el main del juego donde está el game-loop y la llamada a la inicialización del sistema, del juego y el plot de la pantalla inicial (MAIN-SCREEN) además de llamar al TRAP #1(lectura del input del teclado) y al TRAP #0 encargado de cambiar el buffer y limpiar el buffer escondido.

-	**PACMANS.X68**
En este archivo nos encontramos con 3 métodos y los 5 sprites posibles del Pac-Man.
Estos métodos son:
    - *PACINIT:* inicializa la posición X e Y del Pac-Man, y inicializa algunas variables encargadas del movimiento del Pac-Man.
    - *PACPLOT:* llama a al método SPRAYPLOT con la posición X e Y del Pac-Man y la imagen del movimiento actual del Pac-Man.
    - *PACUPD:* Es el método encargado de actualizar la posición X e Y del Pac-Man dependiendo del estado de las flechas del teclado (si están pulsadas o no) y de los espacios disponibles por los que puede ir por el mapa. El código sigue el pseudocódigo de la foto. 

- **GHOSTS.X68**
En este archivo encontramos 5 métodos:
    - *GHINIT:* inicializa las coordenadas de los 4 fantasmas.
    - *GHPLOT:* llama a SPRAYPL para cada fantasma, como resultado pinta los 4 fantasmas.
    - *GHUPDATE:* Llama a GHUPD para cada fantasma.
    - *GHUPD:*  Actualiza la dirección del fantasma observando de las casillas por las que puede ir cual es la que le acerca más al Pac-Man.
    - *COLISION:* Comprueba que el fantasma no está colisionando con el Pac-Man.

- **MAP.X68**
Nos encontramos con 3 métodos y el mapa, estos métodos son:
    - *MAPPLOT:* Encargado de hacer el dibujado del mapa.
    - *GETINFO:* Se le pasa por parámetro una posición X e Y que necesariamente han de ser modulo 32 y devuelve en D7 la información de los alrededores (arriba, abajo, derecha, izquierda, centro).
    - *CLRBOX:* Se encarga de limpiar el contenido de la casilla en el mapa de la posición X e Y que le pasan por parámetro. También será necesario que la posición X e Y sean modulo 32. Será utilizado para limpiar las frutas y pelotitas una vez el Pac-Man se encuentre encima de ellas.

- **SYSTEM.X68**
Encontramos 5 métodos:
    - *SYSINIT:* Encargado de inicializar la pantalla, instalar el TRAP #0 (SCRPLOT) y el TRAP #1, inicializa la variable que usamos para guardar el ultimo color que se ha usado a la hora de pintar un pixel y cambiamos a modo usuario.
    - *DBUFF:* Encargado de llamar a la tarea #92 del TRAP #15 para activar el doble buffer.
    - *KBDINIT:* Se encarga de inicializar la variable KBDVAL.
    - *KBDUPDATE:* Encargado de actualizar la variable KBDVAL con los valores actuales del teclado (del momento en el que se llama al método). Este método está instalado en el TRAP #1.
    - *SCRPLOT:* Esta rutina, instalada en el TRAP #0, se encarga de cambiar el buffer y limpiar el buffer escondido

- **INIT.X68**
En este archivo encontramos dos métodos: SOUNDLD y SOUNDPL encargados de cargar sonidos en los canales y de reproducirlos respectivamente.

- **TIMER.X68**
Archivo en el que encontramos los métodos necesarios para el tratamiento del reloj que aparece en pantalla con el tiempo que llevamos en la partida y el tiempo récord global del juego. Los métodos son:
    - *CLKINIT:* Encargado de leer el archivo con el tiempo récord y guardar el tiempo récord en la variable RECRDTIME, si el archivo no existe porque es la primera vez que se ejecuta el juego o anteriormente no se ha ganado ninguna partida en RECRDTIME se guarda 1111.
    - *CLKSTART:* Guarda el tiempo del sistema en el que se empieza a jugar.
    - *CLKSTOP:* Guarda el tiempo del sistema en el que se acaba la partida.
    - *CLKPLOT:* Hace el plot en la pantalla del récord y del tiempo que lleva el jugador en la partida.
    - *SAVETIME:* Método encargado de guardar el tiempo de la partida si resulta que este es un récord.

    En este archivo encontramos el uso de traps para controlar la lectura y escritura de ficheros.

- **VARS.X68, SYSVARS.X68, CONST.X68**
En estos ficheros encontramos las variables y las constantes usadas en el juego.

- **SCORE.X68, MAIN-SCREEN.X68, LOSS-SCREEN.X68, WIN-SCREEN.X68**
    - *SCORE.X68:* Encargado de hacer el plot de los puntos y las vidas del Pac-Man.
    - *MAIN-SCREEN.X68:* Pantalla inicial en la que se enseña el logo del Pac-Man.
    - *LOSS-SCREEN.X68:* Pantalla que se muestra si has perdido.
    - *WIN-SCREEN.X68:* Pantalla que se muestra si has ganado

## Características adicionales añadidas
### Visualización de imágenes
En el juego mostramos diversas imágenes, entre estas encontramos la portada, los 4 fantasmas y el Pac-Man en sus 5 posiciones posibles (arriba, abajo, derecha, izquierda y centro). Para ello hemos creado un pequeño programa en Python que le pasamos una imagen y nos devuelve el color de cada pixel de la imagen. Para que sea más fácil de poner en el juego le hemos dado un poco de formato a la salida del programa.
```python
from skimage.io import imread

theImage = imread('./Image_parser/clyde.png')
print(theImage.shape)
cont = 1
print('\n        DC.L      ', end="")
for row in range(theImage.shape[0]):
    for column in range(theImage.shape[1]):

        red = theImage[row, column, 0]
        green = theImage[row, column, 1]
        blue = theImage[row, column, 2]

        if cont % 6 == 0:
            print('$00%.2X%.2X%.2X'%(blue, green, red), end="")
        else:
            print('$00%.2X%.2X%.2X,'%(blue, green, red), end="")
        if cont % 6 == 0:
            print('\n        DC.L      ', end="")

        cont += 1
```

La salida tendrá este formato:
```
DC.L      $00000000,$00000000,$00000000,$00000000,$00000000,$00000000
```
Con la información guardada de esta manera hemos creado un subprograma (PRINT-SPRITE) al que le pasamos la posición X e Y dónde queremos que se pinte el Sprite(posición arriba a la izquierda del Sprite) y la dirección de memoria en la que se encuentra el color de cada pixel de la imagen. Como todos los sprites de los fantasmas y del Pac-Man son de 32x32 pixeles para dibujar la imagen es como recorrer una matriz de posiciones X e Y. Vamos avanzando en las X y cuando hayamos avanzado 32 pixeles hacia la derecha volvemos a poner las X al valor que nos han pasado por parámetro y le sumamos uno a la Y. Así hasta que hayamos llegado a sumar 32 a la Y que nos pasan por parámetro. Y en cada posición X-Y leemos de memoria el color en del pixel y lo seteamos como color del pincel.

Para optimizar un poco este subprograma hacemos dos cosas:
-	Si el pixel es negro no lo pintamos ya que los pasillos por dónde van los fantasmas son negros.
-	Si el pixel que vamos a pintar ahora es del mismo color que el anterior no volvemos a setear el color del pincel, de esta forma cada vez que pintemos el pixel del mismo color que el pixel anterior nos ahorramos un TRAP #80.

## Uso de ficheros.
Hemos implementado esta característica adicional para guardar cual ha sido el récord de tiempo en pasarnos el juego. Esta característica está implementada dentro del archivo TIMER.X68 con el uso de las tareas #50, #51, #52, #53 y #54. La implementación consiste en lo siguiente:

- Primero de todo cuando se inicia la partida leo el archivo con el nombre FILENAME mediante la tarea #51, si el fichero no está creado el TRAP me devuelve en D0 un 2 indicando que ha habido un error. En el caso de que ocurra el error uso la tarea #52 para abrir el fichero con el nombre FILENAME, la diferencia es que si no existe crea un fichero nuevo con ese nombre y si existe lo machaca.
Como ha habido dos inicios posibles, entonces suceden dos cosas, si no ha dado error al abrir el archivo entonces procedo a leer 4bytes del archivo mediante la tarea #53 para leer el long que representa el tiempo récord guardado anteriormente. En el otro caso en el que ha habido un error ya no procedo a leer porque se seguro que dentro del archivo no habrá nada escrito.
- Por otra parte, al final del código del archivo TIEMR.X68 después de un poco de lógica si hemos obtenido un récord nuevo procedo a abrir el fichero con el nombre FILENAME ya que lo que quiero es machacar el archivo y escribir el nuevo récord en él, para ello abro el archivo con la tarea #52 y escribo el nuevo récord con la tarea #54.
- Para finalizar usamos la tarea #50 para cerrar todos los ficheros que pueda haber abiertos.

## Dificultades encontradas
Unas de las principales dificultades fue conseguir que el Pac-Man solo se pudiera mover por los pasillos del mapa siguiendo las instrucciones del teclado. Para ello hemos tenido que crear un método que devuelve un word con la información de alrededor de un recuadro de 32x32 pixeles cuyas coordenadas X e Y son las que están situadas en la esquina de arriba a la derecha del recuadro. Este método lo encontramos dentro del archivo MAPA.X68, su nombre es GETINFO. Para que sea más cómodo y más fácil de calcular que hay alrededor solo podemos llamar a este método cuando el Sprite este situado en una posición X e Y modulo 32. En el subprograma usamos la formula { ((row) * COLUMNS + column) } para acceder a la “casilla” en la que está el Sprite, el resultado de la formula se lo sumamos al LEA donde está el mapa y el contenido de la suma será el valor de la casilla. Haciendo cuatro sumas y cuatro restas podremos acceder a los diferentes valores de alrededor.

Este método GETINFO también me sirve mucho para implementar el movimiento de los fantasmas. Me di cuenta de que para conseguir un movimiento perfecto en los fantasmas debería implementar algoritmos que me calcularan caminos óptimos como es el de A*. Hablando con el profesor quedamos en que eso sería muy complejo para el poco tiempo que tenemos para ello lo que hago es calcular cada vez que el fantasma está en una posición modulo 32 cuál de las casillas libres que tiene alrededor le acercan más al Pac-Man. Para calcular la distancia más corta hemos implementado un método que nos calcula la distancia de Manhattan. Al haber implementado el algoritmo de esta manera la mayoría del tiempo nos encontramos a algún fantasma que se queda moviéndose entre dos bloques.

## Conclusiones
Al principio nos costo ver cuales eran las tareas que había que hacer, pero poco a poco se fueron aclarando las ideas y viendo cual sería la estructura. Ha sido interesante implementar la lógica que había detrás del juego, fue un reto conseguir mover los sprites por los pasillos.

Si hubiésemos tenido más tiempo nos habría gustado implementar el algoritmo de A* y unos cuantos mapas más.





