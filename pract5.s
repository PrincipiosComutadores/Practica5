#******************************************************************************

# PRACTICA 5 DE PRINCIPIO DE COMPUTADORES



# AUTOR: Lorenzo Martín Álvarez


# GRUPO: Tarde, L14


#******************************************************************************


size = 4  # Constante que nos dice la distancia entre los elementos del vector, o lo q es o mismo
          
# que cada uno ocupa 4 bytes de espacio


#******************************************************************************



.data

   

vector1:  .word 2,3,5,6,8,1,3,2,5,9
  
   
cad1: .asciiz "                                         ---  PRACTICA 5 DE PRINCIPIO DE COMPUTADORES  --- \n";
   
cad2: .asciiz "     SUMA DE LOS ELEMENTOS DE UN VECTOR RECUSIVAMENTE \n";
   
cad3: .asciiz " Vector:    \n";
   
cad4: .asciiz " Resultado de la suma:  ";
   
cadx: .asciiz "\n";


#******************************************************************************



.text

   

		main:               
# Cargo el encabezado del programa
     
      
li $v0,4
      
la $a0,cad1
     
 syscall
      
li $v0,4
      
la $a0,cadx
     
 syscall
      
li $v0,4
      
la $a0,cad2
      
syscall
      
li $v0,4
      
la $a0,cadx
      
syscall
      
li $v0,4
      
la $a0,cad3
      
syscall
      
li $v0,4
     
 la $a0,cadx
      
syscall


#******************************************************************************

      
la $a2,vector1      # $a0 direccion del vector
      
li $a1,10            # Numero total de elementos que contiene el vector, en este caso 10
      
move $s2,$zero
      
li $s2,0
      
li $s3,size
      
li $s4,1


#****************************************************************************** 

   
bucle:              # En este bucle muestro el vector

     
 
mul $t1,$s2,$s3
      
addu $t1,$a2,$t1
      
lw $t2,0($t1)
   
      
li $v0,1
      
move $a0,$t2
      
syscall 

      
addi $s4,$s4,1
     
 addi $s2,$s2,1
 
      
ble $s4,$a1,bucle
      
li $v0,4
      
la $a0,cadx
      
syscall


#****************************************************************************** 
 
                         

 # En esta parte salto al programa recursivo:suma
      

jal suma            # quedara en $v0 el resultado de la suma
      
move $s1,$v0        # Como al acabar el subprograma el resultado esta el $v0, lo paso a $s1, para guardarlo y usar
                          
# $v0 para otras cosas
     

#****************************************************************************** 

      
li $v0,4           # Muestro el resultado de la suma
      
la $a0,cadx
      
syscall
      
li $v0,4
      
la $a0,cad4
      
syscall      

     
 li $v0,1
     
 move $a0,$s1
      
syscall
     
 
#******************************************************************************

      
li $v0,10  
# Salida limpia del sistema
     
 syscall


#******************************************************************************

   
suma:                     
							# En esta parte esta el subprograma recursivo, compuesto de suma yd dentro de suma esta 
                             
							# bucle, que es el realiza la recursividad.

      
bgt $a1,$zero,bucle    
							# El subprograma lo q hace es moverse desde la 1º posicion del vector hasta la ultima
                            
 							# guardando en cada iteracion la instruccion de retorno, y la direccion del elemento anterior
                             
							# Para controlar las iteraciones esta el registro $a1, que contiene el numeo de elementos del
                            
							# vector, partiendo de un valor = 10, que es el numero de elementos del vector, e ira 
                             
							# decreciendo inversamente proporcional a lo que lo hace el puntero en el vector, es decir
                             
							# cuando $a1 = 0, $a2, tendra la direccion del ultimo elemento, con lo que ahora lo unico
                            
							# es volver para atras, puesto que tenemos guardadas las direcciones de todos los elementos 
                             
							# y la direccion de retorno para volver a ellos. Hacemos esto y los sumamos

 jr,$ra

   

bucle:
      
      

move  $v0,$zero  

-----puuush 
      
addi $sp,$sp,-8       	# Reservo memoria para almacenar 8 bytes, la direccion de retorno y la direccion de los 
                            
			# elementos
      
sw $ra,4($sp)	
      direccion de retorno
sw $a2,0($sp)
      
      direccion de elemento
addi $a2,$a2,size    	 # Sumo 4 bytes a la direccion actual para acceder al siguiente elemento, y 
                           
 			# acutalizo el contador
      

addi $a1,$a1,-1
      

jal suma
       
      
-------pop
lw $a2,0($sp)         # Ahora retrocedo por la pila, liberando a su vez la memoria 
      
lw $ra,4($sp)
      
addi $sp,$sp,8

      
lw $t2,0($a2)
      
add $v0,$t2,$v0
   
      
jr $ra


