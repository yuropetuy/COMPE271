	.text
	
	.globl main
	
main:	

	li $v0, 4
	la $a0, txt
	syscall
	
	li $v0,10
	
	.data
txt:	
	.asciiz "Hello Brent!\n"