# Jun He
# mg240

  org 0x0000
  
# main function (testcase)
main:
  ori $29, $0, 0xFFFC #same as mov $29, 0xFFFC
  ori $6, $0, 4
  ori $7, $0, 5
  push $6
  push $7
  j func_mult

# mult function
func_mult:
  pop $2 #counter
  pop $3 #stay same
  ori $4, $0, 0 #result
loop:
  beq $2, $0, exit
  addi $2, $2, -1
  add $4, $4, $3
  j loop
 exit:
  push $4
  halt
