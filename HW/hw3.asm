# Author:	Brent Son
# Date:		July 11, 2021
# Description:	Homework #3: Find 2D array content by row/col

.data
askrow:	.asciiz	"Enter row in the range [0..2]: "
askcol:	.asciiz	"Enter column in the range [0..4]: "
rowcol: .asciiz "row and column value: "
print:	.asciiz	"array[row][col] = "
statement: .asciiz "Array Address: "

rowsize: .word 3

colsize: .word 5

# array oinitialization
array:
	.word	  1, 2, 3, 4, 5
	.word	  6, 7, 8, 9,10
	.word	  11,12,13,14,15

.text

main: 
	#Prompt asking for row value
	li $v0, 4
	la $a0, askrow
	syscall
	
	#Input row value
	li $v0, 5
	syscall
	move $t0, $v0
	
	#Prompt asking for column value
	li $v0, 4
	la $a0, askcol
	syscall
	
	#Input column value
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Output row and column value
	#li $v0, 4
	#la $a0, rowcol
	#syscall
	
	#li $v0, 1
	#la $a0, ($t0)
	#syscall
	
	#li $v0, 1
	#la $a0, ($t1)
	#syscall
	
	#statement before value
	li $v0, 4
	la $a0, statement
	syscall
	
	#Argumants and Function Call
	la $a0, array
	move $a1, $t0	#row value
	move $a2, $t1	#col value
	li $a3, 5
	jal arrAddress
	
	#print address
	#move $a0, $v0
	li $v0, 1
	syscall
	
	
	#Terminate Program
	li $v0, 10
	syscall

arrAddress:
	#Finding the address of the given row/col value
	addi $t2, $zero, 0	#row index
	addi $t3, $zero, 0	#column index
	blt $t2, $a1, rowLoop
	blt $t3, $a2, colLoop
	
	
	rowLoop:
		blt $t3, $a2, colLoop
		#addi $t2, $t2, 1
		j return
		
	colLoop:
		sll $a0, $a0, 2
		addi $t3, $t3, 1
		blt $t3, $a2, colLoop
		addi $t3, $zero, 0
		addi $t2, $t2, 1
		blt $t2, $a1, rowLoop
	
	return:	
	jr $ra
			  
		
			 
	
	
