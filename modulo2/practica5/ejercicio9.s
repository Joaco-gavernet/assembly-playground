
  .data
valor: .word 4
result: .word 0

  .text
daddi $sp, $0, 0x400 ; Inicializa el puntero al tope de la pila (1)
ld $a0, valor($0)

jal factorial
sd $v0, result($0)
halt

factorial: nop 
; PROLOGO
daddi $sp, $sp, -16 ; Reserva espacio para el registro de activacion
sd $ra, 0($sp) ; Guarda el registro de activacion en la pila
sd $a0, 8($sp) ; Guarda el argumento en la pila

; CUERPO
; a0 = input
; t0 = retorno en backtracking
; v0 = output

beqz $a0, BASE

; REVISAR !!!!!!!!!!!!!!!!!!!
; lo optimo seria no realizar la resta y suma de 1, pero no se me ocurrio como hacerlo
daddi $a0, $a0, -1
jal factorial ; retorna en $v0 el resultado
daddi $a0, $a0, 1 ; restaura el valor de a0

dmul $v0, $a0, $v0 ; multiplicacion factorial
j FIN

BASE: daddi $v0, $v0, 1 ; caso base

; EPILOGO
FIN: ld $ra, 0($sp) ; Recupera el registro de activacion de la pila
ld $a0, 8($sp) ; Recupera el argumento de la pila
daddi $sp, $sp, 16 ; Libera el espacio del registro de activacion

jr $ra