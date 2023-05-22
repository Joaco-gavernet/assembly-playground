  .data
zero: .double 0.0
w: .double 78.8
h: .double 1.78
IMC: .double 0.0
infrapeso: .double 18.5
normal:    .double 25.0
sobrepeso: .double 30.0

estado: .word 0

  .code
l.d f0, zero(r0) ; f0 = 0.0 (buena practica)
l.d f1, w(r0) ; f1 = weight
l.d f2, h(r0) ; f2 = height

; inicializo registros en cero (buena practica)
l.d f3, 0(r0) ; resultados parciales y finales
l.d f4, 0(r0) ; registro temporal de calculos
l.d f5, 0(r0) ; index para tabla de limites de estados

mul.d f4, f2, f2 ; calculo el cuadrado de la altura en f2
div.d f3, f1, f4 ; calculo la division del peso en f1 por el cuadrado de la altura en f4
s.d f3, IMC(r0) ; almaceno IMC en memoria

daddi r1, r0, 4 ; estado = 4 (por defecto)
l.d f4, infrapeso(r5) ; cargo limite de estado

sub.d f4, f3, f4 ; comparo IMC con 18.5
c.lt.d f4, f0 ; si IMC < 18.5
bc1f next1 ; salto a menor
daddi r1, r0, 1 ; estado = 1
j end ; salto a fin

next1: daddi r5, r0, 8 ; index++
l.d f4, infrapeso(r5) ; traigo limite de estado en memoria
sub.d f4, f3, f4 ; comparo IMC con 25.0
c.lt.d f4, f0 ; si IMC < 25.0
bc1f next2 ; salto a menor
daddi r1, r0, 2 ; estado = 2
j end ; salto a fin

next2: daddi r5, r0, 16 ; index++
l.d f4, infrapeso(r5) ; traigo limite de estado en memoria
sub.d f4, f3, f4 ; comparo IMC con 30.0
c.lt.d f4, f0 ; si IMC < 30.0
bc1f end ; salto a menor
daddi r1, r0, 3 ; estado = 3

end: sd r1, estado(r0) ; cargo estado en memoria
halt
