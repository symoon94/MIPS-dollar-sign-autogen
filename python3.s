# FILE: asm1.s
# ASSIGNMENT: Assembly Project #1
# AUTHOR: Sooyoung Moon
# DESCRIPTION: This program operates getting median and absolute value, 
#	summing values up, rotating values and dumping values.
# USAGE:
#	GUI: Assemble the file -> Run
# 	CMD: java -jar Mars4.5la.jar

.data
	str1:    	.asciiz "median: "
   str2:    	.asciiz "Comparisons: "
   str3:			.asciiz "sum: "
   str4:			.asciiz "one: "
   str5:			.asciiz "\ntwo: "
   str6:			.asciiz "\nthree: "
   nln:     	.asciiz "\n"
   space:   	.asciiz " "
   oneNeg:  	.asciiz "'one' was negative\n"
   twoNeg:  	.asciiz "'two' was negative\n"
   threeNeg:  	.asciiz "'three' was negative\n"
    
.text

.globl studentMain 

studentMain:
	addiu $sp,	$sp,	-24
	sw	  	$fp,	0($sp)
	sw  	$ra,	4($sp)
	addiu $fp,	$sp,	20


	la	   $s0,	median
	lw	   $s0,	0($s0)

	la		$s1,	one
	lw 	$s1,	0($s1)

	la 	$s2,	two
	lw 	$s2,	0($s2)

	la 	$s3,	three
	lw 	$s3,	0($s3)

	la 	$s4,	absVal			# s4 = &absVal
	lw 	$s4,	0($s4)				# s4 = absVal

	la 	$s5,	sum					# s5 = &sum
	lw 	$s5,	0($s5)				# s5 = sum

	la 	$s6,	rotate				# s6 = &rotate
	lw 	$s6,	0($s6)				# s6 = rotate

	la 	$s7,	dump				# s7 = &dump
	lw 	$s7,	0($s7)				# s7 = dump

# median
	addi  $t0,	$zero,	1			# t0 = 1
	bne 	$s0,	$t0,	DONE			# if median != 1, go to DONE

	beq 	$s1,	$s2,	IF			# if one == two, go to IF
	beq 	$s1,	$s3,	IF			# if one == three, go to IF
	beq 	$s2,	$s3,	ELSE_IF		# if two == three, go to ELSE_IF

	slt 	$t0,	$s1,	$s2			# t0 = one < two
	slt 	$t1,	$s1,	$s3			# t1 = one < three
	slt 	$t2,	$s2,	$s3			# t2 = two < three

	addi  $v0,	$zero,	4			# print_str
	la 	$a0,	str2				# print_str("Comparisons: ")
	syscall							# do it!

	addi 	$v0,	$zero,	1			# print_int
	add 	$a0,	$zero,	$t0		# print_int(one < two)
	syscall							# do it!

	addi 	$v0,	$zero,	4			# print_str
	la 	$a0,	space				# print_str(" ")
	syscall
	addi	$v0,	$zero,	1			# print_int
	add 	$a0,	$zero,	$t1		# print_int(one < three)
	syscall							# do it!

	addi 	$v0,	$zero,	4			# print_str
	la 	$a0,	space				# print_str(" ")
	syscall
	addi	$v0,	$zero,	1			# print_int
	add 	$a0,	$zero,	$t2		# print_int(two < three)
	syscall							# do it!

	addi 	$v0,	$zero,	4			# print_str
	la	   $a0,	nln					# print_str("\n")
	syscall							# do it!

	bne 	$t0,	$t2,	NEXT_1		# if((one < two) != (two < three)), go to NEXT_1

	addi  $v0,	$zero,	4			# print_str
	la 	$a0,	str1				# print_str("median: ")
	syscall							# do it!o

	addi  $v0,	$zero,	1			# print_int
	add   $a0,	$zero,	$s2		# print_int(two)
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la 	$a0,	nln					# print_str("\n")
	syscall							# do it!

NEXT_1:
	beq   $t0,	$t1,	NEXT_2		# if((one < two) == (one < three)), go to NEXT_2

	addi  $v0,	$zero,	4			# print_str
	la	   $a0,	str1				# print_str("median: ")
	syscall							# do it!

	addi  $v0,	$zero,	1			# print_int
	add   $a0,	$zero,	$s1		# print_int(one)
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	nln					# print_str("\n")
	syscall							# do it!

NEXT_2:
	beq   $t1,	$t2,	AFTER 		# if((one < three) == (two < three)), go to AFTER

	addi $v0,	$zero,	4			# print_str
	la    $a0,	str1				# print_str("median: ")
	syscall							# do it!

	addi  $v0,	$zero,	1			# print_int
	add   $a0,	$zero,	$s3		# print_int(three)
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	nln					# print_str("\n")
	syscall							# do it!

	j     AFTER						# jump to AFTER

IF:
	addi  $v0,	$zero,	4			# print_str
	la    $a0,	str1				# print_str("median: ")
	syscall							# do it!

	addi  $v0,	$zero,	1			# print_int
	add   $a0,	$zero,	$s1		# print_int(one)
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	nln					# print_str("\n")
	syscall							# do it!

	j AFTER							# jump to AFTER

ELSE_IF:
	addi  $v0,	$zero,	4			# print_str
	la    $a0,	str1				# print_str("median: ")
	syscall							# do it!

	addi  $v0,	$zero,	1			# print_int
	add   $a0,	$zero,	$s2		# print_int(two)
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	nln					# print_str("\n")
	syscall							# do it!
	j AFTER							# jump to AFTER

AFTER:
	addi  $v0,	$zero,	4			# print_str
	la 	$a0,	nln					# print_str("\n")
	syscall							# do it!

DONE:

# absVal
	addi  $t0,	$zero,	1			# t0 = 1
	bne	$s4,	$t0,	ABS_DONE	# if absVal != 1, go to ABS_DONE

	slti  $t0,	$s1,	0				# t0 = one < 0
	beq   $t0,	$zero,	JUMP_1	# if (one < 0) == false, go to JUMP_1

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	oneNeg				# print_str("'one' was negative\n")
	syscall							# do it!

	sub   $s1,	$zero,	$s1		# s1 = 0 - s1
	la    $t0,	one					# t0 = &s1
	sw    $s1,	0($t0)  			# 0(t0) = s1

JUMP_1:
	slti  $t0,	$s2,	0				# t0 = two < 0
	beq 	$t0,	$zero,	JUMP_2	# if (two < 0) == false, go to JUMP_2

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	twoNeg				# print_str("'two' was negative\n")
	syscall							# do it!

	sub   $s2,	$zero,	$s2		# s2 = 0 - s2
	la    $t0,	two					# t0 = &s2
	sw    $s2,	0($t0)  			# 0(t0) = s2

JUMP_2:
	slti  $t0,	$s3,	0				# t0 = three < 0
	beq   $t0,	$zero,	ABS_DONE	# if (three < 0) == false, go to ABS_DONE

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	threeNeg			# print_str("'three' was negative\n")
	syscall							# do it!
	
	sub   $s3,	$zero,	$s3		# s3 = 0 - s3
	la    $t0,	three				# t0 = &s3
	sw    $s3,	0($t0)  			# 0(t0) = s3

ABS_DONE:
	addi  $v0,	$zero,	4			# print_str
	la    $a0,	nln					# print_str("\n")
	syscall							# do it!

# sum  
	addi  $t0,	$zero,	1			# t0 = 1
	bne   $s5,	$t0,	SUM_DONE	# if sum != 1, go to SUM_DONE  

	add   $t0,	$s1,	$s2			# t0 = one + two
	add   $t0,	$t0,	$s3			# t0 = t0 + three

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	str3				# print_str("sum: ")
	syscall							# do it!

	addi  $v0,	$zero,	1			# print_int
	add   $a0,	$zero,	$t0		# print_int(t0)
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	nln					# print_str("\n")
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la    $a0,	nln					# print_str("\n")
	syscall							# do it!

SUM_DONE:

# rotate
	addi  $t0,	$zero,	1			# t0 = 1
	bne   $s6,	$t0,	ROT_DONE   # if rotate != 1, go to ROT_DONE  

	la    $t1,	one					# t1 = &one
	la    $t2,	two					# t2 = &two
	la    $t3,	three				# t3 = &three

	sw 	$s1,	0($t2)  			# 0(t2) = one
	sw 	$s2,	0($t3)				# 0(t3) = two
	sw	   $s3,	0($t1)				# 0(t1) = three

	lw	   $s1,	0($t1)				# s1 = three
	lw 	$s2,	0($t2)				# s2 = one
	lw 	$s3,	0($t3)				# s3 = two

ROT_DONE:

# dump
	addi  $t0,	$zero,	1			# t0 = 1
	bne 	$s7,	$t0,	DUMP_DONE	# if rotate != 1, go to DUMP_DONE

	addi  $v0,	$zero,	4			# print_str
	la 	$a0,	str4				# print_str("one: ")
	syscall							# do it!

	addi  $v0,	$zero,	1			# print_int
	add 	$a0,	$zero,	$s1		# print_int(one)
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la 	$a0,	str5				# print_str("\ntwo: ")
	syscall							# do it!

	addi  $v0,	$zero,	1			# print_int
	add 	$a0,	$zero,	$s2		# print_int(two)
	syscall							# do it!

	addi 	$v0,	$zero,	4			# print_str
	la 	$a0,	str6				# print_str("\nthree: ")
	syscall							# do it!

	addi  $v0,	$zero,	1			# print_int
	add 	$a0,	$zero,	$s3		# print_int(three)
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la 	$a0,	nln					# print_str("\n")
	syscall							# do it!

	addi  $v0,	$zero,	4			# print_str
	la 	$a0,	nln					# print_str("\n")
	syscall							# do it!

DUMP_DONE:


	lw 	$ra,	4($sp)       	# get return address from stack
	lw 	$fp,	0($sp)      		# restore the caller’s frame pointer
	addiu $sp,	$sp,	24  			# restore the caller’s stack pointer
	jr    $ra            		# return to caller’s code





