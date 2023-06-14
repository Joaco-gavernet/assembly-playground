.data
  tabla_1: .word 21, 12, 5, 16, 8, 39, 10, 41, 4, 33
  tabla_2: .word 32, 24, 15, 32, 17, 28, 11, 20, 44, 21
  CONTROL: .word 0x10000
  DATA: .word 0x10008
  rojo: .byte 255, 0, 0, 0
  verde: .byte 0, 255, 0, 0

.code
  lwu $s6, CONTROL($0)
  lwu $s7, DATA($0)

  daddi $a1, $0, tabla_1
  daddi $a2, $0, 10
  jal MIN_MAX                   ; tabla_1
  dadd $s0, $0, $v0
  dadd $s1, $0, $v1

  daddi $a1, $0, tabla_2
  daddi $a2, $0, 10
  jal MIN_MAX                   ; tabla_2

  daddi $t0, $0, rojo
  lwu $t0, 0($t0)
  sw $t0, 0($s7)
  sb $s0, 5($s7)
  sb $v1, 4($s7)
  daddi $t0, $0, 5              ; corregido
  sw $t0, 0($s6)                ; imprime

  daddi $t0, $0, verde
  lwu $t0, 0($t0)
  sw $t0, 0($s7)
  sb $s1, 5($s7)
  sb $v0, 4($s7)
  daddi $t0, $0, 5              ; corregido
  sw $t0, 0($s6)                ; imprime

halt

MIN_MAX: nop
  ; a1 = direccion de tabla
  ; a2 = cantidad de elementos
  ; v0 = minimo
  ; v1 = maximo
  ; t0 = contador
  ; t1 = actual

  daddi $t0, $0, 0
  daddi $v0, $0, 0
  daddi $v1, $0, 0
  beqz $a2, end                 ; corregido

  ld $t1, 0($a1)
  dadd $v0, $0, $t1
  dadd $v1, $0, $t1             ; inicializacion

  daddi $a1, $a1, 8
  daddi $t0, $t0, 1
  beq $t0, $a2, end             ; revisar

  loop: ld $t1, 0($a1)
    slt $t3, $t1, $v0
    beqz $t3, nextA
      dadd $v0, $0, $t1
    nextA: slt $t3, $v1, $t1
    beqz $t3, nextB
      dadd $v1, $0, $t1
    nextB: nop
    daddi $a1, $a1, 8
    daddi $t0, $t0, 1
    bne $t0, $a2, loop          ; corregido
  end: jr $ra