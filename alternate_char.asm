.data
string:	.space 100				#assuming string max size would be 99

.text
main:	la $a0,string
	li $a1,100
	li $v0,8
	syscall
	la $t1,string				#saving address in t1, t2
	la $t2,string
	li $s0,90
	li $s1,97
	li $s3,32
	
length:	lb $t3,($t2)
	beqz $t3,init
	addi $t2,$t2,1
	b length
	
init:	move $t3,$t1
	addi $t2,$t2,-2
	
proc:	bgt $t3,$t2,print		#to check is string remains
	lb $t4,($t3)
	beq $t4,$s3,noop
	ble $t4,$s0,tolow
	bge $t4,$s1,tohigh
	b proc
	
tolow:addi $t4,$t4,32 			#change it to lower
	sb $t4,($t3)
	addi $t3,$t3,2
	b proc
	
tohigh:addi $t4,$t4,-32			#change it to upper case
	sb $t4,($t3)
	addi $t3,$t3,2
	b proc
	
noop:	addi $t3,$t3,2
	b proc
	
print:	move $a0,$t1
	li $v0,4
	syscall
	li $v0,10
	syscall
	