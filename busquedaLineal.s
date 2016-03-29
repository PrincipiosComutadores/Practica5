# PROGRAMA QUE REALIZA UNA BÚSQUEDA LINEAL DE UN ELEMENTO

# EN UN VECTOR.


size = 4	# tamano de los elementos del vector

N = 10		# numero de elementos del vector
			

.data


vector:			.word	2,3,5,6,8,1,3,2,5,9	

abuscar:		.word	7        # modifica este valor para que pruebes diferentes busquedas

encontrado:		.word   0	 # tras la ejecucion en Qtspim inspecciona esta posicion de memoria
	
n:			.asciiz "\n";				

 # para comprobar el resultado

			


.text

		main:


			
la	$a0,vector    	# primer parametro la direccion base del vector
			
li	$a1,N		# segundo parametro el numero de elementos del vector
			
lw	$a2,abuscar     # tercer parametro el elemento a buscar

			
jal	blineal     	# quedara en $v0 1 si lo encontro 0 en caso contrario
			
move $t2,$v0
li $v0,1
move $a0,$t2
syscall
#sw	$v0,encontrado  # almacenamos en resultado de busqueda en una posicion de memoria
	
		
			


# salida limpia del sistema
			
li	$v0,10
			
syscall



# FIN DEL PROGRAMA PRINCIPAL


blineal:	bne $a1,$zero,mayorquecero		#si nuestro tamaño no es >= a 0 retornamos v0=0
		move $v0,$zero
#..MODIFICACION
		move $t5,$a0
		move $t6,$v0
		li $v0,1
		move $a0,$ra
		syscall
		li $v0,4
		la $a0,n
		syscall
		move $a0,$t5
		move $v0,$t6
#..MODIFICACION
		jr $ra
mayorquecero:						
		lw $t0,0($a0)		#cargamos en t0 el elemento del vector a comparar
		bne $a2,$t0,diferentes	#si nuestro elemento es distinto salta a diferente

	
		li $v0,1		# como nuestro elemento es igual v0=1 y retornamos
#..MODIFICACION
		move $t5,$a0
		move $t6,$v0
		li $v0,1
		move $a0,$ra
		syscall
		li $v0,4
		la $a0,n
		syscall
		move $a0,$t5
		move $v0,$t6
#..MODIFICACION
		jr $ra


diferentes:	addi $sp, -8	#reservamos memoria en la pila para la direccion de retorno y la direccion del elemento
		sw $ra, 4($sp)	#direccion de retorno 
		sw $a0, 0($sp)	#direccion de elemento
		addi $a0, $a0, 4	#avanzamos en nuestro vector el tamaño size
		addi $a1, -1 	#decrementamos nuestro tamaño de vector
			
		jal blineal	
			

		lw $a0, 0($sp)	#direccion de retorno al hacer pop del elemento
		lw $ra, 4($sp)	#return
		addi $sp, 8
#..MODIFICACION
		move $t5,$a0
		move $t6,$v0
		li $v0,1
		move $a0,$ra
		syscall
		li $v0,4
		la $a0,n
		syscall
		move $a0,$t5
		move $v0,$t6
#..MODIFICACION
		jr $ra



		# funcion blinealR: 	$a0 direccion base del vector
                
		#                       $a1 numero de elementos del vector a buscar
                
		#			$a2 elemento buscado
                
		#	devuelve:	$v0 = 1 si encontra el elemento $v0 = 0 en caso contrario
		
		#  INTRODUCE COMO COMENTARIO EL PSEUDOCÓDIGO O EL PROGRAMA EN LENG. ALTO NIVEL
		
		#			
		#   			
		#    			
        

   


# INTRODUCE AQUI EL CÓDIGO DE TU SUBRUTINA
    
#abuscar(int* vector ,int N,int a_buscar){
#int pos=0;
#if(n==0)return 0;
#else{
#if(vector[pos]==a_buscar)
#return 1;
#else 
#abuscar(vector[pos++],N-1,a-buscar);
#}