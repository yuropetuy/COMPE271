.data

label: .asciiz "Number: "
newLine: .asciiz "\n"


.text

main:
	
	#initialize starting seed
	addi $t0, $zero, 0x55AAFF00
	
	#counters
	addi $t1, $zero, 0
	addi $t2, $zero, 10
	
	#call lfsr function 10 times
	blt $t1, $t2, mainLoop
	
	mainLoop:
	bge $t1, $t2, terminate 
	
	#Output label
	addi $v0, $zero, 4
	la $a0, label
	syscall
	
	move $a1, $t0
	jal lfsr32
	addi $t1, $t1, 1
	
	addi $v0, $zero, 4
	la $a0, newLine
	syscall
	
	blt $t1, $t2, mainLoop
	
	
	#terminate program
	terminate:
	addi $v0, $zero, 10
	syscall
	
lfsr32:
	
	#counters
	addi $t3, $zero, 0
	addi $t4, $zero, 32
	addi $t9, $zero, 0
	
	#loop for bit manipulation
	blt $t3, $t4, bitLoop
	
	bitLoop:
	bge $t3, $t4, output
	
	srl $t5, $a1, 31
	andi $t5, $t5, 1 
	
	srl $t6, $a1, 30
	andi $t6, $t6, 1
	
	srl $t7, $a0, 10
	andi $t7, $t7, 1
	
	srl $t8, $a1, 0
	andi $t8, $t8, 1
	
	xor $t5, $t5, $t6
	xor $t5, $t5, $t7
	xor $t5, $t5, $t8
	
	srl $a1, $a1, 1
	sll $t6, $t5, 31
	
	or $a1, $a1, $t6
	
	add $t9, $t9, $t5
	sll $t9, $t9, 1
	
	addi $t3, $t3, 1
	blt $t3, $t4, bitLoop 
	
	#output
	output:
	addi $v0, $zero, 34
	la $a0, ($t9)
	syscall
	
	move $t0, $a1
	jr $ra
