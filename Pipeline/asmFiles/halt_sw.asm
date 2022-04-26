  org 0x0000
  ori   $1, $zero, 10
  ori   $4, $1, 10
  ori   $2, $zero, 0x0080
  halt

  stephen:
  sw $1, 0($2)
  sw $4, 4($2)
  sw $1, 8($2)
  sw $4, 12($2)
  sw $1, 16($2)
  
