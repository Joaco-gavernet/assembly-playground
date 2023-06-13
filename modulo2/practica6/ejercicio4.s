  .data
CONTROL: .word 0x10000
DATA: .word 0x10008
msj: .asciiz "Ingresar clave: "
bienvenido: .asciiz "Bienvenido!"
error: .asciiz "Error al ingresar la clave."
clave: .asciiz "hola"
ingresado: .word 1

  .code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

restart: nop
daddi $s3, $zero, 4 ; contador inicializado en 4 (caracteres por leer)
daddi $s4, $zero, 0 ; contador de la direccion de almacenamiento (caracteres leidos)

daddi $a0, $0, msj
jal print

loop: jal char ; se solicita ingreso (caracter por caracter)
  sb $v0, ingresado($s4) ; almacenamiento del caracter en "ingresado"
  daddi $s4, $s4, 1 ; incremento de la direccion destino en 1 byte
  daddi $s3, $s3, -1 ; se decrementa el contador
  bnez $s3, loop

daddi $a0, $0, clave ; se envian como argumentos las direcciones de las cadenas a comparar
daddi $a1, $0, ingresado
jal comparar

bnez $v0, sonIguales ; si $v0 != 0 entonces son iguales
daddi $a0, $0, error ; paso como argumento la direccion del mensaje a mostrar
jal print
j restart

sonIguales: daddi $a0, $0, bienvenido
jal print

halt

char: daddi $t0, $0, 9 ; funcion 9 (lectura de caracter)
  sd $t0, 0($s0) ; se ejecuta
  lbu $v0, 0($s1) ; recupero valor leido en DATA y lo retorno

  jr $ra

comparar: daddi $v0, $0, 0 ; por default las cadenas son diferentes
  lbu $t0, 0($a0) ; recupero primer caracter de ambas cadenas
  lbu $t1, 0($a1)
  bne $t0, $t1, finComparar
  lbu $t0, 1($a0) ; recupero siguiente caracter
  lbu $t1, 1($a1)
  bne $t0, $t1, finComparar
  lbu $t0, 2($a0) ; recupero siguiente caracter
  lbu $t1, 2($a1)
  bne $t0, $t1, finComparar
  lbu $t0, 3($a0) ; recupero siguiente caracter
  lbu $t1, 3($a1)
  bne $t0, $t1, finComparar
  daddi $v0, $0, 1 ; retorno 1 si son iguales

  finComparar: jr $ra

print: daddi $t0, $0, 6 ; funcion 6 (limpiar pantalla)
  sd $t0, 0($s0) ; se ejecuta

  daddi $t0, $0, 4 ; funcion 4 (salida de cadena ASCII)
  sd $a0, 0($s1) ; almaceno direccion del mensaje a mostrar en DATA
  sd $t0, 0($s0) ; se ejecuta

  jr $ra