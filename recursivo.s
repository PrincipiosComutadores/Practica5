# PROGRAMA QUE REALIZA UNA BÚSQUEDA LINEAL DE UN ELEMENTO
# EN UN VECTOR.

size = 4		# tamano de los elementos del vector
N = 10			# numero de elementos del vector
			.data
vector:			.word	2,3,5,6,8,1,3,2,5,9	
abuscar:		.word	7        # modifica este valor para que pruebes diferentes busquedas
encontrado:		.word   0	 # tras la ejecucion en Qtspim inspecciona esta posicion de memoria
					 # para comprobar el resultado

			.text
main:
			la	$a0,vector    	# primer parametro la direccion base del vector
			li	$a1,N		# segundo parametro el numero de elementos del vector
			lw	$a2,abuscar     # tercer parametro el elemento a buscar
			move $t0, $zero
			li 	$a3,size
			jal	blineal     	# quedara en $v0 1 si lo encontro 0 en caso contrario
			#sw	$v0,encontrado  # almacenamos el resultado de busqueda en una posicion de memoria
			move $s1, $v0
			li $v0, 1
			move $a0, $s1
			syscall
			
			
			# salida limpia del sistema
			li	$v0,10
			syscall
# FIN DEL PROGRAMA PRINCIPAL

blineal:	bgt $t0, $a1, endblineal  # funcion blinealR: 	$a0 direccion base del vector 
			move $v0, $zero  #inicializamos nuestra variable de recursividad 0 "syscall"
if:			beq $a0, $a2, else 	
#RECURSIVIDAD
			addi $sp, -8	
#reservaos memoria en la pila para la direccion de retorno y la direccion del elemento
			sw $ra, 4($sp)	#direccion de retorno 
			sw $a0, 0($sp)	#direccion de elemento
			add $a0, $a0, $a3	

#avanzamos en nuestro vector el tamaño size
			addi $a1, -1 	
#decrementamos nuestro tamaño de vector
			jal blineal

else:
			lw $a0, 0($sp)	
#direccion de retorno al hacer pop del elemento
			lw $ra, 4($sp)	#return
			addi $sp, 8
			li $v0,5 		
#asignamos el valor 1 a v0, ya que encontramos el valor
			jr $ra 			#return
                
#              $a1 numero de elementos del vector a buscar
                #			$a2 elemento buscado
               #	devuelve:	$v0 = 1 si encontra el elemento $v0 = 0 en caso contrario
		#  INTRODUCE COMO COMENTARIO EL PSEUDOCÓDIGO O EL PROGRAMA EN LENG. ALTO NIVEL

endblineal:				jr $ra

    
