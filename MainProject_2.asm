#Author: Brent Son
#Professor: Ken Arnold
#Class: COMPE271
#Project: The 405

.data

#16 x 8 grid for the playArea
frameBuffer:	.space 8192	#for the bit display map
xPos:		.word 8
yPos:		.word 4
obxPos:		.word 0
obyPos:		.word 0
yMult:		.word 64
xMult:		.word 4
health:		.word 5

startGame:	.asciiz "\nGame Start\n"
endGame:	.asciiz "\nGame Over\n"
three:		.asciiz "3\n"
two:		.asciiz "2\n"
one:		.asciiz "1\n"
go:		.asciiz "Go!!\n"
hitSound:		.asciiz "\nHIT!!!\n"
crashSound:		.asciiz "\nCRASH!!!\n"
crackSound:		.asciiz "\nCRACK!!!\n"
bamSound:		.asciiz "\nBAM!!!\n"
healthPrompt:		.asciiz "/5\n"
healthWord:		.asciiz "Health:"


.text
main:
	li $v0, 4
	la $a0, startGame
	syscall
	
	li $v0, 32
	li $a0, 1000
	syscall
	
	li $v0, 4
	la $a0, three
	syscall
	
	li $v0, 32
	li $a0, 1000
	syscall
	
	li $v0, 4
	la $a0, two
	syscall
	
	li $v0, 32
	li $a0, 1000
	syscall
	
	li $v0, 4
	la $a0, one
	syscall
	
	li $v0, 32
	li $a0, 1000
	syscall
	
	li $v0, 4
	la $a0, go
	syscall
	
	la $t0, frameBuffer	
	li $t1, 128
	li $t2, 0x00333333
		
background:			
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	subi $t1, $t1, 1
	bne $t1, $zero, background	#generating the gray backgroud for bitmap
	
generateCar:
	lw $t1, xPos		#position of front half of car
	lw $t2, yPos
	lw $t3, xMult
	lw $t4, yMult
	
	li $t5, 0x000004fe 	#color of car
	
	mul $t2, $t2, $t4
	mul $t1, $t1, $t3
	
	add $t1, $t1, $t2
	
	sw $t5, frameBuffer($t1)
	
	add $t1 $t1,$t4
	sw $t5, frameBuffer($t1)
	
generateObstacle:
	addi $t8, $zero, 0x12322475
	jal lfsr
	
	rem $t7, $t7, 13
	addi $t7, $t7, 1
	
	sw $t7, obxPos
	
	la $a0, frameBuffer
	lw $t0, obxPos
	lw $t1, obyPos
	lw $t4, xMult
	lw $t5, yMult
	
	li $t6, 0xfff00000	#color of obstacles
	
	mul $t0, $t0, $t4
	mul $t1, $t1, $t5
	add $t0, $t0, $t1
	
	sw $t6, frameBuffer($t0)
	
	
gameLoop:

	li $v0, 32
	li $a0, 55
	syscall
	
	#lw $t3, 0xffff0004	#using keyboard sim tool for input for continous input
	
	jal obstacleUpdate
	
	jal collisionCheck
	
	li $v0, 12
	syscall
	move $t3, $v0
	
	
	
	beq $t3, 112, gameEnd
	beq $t3, 119, moveUp
	beq $t3, 100, moveRight
	beq $t3, 97, moveLeft
	beq $t3, 115, moveDown
	
	j gameLoop
	
gameEnd:
	li $v0, 4
	la $a0, endGame
	syscall
	
	li $v0, 10
	syscall
	
moveUp:
	la $a0, frameBuffer
	addi $s0, $zero, 0
	lw $t0, xPos
	lw $t1, yPos
	lw $t3, xMult
	lw $t4, yMult
	
	li $t5, 0x000004fe	#car color
	li $t6, 0x00333333	#floor color
	
	sub $t1, $t1, 1
	sw $t1, yPos
	
	mul $t0, $t0, $t3
	mul $t1, $t1, $t4
	
	add $s0, $t0, $t1
	
	sw $t5, frameBuffer($s0)
	
	add $s0, $s0, $t4
	add $s0, $s0, $t4
	
	sw $t6, frameBuffer($s0)
	
	j gameLoop
	
moveDown:
	la $a0, frameBuffer
	addi $s0, $zero, 0
	lw $t0, xPos
	lw $t1, yPos
	lw $t3, xMult
	lw $t4, yMult
	
	li $t5, 0x000004fe	#car color
	li $t6, 0x00333333	#floor color
	
	add $t1, $t1, 1
	sw $t1, yPos
	
	mul $t0, $t0, $t3
	mul $t1, $t1, $t4
	
	add $s0, $t0, $t1
	
	sub $s0, $s0, $t4
	sw $t6, frameBuffer($s0)
	
	add $s0, $s0, $t4
	add $s0, $s0, $t4
	sw $t5, frameBuffer($s0)
	
	 j gameLoop
	 
moveLeft:
	la $a0, frameBuffer
	addi $s0, $zero, 0
	lw $t0, xPos
	lw $t1, yPos
	lw $t3, xMult
	lw $t4, yMult
	
	li $t5, 0x000004fe	#car color
	li $t6, 0x00333333	#floor color
	
	sub $t0, $t0, 1
	sw $t0, xPos
	
	mul $s0, $t0, $t3
	mul $s1, $t1, $t4
	
	add $s0, $s0, $s1
	sw $t5, frameBuffer($s0)
	
	add $s0, $s0, $t4
	sw $t5, frameBuffer($s0)
	
	add $s0, $s0, $t3
	sw $t6, frameBuffer($s0)
	
	sub $s0, $s0, $t4
	sw $t6, frameBuffer($s0)
	
	j gameLoop
	
moveRight:
	la $a0, frameBuffer
	addi $s0, $zero, 0
	lw $t0, xPos
	lw $t1, yPos
	lw $t3, xMult
	lw $t4, yMult
	
	li $t5, 0x000004fe	#car color
	li $t6, 0x00333333	#floor color
	
	add $t0, $t0, 1
	sw $t0, xPos
	
	mul $s0, $t0, $t3
	mul $s1, $t1, $t4
	
	add $s0, $s0, $s1
	sw $t5, frameBuffer($s0)
	
	add $s0, $s0, $t4
	sw $t5, frameBuffer($s0)
	
	sub $s0, $s0, $t3
	sw $t6, frameBuffer($s0)
	
	sub $s0, $s0, $t4
	sw $t6, frameBuffer($s0)
	
	j gameLoop
	
lfsr:
	#bit counter for random value gneneration
	addi $s3, $zero, 0
	addi $t7, $zero, 0
	
	j bitLoop
	
bitLoop:
	
	#tap values: 3,9,12
	srl $s4, $t8, 9
	andi $s4, $s4, 1
	
	srl $s5, $t8, 3
	andi $s5, $s5, 1
	
	srl $s6, $t8, 12
	andi $s6, $s6, 1
	
	xor $s4, $s4, $s5
	xor $s4, $s4, $s6
	
	#creating new seed
	srl $t8, $t8, 1
	sll $s5, $s4, 31
	or $t8, $t8, $s5
	
	#outputting random bit val
	or $t7, $t7, $s4
	sll $t7, $t7, 1
	
	#counter iteration
	addi $s3, $s3, 1
	blt $s3, 16, bitLoop
	
	jr $ra
	
obstacleUpdate:
	#two conditions: moveDown or reset at the top
	
	#if obstacle position is greather than last value in framebuffer: moveDown
	
	#if obstacle position is less than last value in frameBuffer array: reset
	
	la $a0, frameBuffer
	lw $t0, obxPos
	lw $t1, obyPos
	lw $t3, xMult
	lw $t4, yMult
	
	mul $t0, $t0, $t3	#position of obstacle
	mul $t1, $t1, $t4
	add $t0, $t1, $t1
	add $a1, $a0, $t0
	
	addi $s0, $zero, 14
	mul $s0, $s0, $t4
	add $a2, $a0, $s0
	
	#ble $t0, $s1, firstRowDown
	
	ble $a1, $a2, rowDown
	
	bgt $a1, $a2, reset
		
rowDown:
	la $a0, frameBuffer
	lw $t0, obxPos
	lw $t1, obyPos
	lw $t3, xMult
	lw $t4, yMult
	
	li $t5, 0xfff00000	#red color
	li $t6, 0x00333333	#floor color
	
	addi $t1, $t1, 1
	sw $t1, obyPos
	
	mul $t0, $t0, $t3
	mul $t1, $t1, $t4
	add $t0, $t0, $t1
	
	sw $t5, frameBuffer($t0)
	
	sub $t0, $t0, $t4
	sub $t0, $t0, $t4
	
	sw $t6, frameBuffer($t0)
	
	jr $ra
	
reset:
	lw $a0, frameBuffer
	lw $t0, obxPos
	lw $t1, obyPos
	lw $t3, xMult
	lw $t4, yMult
	
	li $t6, 0x00333333	#floor color
	
	mul $t0, $t0, $t3
	mul $t1, $t1, $t4
	add $t0, $t0, $t1
	
	sub $t0, $t0, $t4
	
	sw $t6, frameBuffer($t0)
	
	sw $ra, -4($sp)
	
	jal lfsr
	rem $t7, $t7, 13
	addi $t7, $t7, 1
	
	sw $t7, obxPos
	
	move $t0, $t7
	
	addi $t1, $zero, 0
	sw $t1, obyPos
	
	li $t9, 0xfff00000	#red color
	
	
	mul $t0, $t0, $t3
	
	sw $t9, frameBuffer($t0)
	
	lw $ra, -4($sp)
	
	jr $ra
	
collisionCheck:
	la $a0, frameBuffer
	lw $t0, xPos
	lw $t1, yPos
	lw $t3, obxPos
	lw $t4, obyPos
	lw $t5, xMult
	lw $t6, yMult
	
	mul $s0, $t0, $t5	#position of player
	mul $t1, $t1, $t6
	add $s0, $s0, $t1
	
	add $s3, $s0, $t6	#back of player
	
	mul $s1, $t3, $t5
	mul $t4, $t4, $t6
	add $s1, $s1, $t4	#position of obstacle
	
	sub $s2, $s1, $t6	#back of obstacle
	
	beq $s0, $s1, hit
	beq $s0, $s2, crash
	beq $s3, $s1, crack
	beq $s3, $s2, bam
	
	bne $s0, $s1, return
	
return:
	jr $ra
	
hit:
	li $v0, 4
	la $a0, hitSound
	syscall
	
	j healthLoss
	
crash:
	li $v0, 4
	la $a0, crashSound
	syscall
	
	j healthLoss
	
crack:
	li $v0, 4
	la $a0, crackSound
	syscall
	
	j healthLoss
	
bam:
	li $v0, 4
	la $a0, bamSound
	syscall
	
	j healthLoss
	
healthLoss:
	lw $t0, health
	subi $t0, $t0, 1
	sw $t0, health
	
	li $v0, 4
	la $a0, healthWord
	syscall
	
	li $v0, 1
	lw $a0, health
	syscall
	
	li $v0, 4
	la $a0, healthPrompt
	syscall
	
	lw $t1, health
	beq $t1, $zero, gameEnd
	
	jr $ra

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
