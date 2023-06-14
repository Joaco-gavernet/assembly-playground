.data
  CONTROL:   .word 0x10000
  DATA:      .word 0x10008
  msjBase:   .asciiz "Ingresar base: "
  msjAltura: .asciiz "Ingresar altura: "
  coorX:     .byte 5
  coorY:     .byte 5
  colors:    .byte 0, 255, 0, 0

.code
  lwu $s6, CONTROL($0)
  lwu $s7, DATA($0)

  ; s0 = funcion 8 (lectura por terminal)
  ; s1 = base
  ; s2 = altura
  ; s5 = funcion 5 (imprimir en pantalla grafica)

  daddi $s0, $0, 8              ; funcion 8

  daddi $a0, $0, msjBase
  jal print
  sd $s0, 0($s6)
  lwu $s1, 0($s7)               ; base

  daddi $a0, $0, msjAltura
  jal print
  sd $s0, 0($s6)
  lwu $s2, 0($s7)               ; altura

  daddi $s5, $0, 5              ; funcion 5

  ; DATA =  R, G, B, 0, Y, X
  lwu $t0, colors($0)
  sw $t0, 0($s7)

  ; $a0 = X inicial
  ; $a1 = Y inicial
  ; $a2 = desplazamiento
  lbu $a0, coorX($0)
  lbu $a1, coorY($0)
  dadd $a2, $0, $s1
  jal horizontal              ; horizontal inferior

  lbu $a0, coorX($0)
  lbu $a1, coorY($0)
  dadd $a1, $a1, $s2
  daddi $a1, $a1, -1          ; correccion
  dadd $a2, $0, $s1
  jal horizontal              ; horizontal superior

  lbu $a0, coorX($0)
  lbu $a1, coorY($0)
  dadd $a2, $0, $s2
  jal vertical                ; vertical izquierda

  lbu $a0, coorX($0)
  dadd $a0, $a0, $s1
  daddi $a0, $a0, -1          ; correcion
  lbu $a1, coorY($0)
  dadd $a2, $0, $s2
  jal vertical                ; vertical izquierda

halt

horizontal: sb $a1, 4($s7)
  loopH: sb $a0, 5($s7)
    daddi $a0, $a0, 1
    daddi $a2, $a2, -1
    sw $s5, 0($s6)            ;imprime
    bnez $a2, loopH
  jr $ra

vertical: sb $a0, 5($s7)
  loopV: sb $a1, 4($s7)
    daddi $a1, $a1, 1
    daddi $a2, $a2, -1
    sw $s5, 0($s6)            ;imprime
    bnez $a2, loopV
  jr $ra

print: daddi $t0, $0, 4 ; funcion 4 (salida de cadena ASCII)
  sd $a0, 0($s7) ; almaceno direccion del mensaje a mostrar en DATA
  sd $t0, 0($s6) ; se ejecuta
  jr $ra