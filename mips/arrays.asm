.data
error_string: .asciiz "Error: invalid argu!\n"

.text
main:
	blt $a0,3,error
	addiu $s0, $a0, -1   
	divu  $s0, $s0, 2
	move  $t9, $s0
	sll   $t8, $t9, 2
	sll   $t7, $t9, 3
	li $v0, 9
	move $a0, $t7   # sbrk 4*num * 2 bytes
	syscall         
	move $s1, $v0
	addu $s2, $s1, $t8         
	move  $s3, $s1
charloop1:
	lw $t0, 0($a1) 
	lb $t1, 0($t0)  
	addiu $t1,$t1,-48   
	sw    $t1, 0($s3)
	addiu $s3, $s3, 4
	addiu $t9, $t9, -1
	addiu $a1, $a1, 4
	bgt $t9, $zero, charloop1

	lw $t0, 0($a1)      
	lb $t1, 0($t0)
	bne $t1,88,error
	addiu $a1, $a1, 4   
	move $t9, $s0
charloop2:
	lw $t0, 0($a1)  
	lb $t1, 0($t0)  
	addiu $t1,$t1,-48   
	sw    $t1, 0($s3)
	addiu $s3, $s3, 4
	addiu $t9, $t9, -1
	addiu $a1, $a1, 4
	bgt $t9, $zero, charloop2
	
	move $t9, $s0
	move $s3, $s1
	move $s4, $s2
myloop: 
	lw $t2, 0($s3)
	lw $t3, 0($s4)
	addu $t2, $t2, $t3
	sw $t2, 0($s3)
	addiu $s3, $s3, 4
	addiu $s4, $s4, 4
	addiu $t9, $t9, -1
	bgt $t9, $zero, myloop
	
error:
	la $a0, error_string
	li $v0, 4
	syscall
	j exit
	
exit:
	li $v0, 10	# clean & exit
	syscall	
