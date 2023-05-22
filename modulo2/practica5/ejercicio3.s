  .data
b: .double 5.85
h: .double 13.47
divisor: .double 2
res: .double 0.0

  .code
l.d f0, b(r0)
l.d f1, h(r0)
l.d f2, divisor(r0)
mul.d f3, f0, f1 ; base por altura
div.d f3, f3, f2 ; divido por 2
s.d f3, res(r0)

halt
