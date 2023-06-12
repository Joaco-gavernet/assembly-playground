  .data
texto: .asciiz "Hola, Mundo!" ; El mensaje a mostrar
textoIngresado: .asciiz ""
CONTROL: .word32 0x10000
DATA: .word32 0x10008

  .text
lwu $s0, DATA(r0) ; $s0 = dirección de DATA

lwu $s1, CONTROL(r0) ; $s1 = dirección de CONTROL
daddi $t0, $0, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
sd $t0, 0($s1) ; CONTROL recibe 6 y limpia la pantalla

daddi $t0, $0, 9 ; $t0 = 9 -> función 9: espera por un ASCII
sb $t0, 0($s1) ; CONTROL recibe 9 y espera por el ASCII (el cual es almacenado en DATA)

lb $t0, 0($s0) ; se recupera el caracter ingresado en t0
daddi $t1, $0, textoIngresado ; obtengo direccion de la etiqueta en t1
sb $t0, 0($t1)

daddi $t0, $0, 0 ; agrego un 0 luego del ASCII
sd $t0, 8($t1)

daddi $t0, $0, textoIngresado ; $t0 = dirección del mensaje a mostrar
sd $t0, 0($s0) ; DATA recibe el puntero al comienzo del mensaje

daddi $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
sd $t0, 0($s1) ; CONTROL recibe 4 y produce la salida del mensaje
halt