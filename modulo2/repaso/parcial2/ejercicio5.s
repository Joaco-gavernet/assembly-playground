.data
  cadena: .asciiz 'ejemplo'
  result: .word 0

.code
  daddi $t1, $zero, cadena
  dadd $t2, $zero, $zero
  loop: lbu $t3, 0($t1)
    daddi $t2, $t2, 1
    daddi $t1, $t1, 1
    bnez $t3, loop

  sd $t2, result($zero)
halt