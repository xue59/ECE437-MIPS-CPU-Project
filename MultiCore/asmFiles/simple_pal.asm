#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  
  ori   $t6, $zero, 2
  ori   $t7, $zero, 0
genRand:
  ori   $a0, $zero, l1 
  jal   lock           
  or    $t8, $zero, $t7     # set argument 0 to counter
  ori   $t0, $zero, cnt
  sw    $t8, 0($t0)                    # update the counter
  ori   $a0, $zero, l1 
  jal   unlock

  addi  $t7, $t7, 1
  bne   $t7, $t6, genRand     

  halt

l1:
  cfw 0x0


#----------------------------------------------------------
# Second Processor
#----------------------------------------------------------
  org   0x1000               # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack
  ori   $t5, $zero, 2
  ori   $t6, $zero, 0 
popNextVal:
checkStack:
  ori $t0, $zero, cnt
  lw $t1, 0($t0)                      # load the offset
  beq $t1, $zero, checkStack

  addi  $t6, $t6, 1
  bne   $t6, $t5, popNextVal
  halt
      
-------------------------------------------------------------------
lock:
  ori $t4, $zero, 0
  ori $t5, $zero, 1
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra
unlock:
  sw    $0, 0($a0)
  jr    $ra

cnt:
cfw 0
