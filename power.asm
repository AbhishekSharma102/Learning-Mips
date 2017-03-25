.text

main:
	li $v0,5
	syscall
	move $s1,$v0
	li $v0,5
	syscall
	move $s2,$v0
	li $t0,2
	move $s4,$sp
	beqz $s2,zeropow

loop:
	bne $s2,1,rec
 
return1:
	move $s3,$s1
	jr $ra

rec:
	 div $s2,$t0			#if it is even or odd
	 mfhi $t1
	 mflo $s2
	 addi $sp,$sp,-8
	 sw $t1,0($sp)
	 sw $ra,4($sp)
	 jal loop
	
	 lw $t2,0($sp)
	 beqz $t2,ifzero
	 bnez $t2,ifone
	 
ifzero:
	
	mult $s3,$s3
	mflo $s3
	lw $ra,4($sp)
	addi $sp,$sp,8
	beq $sp,$s4,print
	jr $ra
	
ifone:
	mult $s3,$s3
	mflo $s3
	mult $s3,$s1
	mflo $s3
	lw $ra,4($sp)
	addi $sp,$sp,8
	beq $sp,$s4,print
	jr $ra
	
zeropow:li $s3,1
	
print:
	move $a0,$s3
	li $v0,1
	syscall
	li $v0,10
	syscall
	
