# MIPS Program to find the minimum (or maximum) element of an array
# author: Keshan M.W.M.
# https://github.com/keshan99
#------------------------------------------------- 
#Data Declarations

.data

tabMsg: 	.asciiz "\t"
newlineMsg: .asciiz "\n"
A: 	.word 1, 2, 3, 4, 5
n: 	.word 5

#------------------------------------------------ 
.globl main

#text/code section
.text

# Your code

printTriangle:
	# a0 = array address	,	a1 = n 
	add		$t0, $a1, $zero		# $t0 = $a1 + $zero
	
	

	addi	$sp, $sp, -4			# $sp = $sp + -4
	sw		$ra, 0($sp)				# save $ra to stack 



	#    if (n = 0) return;
	addi	$t1, $zero, 0			# $t1 =  0
	bne		$t1, $t0, continue		# if $t1 != $t0 then continue, otherwise return
		add		$a1, $a1, 1			# $a0 = $a1 + 1
		lw		$ra, 0($sp)			# Restore anything saved in stack
		addi	$sp, $sp, 4			# Pop items to restore stack
		jr		$ra					# jump to $ra

	#    if (n >= 1) continue;	
	continue:
	addi	$sp, $sp, -4			# $sp = $sp + -4
	sw		$a0, 0($sp)				# save A address to stack 

	# the space that aquired from stack for creating temp array(5 word)
	addi	$sp, $sp, -20			# $sp = $sp + -20			,temp[5]

	addi	$t1, $t0, -1			# $t1 = $t0 + -1			($t1 = n -1) 
	addi	$t2, $zero, 0			# $t2 = 0					i = 0
	forLoop1:
	beq		$t2, $t1, exitLoop1		# if $t2 == $t1 then exitLoop

	sll		$t3, $t2, 2				# $t3 = i*4
	add		$t3, $a0, $t3			# $t3 = $sp + $t2			, $t3 = A[i] address

	lw		$t4, 0($t3)				# $t4 = A[i]
	lw		$t5, 4($t3)				# $t5 = A[i+1]
	add		$t5, $t5, $t4			# $t5 = $t4 + $t5			, $t5 = A[i] + A[i+1]
	
	sll		$t3, $t2, 2			# $t3 = i*4
	add		$t4, $sp, $t3		# $t3 = $sp + $t2				, temp[i] address
	sw		$t5, 0($t4)			# temp[i] = x
	addi	$t2, $t2, 1			# $t2 = $t2 + 1					i ++
	j		forLoop1			# jump to forLoop1
	
	exitLoop1:
	
	add		$a0, $sp, $zero			# $a0 = $t0 		pass A address
	addi	$a1, $a1, -1			# $a1 = $a1 - 1		pass n-1 

	jal		printTriangle				# jump to printTriangle and save position to $ra
	

	addi	$t1, $a1, 0				# $t1 = $t0 + 0			($t1 = n ) 
	addi	$t2, $zero, 0			# $t2 = 0					i = 0
	forLoop2:
	beq		$t2, $t1, exitLoop2		# if $t2 == $t1 (i == n) then exitLoop2
	addi	$t4, $sp, 20			# get previace arr address
	
	add		$t3, $zero, $t4			# $t3 =  $sp			, temp[i] address

	lw		$t3, 0($t3)				# $t3 = temp[i]				, find A[] address
	sll		$t4, $t2, 2				# $t3 = i*4					, for get i address
	add		$t3, $t3, $t4			# $t3 = $t3 + $sp			, temp[i] address
	lw		$t3, 0($t3)				# $t3 = temp[i]				, temp[i] value

	addi $v0,$zero,1			# Code for print integer
	add $a0,$zero, $t3			#Pointer to call integer
	syscall

	# print tab space
	addi $v0,$zero,4			#Code for print String
	la $a0, tabMsg				#Pointer to call string
	syscall

	addi	$t2, $t2, 1			# $t2 = $t2 + 1					i ++

	j		forLoop2			# jump to forLoop2


	exitLoop2:
	addi	$sp, $sp, 24		# Pop items to restore stack

	# cout << endl;
	addi $v0,$zero,4			#Code for print String
	la $a0, newlineMsg			#Pointer to call string
	syscall

	addi	$a1, $a1, 1			# $t0 = $t0 + 1
	#return
	lw		$ra, 0($sp)			# Restore anything saved in stack
	addi	$sp, $sp, 4			# Pop items to restore stack
	jr		$ra					# jump to $ra
	

#---------------------------------------------------

.ent main

# Your code
main:

	la		$t0, A					# load A address (first word address)
	la		$t1, n 					# load n address
	lw		$t1, 0($t1)				# get n value

	add		$a0, $t0, $zero			# $a0 = $t0 		pass A address
	add		$a1, $t1, $zero			# $a1 = $t1 		pass n 

	jal		printTriangle				# jump to printTriangle and save position to $ra
	

#---------------------------------------------------


#Done, terminate program.
	addi $v0, $zero, 10 		# call code for terminate
	syscall 					# system call
	
.end main