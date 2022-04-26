# Jun He
# mg240

  org 0x0000

# main function (testcase)
main:
  ori $29, $0, 0xFFFC #same as mov $29, 0xFFFC
  ori $6, $0, 19 # DD
  ori $7, $0, 8 # MM
  ori $8, $0, 2016 #YYYY
  j func_calc_days

# calc_days function
## DD + (30 * (MM - 1)) + 365 * (YYYY - 2000)
## 30 + (30 * (8 - 1)) + 365 * (2016 -2000)
## 6080 days or 0x17C0 days

# REG6 - Day
# REG7 - Month
# REG8 - Year
# REG9 - Constant 30
# REG10 - Constant 365
# REG11 - Result
# REG12 - Backup Reg

func_calc_days:
  # Month
  addi $7, $7, -1
  ori $9, $0, 30
  push $7
  push $9
  jal func_mult
  pop $11

  # Year
  addi $8, $8, -2000
  ori $10, $0, 365
  push $8
  push $10
  jal func_mult
  pop $12

  # Finish up
  add $11, $11, $12
  add $11, $11, $6
  halt



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
  jr $ra
