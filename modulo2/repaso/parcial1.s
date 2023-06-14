.data
A: .word 4
B: .word 10
X: .word 0

.code
ld r3, A(r0)
ld r5, B(r0)
dadd r7, r0, r0
lazo: daddi r3, r3, -1
  dadd r7, r7, r5
  bnez r3, lazo

sd r7, X(r0)
halt