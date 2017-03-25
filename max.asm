.data
.globl main
.text

main:
	li $v0, 5			#scanning n
	syscall
	move $s0, $v0		#store it in register s0
	li $t0, 0
findMax:
	li $v0, 5			#scanning first element
	syscall
	move $s1, $v0		#assuming first element is maximum and comparing incoming elements with it
	addi $t0, $t0, 1 	
loop:
	beq $t0, $s0, print	#loop for incoming elements and comparision
	li $v0, 5			#syscode for read int
	syscall
	sub $t1, $v0, $s1	#if new element - existing max > 0, then the incoming element is bigger 
	addi $t0, $t0, 1 	#update counter
	bgtz $t1, swap		#if incoming element is bigger, update existing max
return:
	j loop
swap:
	move $s1, $v0	#part where swapping of incoming element and existing max takes place
	j return
print:
	move $a0, $s1	#print the max num
	li $v0, 1
	syscall
	li $v0, 10		#syscode for exit
	syscall
