.data
tab:	.asciiz		"\t"
.globl main
.text

main:
	li $v0, 5					#read n
	syscall
	move $s0, $v0				#store it in s0
	sll $a0, $s0, 2				#find size of needed array
	li $v0, 9					#allocate memory
	syscall
	move $s1, $v0				#take allocated address and save it in s1 and s3
	move $s3, $v0
	li $t0, 0					#some count variables
	li $t1, 0
	li $s2, 0
loop:
	beq $t0, $s0, print			#to save sum in memory location
	li $v0, 5					#read int syscall code
	syscall
	add $s2, $s2, $v0			#adding new element to previous sum
	sw $s2, 0($s1)				#save it at address pointed by s1
	addi $t0, $t0, 1 			#update counter registers
	addi $s1, $s1, 4
	j loop
print:
	beq $t1, $s0, exit			#to print cumulative sum
	lw $s2, 0($s3)				#get element at address pointed by s3
	addi $s3, $s3, 4			#update counters
	addi $t1, $t1, 1
	move $a0, $s2
	li $v0, 1 					#print int syscall code
	syscall
	la $a0, tab
	li $v0, 4					#print string syscall code
	syscall
	j print
exit:
	li $v0, 10					#exit syscall code
	syscall