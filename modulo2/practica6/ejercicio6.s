  .data 
msjCoordenadaX: .asciiz "Ingresar coordenada X [0, 49]: "
msjCoordenadaY: .asciiz "Ingresar coordenada Y [0, 49]: "
msjColor: .asciiz "Ingresar color en RGB: "
color:   .byte   255, 0, 255, 0 ; Red, Green, Blue, Opacity
CONTROL: .word32 0x10000 
DATA: .word32 0x10008 
  
  .text 
lwu $s6, CONTROL(r0)
lwu $s7, DATA(r0)

daddi  $t0, $0, 7 ; funcion 7: limpiar pantalla
sd $t0, 0($s7)

daddi $a0, $0, msjCoordenadaX
jal print
jal ingresarEntero ; retorna el entero ingresado en $v0
sb $v0, 5($s7) ; DATA+5 recibe el valor de coordenada X

daddi $a0, $0, msjCoordenadaY
jal print
jal ingresarEntero ; retorna el entero ingresado en $v0
sb $v0, 4($s7) ; DATA+4 recibe el valor de coordenada Y

; daddi $a0, $0, msjColor
; jal print ; se imprime mensaje
; daddi $s0, $0, 0 ; lectura de 4 bytes en direccion de "color"
; loop: jal ingresarEntero
;   sb $v0, color($s0) ; se almacena en la direccion de color
;   daddi $s0, $s0, 1
;   slti $t0, $s0, 4 ; contador de bytes procesados
;   bnez $t0, loop ; si $t0 != 0 entonces aun no se procesaron 4 bytes

; daddi  $t0, $0, 6 ; funcion 6 (limpiar terminal)
; sd $t0, 0($s6)

lwu $s2, color(r0) ; $s2 = valor de color a pintar 
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar 

daddi  $t0, $0, 5 ; funcion 5 (salida)
sd $t0, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto 
halt

print: daddi $t0, $0, 6 ; funcion 6 (limpiar pantalla)
  sd $t0, 0($s6) ; se ejecuta

  daddi $t0, $0, 4 ; funcion 4 (salida de cadena ASCII)
  sd $a0, 0($s7) ; almaceno direccion del mensaje a mostrar en DATA
  sd $t0, 0($s6) ; se ejecuta

  jr $ra

ingresarEntero: daddi $t0, $0, 8
  sd $t0, 0($s6)
  ld $v0, 0($s7) ; se retorna el numero leido en f0 (registro de flotantes)
  jr $ra
