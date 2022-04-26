org 0x0000
ori $sp, $0, 0x800
addu $fp, $sp, $0
jal main
halt
	split:
	
	addiu	$sp,$sp,-24
	sw	$fp,20($sp)
	addu	$fp,$sp,$0
	sw	$4,24($fp)
	sw	$5,28($fp)
	sw	$6,32($fp)
	lw	$2,28($fp)
	#nop
	sll	$2,$2,2
	lw	$3,24($fp)
	#nop
	addu	$2,$3,$2
	lw	$2,0($2)
	#nop
	sw	$2,8($fp)
	j	L2
	#nop
	
	L4:
	lw	$2,32($fp)
	#nop
	addiu	$2,$2,-1
	sw	$2,32($fp)
	L2:
	lw	$3,28($fp)
	lw	$2,32($fp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,L3
	#nop
	
	lw	$2,32($fp)
	#nop
	sll	$2,$2,2
	lw	$3,24($fp)
	#nop
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,8($fp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,L4
	#nop
	
	L3:
	lw	$3,28($fp)
	lw	$2,32($fp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,L13
	#nop
	
	L5:
	lw	$2,28($fp)
	#nop
	sll	$2,$2,2
	lw	$3,24($fp)
	#nop
	addu	$2,$3,$2
	lw	$3,32($fp)
	#nop
	sll	$3,$3,2
	lw	$4,24($fp)
	#nop
	addu	$3,$4,$3
	lw	$3,0($3)
	#nop
	sw	$3,0($2)
	lw	$2,28($fp)
	#nop
	addiu	$2,$2,1
	sw	$2,28($fp)
	j	L7
	#nop
	
	L9:
	lw	$2,28($fp)
	#nop
	addiu	$2,$2,1
	sw	$2,28($fp)
	L7:
	lw	$3,28($fp)
	lw	$2,32($fp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,L8
	#nop
	
	lw	$2,28($fp)
	#nop
	sll	$2,$2,2
	lw	$3,24($fp)
	#nop
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,8($fp)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,L9
	#nop
	
	L8:
	lw	$3,28($fp)
	lw	$2,32($fp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,L14
	#nop
	
	L10:
	lw	$2,32($fp)
	#nop
	sll	$2,$2,2
	lw	$3,24($fp)
	#nop
	addu	$2,$3,$2
	lw	$3,28($fp)
	#nop
	sll	$3,$3,2
	lw	$4,24($fp)
	#nop
	addu	$3,$4,$3
	lw	$3,0($3)
	#nop
	sw	$3,0($2)
	lw	$2,32($fp)
	#nop
	addiu	$2,$2,-1
	sw	$2,32($fp)
	#nop
	j	L2
	#nop
	
	L13:
	#nop
	j	L6
	#nop
	
	L14:
	#nop
	L6:
	lw	$2,32($fp)
	#nop
	sll	$2,$2,2
	lw	$3,24($fp)
	#nop
	addu	$2,$3,$2
	lw	$3,8($fp)
	#nop
	sw	$3,0($2)
	lw	$2,32($fp)
	addu	$sp,$fp,$0
	lw	$fp,20($sp)
	addiu	$sp,$sp,24
	jr	$31
	#nop
	
	quicksort:
	
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	addu	$fp,$sp,$0
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	lw	$3,44($fp)
	lw	$2,48($fp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,L19
	#nop
	
	L16:
	lw	$4,40($fp)
	lw	$5,44($fp)
	lw	$6,48($fp)
	jal	split
	#nop
	
	sw	$2,24($fp)
	lw	$2,24($fp)
	#nop
	addiu	$2,$2,-1
	lw	$4,40($fp)
	lw	$5,44($fp)
	addu	$6,$2,$0
	jal	quicksort
	#nop
	
	lw	$2,24($fp)
	#nop
	addiu	$2,$2,1
	lw	$4,40($fp)
	addu	$5,$2,$0
	lw	$6,48($fp)
	jal	quicksort
	#nop
	
	j	L18
	#nop
	
	L19:
	#nop
	L18:
	addu	$sp,$fp,$0
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	#nop
	
	main:
	
	addiu	$sp,$sp,-64
	sw	$31,60($sp)
	sw	$fp,56($sp)
	addu	$fp,$sp,$0
	ori	$2, $zero, 1
	sw	$2,24($fp)
	ori	$2, $zero, 3
	sw	$2,28($fp)
	ori	$2, $zero, 4
	sw	$2,32($fp)
	ori	$2, $zero, 5
	sw	$2,36($fp)
	ori	$2, $zero, 6
	sw	$2,40($fp)
	ori	$2, $zero, 8
	sw	$2,44($fp)
	ori	$2, $zero, 5
	sw	$2,48($fp)
	ori	$2, $zero, 2
	sw	$2,52($fp)
	addiu	$2,$fp,24
	addu	$4,$2,$0
	addu	$5,$0,$0
	ori	$6, $zero, 7
	jal	quicksort
	#nop
	
	addu	$2,$0,$0
	addu	$sp,$fp,$0
	lw	$31,60($sp)
	lw	$fp,56($sp)
	addiu	$sp,$sp,64
	jr	$31
	#nop
	
        halt
