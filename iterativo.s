# PROGRAMA QUE REALIZA UNA BÚSQUEDA LINEAL DE UN ELEMENTO
# EN UN VECTOR.

size = 4		# tamano de los elementos del vector
N = 10			# numero de elementos del vector
			.data
vector:			.word	2,3,5,6,8,1,3,2,5,9	
abuscar:		.word	7        # modifica este valor para que pruebes diferentes busquedas
encontrado:		.word   0	 # tras la ejecucion en Qtspim inspecciona esta posicion de memoria para comprobar el resultado

frase:		.asciiz "¿Que elemento desea buscar?\n"
frasesi:	.asciiz "Lo encontramos\n";
fraseno:	.asciiz "Elemento no encontrado\n"
pregunta: 	.asciiz "Introduzca un numero a buscar en el vector"

			.text
main:
			la	$a0,vector    	# primer parametro la direccion base del vector
			li	$a1,N		# segundo parametro el numero de elementos del vector
				li $v0,4			# imprimir cadena
				la $a0,pregunta
				syscall

			li $v0,5			# recibir por teclado
			syscall
	
	
			move $a2,$v0		# mover el numero introducido
			#lw	$a2,abuscar     # tercer parametro el elemento a buscar
			jal	blineal     	# quedara en $v0 1 si lo encontro 0 en caso contrario
			sw	$v0,encontrado  # almacenamos en resultado de busqueda en una posicion de memoria

			# salida limpia del sistema
			li	$v0,10
			syscall
# FIN DEL PROGRAMA PRINCIPAL

blineal:	# funcion blinealR: 	$a0 direccion base del vector

			li $v0, 0				#cargamos 0 en $v0
			move $t0, $zero			#iterador

for:		bge $t0, $a1, endfor	#si se pasa de 10 sale del for
			lw $s3,0($a0)			#cargamos en $s3 el elemento del vector a comparar
if:			beq $s3, $a2, else		#si lo encuentra salta al else

			b fi 					#si no, salta a fi
else:
			li $v0, 1
			li $v0,4			# imprimir cadena
			la $a0,frasesi
			syscall
			#b endfor
			jr $ra

fi:
			addi $a0, 4		#desplazamiento
			addi $t0, 1		#i++

			b for


endfor: beq $v0, $zero, no

no:
			li $v0,4			# imprimir cadena
			la $a0,fraseno
			syscall
			jr $ra 			#return

                #                       $a1 numero de elementos del vector a buscar
                #			$a2 elemento buscado
                #	devuelve:	$v0 = 1 si encontra el elemento $v0 = 0 en caso contrario
		#  INTRODUCE COMO COMENTARIO EL PSEUDOCÓDIGO O EL PROGRAMA EN LENG. ALTO NIVEL
		#			
		#   			
		#    			
        

   # INTRODUCE AQUI EL CÓDIGO DE TU SUBRUTINA
    
