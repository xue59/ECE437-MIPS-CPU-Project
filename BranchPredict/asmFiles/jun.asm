org 0x0000

ori $29, $0, 0xFFFC
ori $30, $0, 0xFFF8
ori $20, $0, 0x0000 #result


ori $21, $0, 0x0002 #operand 1
ori $22, $0, 0x0003 #operand 2
ori $23, $0, 0x0004 #operand 3
ori $24, $0, 0x0005 #operand 4

push $21
push $22
push $23
push $24

MOREVALS:
	pop $2
	pop $3
	JAL MULTIPLY
	bne $29, $30, MOREVALS
	HALT

MULTIPLY:
	addi $20, $0, 0
ADDLOOP:
	add $20, $20, $2
	addi $3, $3, -1
	bne $3, $0, ADDLOOP
	PUSH $20
	JR $ra


FINISHPROG:
HALT
