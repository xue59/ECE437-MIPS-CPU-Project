org 0x0000
ori $sp, $0, 0x800
addu $fp, $sp, $0
ori $4, $0, 0x300
ori $5, $0, 64

jal quicksort
ori $8, $0, 0x500
sw $2, 0($8)
halt
	split:
	
	addiu	$sp,$sp,-24
	sw	$fp,20($sp)
	addu	$fp,$sp,$0
	sw	$4,24($fp)
	sw	$5,28($fp)
	sw	$6,32($fp)
	lw	$2,28($fp)
	sll	$2,$2,2
	lw	$3,24($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,8($fp)
	j	L2
	
	
	L4:
	lw	$2,32($fp)
	addiu	$2,$2,-1
	sw	$2,32($fp)
	L2:
	lw	$3,28($fp)
	lw	$2,32($fp)
	slt	$2,$3,$2
	beq	$2,$0,L3
	lw	$2,32($fp)
	sll	$2,$2,2
	lw	$3,24($fp)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,8($fp)
	slt	$2,$3,$2
	beq	$2,$0,L4
	
	L3:
	lw	$3,28($fp)
	lw	$2,32($fp)
	slt	$2,$3,$2
	beq	$2,$0,L13
	
	L5:
	lw	$2,28($fp)
	sll	$2,$2,2
	lw	$3,24($fp)
	addu	$2,$3,$2
	lw	$3,32($fp)
	sll	$3,$3,2
	lw	$4,24($fp)
	addu	$3,$4,$3
	lw	$3,0($3)
	sw	$3,0($2)
	lw	$2,28($fp)
	addiu	$2,$2,1
	sw	$2,28($fp)
	j	L7
	
	L9:
	lw	$2,28($fp)
	addiu	$2,$2,1
	sw	$2,28($fp)
	L7:
	lw	$3,28($fp)
	lw	$2,32($fp)
	slt	$2,$3,$2
	beq	$2,$0,L8
	lw	$2,28($fp)
	sll	$2,$2,2
	lw	$3,24($fp)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,8($fp)
	
	slt	$2,$2,$3
	beq	$2,$0,L9
	
	
	L8:
	lw	$3,28($fp)
	lw	$2,32($fp)
	
	slt	$2,$3,$2
	beq	$2,$0,L14
	
	
	L10:
	lw	$2,32($fp)
	
	sll	$2,$2,2
	lw	$3,24($fp)
	
	addu	$2,$3,$2
	lw	$3,28($fp)
	
	sll	$3,$3,2
	lw	$4,24($fp)
	
	addu	$3,$4,$3
	lw	$3,0($3)
	
	sw	$3,0($2)
	lw	$2,32($fp)
	
	addiu	$2,$2,-1
	sw	$2,32($fp)
	
	j	L2
	
	
	L13:
	
	j	L6
	
	
	L14:
	
	L6:
	lw	$2,32($fp)
	
	sll	$2,$2,2
	lw	$3,24($fp)
	
	addu	$2,$3,$2
	lw	$3,8($fp)
	
	sw	$3,0($2)
	lw	$2,32($fp)
	addu	$sp,$fp,$0
	lw	$fp,20($sp)
	addiu	$sp,$sp,24
	jr	$31
	
	
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
	
	slt	$2,$3,$2
	beq	$2,$0,L19
	
	
	L16:
	lw	$4,40($fp)
	lw	$5,44($fp)
	lw	$6,48($fp)
	jal	split
	
	
	sw	$2,24($fp)
	lw	$2,24($fp)
	
	addiu	$2,$2,-1
	lw	$4,40($fp)
	lw	$5,44($fp)
	addu	$6,$2,$0
	jal	quicksort
	lw	$2,24($fp)
	addiu	$2,$2,1
	lw	$4,40($fp)
	addu	$5,$2,$0
	lw	$6,48($fp)
	jal	quicksort
	j	L18
	
	L19:
	
	L18:
	addu	$sp,$fp,$0
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	
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
	
	
	addu	$2,$0,$0
	addu	$sp,$fp,$0
	lw	$31,60($sp)
	lw	$fp,56($sp)
	addiu	$sp,$sp,64
	jr	$31





org 0x300
data:
cfw 90
cfw 81
cfw 51
cfw 25
cfw 80
cfw 41
cfw 22
cfw 21
cfw 12
cfw 62
cfw 75
cfw 71
cfw 83
cfw 81
cfw 77
cfw 22
cfw 11
cfw 29
cfw 7
cfw 33
cfw 99
cfw 27
cfw 100
cfw 66
cfw 61
cfw 32
cfw 1
cfw 54
cfw 4
cfw 61
cfw 56
cfw 3
cfw 48
cfw 8
cfw 66
cfw 100
cfw 15
cfw 92
cfw 65
cfw 32
cfw 9
cfw 47
cfw 89
cfw 17
cfw 7
cfw 35
cfw 68
cfw 32
cfw 10
cfw 7
cfw 23
cfw 92
cfw 91
cfw 40
cfw 26
cfw 8
cfw 36
cfw 38
cfw 8
cfw 38
cfw 16
cfw 50
cfw 7
cfw 67

org 0x500
sorted:
