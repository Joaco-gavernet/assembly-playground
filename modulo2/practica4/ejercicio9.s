  .data
A: .word 3
X: .word 4
Y: .word 6

  .code
ld r1, A(r0)
ld r2, X(r0)
ld r3, Y(r0)

beqz r1, FIN
WHILE: dadd r2, r2, r3
daddi r1, r1, -1
bnez r1, WHILE

FIN: halt