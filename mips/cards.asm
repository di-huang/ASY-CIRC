.data
error_string: .asciiz "Error: not enough arguments!\n"
newline: .asciiz "\n"

.text
main:
	# First card is stored in $t0 as an integer
	li $v0, 5
	syscall
	move $t0, $v0
	andi $t2, $t0, 3 # suit of first card stored in $t2
	
	# Second card is stored in $t1 as an integer
	li $v0, 5
	syscall
	move $t1, $v0
	andi $t3, $t1, 3 # suit of second card stored in $t3
	
	# $s0 holds the integer 1 if the cards were the same suit 
	# and integer 0 if the cards were different suits.
	bne $t2, $t3, exit
	li $s0, 1
exit:   li $v0, 10 # exit cleanly
	syscall
