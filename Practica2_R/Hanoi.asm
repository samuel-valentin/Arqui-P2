################################################# 
#  Integrantes del equipo:              	#
#  Carlos Rubio Orellana - is709385             #
#  Samuel Valentin Lopez Valenzuela - is736144  #
#################################################

.data
.text

main:
	# variable para asignar N
	addi s0, zero, 3		# Se inicializa s0 con el valor 3 (cantidad de discos)

	### Apuntadores base: ###
	
	# Torre A
	lui a3, 0x10010		# Se carga la dirección base de la Torre A en a3 (sección de memoria de datos)
	addi a3, a3, 4		# Se ajusta el offset para apuntar a la primera posición de la Torre A

	# Torre B
	lui a4, 0x01001		# Se carga la direccion base de la Torre B en a4 (seccion de memoria de datos)
	ori a4, a4, 0x02		# Se agrega un offset a la dirección para apuntar a la segunda posicion de la Torre B
	slli a4, a4, 4			# Se realiza un desplazamiento lógico a la izquierda para ajustar el offset

	#Torre C
	lui a5, 0x01001		# Se carga la dirección base de la Torre C en a5 (sección de memoria de datos)
	ori a5, a5, 0x04		# Se agrega un offset a la dirección para apuntar a la tercera posición de la Torre C
	slli a5, a5, 4			# Se realiza un desplazamiento lógico a la izquierda para ajustar el offset
	
	# Stack para los valores de N
	lui a2, 0x01001		# Se carga la dirección base del stack en a2 (sección de memoria de datos)
	ori a2, a2, 0x06		# Se agrega un offset a la dirección para apuntar a la primera posición del stack
	slli a2, a2, 4			# Se realiza un desplazamiento lógico a la izquierda para ajustar el offset

	# contador para nuestro loop -> colocar_discos
	add a7, zero, s0		# Se copia el valor de s0 (cantidad de discos) a a7 para utilizarlo como contador en el siguiente bucle
	jal ra, colocar_discos	# Se salta a la etiqueta colocar_discos para colocar N discos en la Torre A

	# Mandamos llamar hanoi(n,origin, dest, aux)
	# N
	sw s0, 0(a2)			# Se guarda el valor de s0 (cantidad de discos) en la dirección de memoria apuntada por a2 (stack de valores de N)
	jal ra, hanoi			# Se salta a la etiqueta hanoi para ejecutar el algoritmo de la Torre de Hanoi

	jal zero, fin			# Se salta a la etiqueta fin para finalizar el programa


# loop para colocar N número de discos en Torre A
colocar_discos:
	sw a7, 0(a3)			# Se guarda el valor de a7 (contador) en la dirección de memoria apuntada por a3 (Torre A)
	addi a3, a3, 4			# Se incrementa a3 para apuntar a la siguiente posición de la Torre A
	addi a7, a7, -1			# Se decrementa a7

	blt zero, a7, colocar_discos	# Si a7 es mayor o igual a cero, se repite el bucle colocar_discos
	
	# Revirtiendo la última acción (no deseada) del 'do while'
	addi a3, a3, -4			# Se revierte el incremento de a3 para apuntar a la última posición válida de la Torre A
	jalr zero, ra, 0			# Se realiza un salto indirecto a ra para salir de la función


hanoi:
	addi sp, sp, -4			# Se ajusta el puntero de pila (stack pointer) en 4 bytes hacia abajo
	sw ra, 0(sp)			# Se guarda el valor de ra (return address) en la posición de memoria apuntada por sp

	# if n == 1 -> saltar a n_1
	addi t0, zero, 1		# Se carga el valor 1 en t0
	lw t1, 0(a2)			# Se carga el valor de la cantidad de discos desde la dirección de memoria apuntada por a2 a t1
	beq t1, t0, n_1			# Si t1 es igual a t0, se salta a la etiqueta n_1

	### Llamada recursiva
	# n - 1
	lw t1, 0(a2)			# Se carga el valor de la cantidad de discos desde la dirección de memoria apuntada por a2 a t1
	addi t1, t1, -1			# Se decrementa t1 en 1 para calcular el valor de n - 1
	sw t1, 4(a2)			# Se guarda el valor de n - 1 en la siguiente posición del stack (a2 + 4)
	addi a2, a2, 4			# Se incrementa a2 para apuntar a la siguiente posición del stack

	# origin=origin, dest=aux, aux= dest
	add t1, zero, a4			# Se copia el valor de a4 (Torre B) a t1
	add a4, zero, a5		# Se copia el valor de a5 (Torre C) a a4 (aux)
	add a5, zero, t1		# Se copia el valor de t1 a a5 (dest)

	jal ra, hanoi			# Se realiza una llamada recursiva a la función hanoi

	# Regresar las torres al orden inicial de la llamada actual
	add t1, zero, a4			# Se copia el valor de a4 (aux) a t1
	add a4, zero, a5		# Se copia el valor de a5 (dest) a a4
	add a5, zero, t1		# Se copia el valor de t1 a a5

	# Cargar disco de origen a destino
	lw t1, 0(a3)			# Se carga el valor del disco en la posición de memoria apuntada por a3 (origen) a t1
	sw zero, 0(a3)			# Se guarda el valor cero en la posición de memoria apuntada por a3 (origen) para borrar el disco
	addi, a3, a3, -4		# Se decrementa a3 para apuntar a la siguiente posición anterior de la Torre A
	addi a5, a5, 4			# Se incrementa a5 para apuntar a la siguiente posición de la Torre C
	sw t1, 0(a5)			# Se guarda el valor del disco en la posición de memoria apuntada por a5 (destino)

	# origin=aux, dest=dest, aux=origin
	addi a2, a2, 4			# Se incrementa a2 para apuntar a la siguiente posición del stack
	add t1, zero, a3			# Se copia el valor de a3 (origen) a t1
	add a3, zero, a4		# Se copia el valor de a4 (aux) a a3 (origen)
	add a4, zero, t1		# Se copia el valor de t1 a a4 (aux)

	jal ra, hanoi			# Se realiza una llamada recursiva a la función hanoi

	# Regresar las torres al orden inicial de la llamada actual
	add t1, zero, a3			# Se copia el valor de a3 (origen) a t1
	add a3, zero, a4		# Se copia el valor de a4 (aux) a a3 (origen)
	add a4, zero, t1		# Se copia el valor de t1 a a4 (aux)
	jal ra, hanoi_fin		# Se salta a la etiqueta hanoi_fin para finalizar la llamada recursiva

n_1:	
	# Cargamos disco de destino a origen
	lw t1, 0(a3)			# Se carga el valor del disco en la posición de memoria apuntada por a3 (destino) a t1
	sw zero, 0(a3)			# Se guarda el valor cero en la posición de memoria apuntada por a3 (destino) para borrar el disco
	addi, a3, a3, -4		# Se decrementa a3 para apuntar a la siguiente posición anterior de la Torre A
	addi a5, a5, 4			# Se incrementa a5 para apuntar a la siguiente posición de la Torre C
	sw t1, 0(a5)			# Se guarda el valor del disco en la posición de memoria apuntada por a5 (origen)

hanoi_fin:
	# Recuperando referencia a N anterior
	addi a2, a2, -4			# Se decrementa a2 para apuntar a la posición anterior del stack
	lw ra, 0(sp)			# Se carga el valor de ra desde la posición de memoria apuntada por sp a ra
	addi sp, sp, 4			# Se incrementa el puntero de pila (stack pointer) en 4 bytes para liberar el espacio
	jalr zero, ra, 0			# Se realiza un salto indirecto a ra para salir de la función

fin:						# Etiqueta para finalizar el programa
