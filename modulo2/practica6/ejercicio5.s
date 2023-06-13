  .data
CONTROL: .word 0x10000
DATA: .word 0x10008
msjBase: .asciiz "Ingrese la base (flotante): "
msjExponente: .asciiz "Ingrese el exponente (entero sin signo): "
msjResultado: .asciiz "Resultado de la potencia: "
unoFlotante: .double 1

  .code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

daddi $a0, $0, msjBase
jal print ; recibe en argumetno $a0 la direccion inicial del string a imprimir
jal ingresarFlotante ; retorna el flotante ingresado en f0

daddi $a0, $0, msjExponente
jal print
jal ingresarEntero ; retorna el entero ingresado en $v0

mov.d f1, f0 ; paso como argumento la base
dadd $a0, $0, $v0 ; paso como argumento el exponente
jal a_la_potencia ; retorna resultado en f0

daddi $a0, $0, msjResultado
jal print
jal printFlotante ; recibe flotante en f0

halt

print: daddi $t0, $0, 6 ; funcion 6 (limpiar pantalla)
  sd $t0, 0($s0) ; se ejecuta

  daddi $t0, $0, 4 ; funcion 4 (salida de cadena ASCII)
  sd $a0, 0($s1) ; almaceno direccion del mensaje a mostrar en DATA
  sd $t0, 0($s0) ; se ejecuta

  jr $ra

printFlotante: daddi $t0, $0, 3 ; funcion 3 (salida de flotante)
  s.d f0, 0($s1) ; almaceno resultado (flotante) a mostrar en DATA
  sd $t0, 0($s0) ; se ejecuta
  jr $ra

ingresarFlotante: daddi $t0, $0, 8
  sd $t0, 0($s0)
  l.d f0, 0($s1) ; se retorna el numero leido en f0 (registro de flotantes)
  jr $ra

ingresarEntero: daddi $t0, $0, 8
  sd $t0, 0($s0)
  ld $v0, 0($s1) ; se retorna el numero leido en f0 (registro de flotantes)
  jr $ra

a_la_potencia: daddi $t0, $0, 1 ; por defecto se retorna 1 (en flotante)
  ; mtcl $t0, f0 ; almacena entero en registro flotante
  ; cvt.d.l f0, f0 ; convierto al 1 en punto flotante
  l.d f0, unoFlotante($0)
  beqz $a0, finPotencia

  loop: mul.d f0, f1, f0
  daddi $a0, $a0, -1
  bnez $a0, loop

  finPotencia: jr $ra