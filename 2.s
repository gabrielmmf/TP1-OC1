    jal x1, selection_rec
    beq x0, x0, Exit

selection_rec:
    # Inicia preservando registradores salvos na pilha
    addi x2, x2, -48
    sw x9, 0(x2)
    sw x18, 4(x2)
    sw x19, 8(x2) 
    sw x20, 12(x2)
    sw x21, 16(x2)
    sw x22, 20(x2) 
    sw x23, 24(x2) 
    sw x24, 28(x2)
    sw x25, 32(x2) 
    sw x26, 36(x2) 
    sw x27, 40(x2) 
    # Preserva endereço de retorno na pilha
    sw x1, 44(x2)
    
    # Seta registrador para comparação <= 2
    addi x5, x0, 2 
    
    # Se nelem é menor que 2, retorna
    blt x11, x5, retorna
    
	# Senão, executa loop no vetor para encontrar maior elemento:
    # x7 = endereço do último elemento do array:
    slli x7, x11, 2
    addi x7, x7, -4
    add x7, x10, x7
    
    # x6 = posição do maior elemento (inicialmente = 0)
    addi x6, x0, 0
    
    # x30 = maior elemento (inicialmente o primeiro elemento)
    lw x30, 0(x10)
    
    # x31 recebe o endereço do começo do array para percorrê-lo
    addi x31, x10, 0
    # x31 avança uma posição para começar o loop
    addi x31, x31, 4
    # x29 = posição atual no loop = inicialmente 1, estamos começando a primeira iteração
    addi x29, x0, 1 
loop:
	lw x28, 0(x31) # x28 recebe o elemento atual no loop
    blt x28, x30, menor # compara elemento atual e maior elemento e pula caso o elemento atual seja menor
    
    # Senão, atualizamos maior valor encontrado, e a posição do maior valor encontrado
maior:
	addi x30, x28, 0 # atualiza x30, que guarda maior valor encontrado
    addi x6, x29, 0 # atualiza posição do maior elemento
    addi x29, x29, 1 # incrementa posição atual no array
    addi x31, x31, 4 # avança uma posição no loop
    bge x7, x31, loop # continua loop se ainda não é final do array
    beq x0, x0, swap # se já comparou todo array, executa swap
menor:
    addi x29, x29, 1 # incrementa indicador da posição atual
    addi x31, x31, 4 # avança uma posição no loop
    bge x7, x31, loop # continua loop se ainda não é final do array
swap:
	# x9 recebe endereço do maior valor do array
	slli x6, x6, 2
    add x9, x10, x6 
    
    # x18 recebe o último valor do array
    lw x18, 0(x7)
    
    # x19 recebe maior valor encontrado no array
    lw x19, 0(x9)
    
    # executa swap do maior elemento com o último elemento
    sw x19, 0(x7)
    sw x18, 0(x9)
    
    # decrementa o número de elementos 
    addi x11, x11, -1
    
	# executa o procedimento recursivamente para array[nelem-1]
    jal x1, selection_rec
retorna:
	# Restaura registradores salvos e endereço de retorno e retorna
    lw x9, 0(x2)
    lw x18, 4(x2)
    lw x19, 8(x2) 
    lw x20, 12(x2) 
    lw x21, 16(x2) 
    lw x22, 20(x2) 
    lw x23, 24(x2)
    lw x24, 28(x2)
    lw x25, 32(x2) 
    lw x26, 36(x2) 
    lw x27, 40(x2)
    lw x1, 44(x2)
    addi x2, x2, 48    
    jalr x0, 0(x1)
Exit:
