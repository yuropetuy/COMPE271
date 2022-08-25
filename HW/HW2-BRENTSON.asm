	.text
	
	.globl main
	
main:
	#ask user to input age
	li $v0, 4
	la $a0, inputNum
	syscall
	
	#input and store user input
	li $v0, 5
	syscall
	move $t0, $v0
	
	#multiply value by 8
	li $t2, 8
	mul $t1, $t0, $t2
	
	#output name and REDID
	li $v0, 4
	la $a0, name
	syscall
	
	#output statement before integer
	li $v0, 4
	la $a0, statement
	syscall
	 
	#output integer
	li $v0, 1
	move $a0, $t1
	syscall
	
	.data
	
inputNum:
	.asciiz "Please input a number:\n"
	
name:
	.asciiz "Brent Son\n827108705\n"
	
statement:
	.asciiz "The integer shifted to the equivalent of being multiplied by 8 is: "