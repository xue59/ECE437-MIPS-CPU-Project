org 0x0000

ori $29, $0, 0xFFFC
ori $30, $0, 0xFFF8
ori $20, $0, 0x0000 #result


ori $21, $0, 0x0002 #operand 1
ori $22, $0, 0x0001 #operand 2

push $21
push $22

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
