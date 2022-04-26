
org 0x0000 #base address

ori $29, $0, 0xFFFC #stack to FFFC
ori $10, $0, 0x0000 #set counter to zero for the multiplication loop

ori $3, $0, 0x0003	#set first operand to 3
ori $4, $0, 0x0002	#set second operand to 2

					#this should yield a result of 2 * 3 = 6

push $3				#push the first operand
push $4				#push the second

pop $4				#pop second
pop $3				#pop first


LOOPJUMP:
beq $4, $10, FINISH
addu $20, $20, $3
addiu $10, $10, 0x0001
j LOOPJUMP

FINISH:
push $20
HALT
