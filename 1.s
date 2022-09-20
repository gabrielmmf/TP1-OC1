sequencia:
    # Inicializa registradores temporarios com imediatos
    addi x31, x0, 1
    addi x5, x0, 2
    addi x6, x0, 3
loop:
	addi x10, x10, -1
    
    # Verifica se é o último loop a ser feito
    bge x0, x10, final_loop
    
    # Se não é o último loop a ser feito e An == 1, então x11 = 0
    beq x11, x31, nmaior   
    
    # x7 armazena An/2 
    # x28 armazena 3An + 1  
    # x29 armazena resto de An/2
    div x7, x11, x5        
    mul x28, x6, x11
    addi x28, x28, 1       #
    rem x29, x11, x5       
    
    # Se An é par: x11 = x7 = An/2
    beq x29, x0, par

	# Se An é ímpar: x11 = 28 = 3An + 1
impar:
    add x11, x0, x28  
    beq x0, x0, continua 

par:
    add x11, x0, x7

continua:
	# Reinicia Loop
    beq x0, x0, loop
nmaior:
	addi x11, x0, 0

final_loop:
    addi x10, x11, 0
    addi x11, x0, 0
Exit:
