  .data
cadena: .asciiz "abcdcdedfdgdhdid" ;cadena a analizar
car: .asciiz "d" ;caracter buscado
cant: .word 0 ;cantidad de veces que aparece el caracter

  .code
lbu r1, car(r0)
lbu r2, cadena(r0)
daddi r3, r0, 0 ;inicializo registro index en cero
daddi r4, r0, 0 ;inicializo registro contador en cero
daddi r5, r0, 16 ;inicializo registro condicion de corte

loop: lbu r2, cadena(r3)
bne r2, r1, next
daddi r4, r4, 1
next: daddi r3, r3, 1
bne r3, r5, loop

sw r3, cant(r0)
halt

; CPI = 2.179
; CPI = 1.974           forwarding 
; CPI = 2.077           forwarding + branch prediction (la prediccion empeora el rendimiento por ser secuencia aleatoria)