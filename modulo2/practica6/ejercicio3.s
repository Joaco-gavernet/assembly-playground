  .data
msj: .asciiz "Ingrese un numero: " ; El mensaje a mostrar
msj2: .asciiz "Resultado: "
cero: .asciiz "cero"
uno: .asciiz "uno"
dos: .asciiz "dos"
tres: .asciiz "tres"

CONTROL: .word32 0x10000
DATA: .word32 0x10008

  .text
lwu $s0, CONTROL(r0)
lwu $s1, DATA(r0)
jal ingreso ; ingreso del primer numero
beqz $v0, NotANumber
daddui $a0, $v0, 0
jal ingreso ; ingreso del segundo numero
beqz $v0, NotANumber
daddui $a1, $v0, 0

jal resultado

NotANumber: halt

ingreso: daddi $t0, $0, 6 ; funcion 6 (limpiar pantalla)
  sd $t0, 0($s0) ; se ejecuta

  daddi $t1, $0, msj ; obtengo en $t1 direccion del mensaje a mostrar
  sd $t1, 0($s1) ; almaceno direccion en DATA
  daddi $t0, $0, 4 ; funcion 4 (salida de cadena ASCII)
  sd $t0, 0($s0) ; se ejecuta

  daddi $t0, $0, 9 ; funcion 9 (entrada de ASCII en DATA)
  sd $t0, 0($s0) ; se ejecuta
  
  daddi $v0, $0, 0 ; por defecto retorna 0 (numero invalido)

  ; se corrobora si el valor almacenado en $s0 (DATA) es un digito
  ld $t0, 0($s1) ; almaceno en $t0 el valor
  slti $t1, $t0, 48
  bnez $t1, fin ; analizo si es mayor a numeros en ASCII
  slti $t1, $t0, 57
  beqz $t1, fin ; analizo si es menor a numeros 
  daddui $t0, $t0, -48
  daddi $v0, $t0, 0 ; retorno el numero si es valido
  fin: jr r31

resultado: dadd $v0, $a0, $a1
  daddi $t0, $0, 6 ; funcion 6 (limpiar pantalla)
  sd $t0, 0($s0) ; se ejecuta

  daddi $t1, $0, msj2 ; obtengo en $t1 direccion del mensaje a mostrar
  sd $t1, 0($s1) ; almaceno direccion en DATA
  daddi $t0, $0, 4 ; funcion 4 (salida de cadena ASCII)
  sd $t0, 0($s0) ; se ejecuta

  sd $v0, 0($s1)
  daddi $t0, $0, 1
  sd $t0, 0($s0)
  jr r31