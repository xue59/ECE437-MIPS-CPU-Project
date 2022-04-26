org 0x0000

ori $29, $0, 0xFFFC

ori $2, $0, 0	#the location of the final number of days
ori $3, $0, 19	#the current Day (19)
ori $4, $0, 8	#the current Month (8)
ori $5, $0, 2016	#the current Year (2016)

ori $6, $0, 0	#counter

addi $5, $5, -2000	#subtract 2000 from 2016
addi $4, $4, -1	#subtract 1 from month

#now I just need to add days with 30*month and 365*year

add $2, $0, $3		#add days 




ADDMONTH:
	beq $6, $4, RESETCOUNTER
	addi $2, $2, 30
	addi $6, $6, 1
	j ADDMONTH

RESETCOUNTER:
	addi $6, $0, 0

ADDYEAR:
	beq $6, $5, FINISHPROG
	addi $2, $2, 365
	addi $6, $6, 1
	j ADDYEAR


FINISHPROG:
HALT

