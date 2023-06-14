.data
  msj:           .asciiz "El resultado es: "
  CONTROL:       .word 0x10000
  DATA:          .word 0x10008
  Valor:         .double 10.00
  X:             .double 0.0

.code
  lwu $s6, CONTROL($0)
  lwu $s7, DATA($0)

  daddi $s0, $0, 8
  sd $s0, 0($s6)

  l.d f0, 0($s7)
  s.d f0, X($0)
  l.d f1, Valor($0)

  c.lt.d f1, f0
  bc1f else
    ; f3 = (f0 - f1) * f0
    sub.d f3, f0, f1
    mul.d f3, f3, f0
    j end
  else: nop
    ; f3 = (f1 - f0) / f0
    sub.d f3, f1, f0
    div.d f3, f3, f0
  end: daddi $t0, $0, msj
    sd $t0, 0($s7)
    daddi $t0, $0, 4
    sd $t0, 0($s6)
    s.d f3, 0($s7)
    daddi $t0, $0, 3
    sd $t0, 0($s6)
halt