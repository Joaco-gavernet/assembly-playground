  .data
A: .word 4
B: .word 4
C: .word 4
D: .word 0

  .code
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
daddi r4, r0, 0 ;inicializo registro en 0

bne r1, r2, next1
daddi r4, r4, 1
next1: bne r1, r3, next2
daddi r4, r4, 1
next2: bne r2, r3, check
daddi r4, r4, 1

check: daddi r5, r0, 1
beq r0, r0, fin
daddi r4, r0, 2
fin: sd r4, D(r0)

halt