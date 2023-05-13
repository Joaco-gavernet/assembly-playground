  .data
A: .word 4
B: .word 4
C: .word 4
D: .word 0

  .code
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
daddi r4, r0, 0

xor r5, r1, r2
bnez r5, next1
daddi r4, r4, 2

next1: xor r5, r1, r3
bnez r5, next2
bnez r4, inc
daddi r4, r4, 2
j next2
inc: daddi r4, r4, 1

next2: xor r5, r2, r3
bnez r5, fin
bnez r4, inc2
daddi r4, r4, 2
j fin
inc2: daddi r4, r4, 1

fin: sd r4, D(r0)

halt