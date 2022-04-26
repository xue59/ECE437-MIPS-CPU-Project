org 0x0000
ori $2, $zero, 0x800
ori $3, $zero, 0x80
ori $4, $zero, 0x8

sw $4, 0($2)
add $5, $3, $2

lw $4, 0($2)

add $6, $4, $5
sw $6, 4($2)
halt
