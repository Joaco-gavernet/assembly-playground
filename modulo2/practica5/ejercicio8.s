  .data
A: .asciiz "COCO" ;0
B: .asciiz "COCO" ;0
result: .word 0

  .code
daddi $a0, $0, A
daddi $a1, $0, B

jal compararCadenas
sd $v0, result($0)
halt

compararCadenas: daddi $v0, $0, -1 ; inicializo el resultado en -1
daddi $t3, $0, 0 ; inicializo posicion actual en 0
loop: lbu $t0, 0($a0)
lbu $t1, 0($a1)

daddi $a0, $a0, 1
daddi $a1, $a1, 1

beqz $t0, terminar

daddi $t3, $t3, 1

dsub $t2, $t0, $t1
beqz $t2, loop

terminar: beqz $t1, fin
daddi $v0, $t3, -1 ; almaceno posicion diferente (0-based strings)
fin: jr $ra