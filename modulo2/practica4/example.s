;Escribir un programa que lea tres números enteros A, B y C de la memoria de datos 
;y determine cuántos de ellos son iguales
;entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D.

.data
A: .word 1
B: .word 2
C: .word 4
D: .word 0
E: .word 0

;dos numeros son iguales

.code
ld r1, A(r0)       ;se carga un 1 en r1
ld r2, B(r0)       ;se carga un 2 en r2
ld r3, C (r0)      ; se carga un 3 en r3
ld r4, D (r0)      ; inicializo r4 en 0


;PRIMERA COMPARACION
bne r1, r2, listo  ;si no son iguales que salte y no sume    
daddi r4, r4, 1    ;inc contador

;SEGUNDA COMPARACION
listo: bne r1,r3, next   ;suma 1 a result
daddi r4, r4, 1    ;inc contador

;TERCER COMPARACION
daddi r5, r5, 2  
beq r5, r4, analizar
next: bne r2, r3, analizar  
daddi r4, r4, 1 ;inc contador

analizar: beqz r4, salto
daddi r4, r4, 1
salto: sd r4, D(r0)  ;mando a memoria num que tiene el contador

halt ; fin del programa