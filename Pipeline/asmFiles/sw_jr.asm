org 0x0000 #base address

ori $29, $0, 0xFFFC #stack to FFFC
ori $3, $0, 0x0003	#set first operand to 3
ori $4, $0, 0x0004	#set second operand to 2
ori $5, $0, 0x0005	#set first operand to 3
ori $6, $0, 0x0006	#set second operand to 2

LABLE1:
jal LABLE2
push $5
push $6
pop $5
pop $6
jal LABLE2
halt

LABLE2:
push $3				#push the first operand
push $4				#push the second
push $5
jr $ra
