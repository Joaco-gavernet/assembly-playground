  .data
A: .word 4
B: .word 5

  .code
ld r1, A(r0)
ld r2, B(r0)
daddi r3, r0, 0

beqz r1, FIN
beqz r2, FIN

LOOP: daddi r2, r2, -1
bnez r2, LOOP ;cambio el orden para aprovechar el Delay Slot (Salto con retardo)
dadd r3, r3, r1

FIN: halt