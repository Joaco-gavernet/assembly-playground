  .data
TABLA: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
CANT: .word 0
X: .word 5
RES: .word 0

  .code
daddi r3, r0, 10 ;inicializo dimension logica de la tabla
daddi r4, r0, 0 ;inicializo index de recorrido en 0
daddi r5, r0, 0 ;registro temporal
daddi r6, r0, 0 ;inicializo contador en 0
daddi r7, r0, 1 ;registro asignacion 1

ld r2, X(r0) ;cargo el valor de X en r2

loop: ld r1, TABLA(r4)
dsub r5, r1, r2
beqz r5, esMenor 
slt r5, r1, r2
daddui r5, r5, -1
beqz r5, esMenor

daddi r6, r6, 1 ;incremento cantidad resultado
sd r7, RES(r4) ;guardo 1 en la tabla de resultados
j next

esMenor: sd r0, RES(r4) ;guardo 0 en la tabla de resultados
next: daddi r4, r4, 8
daddui r3, r3, -1
bnez r3, loop

sd r6, CANT(r0)
halt