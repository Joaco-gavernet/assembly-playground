  .data
M:      .word 3
dim:    .word 5
tabla:  .word 1, 2, 3, 4, 5
result: .word 0

  .code
ld $a0, M($0) ; valor a comparar como limite
daddi $a1, $0, tabla ; direccion inicial de la tabla
ld $a2, dim($0) ; dimension logica de la tabla

jal checkTabla

sd $v0, result($0)
halt

checkTabla: ld $t1, 0($a1) ; cargo valor de la tabla
slt $t1, $a0, $t1 ; comparo con el limite
beqz $t1, menor
daddi $v0, $v0, 1 ; si es mayor, incremento contador

menor: daddi $a1, $a1, 8 ; desplazamiento de indice de tabla
daddi $a2, $a2, -1 ; decremento contador de recorrido
bnez $a2, checkTabla ; si no llegue al final, vuelvo a chekear
terminar: jr $ra